# Resultados de copias de frame con efectos

Fecha de sesión: 2026-10-06. Linux x64 mediante WSL, AMD Ryzen 7 1700, NASM y .NET 10. Se añade `--effect-registers`, desactivada por defecto. La opción permite conservar copias de bindings de 64 bits en funciones con llamadas y escrituras crudas, sin cambiar el algoritmo del corpus. El [contrato](../../EFFECT-REGISTERS.md) detalla la regla de coherencia.

Todas las escrituras nombradas siguen publicándose en RAM. Después de cada STORE crudo y llamada que retorna, se recargan las copias seleccionadas. La IR registra efectos, control estructurado y anchuras crudas; no introduce SSA, resumen interprocedural ni ausencia de alias implícita. El backend de referencia permanece disponible.

## Programa real

El programa de texto pasa de **3 a 27 funciones con copias**; 24 funciones quedan habilitadas por primera vez, incluidas `TextFlush`, `TextFeed`, `TextCleanup` y funciones de arena/vector. Los nombres y sus fronteras están en `text_functions` del informe. No hay un reconocedor por nombres ni se modifica la biblioteca para forzar el resultado.

Medianas de feed/count en **milisegundos**, con cinco calentamientos y 30 muestras por modo y anfitrión, rotatorias e intercaladas en el mismo proceso. Ambos modos tienen stack transfers y frame registers; el segundo añade effect registers. Las regresiones concluyeron antes de medir. Se comprueban salida, vecinos de la arena y liberación de memoria.

| Caso | Anfitrión | Anterior | Effect registers | Reducción de tiempo | p95 anterior | p95 nuevo |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| 4096-v4-uniform-b4096 | gcc | 1.578 | 1.562 | 1.05% | 2.314 | 2.313 |
| 4096-v4-uniform-b4096 | clang | 1.564 | 1.550 | 0.93% | 2.335 | 2.323 |
| 4096-v256-uniform-b4096 | gcc | 6.527 | 6.296 | 3.53% | 9.300 | 9.277 |
| 4096-v256-uniform-b4096 | clang | 6.645 | 6.582 | 0.95% | 10.048 | 9.317 |
| 65536-v64-uniform-b4096 | gcc | 43.971 | 42.018 | 4.44% | 50.024 | 51.128 |
| 65536-v64-uniform-b4096 | clang | 44.244 | 41.821 | 5.48% | 57.684 | 51.053 |

Las seis medianas bajan entre aproximadamente un 1% y un 5,5%. La cola no mejora de forma uniforme: para 64 KiB con anfitrión GCC, el p95 aumenta. Las diferencias pequeñas y la variación de WSL no constituyen una garantía de velocidad ni latencia. Este experimento aplica el modo al conjunto de funciones elegibles; no atribuye toda la ganancia a `TextFlush` en solitario.

Estas medidas cubren las fases nativas del analizador sin supervisor; los casos protegidos se validan por separado. No son latencias de extremo a extremo de archivo o monitor, ni una medida de rapidez de compilación.

La auditoría estática de `TextFlush` pasa de 42 a 71 cargas explícitas del frame y añade 13 fronteras de recarga. `TextFeed` pasa de 13 a 23 y añade cinco fronteras. Estos totales incluyen caminos fríos y muestran el coste conservador de las recargas; no cuentan cargas ejecutadas, cache misses ni ciclos. La nueva ruta cambia dónde se leen los valores y permite usar copias en los recorridos calientes, pero no elimina las escrituras observables.

## Búsqueda con llamada de comparación

`effect-kernels.ubc` reproduce un recorrido de registros con llamada a `ft_memcmp` cuando coincide la longitud. La referencia C recorre los mismos registros en el mismo orden, con comparación byte a byte en una función escalar separada marcada noinline. No hay cambios de hash, índices, SIMD, validaciones de vector ni asignación en ninguno de estos kernels. Es una comparación del núcleo con llamada; no representa el coste completo de `TextFlush`.

Medianas en **microsegundos por invocación**. GCC/Clang usan `-O2`, sin vectorización ni LTO. El informe conserva muestras, versiones, flags implícitos del runner y desensamblados; los objetos C no contienen SIMD ni dependencias externas.

