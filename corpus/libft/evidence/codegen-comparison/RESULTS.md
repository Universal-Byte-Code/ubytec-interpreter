# Qué hace C mejor y cómo especializar la reducción

La comparación del código generado identifica el tráfico de pila y marco como la diferencia principal del recorrido de bytes. En la función actual DiagBytes de Ubytec, cada iteración válida ejecuta 28 instrucciones, cuatro lecturas y diez escrituras. Las escrituras son accesos arquitectónicos de pila o marco; no representan diez escrituras independientes a DRAM. El conteo incluye condición y salto de vuelta, y excluye entrada, salida y la comprobación final fallida.

El bucle escalar de GCC contiene cinco instrucciones: cargar un byte, avanzar el puntero, sumar, comparar y saltar. No escribe intermediarios en memoria. Clang escalar desenrolla ocho bytes por vuelta. En registros de 24 bytes, GCC avanza el puntero 24 bytes y suma el campo directamente desde memoria; Ubytec sigue materializando el cálculo base más índice por 24 más 16 y sus temporales.

En las dos versiones C con vectorización automática, el sumatorio se transforma en cargas vectoriales y extensiones de byte a word, dword o qword antes de sumar. El candidato especializado usa PSADBW o VPSADBW con un vector de ceros para sumar grupos de ocho bytes sin esa cadena de extensiones. La versión AVX2 trabaja con cuatro acumuladores independientes y bloques de 128 bytes, reduce sus cuatro carriles al final y procesa el resto con lecturas de byte. No lee fuera del rango solicitado.

El código candidato es un fixture nativo con ABI Linux System V para RAM ordinaria de sólo lectura. No constituye un opcode implementado, un nuevo backend de Ubytec ni una transformación ya justificada para cualquier LOAD raw. La tabla mezcla deliberadamente el compilador actual y candidatos de rendimiento para cuantificar el objetivo, no para afirmar que tienen todos los mismos canales observables de memoria interna.

## Medidas de ejecución

AMD Ryzen 7 1700 bajo WSL; GCC 9.4 y Clang 10. Cada tamaño usa cinco calentamientos y 40 muestras, con las diez variantes intercaladas y su orden rotado dentro del mismo proceso. Las entradas, el resultado y la operación matemática son idénticos. La misma referencia C se compila tanto con el perfil escalar anterior como con -O3 -march=native; este segundo perfil permite la vectorización automática.

| Variante | 256 bytes ns | 4 KiB ns | 64 KiB microsegundos |
| --- | ---: | ---: | ---: |
| ubytec_frame_registers | 887.45 | 13840.59 | 218.070 |
| gcc_O2_scalar | 100.70 | 1358.40 | 27.638 |
| clang_O2_scalar | 75.94 | 1329.37 | 21.263 |
| gcc_O3_native | 55.70 | 886.79 | 14.270 |
| clang_O3_native | 44.27 | 680.79 | 10.747 |
| candidate_scalar4 | 71.15 | 999.64 | 16.099 |
| candidate_sse2 | 15.35 | 207.66 | 3.215 |
| candidate_avx2 | 8.15 | 82.37 | 1.296 |
| gcc_intrinsics_avx2 | 8.56 | 85.15 | 1.295 |
| clang_intrinsics_avx2 | 7.05 | 82.57 | 1.297 |

La versión AVX2 especializada supera la vectorización automática de estas versiones de GCC y Clang en este kernel y equipo. C con intrínsecos AVX2 implementando la misma estrategia alcanza prácticamente el mismo tiempo. La evidencia muestra una mejora de selección de instrucciones y especialización; no demuestra una ventaja inherente de Ubytec sobre C ni una ventaja universal frente a otros compiladores o bibliotecas. El proveedor y el cliente no usan LTO. P95, muestras y opciones de compilación están en report.json.

## Validación de los candidatos

10.360 comprobaciones pasan: 23 longitudes en 32 alineaciones, 256 longitudes pseudoaleatorias y extremos de buffers junto a páginas inaccesibles. Cada una compara las diez variantes con el resultado esperado. Se incluyen longitud cero y restos de bloques de 4, 16, 32 y 128 bytes; no se permite lectura anterior o posterior al buffer. AVX2 se selecciona sólo si la CPU lo admite.

Esta validación cubre los nuevos fixtures. La suite previa de 695 pruebas del compilador no necesita repetirse: el compilador no cambia en este experimento. No se ejecuta una nueva regresión del monitor ni se atribuye al analizador completo la ganancia de este kernel.

## Integración que justifica el siguiente cambio

La prioridad es que una operación de pila lógica no materialice cada intermediario en la pila física. La IR debe representar valores y control entre bloques, conservar sumas e índices en registros, plegar direcciones y reducir el índice multiplicado a avance de puntero. La copia de marco en registros implementada anteriormente elimina algunas lecturas; conserva precisamente las diez escrituras que todavía distinguen este bucle de C.

Para retirar esas escrituras hay que establecer qué memoria puede observar el consumidor. Un puntero raw puede apuntar a locales o celdas residuales. Una especialización puede apoyarse en un contrato independiente de RAM y regiones que no solapan esa memoria, o comprobar dinámicamente el rango y usar el backend de respaldo para los aliases. Debe preservar también los efectos finales de las celdas que un anfitrión pueda observar, y justificar las observaciones en fallos. No basta con que la entrada del benchmark sea un buffer separado.

La reducción SIMD necesita además garantizar RAM ordinaria: agrupar byte LOAD en cargas anchas no preserva automáticamente un dispositivo de memoria o una lectura volátil. Una vez demostrado ese contrato, el backend puede reconocer la reducción y emitir SSE2 o AVX2 con una cola exacta y selección de CPU. Esa es una optimización de compilación para la misma suma, no una reescritura del analizador para facilitar la comparación.

No hace falta prometer que ningún C pueda igualarnos. La meta concreta es generar código equivalente al escalar óptimo cuando corresponda y reconocer patrones que los compiladores C aquí probados no seleccionan automáticamente. La combinación de un backend que elimine intermediarios observacionalmente irrelevantes y kernels especializados es la vía que este experimento respalda.

## Reproducción

```sh
python3 corpus/libft/run_codegen_comparison.py \
  --ubytec-assembly artifacts/frame-registers/paired/registers.nasm \
  --output artifacts/codegen-comparison
```

El ensamblado Ubytec del experimento y todos los desensamblados se conservan junto a este archivo. Sus hashes y los de los fixtures se han contrastado con report.json. El hardware y las versiones de compilador limitan el alcance de las cifras.
