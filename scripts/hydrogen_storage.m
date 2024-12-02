function dydt = hydrogen_storage(t, y, params)
    % Parámetros
    U = params.U; % Coeficiente de transferencia de calor (W/m²K)
    A = params.A; % Área del tanque (m²)
    L = params.L; % Espesor del aislamiento (m)
    Tamb = params.Tamb; % Temperatura ambiente (K)
    Lv = params.Lv; % Calor latente de vaporización del H2 (J/kg)
    R = params.R; % Constante de gas para H2 (J/kgK)
    V = params.V; % Volumen del tanque (m³)
    DeltaH_OPC = params.DeltaH_OPC; % Presión inicial (bar)

    % Variables del estado
    T_tanque = y(1); % Temperatura del tanque
    P = y(2); % Presión interna
    chi_para = y(3); % Fracción molar de para-hidrógeno

    % Ecuaciones
    Q = (U * A * (Tamb - T_tanque)) / L; % Transferencia de calor
    mdot_boil_off = Q / Lv; % Pérdidas por boil-off
    dPdt = (R * T_tanque * mdot_boil_off) / V; % Dinámica de presión
    dChidt = (chi_para - 0.25) * 0.1; % Tasa de conversión orto-para
    Q_OPC = DeltaH_OPC * dChidt; % Calor de conversión orto-para

    % Balance energético
    dTdt = (Q + Q_OPC) / (params.Cp * params.m); % Cambio de temperatura

    % Derivadas
    dydt = [dTdt; dPdt; dChidt];
end