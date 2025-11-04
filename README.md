Implementación del algoritmo de programación dinámica para el problema del agente viajero (TSP)
# Solucionador de TSP con Programación Dinámica en Julia

Este repositorio contiene la implementación del problema del agente viajero utilizando programación dinámica en el lenguaje Julia. El algoritmo implementado es conocido como el algoritmo de Held-Karp.

## Descripción del Algoritmo
La solución implementada utiliza programación dinámica con memoización para encontrar la ruta de costo mínimo que visita cada ciudad exactamente una vez antes de regresar a la ciudad de inicio.

El estado del problema se define mediante una tupla `(ciudad_actual, mascara_visitados)`:

Donde: 
* **`ciudad_actual`**: El índice de la ciudad donde se encuentra el vendedor.
* **`mascara_visitados`**: Una máscara de bits (un entero) que representa el conjunto de ciudades que ya han sido visitadas.

El algoritmo funciona de manera recursiva, explorando los caminos posibles. Para evitar cálculos redundantes, los resultados de los subproblemas (el costo mínimo para completar el recorrido desde un estado `(u, mascara)` específico) se almacenan en un diccionario de memoización (`memo`).

Si el algoritmo necesita resolver un subproblema que ya está en el `memo`, simplemente devuelve el valor almacenado en lugar de recalcularlo. Una vez que todas las ciudades han sido visitadas (`mascara` tiene todos los bits encendidos), la función devuelve el costo de regresar a la ciudad inicial (C1).

Finalmente, la ruta óptima se reconstruye siguiendo las decisiones óptimas (la `siguiente_ciudad`) guardadas en el `memo` desde el estado inicial.

## Dependencias
Este proyecto solo requiere una instalación estándar de **Julia**.
No se requieren paquetes externos. El proyecto utiliza los módulos estándar de Julia:
* `Printf`: Para formatear la salida en consola y archivos.
* `Random`: Para la generación de la matriz aleatoria y la fijación de la semilla.

## Estructura del Proyecto
El código está organizado en módulos de datos (`data/`) y módulos de código fuente (`src/`).

## Instrucciones de Ejecución
Los scripts `main` añaden automáticamente los directorios `src/` y `data/` al `LOAD_PATH` de Julia.

Hay dos puntos de entrada principales:
### 1. Problema de 10 ciudades (Datos fijos)
Este script ejecuta el algoritmo sobre una matriz de distancias simétrica y predefinida de 10 ciudades.

Para probar solo es necesario ejecutar el archivo main.jl
### 2. Problema de n ciudades (Datos random)
Este script ejecuta el algoritmo sobre una matriz de distancias simétrica y predefinida de n ciudades.

Para probar solo es necesario ejecutar el archivo main_matriz_random.jl
