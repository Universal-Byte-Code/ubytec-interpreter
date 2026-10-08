# Reducciones por bloques de bytes

`--block-reductions` integra SSE2 en el backend Linux x64 para una reducción cerrada sobre bytes de RAM ordinaria estable. Está desactivada por defecto. La API es `SourceCompiler.Compile(..., optimizeBlockReductions: true)`; funciona sin `--loop-reductions` y puede combinarse con las opciones anteriores. Si ambas se activan, la vía de bloques tiene prioridad e incluye el respaldo escalar.

El reconocimiento reutiliza el patrón de [loop reductions](LOOP-REDUCTIONS.md): dos argumentos y dos locales `t_uint64`, condición unsigned `<`, lectura de un byte, suma con envoltura, incremento y retorno. No depende del nombre de la función ni del tamaño de un benchmark. La emisión de referencia sigue validando tipos, readonly, scopes y retorno antes de la sustitución. Otros patrones conservan el backend anterior.

## Perfil de memoria y comprobaciones

La entrada debe ser RAM ordinaria, con valores, mappings y permisos estables durante la llamada, sin MMIO ni lecturas volátiles. Las exclusiones del [contrato observable](../../Wiki/docs/observable-contract.md) sobre observación entre instrucciones, introspección de código y modificación asíncrona siguen aplicándose. Este perfil no admite que dos mappings virtuales distintos hagan referencia a la misma memoria física de la pila escrita por el bucle; la comprobación de intervalos virtuales no detectaría ese alias. Los préstamos del monitor tienen backing dedicado separado de la pila del trabajador.

Las comprobaciones calculan el intervalo pendiente `[data + index, data + length)` y rechazan envoltura y direcciones fuera del rango de usuario conservador inferior a `2^47`. Con `S = RBP - FrameSize`, ese intervalo debe ser disjunto de `[S-24, RBP)`, que contiene ambos locales y las tres celdas de evaluación que escribe este patrón. El guard no escribe memoria. Un intervalo que solapa, una dirección no apta o un bucle vacío salta al plan escalar existente; las direcciones que envuelven mantienen allí sus lecturas originales.

La vía SIMD cambia la agrupación y cantidad de lecturas. Puede leer de nuevo el primer y último byte de un tramo y sustituir lecturas escalares por lecturas alineadas de 16 bytes dentro del intervalo autorizado. Esta equivalencia depende del perfil de RAM estable; `--loop-reductions` mantiene su garantía previa de una lectura exacta de un byte por iteración. Elegir un tamaño de bloque o disponer de metadatos no concede permisos de memoria.

## Bucle SIMD y estado observable

El prefijo de alineación y la cola utilizan la secuencia escalar. Para SIMD se calcula el menor de los bytes pendientes y los bytes hasta el siguiente límite de 4 KiB, redondeado hacia abajo a un múltiplo de 16. Cada carga está alineada y permanece en ese tramo; no se amplía el rango hacia datos vecinos.

Antes de entrar se materializa la imagen escalar de fallo: `[S-8] = sum`, `[S-16] = data + index`, `[S-24] = index`, frame ya actualizado y `RSP = S-8`. Una lectura de **un byte** comprueba el primer acceso de ese tramo. Si falla, la señal, código, dirección, frame, evaluación y RSP corresponden a la misma lectura escalar. Si funciona, la página ordinaria estable es legible y se procesa su tramo sin cruzar una frontera de protección. Se excluyen errores de hardware y cambios de mappings o permisos durante el tramo. Las páginas x64 tienen granularidad mínima de 4 KiB; una página mayor contiene estos subtramos. [Protección por páginas del kernel](https://www.kernel.org/doc/html/latest/core-api/protection-keys.html), [manual de arquitectura de Intel](https://cdrdv2-public.intel.com/868137/325462-089-sdm-vol-1-2abcd-3abcd-4.pdf).

El cuerpo usa `MOVDQA`, `PSADBW` y `PADDQ`, con cuatro acumuladores independientes. Procesa 64 bytes en 16 instrucciones y cuatro cargas vectoriales, sin escrituras de memoria en ese cuerpo. Una cola vectorial procesa 16 bytes por vuelta. SSE2 forma parte del destino x64 y esta opción no requiere AVX2 ni ejecuta CPUID por llamada.

Al terminar cada tramo se combinan los acumuladores, se escriben ambos locales y se reconstruye exactamente la imagen del último back edge: `[S-8] = index siguiente`, `[S-16] = último byte`, `[S-24] = índice anterior`. El retorno deja la suma en `[S-8]`. Hay ocho escrituras del ledger y locales por tramo vectorial, además de las iteraciones escalares de prefijo y cola. Esto permite observar los mismos bytes finales y preparar el siguiente fallo sin materializar siete escrituras por cada byte del tramo.

La separación demostrada impide que diferir esas escrituras cambie las lecturas de entrada. La estabilidad y granularidad de página justifican que no exista un fallo de acceso en medio de un tramo cuyo primer byte se ha leído. Las pruebas ejercitan estas obligaciones, pero no reemplazan esas precondiciones. No se añaden timeouts ni se cambia el contrato de ejecución del monitor.

## Relación con MetaDB

MetaDB ofrece bloques de columna con base y stride, desenrolla cuatro filas y especializa tamaños de copia. Su heurística calcula lotes con un presupuesto de 256 KiB de payload leído y escrito. [Código inspeccionado de Extend0](https://github.com/Papishushi/Extend0/blob/f9e5c7405235f722e0a2554d2c6b67154dd4d453/Extend0/Metadata/Internal/MetaDBManagerHelpers.cs#L403).

Esta integración traslada la especialización de un recorrido y la amortización del trabajo por elemento. Sus tramos están limitados por la página para preservar fallos, sin adoptar el presupuesto de 256 KiB como si demostrara legibilidad. La pasada no cambia el layout de MetaDB ni implementa un optimizador general de columnas, stride o caché. Las medidas sobre varios tamaños de entrada permiten comparar costes; no prueban saturación de la caché sin contadores de hardware.

## Reproducción

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_block_reductions.py --output artifacts/block-reductions/paired
python3 corpus/libft/run_block_reduction_loans.py --output artifacts/block-reductions/protected
python3 corpus/libft/run_text.py --stack-transfers --frame-registers \
  --block-reductions --output artifacts/text-block-reductions
```

Los runners aceptan `--dotnet` y `--compiler`. El proyecto conserva `net9.0`; la ejecución local disponible usa .NET 10 mediante `artifacts/observable-contract/Runtime.props`.

El comparador mide 256 bytes, 4 KiB, 64 KiB, 256 KiB, 1 MiB y 16 MiB, con cinco calentamientos y 40 muestras intercaladas y rotatorias en un proceso. Incluye frame registers, la reducción escalar, la nueva SSE2, GCC/Clang automáticos y prototipos explícitos. Registra geometría de caché, fuentes, DLL, ensamblados, desensamblados y muestras. Los perfiles de pila de C y de los prototipos no ofrecen el ledger físico de Ubytec. No se impone un umbral de velocidad en CI.

El observador de fallos usa procesos hijos y pila de señales independiente para SIGSEGV y SIGBUS. El fixture de préstamos ejecuta realmente el cuerpo SSE2 bajo el monitor, compara el resultado con una suma independiente, comprueba vecinos, denegación, fallo fuera del mapping y recuperación en una llamada nueva. La regresión del analizador completo comprueba también los patrones que conservan el respaldo; sus resultados no atribuyen una mejora a la aplicación entera.

Los resultados y snapshots están en [evidencia](evidence/block-reductions/RESULTS.md).
