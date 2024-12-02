%% Modelo termodinámico del almacenamiento de hidrógeno líquido

% Parámetros iniciales
params = struct('U', 5, 'A', 10, 'L', 0.05, 'Tamb', 298, ...
                'Lv', 446e3, 'R', 4124, 'V', 50, ...
                'DeltaH_OPC', 703, 'Cp', 14.3, 'm', 10);

% Condiciones iniciales: [T_tanque, P, chi_para]
y0 = [20, 1.2, 0.25];

% Simulación
[t, y] = ode45(@(t, y) hydrogen_storage(t, y, params), [0, 3600], y0);

% Resultados
T_tanque = y(:, 1);
P = y(:, 2);
chi_para = y(:, 3);

% Gráficos
figure;
subplot(3,1,1); plot(t, T_tanque); title('Temperatura del tanque');
subplot(3,1,2); plot(t, P); title('Presión en el tanque');
subplot(3,1,3); plot(t, chi_para); title('Fracción de para-hidrógeno');