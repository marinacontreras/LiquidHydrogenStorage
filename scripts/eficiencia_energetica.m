function eficiencia_energetica
    % Crear la figura principal
    fig = uifigure('Name', 'Eficiencia Energética', 'Position', [100, 100, 1000, 700]);

    % Crear un grid layout con 1 fila y 2 columnas
    grid = uigridlayout(fig, [1, 2]);
    grid.RowHeight = {'1x'};
    grid.ColumnWidth = {'1x', '2x'}; % Aumentar el ancho de la columna del gráfico

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

    % Slider de flujo de energía
    lbl_Q = uilabel(control_layout, 'Text', 'Flujo de Energía (W):');
    lbl_Q.Layout.Row = 2;
    lbl_Q.Layout.Column = 1;
    Q_slider = uislider(control_layout, 'Limits', [0 500], 'Value', 100);
    Q_slider.Layout.Row = 2;
    Q_slider.Layout.Column = 2;

    % Slider de masa de hidrógeno
    lbl_m = uilabel(control_layout, 'Text', 'Masa de Hidrógeno (kg):');
    lbl_m.Layout.Row = 3;
    lbl_m.Layout.Column = 1;
    m_slider = uislider(control_layout, 'Limits', [1 100], 'Value', 10);
    m_slider.Layout.Row = 3;
    m_slider.Layout.Column = 2;

    % Menú desplegable para seleccionar tipo de simulación
    lbl_mode = uilabel(control_layout, 'Text', 'Modo de Simulación:');
    lbl_mode.Layout.Row = 4;
    lbl_mode.Layout.Column = 1;
    mode_dropdown = uidropdown(control_layout, ...
        'Items', {'Transiente', 'Estacionario'}, ...
        'Value', 'Transiente');
    mode_dropdown.Layout.Row = 4;
    mode_dropdown.Layout.Column = 2;

    % Crear los gráficos en la segunda columna
    ax_eficiencia = uiaxes(grid);
    ax_eficiencia.Layout.Row = 1;
    ax_eficiencia.Layout.Column = 2;
    title(ax_eficiencia, 'Eficiencia Energética');
    xlabel(ax_eficiencia, 'Tiempo (s)');
    ylabel(ax_eficiencia, 'Eficiencia (%)');
    hold on;

    % Función para actualizar la simulación y calcular la eficiencia
    function updateSimulation()
        Tamb = Tamb_slider.Value;
        Q = Q_slider.Value;
        m = m_slider.Value;
        mode = mode_dropdown.Value;

        % Parámetros iniciales
        params = [5, 10, 0.05, Tamb, 446e3, 4124, 50, 703, 14.3, m];
        y0 = [20, 1.5, 0.25];  % Condiciones iniciales

        % Limpiar el gráfico antes de graficar las nuevas curvas
        cla(ax_eficiencia);

        % Inicializar vectores para almacenar las eficiencias
        eficiencia_1_vec = [];
        eficiencia_2_vec = [];
        time_vec = [];

        if strcmp(mode, 'Transiente')
            % Simulación transiente
            tspan = [0, 3600];
            [t, y] = ode45(@(t, y) hydrogen_model(t, y, params), tspan, y0);

            % Cálculo de la eficiencia en cada paso de tiempo
            for i = 1:length(t)
                % Eficiencia de la primera ley
                Q_utilizado = (y(i, 1) - Tamb) * params(1) * params(2) * params(3);  % Aproximación de la energía utilizada
                Q_entrada = Q * t(i);  % Energía total suministrada
                eficiencia_1 = (Q_utilizado / Q_entrada) * 100;
                eficiencia_1_vec = [eficiencia_1_vec, eficiencia_1];

                % Eficiencia de la segunda ley
                S_entropia = Q / params(5);  % Aproximación del cambio en entropía
                eficiencia_2 = (Q_utilizado / (Q_entrada - S_entropia)) * 100;
                eficiencia_2_vec = [eficiencia_2_vec, eficiencia_2];
                time_vec = [time_vec, t(i)];
            end

            % Actualizar gráficos con las eficiencias
            plot(ax_eficiencia, time_vec, eficiencia_1_vec, 'LineWidth', 1.5, 'DisplayName', 'Eficiencia 1ra Ley');
            plot(ax_eficiencia, time_vec, eficiencia_2_vec, 'LineWidth', 1.5, 'DisplayName', 'Eficiencia 2da Ley');
            legend(ax_eficiencia);

        else
            % Simulación estacionaria (resolver para equilibrio)
            [y_eq] = hydrogen_stationary(y0, params);

            % Calcular eficiencias en el estado estacionario
            Q_utilizado = (y_eq(1) - Tamb) * params(1) * params(2) * params(3);
            Q_entrada = Q * 3600;  % Energía total en una hora
            eficiencia_1 = (Q_utilizado / Q_entrada) * 100;

            % Eficiencia de la segunda ley en el equilibrio (aproximación)
            S_entropia = Q / params(5);
            eficiencia_2 = (Q_utilizado / (Q_entrada - S_entropia)) * 100;

            % Mostrar en los gráficos (para un solo punto en el caso estacionario)
            plot(ax_eficiencia, [0, 3600], [eficiencia_1, eficiencia_1], 'LineWidth', 1.5, 'DisplayName', 'Eficiencia 1ra Ley');
            plot(ax_eficiencia, [0, 3600], [eficiencia_2, eficiencia_2], 'LineWidth', 1.5, 'DisplayName', 'Eficiencia 2da Ley');
            legend(ax_eficiencia);
        end
    end

    % Ejecutar la simulación cuando los sliders o el modo cambien
    Tamb_slider.ValueChangedFcn = @(src, event) updateSimulation();
    Q_slider.ValueChangedFcn = @(src, event) updateSimulation();
    m_slider.ValueChangedFcn = @(src, event) updateSimulation();
    mode_dropdown.ValueChangedFcn = @(src, event) updateSimulation();

    % Llamar a la simulación inicial
    updateSimulation();
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

% Modelo estacionario
function y_eq = hydrogen_stationary(y0, params)
    % Resolver el modelo estacionario para encontrar el equilibrio
    options = optimset('Display', 'off');
    y_eq = fsolve(@(y) hydrogen_model(0, y, params), y0, options);
end
