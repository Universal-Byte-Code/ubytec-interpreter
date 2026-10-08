# Reducciones por bloques y resultados

Fecha de la sesión: 2026-10-06. Backend Linux x64 mediante WSL, AMD Ryzen 7 1700, NASM y .NET 10. La opción `--block-reductions` está integrada en el compilador y desactivada por defecto. Reconoce el mismo patrón de reducción que la opción escalar, con guard de intervalo y respaldo para aliases. El [contrato](../../BLOCK-REDUCTIONS.md) detalla su perfil de RAM ordinaria estable y las observaciones conservadas.

## Medidas

Medianas en **microsegundos por invocación**. Cinco calentamientos y 40 muestras intercaladas con orden rotatorio en un mismo proceso. Todas las variantes reciben el mismo puntero y longitud y comprueban el resultado. Esta ejecución final se realizó después de concluir las regresiones, sin ejecutarlas en paralelo.

| Bytes | Ubytec escalar | Ubytec SSE2 | GCC automático | Clang automático | GCC con intrínsecos AVX2 | Escalar / SSE2 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 256 | 0.608 | 0.015 | 0.056 | 0.044 | 0.009 | 41.31× |
| 4,096 | 9.584 | 0.098 | 0.872 | 0.673 | 0.085 | 97.91× |
| 65,536 | 153.509 | 1.428 | 14.127 | 10.709 | 1.295 | 107.47× |
| 262,144 | 621.604 | 6.151 | 57.037 | 42.424 | 5.218 | 101.05× |
| 1,048,576 | 2429.504 | 25.125 | 224.631 | 171.186 | 21.361 | 96.70× |
| 16,777,216 | 40768.877 | 1126.590 | 3842.993 | 3026.909 | 1103.463 | 36.19× |

Para 64 KiB, el p95 pasa de **179.558 µs** en la reducción escalar a **2.293 µs** en la nueva vía. El JSON conserva p95, muestras y todas las variantes, incluidos frame registers y los prototipos manuales SSE2/AVX2.

La mejora procede de la emisión de un recorrido por bloques: el cuerpo tiene 16 instrucciones por 64 bytes, cuatro cargas SIMD y ninguna escritura de memoria. La preparación, el probe, la reducción horizontal, el ledger y las colas añaden trabajo fuera de ese cuerpo. Se materializan ocho escrituras de frame y evaluación por tramo vectorial, en lugar de siete por byte. No se atribuye este resultado a toda la aplicación ni al lenguaje en general.

El C automático usa GCC/Clang locales y `-O3 -march=native`; las versiones y flags exactos están en el informe. C con la estrategia explícita de intrínsecos puede igualar o superar la emisión Ubytec; el resultado no demuestra superioridad frente a C como lenguaje. El perfil de C y de los prototipos no conserva la imagen física del frame de Ubytec.

Los tamaños atraviesan distintos niveles de caché. El equipo muestra L1D de 32 KiB, L2 de 512 KiB por núcleo y L3 de 8 MiB por grupo registrado en CPU0; los datos compartidos y las líneas de 64 bytes están en `cache_geometry_cpu0`. No se recogieron contadores de hardware: las medidas no demuestran saturación de caché ni permiten atribuir todos los costes a misses.

## Validación

- **792 pruebas completas**, sin fallos ni omisiones, en Linux x64 y .NET 10. La matriz combina las ocho opciones anteriores con la nueva opción de bloques. Cubre aliases de locales y celdas de evaluación, un intervalo de 128 bytes que solapa el frame, lecturas desalineadas, bucles vacíos, direcciones con envoltura y casos de respaldo. Las pruebas vectoriales cruzan páginas con 16 alineaciones, semilla que envuelve y un índice inicial distinto de cero; verifican ambas variables y las tres celdas residuales.
- **12,432 comprobaciones** de resultados y límites sobre 12 variantes, con tamaños pequeños, 32 alineaciones, entradas aleatorias y rangos junto a páginas inaccesibles.
- **19 casos de SIGSEGV y seis de SIGBUS por cada anfitrión GCC/Clang**, sobre la referencia, reducción escalar y reducción por bloques. Coinciden señal, código, dirección, ambas variables, tres celdas de evaluación y RSP. Los observers usan procesos hijos y pila de señales independiente. No se promete identidad de registros temporales, código o trazas por instrucción.
- **76 casos de préstamos protegidos**: dos anfitriones y dos variantes de reducción, con lectura autorizada, resultado independiente, vecinos, denegación sin lanzamiento, fallo fuera del mapping y recuperación en una llamada nueva. El ensamblado protegido incluye y ejecuta el cuerpo SSE2.
- La regresión del analizador completo pasa **52 casos protegidos por anfitrión GCC/Clang**, además del oráculo independiente y pruebas de I/O. Se conserva la regresión tipada, transporte y solicitudes malformadas; sus informes están incluidos. Estos patrones usan el respaldo, y esta ejecución no mide una mejora de la aplicación completa. Los sanitizadores instrumentan los componentes C, no el NASM.

El repositorio mantiene `net9.0`; la validación local usa el override de .NET 10 conservado en `Runtime.props`. Windows, .NET 9 y la CI remota no se ejecutaron en esta sesión. La CI incorpora los runners sin umbral de velocidad.

## Evidencia y reproducción

SHA-256 del DLL probado: `ac21715c4983dfcd3fe372c333d4e7ae4a88d8c681ce5fc24c1cc52069ff41aa`.

`report.json` fija hashes de fuentes, compilador y ensamblados; `comparison-samples.jsonl` contiene muestras y `comparison-*.disasm` el código máquina. `protected-report.json` y `text-report.json` conservan los préstamos y la regresión completa. `full.trx` acredita la suite. Se incluyen snapshots de las fuentes modificadas y del contrato, fixtures y runners; sus hashes se comprobaron contra los archivos actuales antes de guardar esta evidencia.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_block_reductions.py --output artifacts/block-reductions/paired
python3 corpus/libft/run_block_reduction_loans.py --output artifacts/block-reductions/protected
python3 corpus/libft/run_text.py --stack-transfers --frame-registers \
  --block-reductions --output artifacts/text-block-reductions
```

Con el SDK disponible localmente, el primer comando utiliza `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"`. Los runners usan `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`.
