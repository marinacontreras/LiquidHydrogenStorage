function simulacion_interactiva
    % Crear la figura principal
    fig = uifigure('Name', 'Simulación Interactiva', 'Position', [100, 100, 1000, 700]);

    % Crear un grid layout con 2 filas y 2 columnas
    grid = uigridlayout(fig, [2, 2]);
    grid.RowHeight = {'fit', '1x'};
    grid.ColumnWidth = {'fit', '1x'};

    % Crear un panel en el primer cuadrante para los controles
    control_panel = uipanel(grid, 'Title', 'Parámetros de Simulación');
    control_panel.Layout.Row = 1;
    control_panel.Layout.Column = 1;
    control_layout = uigridlayout(control_panel, [4, 2]);
    control_layout.RowHeight = {'fit', 'fit', 'fit', 'fit'};
    control_layout.ColumnWidth = {'fit', '1x'};

    % Slider de temperatura ambiente
    lbl_Tamb = uilabel(control_layout, 'Text', 'Temperatura Ambiente (K):');
    lbl_Tamb.Layout.Row = 1;
    lbl_Tamb.Layout.Column = 1;
    Tamb_slider = uislider(control_layout, 'Limits', [250 310], 'Value', 298);
    Tamb_slider.Layout.Row = 1;
    Tamb_slider.Layout.Column = 2;

    % Slider de presión inicial
    lbl_P = uilabel(control_layout, 'Text', 'Presión Inicial (bar):');
    lbl_P.Layout.Row = 2;
    lbl_P.Layout.Column = 1;
    P_slider = uislider(control_layout, 'Limits', [1 3], 'Value', 1.5);
    P_slider.Layout.Row = 2;
    P_slider.Layout.Column = 2;

    % Slider de flujo de energía
    lbl_Q = uilabel(control_layout, 'Text', 'Flujo de Energía (W):');
    lbl_Q.Layout.Row = 3;
    lbl_Q.Layout.Column = 1;
    Q_slider = uislider(control_layout, 'Limits', [0 500], 'Value', 100);
    Q_slider.Layout.Row = 3;
    Q_slider.Layout.Column = 2;

    % Menú desplegable para seleccionar tipo de simulación
    lbl_mode = uilabel(control_layout, 'Text', 'Modo de Simulación:');
    lbl_mode.Layout.Row = 4;
    lbl_mode.Layout.Column = 1;
    mode_dropdown = uidropdown(control_layout, ...
        'Items', {'Transiente', 'Estacionario'}, ...
        'Value', 'Transiente');
    mode_dropdown.Layout.Row = 4;
    mode_dropdown.Layout.Column = 2;

    % Crear los gráficos en los otros tres cuadrantes
    ax_temp = uiaxes(grid);
    ax_temp.Layout.Row = 1;
    ax_temp.Layout.Column = 2;
    title(ax_temp, 'Evolución de la Temperatura');
    xlabel(ax_temp, 'Tiempo (s)');
    ylabel(ax_temp, 'Temperatura (K)');

    ax_pres = uiaxes(grid);
    ax_pres.Layout.Row = 2;
    ax_pres.Layout.Column = 1;
    title(ax_pres, 'Evolución de la Presión');
    xlabel(ax_pres, 'Tiempo (s)');
    ylabel(ax_pres, 'Presión (bar)');

    ax_chi = uiaxes(grid);
    ax_chi.Layout.Row = 2;
    ax_chi.Layout.Column = 2;
    title(ax_chi, 'Fracción Molar de Para-Hidrógeno');
    xlabel(ax_chi, 'Tiempo (s)');
    ylabel(ax_chi, 'Fracción Molar');

    % Función para actualizar la simulación
    function updateSimulation()
        Tamb = Tamb_slider.Value;
        P = P_slider.Value;
        Q = Q_slider.Value;
        mode = mode_dropdown.Value;

        % Parámetros iniciales
        params = [5, 10, 0.05, Tamb, 446e3, 4124, 50, 703, 14.3, 10];
        y0 = [20, P, 0.25];

        if strcmp(mode, 'Transiente')
            % Simulación transiente
            tspan = [0, 3600];
            [t, y] = ode45(@(t, y) hydrogen_model(t, y, params), tspan, y0);

            % Actualizar gráficos con datos transientes
            plot(ax_temp, t, y(:, 1), 'LineWidth', 1.5);
            plot(ax_pres, t, y(:, 2), 'LineWidth', 1.5);
            plot(ax_chi, t, y(:, 3), 'LineWidth', 1.5);

        else
            % Simulación estacionaria (resolver para equilibrio)
            [y_eq] = hydrogen_stationary(y0, params);

            % Actualizar gráficos con valores constantes
            t_eq = [0, 3600];
            plot(ax_temp, t_eq, [y_eq(1), y_eq(1)], 'LineWidth', 1.5);
            plot(ax_pres, t_eq, [y_eq(2), y_eq(2)], 'LineWidth', 1.5);
            plot(ax_chi, t_eq, [y_eq(3), y_eq(3)], 'LineWidth', 1.5);
        end
    end

    % Ejecutar la simulación cuando los sliders o el modo cambien
    Tamb_slider.ValueChangedFcn = @(src, event) updateSimulation();
    P_slider.ValueChangedFcn = @(src, event) updateSimulation();
    Q_slider.ValueChangedFcn = @(src, event) updateSimulation();
    mode_dropdown.ValueChangedFcn = @(src, event) updateSimulation();

    % Llamar a la simulación inicial
    updateSimulation();
end

% Modelo estacionario
function y_eq = hydrogen_stationary(y0, params)
    options = optimset('Display', 'off');
    y_eq = fsolve(@(y) hydrogen_model(0, y, params), y0, options);
end

% Modelo transiente
function dydt = hydrogen_model(t, y, params)
    % Modelo de ecuaciones diferenciales para almacenamiento de hidrógeno líquido
    % Entrada:
    %   t - Tiempo (s)
    %   y - Vector de estado [T_tanque, P_tank, chi_para]
    %   params - Vector con parámetros del sistema

    % Extraer parámetros desde el vector params
    U = params(1);          % Coeficiente de transferencia de calor (W/m²K)
    A = params(2);          % Área del tanque (m²)
    L = params(3);          % Espesor del aislamiento (m)
    Tamb = params(4);       % Temperatura ambiente (K)
    Lv = params(5);         % Calor latente de vaporización del H2 (J/kg)
    R = params(6);          % Constante de gas para H2 (J/kg·K)
    V = params(7);          % Volumen del tanque (m³)
    DeltaH_OPC = params(8); % Calor de conversión orto-para (J/mol)
    Cp = params(9);         % Capacidad calorífica específica (J/kgK)
    m = params(10);         % Masa del hidrógeno líquido (kg)

    % Variables de estado
    T_tanque = y(1); % Temperatura del tanque (K)
    P_tank = y(2);   % Presión interna del tanque (bar)
    chi_para = y(3); % Fracción molar de para-hidrógeno

    % Ecuaciones del modelo
    Q = (U * A * (Tamb - T_tanque)) / L; % Transferencia de calor
    mdot_boil_off = Q / Lv; % Pérdidas por boil-off
    dPdt = (R * T_tanque * mdot_boil_off) / V; % Dinámica de presión
    dChidt = (chi_para - 0.25) * 0.1; % Conversión orto-para
    Q_OPC = DeltaH_OPC * dChidt; % Calor de conversión orto-para
    dTdt = (Q + Q_OPC) / (Cp * m); % Balance energético

    % Derivadas de las variables de estado
    dydt = [dTdt; dPdt; dChidt];
end