| Caso | Anfitrión | Anterior | Effect registers | C escalar | Factor Ubytec |
| --- | --- | ---: | ---: | ---: | ---: |
| 4, first | gcc | 0.061 | 0.058 | 0.010 | 1.056× |
| 4, first | clang | 0.060 | 0.057 | 0.011 | 1.059× |
| 4, last | gcc | 0.245 | 0.231 | 0.027 | 1.060× |
| 4, last | clang | 0.249 | 0.235 | 0.037 | 1.060× |
| 4, missing | gcc | 0.096 | 0.089 | 0.013 | 1.077× |
| 4, missing | clang | 0.099 | 0.091 | 0.016 | 1.083× |
| 64, first | gcc | 0.059 | 0.055 | 0.008 | 1.061× |
| 64, first | clang | 0.058 | 0.055 | 0.009 | 1.060× |
| 64, last | gcc | 3.332 | 2.930 | 0.370 | 1.137× |
| 64, last | clang | 3.313 | 2.972 | 0.519 | 1.115× |
| 64, missing | gcc | 2.186 | 1.968 | 0.162 | 1.111× |
| 64, missing | clang | 1.606 | 1.482 | 0.216 | 1.084× |
| 256, first | gcc | 0.059 | 0.056 | 0.009 | 1.061× |
| 256, first | clang | 0.058 | 0.055 | 0.010 | 1.058× |
| 256, last | gcc | 12.096 | 10.632 | 1.507 | 1.138× |
| 256, last | clang | 12.081 | 10.640 | 1.859 | 1.135× |
| 256, missing | gcc | 5.839 | 5.313 | 0.574 | 1.099× |
| 256, missing | clang | 5.727 | 5.230 | 0.733 | 1.095× |

C continúa por delante. Su resultado observable y su memoria del programa se conservan, pero no ofrece la imagen física concreta del frame de Ubytec. La prueba no aísla el coste de esa promesa, de la ABI ni de cada instrucción. Tampoco se deben comparar estos valores directamente con el hito anterior de lookup reductions: allí la comparación estaba embebida y aquí permanece una llamada.

La matriz añade identity, suma de bytes y suma de campos como controles: 16 casos, tres variantes y 30 muestras por anfitrión, con **2.880 filas medidas** en total, además del calentamiento y de casos vacíos/longitud incompatible.

## Validación

- **1.010 pruebas completas**, sin fallos ni omisiones; **49 nuevas pruebas** de coherencia. Ocho combinaciones de stack transfers, frame values y frame registers. Se comparan retornos, cuatro locales y tres celdas residuales. Las llamadas directas e indirectas modifican un argumento del llamador y destruyen R8/R9/R10. Se comprueban escrituras desalineadas de uno, dos y cuatro bytes, y ramas con continue/break.
- Las direcciones residuales de retorno se contrastan con el punto de retorno del propio binario; no se exige igualdad numérica entre dos imágenes de código distintas. Los datos y residuos restantes coinciden exactamente.
- **146 SIGSEGV y 144 SIGBUS por anfitrión GCC/Clang**, con dos variantes. Incluyen escritura cruda directa, lectura en llamada directa, escritura en llamada indirecta, ocho posiciones respecto del límite, prefijos de hasta 127 operaciones y regiones de solo lectura. Coinciden señal, código, dirección, cuatro locales actuales, tres celdas residuales y RSP, además de valores esperados independientes. Se usa una pila alternativa de señales.
- **52 casos protegidos del programa completo por anfitrión GCC/Clang**, con esta opción aplicada: oráculo de salida, cuotas, permisos, OOM, limpieza y fallos sin publicación parcial. Los servicios y oráculos C pasan sanitizadores; el NASM generado no está instrumentado. La regresión tipada conserva cinco comprobaciones de transporte y diez solicitudes malformadas con identidad del trabajador.

El repositorio mantiene net9.0; la ejecución local usa .NET 10 con Runtime.props. Windows, .NET 9 y CI remota no se ejecutaron en esta sesión. La CI incorpora la regresión y los runners sin umbrales de velocidad. No se han cambiado opcodes, permisos, timeouts ni las opciones anteriores.

## Evidencia y reproducción

SHA-256 del DLL probado: `e861dd1dd4bc312b29666366220d0038b181fcca1d9b6581d5aefef3542d8100`.

`measurements/` conserva muestras JSONL, mediana/p95, auditoría, ensamblados y desensamblados de los objetos realmente medidos. `verification/` conserva los fallos y límites sin mediciones. `text/` conserva la regresión protegida y tipada; `tests/`, los TRX y el override de SDK. `sources/` conserva snapshots de fuentes, pruebas, contrato y workflow. Todos los hashes de procedencia se contrastaron antes de congelar; `snapshot-sha256.json` verifica el conjunto excepto su propio archivo.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_effect_registers.py --verify-only --output artifacts/effect-registers/verification
python3 corpus/libft/run_text.py --stack-transfers --frame-registers --effect-registers --output artifacts/text-effect-registers
python3 corpus/libft/run_effect_registers.py --output artifacts/effect-registers/measurements
```

En el SDK local, las pruebas añaden `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"`. Los runners reciben `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`.

El siguiente frente es reducir recargas mediante efectos demostrados de llamadas y escrituras. Un destino desconocido debe seguir recargando; eliminar barreras requiere justificar la coherencia de los aliases y las observaciones físicas.
