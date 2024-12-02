# Simulación de Almacenamiento de Hidrógeno Líquido en MATLAB

## Modelo termodinámico
El modelo termodinámico está compuesto por dos scripts de MATLAB que simulan el comportamiento del almacenamiento de hidrógeno líquido utilizando el operador `ode45`. Ambos modelos se basan en ecuaciones diferenciales que describen la dinámica del sistema bajo condiciones controladas.

### Códigos disponibles

1. **`hydrogen_storage.m`**: Este código implementa el modelo termodinámico, compuesto por ecuaciones de transferencia de calor, pérdidas por boil-off, dinámica de presión, y conversión orto-para.
2. **`LiquidHydrogenStorage.m`**: Este código resuelve el modelo termodinámico para los parámetros iniciales dado. Genera gráficos de temperatura del tanque, presión en el tanque y fracción de para-hidrógeno.

### Requisitos

- **MATLAB R2021a** o superior.
- Toolbox: **Optimization** 

### Instrucciones de uso

#### 1. Preparación de los archivos
Los archivos MATLAB se encuentran en la carpeta `scripts`. Ambos scripts deben encontrarse guardados en la misma carpeta para que se pueda ejecutar el código.

#### 2. Ejecutar los scripts
El principal archivo con el cual se trabaja es el `LiquidHydrogenStorage.m`. El archivo `hydrogen_storage.m` no se debe modificar si solo se quieren cambiar los parámetros iniciales o condiciones de operación. Eventualmente, se puede modificar si se desea cambiar las ecuaciones del modelo termodinámico. Por ejemplo, se podrían agregar ecuaciones adicionales al modelo, como una ecuación para el efecto de agitación (*sloshing*). 
1. Abre el archivo `LiquidHydrogenStorage.m` en MATLAB. 
2. Define los parámetros iniciales dentro del script o modifica los valores según lo necesario.
3. Ejecuta el script. Esto generará tres gráficos:
  - La evolución de la presión en el tanque.
  - La temperatura interna del hidrógeno líquido.
  - La fracción molar de para-hidrógeno.

#### 3. Salidas de los modelos
Al ejecutar los scripts, se generarán las siguientes gráficas:
- Presión en el tanque: Muestra cómo cambia la presión interna del tanque de hidrógeno líquido a lo largo del tiempo.
- Temperatura: Muestra la variación de la temperatura interna del tanque.
- Fracción de para-hidrógeno: Muestra cómo la conversión orto-para afecta la composición del hidrógeno.

#### 4. Resultados esperados
Los resultados permiten analizar el comportamiento del sistema de almacenamiento de hidrógeno líquido bajo diferentes condiciones de operación. La simulación sirve paraa entender la dinámica de la presión, las pérdidas por boil-off, y el impacto de la conversión orto-para en la eficiencia del proceso.

## Simulación interactiva




