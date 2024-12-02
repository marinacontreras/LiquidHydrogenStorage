# Simulación Interactiva de Almacenamiento de Hidrógeno Líquido

Este proyecto implementa una simulación interactiva para modelar el comportamiento de un sistema de almacenamiento de hidrógeno líquido bajo diferentes condiciones operativas de temperatura, presión y flujo de energía. La simulación permite analizar la dinámica del proceso y las condiciones de equilibrio del sistema.

## **Descripción General**

La simulación interactiva se basa en el modelo termodinámico planteado previamente. Es decir, el sistema simula los siguientes fenómenos clave:
- **Transferencia de calor** entre el tanque y el ambiente.
- **Pérdidas por boil-off** debido a la evaporación del hidrógeno líquido.
- **Dinámica de presión interna** en el tanque.
- **Conversión orto-para** del hidrógeno, liberando calor adicional.
- **Balance energético** para determinar la evolución de la temperatura interna.

El usuario puede ajustar varios parámetros operativos y elegir entre dos tipos de simulación:
1. **Estado estacionario**: Calcula las condiciones de equilibrio del sistema.
2. **Estado transiente**: Simula la evolución dinámica del sistema en función del tiempo.

---

## **Requisitos**

- MATLAB R2021a o superior.
- Se recomienda una comprensión básica de sistemas dinámicos y ecuaciones diferenciales.

---

## **Archivos Incluidos**

### Scripts principales
- `simulacion_interactiva.m`: Controla la simulación interactiva y permite al usuario elegir parámetros y modos de simulación.
- `hydrogen_storage.m`: Define las ecuaciones diferenciales que describen la dinámica del sistema.
- `LiquidHydrogenStorage.m`: Implementa la simulación completa para el estado transiente.

### Otros archivos
- `README.md`: Este archivo con la documentación.
- Carpeta `images/`: Gráficos de ejemplo generados por la simulación.

---

## **Cómo Usar la Simulación**

### 1. Clonar el repositorio
Clona este repositorio en tu máquina local:
```bash
git clone https://github.com/tu_usuario/LiquidHydrogenStorage.git
