# AVX2 nativo: mecanismo y resultados

Fecha de sesión: 2026-10-06. Backend Linux x64 mediante WSL, AMD Ryzen 7 1700, NASM y .NET 10. Se integra `--block-reductions-native` en el compilador, desactivada por defecto. El [contrato](../../BLOCK-REDUCTIONS.md) describe reconocimiento, perfil de RAM estable y selección de ISA.

## Selección y garantías

La detección se realiza al compilar mediante `Avx2.IsSupported`: elige AVX2 si CPU y sistema operativo lo permiten y SSE2 en caso contrario. El artefacto requiere la ISA seleccionada; mover un ensamblado AVX2 a otra CPU no provoca una selección nueva. `--block-reductions` sigue emitiendo SSE2 portable. No se ejecuta CPUID ni se escribe una caché de selección en cada llamada.

Ambas rutas comparten el guard de separación respecto del frame y la evaluación, comprobaciones de envoltura y direcciones, planificación por páginas de 4 KiB, probe escalar, publicación del ledger y respaldo escalar. La ruta AVX2 usa cuatro acumuladores y procesa 128 bytes en 16 instrucciones, con cuatro cargas alineadas y ninguna escritura en ese cuerpo. El tramo conserva el límite de 16 bytes; cargas VEX128 cubren el puente de alineación y la cola sin perder los carriles superiores del acumulador. `VZEROUPPER` precede a la publicación. No se añaden permisos, timeouts ni opcodes.

## Medidas

Medianas en **microsegundos por invocación**, mismo puntero y longitud en todas las variantes. Cinco calentamientos y 40 muestras intercaladas en orden rotatorio. Esta ejecución se realizó después de concluir pruebas y regresiones, sin ejecutar esas tareas simultáneamente. La columna de proporción divide SSE2 entre AVX2; menos de 1 indica que SSE2 fue más rápida.

| Bytes | Ubytec SSE2 | Ubytec AVX2 | GCC con intrínsecos AVX2 | Clang con intrínsecos AVX2 | SSE2 / AVX2 |
| --- | ---: | ---: | ---: | ---: | ---: |
| 256 | 0.014 | 0.016 | 0.010 | 0.007 | 0.893× |
| 4,096 | 0.106 | 0.099 | 0.085 | 0.085 | 1.081× |
| 65,536 | 1.441 | 1.399 | 1.295 | 1.289 | 1.030× |
| 262,144 | 5.660 | 5.517 | 5.179 | 5.156 | 1.026× |
| 1,048,576 | 29.823 | 22.102 | 21.409 | 20.733 | 1.349× |
| 16,777,216 | 1147.876 | 1095.939 | 1153.517 | 1048.716 | 1.047× |

En 64 KiB, AVX2 consume aproximadamente **8.1%** más tiempo que GCC con intrínsecos AVX2 en esta ejecución. Su p95 es **2.832 µs**, frente a **2.544 µs** de SSE2. Las muestras muestran variabilidad y una diferencia pequeña de mediana no demuestra una ventaja estable en otros equipos.

La anchura de 256 bits no produce una mejora uniforme de 2×: esta máquina muestra ganancias modestas en varios tamaños y una regresión en 256 bytes. Para 1 MiB la reducción de tiempo medida es mayor; no se extrapola a cualquier tamaño, CPU o aplicación. La opción nativa elige una ISA disponible, sin un autotuner que demuestre cuál es más rápida para cada entrada. Se mantienen las dos opciones para poder compararlas.

GCC y Clang automáticos (`-O3 -march=native`), C escalar y prototipos manuales están también en `comparison-report.json`. El C con estrategia explícita puede igualar o superar la emisión Ubytec. La comparación preserva el resultado de cada programa; los kernels de C no ofrecen el ledger físico específico de Ubytec. No se aisló el coste causal de ese ledger mediante una variante que lo eliminara: el margen restante no puede atribuirse íntegramente a esa garantía.

