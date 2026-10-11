# Copias de frame con fronteras de efectos

`--effect-registers` conserva copias de argumentos y locales de 64 bits en registros a través de bucles y ramas, incluso cuando la función contiene llamadas y escrituras crudas. Está desactivada por defecto. Permite optimizar funciones reales como `TextFlush` y `TextFeed` sin cambiar sus algoritmos ni las operaciones autorizadas por el monitor.

## Regla de coherencia

La memoria del frame sigue siendo la autoridad. Todas las escrituras de locales y todas las operaciones sobre la pila se mantienen. Una escritura nombrada actualiza tanto su celda como su copia en registro. Después de cada STORE crudo o llamada que retorna, se recargan todas las copias seleccionadas desde sus celdas originales. No se añaden spills ni se cambia el tamaño del frame.

La IR conserva lecturas, escrituras, profundidad de bucle, efectos de control y registros temporales reservados. Ahora también registra la anchura de cada acceso crudo y clasifica las fronteras que invalidan las copias. Esta versión recarga conservadoramente todo el conjunto, incluso cuando una escritura solo ocupa un byte: no utiliza todavía la anchura para demostrar que un alias es imposible.

| Operación | Tratamiento |
| --- | --- |
| LOAD nombrado de un binding seleccionado | Usa su copia coherente en registro |
| STORE nombrado | Conserva la escritura en RAM y actualiza su copia |
| LOAD crudo | Conserva anchura, orden, dirección, pila y acceso original |
| STORE crudo | Conserva la operación completa y recarga las copias después de que tenga éxito |
| CALL o CALLI | Conserva ABI, argumentos y resultado; recarga las copias después del retorno |
| IF, ELSE, WHILE, LOOP, BREAK y CONTINUE | Conserva el control estructurado y el invariante de coherencia en cada camino |
| Efecto desconocido | Mantiene el backend anterior para la función completa |

El invariante evita tener que adivinar qué rama llegó a una unión: al terminar cada operación que puede modificar el frame, los registros seleccionados contienen otra vez sus bytes actuales. Si la llamada o escritura falla, no se ejecuta la recarga; el estado interrumpido corresponde a la operación original. Las instrucciones MOV añadidas no alteran flags, RAX, RSP ni celdas residuales.

## Selección y alcance

Se seleccionan hasta tres bindings Int64/UInt64 inicialmente definidos, según su frecuencia estática de lectura y presencia en bucles. Se utilizan R8, R9 y R10, reservando los que necesiten las operaciones de pila `TwoSWAP` y `TwoROT`. Las llamadas pueden destruir estas copias y modificar el frame mediante punteros; ambas posibilidades se cubren recargando. R11 y los registros preservados por la ABI no se usan para estas copias.

Los bindings estrechos conservan sus reglas originales de carga y canonicalización. Las declaraciones inline no se promueven antes de su inicialización. Los patrones especializados de bytes, registros y búsqueda conservan prioridad. La opción anterior `--frame-registers` sigue excluyendo funciones con llamadas o escrituras crudas y conserva su comportamiento.

La justificación exige el contrato de frame y RAM ordinaria del backend, llamadas que respeten la ABI y memoria estable salvo las operaciones del propio programa. No concede autoridad a punteros, no cambia permisos del monitor y no promete preservar todos los registros temporales ni la traza de instrucciones ante una interrupción arbitraria. Las direcciones de código corresponden al binario emitido: las pruebas de residuos de llamadas comprueban el punto de retorno de cada binario, sin exigir la misma dirección numérica entre dos imágenes diferentes.

Es una ampliación general de las copias con escritura inmediata sobre control estructurado. No introduce SSA, análisis global de alias, resumen interprocedural de efectos ni eliminación de escrituras del frame. Recargar después de cada frontera tiene coste; la siguiente mejora deberá justificar qué copias siguen válidas antes de omitir una recarga.

## Pruebas y medidas

Las pruebas nuevas comparan resultado, cuatro locales y tres celdas residuales en ocho perfiles de stack transfers, frame values y frame registers. Incluyen escrituras parciales desalineadas y llamadas directas/indirectas que modifican un argumento del llamador y destruyen R8/R9/R10. Los fixtures Linux comparan fallos de escritura directa, lectura en llamada directa y escritura en llamada indirecta, con SIGSEGV y SIGBUS.

`run_text.py` aplica la opción al programa protegido completo y comprueba permisos, cuotas, OOM, salida y limpieza de arena. `run_effect_registers.py` mide dos modos Ubytec con el mismo algoritmo y datos, más una referencia C escalar de búsqueda que conserva una llamada separada de comparación. El programa de texto se mide sin supervisor durante sus fases nativas; sus tiempos no son latencia de extremo a extremo del monitor.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_effect_registers.py --verify-only --output artifacts/effect-registers/verification
python3 corpus/libft/run_text.py --stack-transfers --frame-registers --effect-registers --output artifacts/text-effect-registers
python3 corpus/libft/run_effect_registers.py --output artifacts/effect-registers/measurements
```

Se conservan el algoritmo y las bibliotecas del corpus. Las mediciones representan el conjunto de funciones que pasan a usar copias; no atribuyen toda la ganancia a `TextFlush` en solitario. [Resultados, muestras y snapshots](evidence/effect-registers/RESULTS.md).

El repositorio mantiene net9.0. La sesión local usa .NET 10, con `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"` para las pruebas. Los runners reciben `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`. Windows, .NET 9 y CI remota requieren su propia validación.
