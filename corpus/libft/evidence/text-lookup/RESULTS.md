# Búsqueda del diccionario: validación una vez por palabra

TextFlush valida los vectores y sus tamaños antes de escanear los registros. El recorrido no asigna memoria, invoca callbacks ni conserva punteros tras el crecimiento. Las APIs públicas de vectores, el compilador y los permisos del aislamiento no cambian. Vectores fijados se rechazan antes de modificar contadores.

## Medidas

WSL Linux x64; cinco calentamientos y treinta muestras por caso y compilador. Comparación con la evidencia histórica guardada, mismos bytes de entrada y salida. Las ejecuciones ocurrieron en momentos distintos: los factores son observaciones de este entorno, no una garantía universal.

| Caso | Feed anterior ms | Feed actual ms | Factor | Protegido anterior ms | Protegido actual ms | p95 actual ms |
|---|---:|---:|---:|---:|---:|---:|
| 4096-v4-uniform-b64 | 2.367 | 2.878 | 0.82× | 19.730 | 20.514 | 29.944 |
| 4096-v4-uniform-b4096 | 2.393 | 2.839 | 0.84× | 15.285 | 18.929 | 26.834 |
| 4096-v64-uniform-b4096 | 19.825 | 5.847 | 3.39× | 54.568 | 49.028 | 53.984 |
| 4096-v256-uniform-b4096 | 186.675 | 13.292 | 14.04× | 304.925 | 137.131 | 146.360 |
| 65536-v64-uniform-b4096 | 332.217 | 76.593 | 4.34× | 373.065 | 114.512 | 127.064 |
| 1048576-v4-uniform-b4096 | 621.899 | 685.322 | 0.91× | 695.694 | 725.240 | 769.031 |
| sort-v64-descending-b4096 | 331.676 | 72.726 | 4.56× | 386.374 | 130.047 | 150.152 |
| empty | 0.000 | 0.000 | 0.77× | 9.099 | 9.387 | 12.124 |

La tabla resume GCC; summary.json incluye GCC y Clang, p95 anteriores y actuales. El tiempo protegido incluye proceso, IPC, E/S, publicación y cierre; no mide únicamente el cálculo. El perfil instrumentado sirve para contar recorridos y altera los tiempos.

| Perfil | Visitas anteriores | Visitas actuales | Reducción |
|---|---:|---:|---:|
| 4096-v4-uniform-b4096 | 43,998 | 40,326 | 8.35% |
| 4096-v64-uniform-b4096 | 710,826 | 84,730 | 88.08% |
| 4096-v256-uniform-b4096 | 7,729,098 | 284,538 | 96.32% |
| 65536-v256-uniform-b4096 | 164,204,490 | 3,221,370 | 98.04% |

## Validación y límites

606 pruebas .NET; 52 casos de aplicación y ataques por compilador; regresión de préstamos tipados; matriz funcional completa de 45 casos con GCC y Clang. Ocho casos medidos con 30 muestras; la matriz completa con 30 muestras no se ha ejecutado. Los 16 kernels equivalentes y cuatro perfiles siguen coincidiendo con C. Las fuentes, ensamblados y entradas tienen hashes comprobados.

Las pruebas nuevas cubren fijación del token/diccionario, tamaños incorrectos, crecimiento y coincidencia en el último registro, desbordamiento de frecuencia y limpieza. ASan/UBSan cubre componentes C de la regresión y del diagnóstico, no el NASM generado. No se ha ejecutado CI remota.

La búsqueda y la ordenación continúan siendo lineal e inserción respectivamente. El caso con poco vocabulario puede ganar poco o incluso empeorar por las comprobaciones de mutabilidad; los resultados se muestran sin ocultarlo. El siguiente frente es estudiar el código generado con los kernels equivalentes guardados, especialmente push/pop y cargas de locales, sin atribuirle el coste del diccionario.
