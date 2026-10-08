# Reducción de campos con stride: resultados

Fecha de sesión: 2026-10-06. Linux x64 mediante WSL, AMD Ryzen 7 1700, NASM y .NET 10. Se integra `--record-reductions`, desactivada por defecto. El [contrato](../../RECORD-REDUCTIONS.md) describe reconocimiento, inducción del cursor y estado observable.

El algoritmo del fixture no cambia: suma campos UInt64 de registros con stride 24 y offset 16, con resultado módulo `2^64`. La optimización reconoce instrucciones y bindings de la IR, no nombres ni entradas de benchmark. Otras constantes y aliases se prueban por separado. La dirección se calcula una vez y avanza por stride; cada iteración mantiene una carga exacta de ocho bytes y publica las cuatro celdas residuales del origen antes de ella.

## Comparación del kernel

Medianas en **microsegundos por invocación**. Ambos modos Ubytec tienen stack transfers y frame registers activados; el segundo añade la nueva opción. Cinco calentamientos y 40 muestras rotatorias intercaladas dentro de un proceso, con el mismo puntero, cantidad y resultado comprobado. Las mediciones se realizaron después de concluir las regresiones, sin ejecutarlas simultáneamente.

| Registros | Backend anterior | Record reductions | GCC escalar | Clang escalar | GCC nativo | Factor Ubytec |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 4 | 0.025 | 0.014 | 0.003 | 0.003 | 0.004 | 1.72× |
| 64 | 0.313 | 0.170 | 0.038 | 0.014 | 0.038 | 1.84× |
| 256 | 1.268 | 0.652 | 0.116 | 0.078 | 0.112 | 1.94× |
| 4,096 | 19.351 | 10.336 | 1.770 | 1.291 | 1.771 | 1.87× |
| 65,536 | 309.635 | 165.305 | 29.686 | 24.771 | 29.676 | 1.87× |

Para 256 registros, el p95 pasa de **1.539 µs** a **0.834 µs**. El cuerpo pasa de 40 a 17 instrucciones estáticas, de ocho PUSH/POP a ninguno y de 14 a ocho escrituras por vuelta. El producto por stride queda fuera del bucle. Estos recuentos describen la emisión, sin ser contadores de instrucciones ejecutadas o misses.

C sigue siendo más rápido en este recorrido. El nuevo cuerpo publica el ledger en cada vuelta, además de actualizar ambos locales; C conserva su propio resultado observable y no ofrece esa imagen física particular del frame de Ubytec. El experimento no aísla causalmente el coste de ese ledger, de la ABI ni de cada instrucción. No se atribuye todo el margen a una única garantía.

Las referencias C usan `memcpy` de ocho bytes para definir lecturas desalineadas, con el mismo stride y offset. Se incluyen GCC/Clang a `-O2` sin vectorización y a `-O3 -march=native`. Fuentes, versiones, flags, desensamblados y muestras completas están conservados. No hay LTO ni umbral de velocidad. La evidencia no demuestra paridad general con C.

## Aplicación completa

Medianas de la fase feed/count en **milisegundos**. Cinco calentamientos y 30 muestras intercaladas por modo y anfitrión, mismos bytes y algoritmo. Se comprueban salida y liberación de arena. `plain` y `registers` son los nombres históricos del harness; `text_modes` registra que ambos usan frame registers y que únicamente el segundo añade record reductions.

| Caso | Anfitrión | Anterior | Con record reductions | Factor |
| --- | --- | ---: | ---: | ---: |
| 4096-v4-uniform-b4096 | gcc | 1.573 | 1.584 | 0.993× |
| 4096-v4-uniform-b4096 | clang | 1.592 | 1.563 | 1.019× |
| 4096-v256-uniform-b4096 | gcc | 6.844 | 6.655 | 1.028× |
| 4096-v256-uniform-b4096 | clang | 6.561 | 6.652 | 0.986× |
| 65536-v64-uniform-b4096 | gcc | 43.407 | 44.417 | 0.977× |
| 65536-v64-uniform-b4096 | clang | 44.183 | 44.578 | 0.991× |

