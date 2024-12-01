# Modelo termodinámico

Este modelo matemático describe el comportamiento del almacenamiento de hidrógeno líquido considerando los principales fenómenos físicos y termodinámicos. Incluye ecuaciones para transferencia de calor, pérdidas por boil-off, dinámica de presión, conservación de energía y el efecto de la conversión orto-para.

---

## 1. Transferencia de calor al tanque
El tanque de hidrógeno líquido intercambia calor con el ambiente, lo que puede causar una elevación de la temperatura interna y pérdidas por evaporación (*boil-off*). La cantidad de calor transferido se calcula como:

$$
Q = \frac{U \cdot A \cdot (T_{\text{amb}} - T_{\text{tanque}})}{L}
$$

Donde:
- \(Q\): Tasa de transferencia de calor (W).
- \( U \): Coeficiente de transferencia de calor (W/m²·K).
- \( A \): Área del tanque (m²).
- $$ T_{\text{amb}} $$: Temperatura ambiente (K).
- \( T_{\text{tanque}} \): Temperatura del hidrógeno líquido en el tanque (K).
- \( L \): Espesor del aislamiento térmico (m).

---

## 2. Pérdidas por boil-off
El calor transferido al tanque provoca la evaporación del hidrógeno líquido, lo que genera pérdidas de *boil-off*. La tasa de evaporación se calcula mediante:

$$
\dot{m}_{boil-off} = \frac{Q}{L_v}
$$

Donde:
- \( \dot{m}_{boil-off} \): Tasa de evaporación del hidrógeno (kg/s).
- \( L_v \): Calor latente de vaporización del hidrógeno (~446 kJ/kg).

---

## 3. Dinámica de presión
La presión dentro del tanque cambia debido al aumento de masa de hidrógeno gaseoso generado por el *boil-off*:

$$
\frac{dP}{dt} = \frac{R \cdot T_{\text{tanque}} \cdot \dot{m}_{boil-off}}{V}
$$

Donde:
- \( P \): Presión interna del tanque (Pa).
- \( R \): Constante específica de gas para el hidrógeno (\( 4124 \, \text{J}/\text{kg}\cdot\text{K} \)).
- \( V \): Volumen del tanque (m³).

---

## 4. Conservación de energía
El balance energético del sistema se describe mediante:

$$
\frac{dU}{dt} = Q - \dot{W} + \dot{m}_{in} h_{in} - \dot{m}_{out} h_{out}
$$

Donde:
- \( U \): Energía interna del hidrógeno en el tanque (J).
- \( \dot{W} \): Trabajo realizado por el sistema (W).
- \( \dot{m}_{in} \), \( \dot{m}_{out} \): Tasa de flujo másico de entrada y salida (kg/s).
- \( h_{in} \), \( h_{out} \): Entalpías específicas de entrada y salida (J/kg).

---

## 5. Efecto de la conversión orto-para (OPC)
Durante el almacenamiento, el hidrógeno cambia entre sus formas orto y para, liberando calor adicional:

$$
Q_{OPC} = \Delta H_{OPC} \cdot \frac{d\chi_{\text{para}}}{dt}
$$

Donde:
- \( Q_{OPC} \): Calor liberado por la conversión orto-para (W).
- \( \Delta H_{OPC} \): Calor liberado durante la conversión (~703 J/mol).
- \( \chi_{\text{para}} \): Fracción molar de para-hidrógeno.
- \( \frac{d\chi_{\text{para}}}{dt} \): Tasa de conversión orto-para.

---

## Resolución Numérica
Estas ecuaciones pueden resolverse mediante métodos numéricos en MATLAB, utilizando funciones como `ode45`. Un ejemplo de implementación básica está disponible en la carpeta llamda `code` para simular la evolución de la temperatura, la presión y la fracción de para-hidrógeno en el tanque bajo diferentes condiciones.
