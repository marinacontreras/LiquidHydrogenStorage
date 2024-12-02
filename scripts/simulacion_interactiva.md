# Simulación Interactiva

Este proyecto implementa una simulación interactiva para modelar el comportamiento de un sistema de almacenamiento de hidrógeno líquido bajo diferentes condiciones operativas de temperatura, presión y flujo de energía. La simulación permite analizar la dinámica del proceso y las condiciones de equilibrio del sistema.

## **Descripción General**

La simulación interactiva se basa en el modelo termodinámico planteado previamente. Es decir, el sistema simula los siguientes fenómenos clave:
- **Transferencia de calor** entre el tanque y el ambiente.
- **Pérdidas por boil-off** debido a la evaporación del hidrógeno líquido.
- **Dinámica de presión interna** en el tanque.
- **Conversión orto-para** del hidrógeno, liberando calor adicional.
- **Balance energético** para determinar la evolución de la temperatura interna.

El usuario puede ajustar varios parámetros operativos. Por un lado, puede elegir entre dos tipos de estados:
1. **Estado estacionario**: Calcula las condiciones de equilibrio del sistema.
2. **Estado transiente**: Simula la evolución dinámica del sistema en función del tiempo.
Por otro lado, puede elegir las condiciones operativas de temperatura, presión y flujo de energía.
1. **Temperatura**: La temperatura ambiente entre 250 K - 300 K
2. **Presión**: La presión inicial del sistema, entre 1 y 3 bar
3. **Flujo de energía**: El flujo de energía entre 0 y 500 W

---

## **Códigos disponibles**

### Scripts principales
- `simulacion_interactiva.m`: Controla la simulación interactiva y permite al usuario elegir parámetros iniciales y estado de simulación.
- `hydrogen_model.m`: Función que define las ecuaciones diferenciales que describen el modelo termodinámico. Corresponde a la modificación parcial de `hydrogen_storage.m`
- `simulacion_estacionaria.m`: Función que implementa la simulación completa para el estado estacionario.
- `simulacion_transiente.m`: Función que implementa la simulación completa para el estado transiente, corresponde a la modificación parcial de `LiquidHydrogenStorage.m`.

---

## **Requisitos**

- MATLAB R2021a o superior.
- Toolbox: **Symbolic Math Toolbox** 

---

## Instrucciones de uso

### 1. Preparación de los archivos
Los archivos MATLAB están disponibles en la carpeta `scripts`. Los cuatro scripts deben encontrarse guardados en la misma carpeta para que se pueda ejecutar el código.

### 2. Ejecutar los scripts
El principal archivo con el cual se trabaja es el `simulacion_interactiva.m`. Los otros tres archivos no se deben modificar, a menos que se quiera hacer un cambio en el modelo, y no solo en los parámetros
1. Abre el archivo `simulacion_interactiva.m` en MATLAB. 
2. Define los parámetros iniciales dentro del script.
  - Temperatura ambiente entre 250-310 K
  - Presión entre 1-3 bar
  - Flujo de energía entre 0-500 W
4. Elige el estado en el cual quiere que ocurra el proceso.
  - Estado estacionario (1)
  - Estado transiente (2)
5. Ejecuta el script. 

### 3. Salidas de los modelos
Al ejecutar los scripts en el estado estacionario se obtienen tres valores fijos representados en un gráfico de barra con tres barras:
- Temperatura del tanque 
- Presión en el tanque
- Fracción molar de para-hidrógeno

Al ejecutar los scripts en el estado transiente se obtienen tres gráficos:
- Evolución de la temperatura en el tanque
- Evolución de la presión en el tanque
- Evolución de la fracción molar de para-hidrógeno

### 4. Resultados esperados
Los resultados esperados en estado estacionario:
- Temperatura del tanque: El sistema alcanza una temperatura constante determinada por la transferencia de calor desde el ambiente y el balance energético.
- Presión del tanque: Al estabilizarse las pérdidas por boil-off, la presión también se estabiliza y se mantiene constante.
- Fracción de para-hidrógeno : La conversión orto-para se estabiliza en un valor de equilibrio determinado por la temperatura y la presión.

Los resultados esperados en estado transiente: 
- Temperatura del tanque: Variará con el tiempo hasta alcanzar el equilibrio. Inicialmente, puede aumentar debido a las pérdidas de calor, y luego estabilizarse a medida que el sistema alcanza un balance térmico.
- Presión del tanque: Subirá o bajará dependiendo de la cantidad de hidrógeno que se evapore (boil-off). La presión también se estabilizará después de un cierto tiempo, pero solo después de un periodo transitorio.
- Fracción de para-hidrógeno : Variará a medida que el hidrógeno cambia de su forma orto a para. La conversión será más pronunciada en el tiempo antes de estabilizarse.
