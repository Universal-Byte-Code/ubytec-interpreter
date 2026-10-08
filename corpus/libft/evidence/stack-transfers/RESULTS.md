# Transferencias de pila: primera pasada del compilador

Implementación opcional `--stack-transfers`, desactivada por defecto. Sólo sustituye `push registro` seguido inmediatamente de `pop registro` y conserva la escritura en la celda consumida. No hay asignación global de registros ni eliminación de escrituras observables.

## Kernels equivalentes

Linux x64 sobre WSL, mismo compilador, fuentes y entradas en ambos modos; cinco calentamientos y 30 muestras por modo y GCC/Clang. C permanece escalar, sin vectorización, libc ni LTO. Cada modo se ejecuta en su propio proceso, primero normal y después optimizado; no se intercalan aleatoriamente.

| Kernel | Normal ns/llamada GCC | Optimizado ns/llamada GCC | Factor GCC | Factor Clang |
|---|---:|---:|---:|---:|
| identity | 7.23 | 7.09 | 1.02× | 1.00× |
| bytes-65536 | 522776.25 | 356902.91 | 1.46× | 1.49× |
| records-256 | 2361.67 | 1512.41 | 1.56× | 1.65× |
| lookup-256-last | 15409.43 | 11271.09 | 1.37× | 1.42× |

El informe JSON contiene los 16 casos, medianas, p95, muestras originales, resultados y comparación con C. Son tiempos de ejecución, no tiempos de compilación. La ABI de entrada está incluida.

| Función | Push/pop normales | Push/pop optimizados | Escrituras de pila conservadas |
|---|---:|---:|---:|
| DiagIdentity | 4 | 2 | 1 |
| DiagBytes | 20 | 6 | 7 |
| DiagRecords | 28 | 10 | 9 |
| DiagLookup | 62 | 20 | 21 |

Son recuentos estáticos del cuerpo de las funciones, no instrucciones ejecutadas ni medidas de tiempo.

## Aplicación de texto en memoria

| Caso | Normal ms GCC | Optimizado ms GCC | Factor GCC | Factor Clang |
|---|---:|---:|---:|---:|
| 4096-v4-uniform-b4096 | 2.275 | 1.642 | 1.39× | 1.81× |
| 4096-v256-uniform-b4096 | 13.381 | 7.784 | 1.72× | 1.76× |
| 65536-v64-uniform-b4096 | 75.404 | 59.398 | 1.27× | 1.44× |

Estos tiempos incluyen procesamiento y cierre del token en memoria, sin supervisor ni E/S de archivos. No se midió una mediana de la aplicación protegida: su regresión comprueba comportamiento y contención. Las APIs y el algoritmo del diccionario son los de la optimización anterior.

## Validación y alcance

621 pruebas .NET; 52 casos de aplicación protegida y ataques por GCC/Clang; 17 comprobaciones de préstamos por variante y pruebas de transporte/solicitudes malformadas. Los 16 kernels equivalentes y las tres cargas de texto coinciden con C y liberan la arena. Hashes de fuentes, ensamblados, fuentes compuestas y compilador verificados. No se ha ejecutado CI remota. ASan/UBSan cubre los componentes C de la regresión, no el ensamblador generado.

La opción conserva resultados, flags, pila final y memoria escrita en la celda consumida. No garantiza idénticas instrucciones, direcciones ni RSP transitorio ante observación asíncrona. No atraviesa llamadas, etiquetas ni instrucciones. El optimizador antiguo sigue desconectado.

El próximo paso puede estudiar almacenamiento temporal de valores en registros a través de varias operaciones, con análisis de efectos sobre memoria, llamadas y control de flujo; las celdas que el código unsafe pueda observar requieren un contrato explícito.
