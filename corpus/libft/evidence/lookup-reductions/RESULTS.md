# Resultados de la reducción de búsquedas

Fecha de sesión: 2026-10-06. Linux x64 mediante WSL, AMD Ryzen 7 1700, NASM y .NET 10. `--lookup-reductions` añade una especialización escalar de búsquedas ordinales con comparación anidada de bytes, desactivada por defecto. El [contrato](../../LOOKUP-REDUCTIONS.md) fija el patrón y el estado físico observable.

El algoritmo y los datos se mantienen. El reconocimiento opera sobre instrucciones y bindings de la IR; no usa nombres de funciones, tamaños de benchmark ni contratos implícitos de ausencia de alias. Conserva los cuatro locales y las tres celdas residuales, con lecturas exactas y RSP equivalente en los cuatro puntos de fallo. Es un patrón estructurado cerrado; el optimizador general de CFG/SSA sigue pendiente.

## Comparación del kernel

Medianas en **microsegundos por invocación**. Ambos modos Ubytec usan stack transfers y frame registers; el segundo añade lookup reductions. Cinco calentamientos y 30 muestras por variante, rotatorias e intercaladas dentro del mismo proceso, con resultados comprobados. Las regresiones concluyeron antes de medir. Los nombres `plain` y `registers` son históricos; `text_modes` conserva su significado actual.

| Caso | Anfitrión | Backend anterior | Lookup reductions | C escalar | Factor Ubytec |
| --- | --- | ---: | ---: | ---: | ---: |
| 4, first | gcc | 0.055 | 0.035 | 0.008 | 1.56× |
| 4, first | clang | 0.056 | 0.035 | 0.006 | 1.61× |
| 4, last | gcc | 0.221 | 0.118 | 0.022 | 1.88× |
| 4, last | clang | 0.253 | 0.144 | 0.023 | 1.76× |
| 4, missing | gcc | 0.125 | 0.068 | 0.012 | 1.84× |
| 4, missing | clang | 0.080 | 0.046 | 0.010 | 1.75× |
| 64, first | gcc | 0.053 | 0.034 | 0.008 | 1.58× |
| 64, first | clang | 0.054 | 0.033 | 0.006 | 1.64× |
| 64, last | gcc | 2.800 | 1.628 | 0.289 | 1.72× |
| 64, last | clang | 2.752 | 1.636 | 0.321 | 1.68× |
| 64, missing | gcc | 1.165 | 0.641 | 0.091 | 1.82× |
| 64, missing | clang | 1.190 | 0.652 | 0.129 | 1.82× |
| 256, first | gcc | 0.054 | 0.034 | 0.008 | 1.59× |
| 256, first | clang | 0.054 | 0.033 | 0.006 | 1.64× |
| 256, last | gcc | 10.394 | 5.818 | 0.948 | 1.79× |
| 256, last | clang | 10.042 | 5.810 | 1.221 | 1.73× |
| 256, missing | gcc | 4.559 | 2.535 | 0.331 | 1.80× |
| 256, missing | clang | 4.587 | 2.539 | 0.410 | 1.81× |

Para el último registro entre 256, con anfitrión GCC, el p95 pasa de **14.967 µs** a **8.829 µs**. Las muestras reflejan variación del sistema; no constituyen una garantía de latencia.

C continúa siendo más rápido en estos recorridos. Las referencias C usan GCC y Clang a `-O2`, sin vectorización ni LTO. Sus objetos no contienen instrucciones XMM/YMM/ZMM ni dependencias externas; los desensamblados están conservados. El nuevo cuerpo Ubytec utiliza XMM0/XMM1 para guardar punteros, sin comparar bytes en SIMD. El experimento no separa causalmente el coste del ledger, la ABI o cada instrucción, por lo que no atribuye toda la diferencia con C a una sola promesa.

La matriz también mide identity, suma de bytes y suma de registros como controles. Lookup reductions no sustituye esos cuerpos. Los dos anfitriones comprueban 16 casos con tres variantes y 30 muestras: 2.880 filas medidas en total, además del calentamiento y de los casos vacíos y de longitud incompatible.

## Aplicación completa

Medianas de feed/count en **milisegundos**, con cinco calentamientos y 30 muestras intercaladas por modo y anfitrión. La salida y la liberación de arena coinciden con el oráculo.

