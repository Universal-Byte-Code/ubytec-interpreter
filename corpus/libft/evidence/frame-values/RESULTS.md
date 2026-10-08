# Reutilización de valores del marco: resultados

Implementación opcional `--frame-values`, desactivada por defecto. Se compara la pasada de transferencias de pila sola con esa misma pasada más la reutilización de valores. Las entradas y el compilador son idénticos en ambos modos. Conserva todas las escrituras, registros finales y flags; no atraviesa alias desconocidos, pila, llamadas, saltos o cambios del marco.

## Lecturas del marco en el ensamblador

| Función | Sólo transferencias | Más reutilización |
|---|---:|---:|
| ArenaFind | 12 | 11 |
| ArenaAlloc | 55 | 52 |
| ArenaFree | 33 | 31 |
| ft_atoi | 11 | 9 |
| VectorInit | 15 | 14 |
| VectorValidate | 27 | 26 |
| VectorMutable | 9 | 7 |
| VectorEnsure | 22 | 20 |
| VectorSourceMode | 32 | 29 |
| VectorPush | 7 | 6 |
| VectorLength | 4 | 3 |
| VectorCapacity | 4 | 3 |
| VectorErase | 40 | 39 |
| VectorClear | 6 | 5 |
| VectorPin | 8 | 6 |
| VectorUnpin | 8 | 6 |
| TextSort | 25 | 24 |
| TextFlush | 42 | 39 |
| TextFeed | 13 | 12 |
| TextTotal | 9 | 8 |
| DiagLookup | 18 | 17 |

Son recuentos estáticos del cuerpo de cada función, no cantidades ejecutadas ni tiempos. La pasada es conservadora: los bucles de DiagBytes y DiagRecords conservan sus lecturas.

## Tiempo de ejecución

Linux x64 sobre WSL; cinco calentamientos y 30 muestras por GCC/Clang. Cada modo se mide en proceso separado, primero transferencias y luego transferencias más reutilización; no hay intercalado aleatorio. Las variaciones temporales y de colocación del código impiden atribuir diferencias pequeñas a una ganancia universal.

| Kernel | Base ns/llamada GCC | Más reutilización ns/llamada GCC | Factor GCC | Factor Clang |
|---|---:|---:|---:|---:|
| identity | 6.95 | 7.05 | 0.99× | 0.99× |
| bytes-65536 | 351673.16 | 342899.31 | 1.03× | 0.98× |
| records-256 | 1432.21 | 1511.17 | 0.95× | 0.95× |
| lookup-256-last | 14845.87 | 10743.03 | 1.38× | 1.07× |

El informe JSON contiene los 16 casos, p95, resultados y muestras originales. C permanece escalar, sin vectorización, libc ni LTO. Estas medidas incluyen la ABI de entrada; no son tiempos de compilación.

| Texto en memoria | Base ms GCC | Más reutilización ms GCC | Factor GCC | Factor Clang |
|---|---:|---:|---:|---:|
| 4096-v4-uniform-b4096 | 1.593 | 1.818 | 0.88× | 1.24× |
| 4096-v256-uniform-b4096 | 7.244 | 6.972 | 1.04× | 1.04× |
| 65536-v64-uniform-b4096 | 51.044 | 49.696 | 1.03× | 1.12× |

Los tiempos del texto incluyen el cierre del token, sin supervisor ni archivos. La regresión protegida valida comportamiento y contención; no se ha medido una nueva mediana completa bajo aislamiento.

## Validación y decisión

641 pruebas .NET; 20 casos nuevos sobre valores completos, flags, registros parciales, alias, solapamientos y barreras. La primera ejecución general se abortó por un fixture que alcanzaba el marco del ejecutor; el fixture se corrigió y la suite completa final pasó. No se presenta aquella ejecución abortada como una validación.

52 casos de aplicación y ataques por GCC/Clang, 17 comprobaciones de préstamos por variante y pruebas de transporte y solicitudes malformadas. Kernels y cargas de texto coinciden con C y liberan la arena. Hashes de fuentes, ensamblados y compilador verificados. ASan/UBSan instrumenta los componentes C de la regresión, no NASM. CI remota no ejecutada.

La opción permanece experimental y desactivada por defecto. Supone RAM ordinaria del marco sin escrituras concurrentes/asíncronas; no ofrece lecturas volátiles ni trazas idénticas. Esta pasada reduce algunas lecturas locales; no resuelve la asignación global de registros ni el mantenimiento de valores a través de bucles. El siguiente cambio con mayor alcance requiere representar efectos de memoria, estado de pila y control de flujo antes de extender la vida de los valores.

Las medidas de texto muestran ganancias pequeñas en los casos de mayor vocabulario y una regresión en el caso pequeño con GCC. No hay una mejora uniforme demostrada; esta evidencia no justifica activar la opción por defecto. Antes de ampliar las optimizaciones se prioriza una representación de operaciones con efectos explícitos de pila, memoria y control de flujo.