La auditoría encuentra **cero funciones reconocidas en ambos ensamblados del texto**. Sus recorridos incluyen llamadas, ramas o efectos fuera del patrón cerrado. Las pequeñas diferencias de tiempo no proceden de ejecutar esta optimización y no demuestran una mejora o regresión causal de la aplicación. No se ha cambiado la búsqueda lineal, la construcción de tokens ni las bibliotecas para provocar una ganancia artificial.

El siguiente frente sigue siendo ampliar la IR a bucles con ramas y búsquedas como `DiagLookup`. La reducción con stride es un paso verificable, no una implementación de asignación global, CFG/SSA o vectorización de registros. MetaDB puede describir layouts compatibles, pero este hito no modifica MetaDB ni el monitor.

## Validación

- **921 pruebas completas**, sin fallos ni omisiones; 47 pruebas nuevas de registros. Ocho combinaciones de stack transfers, frame values y frame registers, con el mismo ledger. Incluyen aliases de locales y cuatro celdas residuales, intervalos desalineados, semilla e índice inicial, envoltura del producto/dirección, constantes máximas, órdenes alternativos de bindings, bucles vacíos y patrones de respaldo.
- **7.044 comprobaciones** de seis variantes con 32 alineaciones, tamaños de cero a 65.536 registros, entradas aleatorias y datos junto a páginas inaccesibles. El oráculo reconstruye los valores byte a byte y suma UInt64 con envoltura.
- **66 SIGSEGV y 40 SIGBUS por anfitrión GCC/Clang**, comparando referencia y nueva ruta. Se ejercitan ocho posiciones de la carga respecto del límite, desde acceso completamente inaccesible hasta cargas que cruzan la página, y punteros bajos/fabricados con envoltura. Coinciden señal, código, dirección del fallo, dirección efectiva, dos variables, cuatro celdas de evaluación y RSP. Una pila alternativa evita que el observador sobrescriba el estado interrumpido.
- **64 casos de préstamos protegidos**, con dos anfitriones y dos rutas: resultado UInt64 independiente, bytes vecinos, denegación sin lanzamiento, fallo más allá del mapping y recuperación en una nueva invocación. El ensamblado protegido ejecuta realmente el cuerpo con stride.
- La aplicación completa pasa **52 casos protegidos por anfitrión GCC/Clang**, además de oráculo independiente, I/O, sanitizadores C y regresión tipada. El informe tipado conserva cinco pruebas de transporte, diez solicitudes malformadas e identidad del trabajador. Los sanitizadores C no instrumentan el NASM.

El repositorio mantiene `net9.0`. La ejecución local usa .NET 10 con `artifacts/observable-contract/Runtime.props`. Windows, .NET 9 y CI remota no se ejecutaron en esta sesión. La CI incorpora los runners y publica evidencia sin umbrales de velocidad.

## Evidencia y reproducción

SHA-256 del DLL probado: `afa8c01e3d7f36075dbe82629ef687ca63421be04d671b4f4297bbf873419419`.

`report.json` conserva hashes, auditoría, fallos, muestras resumidas y comparación del texto; `samples.jsonl` conserva las muestras del kernel. Los archivos de texto `.jsonl`, el cliente derivado, desensamblados, ensamblados y fuentes compuestas quedan junto a los informes de pruebas, préstamos y regresión. `sources/` contiene snapshots de las fuentes de la procedencia registrada, del contrato y de las pruebas. Sus hashes se verificaron contra los archivos utilizados; `snapshot-sha256.json` permite verificar el conjunto congelado.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_record_reduction_loans.py --output artifacts/record-reductions/protected
python3 corpus/libft/run_text.py --stack-transfers --frame-registers --record-reductions \
  --output artifacts/text-record-reductions
python3 corpus/libft/run_record_reductions.py --output artifacts/record-reductions/paired
```

Con el SDK disponible aquí, las pruebas añaden `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"`. Los runners utilizan `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`. El driver acepta `--verify-only` para comprobar fallos y límites sin medir. No se han cambiado permisos, timeouts, opcodes ni el comportamiento de las otras opciones.