| Caso | Anfitrión | Anterior | Con lookup reductions | Factor |
| --- | --- | ---: | ---: | ---: |
| 4096-v4-uniform-b4096 | gcc | 1.751 | 1.663 | 1.053× |
| 4096-v4-uniform-b4096 | clang | 1.585 | 1.589 | 0.997× |
| 4096-v256-uniform-b4096 | gcc | 6.968 | 6.770 | 1.029× |
| 4096-v256-uniform-b4096 | clang | 7.120 | 6.668 | 1.068× |
| 65536-v64-uniform-b4096 | gcc | 45.888 | 46.702 | 0.983× |
| 65536-v64-uniform-b4096 | clang | 46.946 | 46.608 | 1.007× |

La auditoría encuentra **cero funciones reconocidas en ambos ensamblados del texto**. Sus búsquedas incluyen efectos o llamadas fuera del patrón cerrado. Las variaciones medidas no proceden de ejecutar esta especialización y no demuestran una mejora causal de la aplicación. El siguiente paso para trasladar la ganancia al programa real es representar y analizar esos efectos en la IR, conservando sus fronteras y sus observaciones de memoria.

## Validación

- **961 pruebas completas**, sin fallos ni omisiones; **40 nuevas pruebas** de búsqueda. Incluyen las ocho combinaciones de opciones del frame, ordinales y ramas, punteros inválidos que no se desreferencian, coincidencias vacías, aliases de locales y celdas residuales, accesos desalineados, envoltura UInt64, bindings reordenados y patrones de respaldo.
- **69 SIGSEGV y 68 SIGBUS por anfitrión GCC y Clang**, con dos variantes y cuatro etapas de lectura: longitud, puntero al nombre, byte del nombre y byte de la clave. Coinciden señal, código, dirección, cuatro locales, tres celdas residuales y RSP; también se contrastan contra valores esperados independientes. El observador usa una pila alternativa de señales.
- **48 casos de búsquedas protegidas** con dos préstamos de lectura: ordinales, coincidencias y diferencias, préstamo vacío, denegación sin lanzamiento, fallo fuera de mapping, bytes vecinos preservados y recuperación en una nueva invocación. Un fixture C prepara dentro del trabajador una tabla privada de punteros reales; conserva el kernel generado. Este hito no implementa transporte general de tablas con punteros entre dominios.
- La aplicación completa supera **52 casos protegidos por anfitrión GCC y Clang**, incluidos cuotas, permisos, OOM, fallos y publicación atómica de salida. Los oráculos C, servicio y transporte pasan sanitizadores; el NASM generado no está instrumentado. La regresión tipada conserva cinco pruebas de transporte, diez solicitudes malformadas y comprobaciones de identidad del trabajador.

El repositorio mantiene net9.0. La validación local usa .NET 10 mediante Runtime.props. Windows, .NET 9 y CI remota no se ejecutaron en esta sesión. La CI incorpora los runners y conserva evidencia sin exigir una velocidad mínima. No se modifican timeouts, permisos, opcodes ni otras opciones de compilación.

## Evidencia y reproducción

SHA-256 del DLL probado: `90a7371c1625fde54580504ffd55b844ab249a8d6c34ea1b78a406885d16a50e`.

`measurements/report.json` conserva mediana, p95, muestras, versiones, hashes y auditoría del texto; sus archivos JSONL contienen las muestras originales. `verification/` conserva la comprobación sin medidas, `protected/` los préstamos, `text/` la regresión de aplicación y transporte, y `tests/` los informes TRX. Los ensamblados originales y el adaptador experimental derivado quedan separados. `sources/` conserva snapshots de la procedencia registrada, pruebas, workflow y contratos.

Los hashes de fuentes, ensamblados, clientes derivados y artefactos se comprobaron contra los informes antes de congelar. `snapshot-sha256.json` permite verificar todos los archivos de este conjunto, salvo el propio manifiesto. Los desensamblados Ubytec corresponden a los objetos efectivamente medidos.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_lookup_reductions.py --verify-only --output artifacts/lookup-reductions/verification
python3 corpus/libft/run_lookup_reduction_loans.py --output artifacts/lookup-reductions/protected
python3 corpus/libft/run_text.py --stack-transfers --frame-registers --lookup-reductions --output artifacts/text-lookup-reductions
python3 corpus/libft/run_lookup_reductions.py --output artifacts/lookup-reductions/measurements
```

Para el SDK local, las pruebas añaden `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"`. Los runners reciben `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`. Las instrucciones completas y los límites físicos se detallan en el contrato enlazado.
