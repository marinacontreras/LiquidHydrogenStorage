# Eficiencia energética
## Cálculo de la eficiencia energética en el almacenamiento de hidrógeno líquido

Para calcular y visualizar la eficiencia energética del sistema de almacenamiento de hidrógeno líquido desde la perspectiva de la primera y segunda ley de la termodinámica, primero debemos entender los conceptos y cómo implementarlos:

### 1. Primera ley de la termodinámica:
La primera ley (conservación de la energía) establece que la energía total de un sistema aislado es constante. En este contexto, la energía entrante en forma de calor debe igualar la energía saliente (pérdidas por boil-off y trabajo realizado por el sistema). La eficiencia basada en la primera ley se puede expresar como:

$$
\eta_1 = \frac{Q_{\text{utilizado}}}{Q_{\text{entrada}}}
$$

Donde:

- $$Q_{\text{utilizado}}$$ es la energía utilizada para mantener el hidrógeno en estado líquido.
- $$Q_{\text{entrada}}$$ es la energía total suministrada (en este caso el calor suministrado).

### 2. Segunda ley de la termodinámica:
La segunda ley se enfoca en la entropía, que debe aumentar en un proceso termodinámico real. La eficiencia de la segunda ley se relaciona con la irreversibilidad del proceso. Para este caso, es importante considerar las pérdidas de calor no aprovechadas que contribuyen a la entropía.

La eficiencia de la segunda ley se calcula utilizando el concepto de eficiencia exergética:

$$
\eta_2 = \frac{Q_{\text{utilizado}}}{Q_{\text{entrada}} - \Delta S}
$$

Donde:

- $$\Delta S$$ es el cambio de entropía del sistema.

## Código
# Simulación Interactiva de Eficiencia Energética en el Almacenamiento de Hidrógeno Líquido

### Descripción General

Este repositorio contiene un código MATLAB para simular y calcular la eficiencia energética de un sistema de almacenamiento de hidrógeno líquido. El modelo tiene en cuenta dos aspectos clave de la termodinámica:

1. **Primera ley de la termodinámica**: Conservación de la energía, donde la eficiencia se calcula como la relación entre la energía utilizada y la energía total suministrada.
2. **Segunda ley de la termodinámica**: Eficiencia exergética, que toma en cuenta las pérdidas de calor no aprovechadas y el cambio de entropía en el sistema.

La interfaz permite al usuario ajustar parámetros del sistema mediante controles deslizantes (sliders) y observar cómo estos afectan la eficiencia energética tanto en el **modo transiente** como en el **modo estacionario**.

### Códigos Disponibles

1. `eficiencia_energetica.m`

Este es el script principal que crea la interfaz interactiva y ejecuta la simulación para calcular la eficiencia energética del sistema de almacenamiento de hidrógeno líquido. 

- **Funciones**:
  - Calcula la eficiencia de la **primera ley** y **segunda ley** de la termodinámica.
  - Permite simular el comportamiento del sistema en el **modo transiente** (a lo largo del tiempo) o en el **modo estacionario** (en equilibrio).

 2. `hydrogen_model.m`

Modelo de ecuaciones diferenciales que describe el comportamiento del sistema de almacenamiento de hidrógeno líquido. Este código es utilizado dentro de `eficiencia_energetica.m` para resolver las ecuaciones de temperatura, presión y fracción molar de para-hidrógeno.

3. `hydrogen_stationary.m`

Función que resuelve el modelo de estado estacionario. Se utiliza para calcular el equilibrio del sistema sin considerar el paso del tiempo.

### Requisitos

Para ejecutar este código, necesitas tener instalado lo siguiente:

- **MATLAB** (R2016a o posterior)
- **MATLAB App Designer** (para `uifigure` y controles interactivos como sliders y dropdowns)
- **Solver `ode45`** para resolver las ecuaciones diferenciales.

### Instrucciones de Uso

#### 1. Preparación de Archivos

1. Descarga o clona este repositorio en tu máquina local.
2. Asegúrate de tener todos los archivos de código en la misma carpeta o directorio de trabajo en MATLAB.

#### 2. Ejecutar los Scripts

1. Abre **MATLAB** y navega hasta el directorio donde están los archivos descargados.
2. Ejecuta el archivo `eficiencia_energetica.m`.
3. Ajusta los parámetros tal como lo deseas.

#### 3. Salidas de los modelos
Gráfico de eficiencia energética: El gráfico de eficiencia se actualiza dinámicamente con las curvas de primera ley y segunda ley de la termodinámica. Muestra cómo cambia la eficiencia a lo largo del tiempo, o en el caso estacionario, muestra un valor constante.

Las eficiencias se grafican en función del tiempo (para el modo transiente), o como valores constantes (en el modo estacionario).

#### 4. Resultados esperados
Al ajustar los parámetros de la simulación y ejecutar el modelo:
- Modo Transiente: Verás dos curvas de eficiencia: una para la primera ley y otra para la segunda ley, que muestran cómo varían con el tiempo.
- Modo Estacionario: Verás líneas horizontales para ambas eficiencias, representando los valores de equilibrio.

Además, podrás ajustar:
- Temperatura ambiente: Entre 250 K y 310 K.
- Flujo de energía: Entre 0 W y 500 W.
- Masa de hidrógeno: Entre 1 kg y 100 kg.
