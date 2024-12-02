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