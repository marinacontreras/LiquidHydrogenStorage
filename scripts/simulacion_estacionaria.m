function simulacion_estacionaria(Tamb, P, Q)
    % Modelo para estado estacionario

    % Entrada:
    %   Tamb: Temperatura ambiente (K)
    %   P: Presión inicial (bar)
    %   Q: Flujo de energía (W)

    % Parámetros del sistema
    U = 5; % Coeficiente de transferencia de calor (W/m²K)
    A = 10; % Área del tanque (m²)
    L = 0.05; % Espesor del aislamiento (m)
    Lv = 446e3; % Calor latente de vaporización del H2 (J/kg)
    R = 4124; % Constante de gas para H2 (J/kgK)
    V = 50; % Volumen del tanque (m³)
    Cp = 14.3; % Capacidad calorífica específica (J/kgK)
    m = 10; % Masa del hidrógeno líquido (kg)

    % Resolver para condiciones estacionarias (derivadas = 0)
    syms T_tanque P_tank chi_para
    Q_heat = (U * A * (Tamb - T_tanque)) / L; % Transferencia de calor
    mdot_boil_off = Q_heat / Lv; % Pérdidas por boil-off
    dPdt = (R * T_tanque * mdot_boil_off) / V; % Cambio de presión
    dChidt = (chi_para - 0.25) * 0.1; % Conversión orto-para
    Q_OPC = 703 * dChidt; % Calor liberado por OPC

    % Balance de energía estacionario
    dTdt = (Q_heat + Q_OPC) / (Cp * m);

    % Resolver ecuaciones estacionarias
    eqns = [dTdt == 0, dPdt == 0, dChidt == 0];
    vars = [T_tanque, P_tank, chi_para];
    sol = solve(eqns, vars);

    % Mostrar resultados
    disp('Resultados en estado estacionario:');
    disp(['Temperatura del tanque: ', num2str(double(sol.T_tanque)), ' K']);
    disp(['Presión del tanque: ', num2str(double(sol.P_tank)), ' bar']);
    disp(['Fracción de para-hidrógeno: ', num2str(double(sol.chi_para))]);

    % Graficar resultados estacionarios
    figure;
    bar([double(sol.T_tanque), double(sol.P_tank), double(sol.chi_para)]);
    set(gca, 'XTickLabel', {'Temperatura (K)', 'Presión (bar)', 'Chi para'});
    title('Resultados en estado estacionario');
end