La geometría registrada en CPU0 incluye L1D de 32 KiB, L2 de 512 KiB y L3 de 8 MiB por grupo, líneas de 64 bytes. No se recogieron contadores de hardware; estas medidas no prueban saturación de caché, misses concretos ni ancho de banda máximo. La variación por tamaño sigue siendo evidencia de esta ejecución.

## Validación

- **874 pruebas completas**, sin fallos ni omisiones. La matriz incluye la opción nativa, aliases de locales y evaluación, desbordamiento aritmético, índices iniciales, intervalos desalineados, bucles vacíos y fallback. Las pruebas vectoriales recorren 32 alineaciones y cruzan páginas verificando resultado, dos variables y tres celdas residuales.
- **179 pruebas de reducción repetidas con AVX2 desactivado**, sin fallos ni omisiones. La API y la CLI seleccionan SSE2 y el driver comprueba que la compilación forzada no contiene YMM ni `VZEROUPPER`.
- **13.468 comprobaciones** sobre 13 variantes, con 32 alineaciones, tamaños cortos, entradas aleatorias y rangos junto a páginas inaccesibles.
- **19 SIGSEGV y seis SIGBUS por anfitrión GCC/Clang**, sobre cinco variantes: referencia, escalar, SSE2, nativa AVX2 y nativa con fallback SSE2. Coinciden señal, código, dirección, dos variables, tres celdas de evaluación y RSP. No se exige igualdad de registros temporales ni trazas.
- **114 casos de préstamos protegidos**, con dos anfitriones y tres variantes. El cuerpo AVX2 se ejecuta dentro del trabajador protegido. Se comprueban resultado independiente, vecinos, denegación sin lanzamiento, fallo fuera del mapping y recuperación en otra invocación.
- La aplicación completa pasa **52 casos protegidos por anfitrión GCC/Clang**, además del oráculo independiente, I/O, sanitizadores C y regresión tipada. El informe tipado conserva transporte, solicitudes malformadas e identidad del trabajador. Esta ejecución valida los patrones que siguen en el backend anterior; no demuestra una mejora de velocidad de toda la aplicación.

El destino declarado del proyecto sigue siendo `net9.0`; la ejecución local emplea .NET 10 con el override `artifacts/observable-contract/Runtime.props`. Windows, runtime .NET 9 y CI remota no se ejecutaron aquí. La CI incluye la nueva opción y el respaldo forzado, sin umbral de velocidad.

## Evidencia y reproducción

SHA-256 del DLL probado: `a72a58575ce04ab77079d3191081f0e31db12a00af9cd64477d40f80ca12a21b`.

`report.json` incluye los hashes de fuentes y ensamblados, auditoría de los cuerpos SIMD, elección nativa y fallback. `comparison-samples.jsonl` guarda las muestras; los desensamblados permiten inspeccionar los kernels generados. `full.trx`, `forced-sse2.trx`, `protected-report.json`, `text-report.json` y `typed-report.json` conservan los resultados. `sources/` incluye snapshots del compilador, pruebas, contratos, fixtures, monitor y runners incluidos en la procedencia registrada. Sus hashes se verificaron contra los archivos utilizados. `snapshot-sha256.json` permite verificar este conjunto congelado.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
DOTNET_EnableAVX2=0 dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release \
  --filter 'FullyQualifiedName~BlockReductionTests|FullyQualifiedName~LoopReductionTests'
python3 corpus/libft/run_block_reduction_loans.py --native-block-reductions \
  --output artifacts/avx2-reductions/protected
python3 corpus/libft/run_text.py --stack-transfers --frame-registers \
  --block-reductions-native --output artifacts/text-avx2-reductions
python3 corpus/libft/run_avx2_reductions.py --output artifacts/avx2-reductions/paired
```

Con el SDK local se añade `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"` a las pruebas. Los runners aceptan `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`. `--verify-only` del driver nativo valida sin medir; el benchmark debe ejecutarse solo después de las regresiones. Las limitaciones del contrato permanecen explícitas y la evidencia anterior de SSE2 se conserva separadamente.
