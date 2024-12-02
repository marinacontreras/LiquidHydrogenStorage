function simulacion_transiente(Tamb, P, Q)
    % Modelo para estado transiente

    % Entrada:
    %   Tamb: Temperatura ambiente (K)
    %   P: Presión inicial (bar)
    %   Q: Flujo de energía (W)

    % Parámetros iniciales
    % params = struct('U', 5, 'A', 10, 'L', 0.05, 'Tamb', Tamb, ...
    %                'Lv', 446e3, 'R', 4124, 'V', 50, ...
    %                'DeltaH_OPC', 703, 'Cp', 14.3, 'm', 10);
    % Definir parámetros como un vector [U, A, L, Tamb, Lv, R, V, DeltaH_OPC, Cp, m]
    params = [5, 10, 0.05, 298, 446e3, 4124, 50, 703, 14.3, 10];


    % Condiciones iniciales: [T_tanque, P, chi_para]
    % T_tanque: Temperatura inicial del tanque (K)
    % P: Presión inicial del tanque (bar)
    % chi_para: Fracción molar inicial de para-hidrógeno
    y0 = [20, P, 0.25];

    % Intervalo de tiempo para la simulación
    tspan = [0, 3600]; % Simulación de 1 hora

    % Resolver el sistema de ecuaciones diferenciales
    [t, y] = ode45(@(t, y) hydrogen_model(t, y, params), tspan, y0);

    % Extraer resultados
    T_tanque = y(:, 1); % Temperatura del tanque (K)
    P_tank = y(:, 2);   % Presión en el tanque (bar)
    chi_para = y(:, 3); % Fracción molar de para-hidrógeno

    % Gráficos de resultados
    figure;

    % Gráfico de temperatura
    subplot(3,1,1);
    plot(t, T_tanque, 'LineWidth', 1.5);
    title('Evolución de la Temperatura en el Tanque');
    xlabel('Tiempo (s)');
    ylabel('Temperatura (K)');
    grid on;

    % Gráfico de presión
    subplot(3,1,2);
    plot(t, P_tank, 'LineWidth', 1.5);
    title('Evolución de la Presión en el Tanque');
    xlabel('Tiempo (s)');
    ylabel('Presión (bar)');
    grid on;

    % Gráfico de fracción molar de para-hidrógeno
    subplot(3,1,3);
    plot(t, chi_para, 'LineWidth', 1.5);
    title('Fracción Molar de Para-Hidrógeno');
    xlabel('Tiempo (s)');
    ylabel('Fracción Molar');
    grid on;

    % Mostrar valores finales
    disp('--- Resultados Finales de la Simulación ---');
    disp(['Temperatura final del tanque: ', num2str(T_tanque(end)), ' K']);
    disp(['Presión final del tanque: ', num2str(P_tank(end)), ' bar']);
    disp(['Fracción final de para-hidrógeno: ', num2str(chi_para(end))]);
end
