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

