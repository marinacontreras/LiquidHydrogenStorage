%% Simulación interactiva del almacenamiento de hidrógeno líquido
% Script principal para simular el comportamiento del sistema bajo diferentes condiciones operacionales

disp('--- Simulación de Almacenamiento de Hidrógeno Líquido ---');

% Entrada de condiciones operacionales
Tamb = input('Ingrese la temperatura ambiente (K) [250-310]: ');
P = input('Ingrese la presión inicial (bar) [1-3]: ');
Q = input('Ingrese el flujo de energía (W) [0-500]: ');

% Validar entrada
if Tamb < 250 || Tamb > 310
    error('La temperatura debe estar entre 250 y 310 K.');
end
if P < 1 || P > 3
    error('La presión debe estar entre 1 y 3 bar.');
end
if Q < 0 || Q > 500
    error('El flujo de energía debe estar entre 0 y 500 W.');
end

% Selección del estado de simulación
disp('Seleccione el tipo de simulación:');
disp('1: Estado estacionario');
disp('2: Estado transiente');
simType = input('Ingrese su elección (1 o 2): ');

% Ejecutar según el tipo de simulación seleccionado
if simType == 1
    disp('Simulación en estado estacionario...');
    simulacion_estacionaria(Tamb, P, Q); % Llama a una función para estado estacionario
elseif simType == 2
    disp('Simulación en estado transiente...');
    simulacion_transiente(Tamb, P, Q); % Llama al modelo transiente existente
else
    error('Opción no válida. Seleccione 1 o 2.');
end