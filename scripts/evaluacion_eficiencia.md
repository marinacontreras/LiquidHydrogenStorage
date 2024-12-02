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
Este repositorio contiene un código MATLAB para simular y calcular la eficiencia energética de un sistema de almacenamiento de hidrógeno líquido. El modelo tiene en cuenta dos aspectos clave de la termodinámica:

1. **Primera ley de la termodinámica** (Conservación de la energía)
2. **Segunda ley de la termodinámica** (Eficiencia exergética)

La interfaz permite al usuario ajustar parámetros del sistema mediante controles deslizantes (sliders) y observar cómo estos afectan a la eficiencia energética tanto en el **modo transiente** como en el **modo estacionario**.

### Requisitos

Para ejecutar este código, necesitas tener instalado lo siguiente:

- **MATLAB** (R2016a o posterior)
- **MATLAB App Designer** (para `uifigure` y controles interactivos como sliders y dropdowns)
- **Solver `ode45`** para resolver las ecuaciones diferenciales.

### Archivos en el Repositorio

1. `eficiencia_energetica.m`

Este es el script principal que crea la interfaz interactiva y ejecuta la simulación. 

**Funciones**:
- **Eficiencia de la primera ley**: Calcula la eficiencia energética desde el punto de vista de la conservación de la energía.
- **Eficiencia de la segunda ley**: Calcula la eficiencia energética teniendo en cuenta las pérdidas por entropía (irreversibilidades).
- **Simulaciones**:
  - **Modo Transiente**: Resuelve el sistema a lo largo del tiempo utilizando un modelo de ecuaciones diferenciales.
  - **Modo Estacionario**: Calcula el estado de equilibrio del sistema, donde las variables no cambian con el tiempo.

2. `hydrogen_model.m`

Modelo de ecuaciones diferenciales que describe el comportamiento del sistema de almacenamiento de hidrógeno líquido. Este código es utilizado dentro de `eficiencia_energetica.m` para resolver las ecuaciones de temperatura, presión y fracción molar de para-hidrógeno.

3. `hydrogen_stationary.m`

Función que resuelve el modelo de estado estacionario. Se utiliza para calcular el equilibrio del sistema sin considerar el paso del tiempo.

### Requisitos del Sistema

El código fue diseñado para simular un sistema de almacenamiento de hidrógeno líquido basado en parámetros físicos típicos. Los parámetros de simulación incluyen:

- **Temperatura ambiente (`Tamb`)**: Ajustable mediante un slider en la interfaz.
- **Flujo de energía (`Q`)**: Ajustable mediante un slider.
- **Masa de hidrógeno (`m`)**: Ajustable mediante un slider.
- **Modo de simulación**: Puedes elegir entre el **modo transiente** (con variaciones de tiempo) y el **modo estacionario** (equilibrio).

### Instrucciones de Uso

#### 1. Ejecutar el Código

1. Abre **MATLAB** y navega hasta el directorio que contiene los archivos del repositorio.
2. Ejecuta el archivo `eficiencia_energetica.m` desde la ventana de comandos de MATLAB.

   ```matlab
   eficiencia_energetica
