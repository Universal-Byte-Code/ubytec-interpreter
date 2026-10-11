# Reducción de búsquedas ordinales

`--lookup-reductions` reconoce una búsqueda de registros con comparación anidada de bytes y emite un recorrido escalar con cursores en registros. Está desactivada por defecto. La búsqueda conserva el algoritmo, las lecturas exactas, los locales y las tres celdas residuales del origen. No añade opcodes ni cambia permisos del monitor.

## Patrón reconocido

`LookupReductionPlan` inspecciona las 48 instrucciones de `FunctionValueIR` y sus bindings. Requiere cuatro argumentos y cuatro locales UInt64, sin llamadas, stores crudos, funciones locales ni efectos adicionales. Los nombres y el orden de declaración pueden variar; la firma de tipos y la estructura deben coincidir.

El bucle externo recorre desde el índice local inicial hasta la cantidad, con comparación unsigned. Calcula `records + index * stride`, guarda el puntero local y lee una longitud UInt64 en un offset constante. Si coincide con la longitud consultada, lee el puntero al nombre desde el offset cero, inicializa el índice interno a cero y compara un byte del nombre seguido de un byte de la clave. Una diferencia sale del bucle interno. Una coincidencia completa devuelve `index + 1`; el índice externo local conserva el índice encontrado. Agotar los registros devuelve cero.

El stride debe estar entre 1 e Int32.MaxValue; el offset de longitud, entre cero e Int32.MaxValue. La aritmética de direcciones e índices conserva la envoltura UInt64. Un registro de longitud cero coincidente lee su puntero al nombre, pero no desreferencia el nombre ni la clave. Una longitud distinta no lee el puntero al nombre. El AST original sigue validándose antes de sustituir su emisión; tipos o mutabilidad inválidos siguen dando error. Otros patrones usan el backend anterior.

La implementación es un patrón estructurado cerrado. Todavía no constituye un optimizador general de CFG/SSA, bucles con llamadas o búsquedas con efectos arbitrarios.

## Estado físico y fallos

Sea `S` el RSP posterior al prólogo y a la reserva de los cuatro locales. El monitor de fallos compara las tres celdas `S-8`, `S-16` y `S-24`, además de los cuatro locales y RSP. Cada lectura ve el ledger completo de la implementación de referencia:

| Lectura | S-8 | S-16 | S-24 | RSP al leer |
| --- | --- | --- | --- | --- |
| Longitud UInt64 | Dirección efectiva del campo | Offset de longitud | Stride | S |
| Puntero al nombre UInt64 | Dirección del registro | Longitud consultada | Stride | S |
| Byte del nombre | Nombre + índice interno | Índice interno | Residuo anterior | S |
| Byte de la clave | Byte del nombre extendido a UInt64 | Clave + índice interno | Índice interno | S-8 |

Antes de leer la longitud se publica el local del registro. Antes del primer byte se publican el local del nombre y el índice interno cero. Cada avance actualiza su local y la celda residual correspondiente. La lectura del nombre ocurre antes de preparar el ledger de la clave. No se amplían ni vectorizan los accesos: UInt64 usa ocho bytes y Byte usa uno. La salida conserva los residuos más profundos, incluso cuando el bucle no entra.

La operación admite punteros crudos que apunten a locales o celdas de evaluación; no introduce una suposición de ausencia de alias. Las pruebas comparan retornos y memoria del frame en ocho combinaciones de stack transfers, frame values y frame registers. La promesa se limita al contrato de RAM y fallos de acceso descrito; no promete conservar una traza de instrucciones, flags o todos los registros ante una interrupción arbitraria.

Solo usa registros enteros volátiles y XMM0/XMM1 para guardar los bits de dos punteros. Esto no es SIMD ni depende de SSE4 o AVX2. R11, los registros preservados por el anfitrión y la ABI de exportación mantienen su contrato.

## Validación y reproducción

`LookupReductionTests` verifica ramas, ordinales independientes, regiones desalineadas, aliases, índices iniciales y envoltura, nombres alternativos y respaldo. `lookup-reduction-faults.c` usa una pila de señales separada y compara señal, código, dirección, locales, residuos y RSP en los cuatro puntos de lectura, con anfitriones GCC y Clang.

`run_lookup_reduction_loans.py` ejecuta el cuerpo generado dentro del trabajador aislado. Un fixture C construye allí una tabla privada con punteros reales hacia dos préstamos de lectura. Solo se sustituye el adaptador público de preparación; el kernel generado y su adaptador candidato permanecen intactos. Es preparación experimental del fixture, no un mecanismo general de transporte de punteros entre dominios.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_lookup_reductions.py --verify-only --output artifacts/lookup-reductions/verification
python3 corpus/libft/run_lookup_reduction_loans.py --output artifacts/lookup-reductions/protected
python3 corpus/libft/run_text.py --stack-transfers --frame-registers --lookup-reductions --output artifacts/text-lookup-reductions
python3 corpus/libft/run_lookup_reductions.py --output artifacts/lookup-reductions/measurements
```

El repositorio mantiene net9.0. En la sesión local se usa .NET 10 mediante `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"`; los runners reciben `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`.

Las medidas se ejecutan después de las regresiones, con cinco calentamientos, 30 muestras rotatorias intercaladas y comprobación de resultados, sin umbral de velocidad. Se conservan las referencias C escalares y sus desensamblados. El análisis cuenta qué funciones del programa de texto reconocen el patrón: una mejora del kernel no implica una mejora de esa aplicación si no ejecuta el cuerpo sustituido. [Resultados y evidencia](evidence/lookup-reductions/RESULTS.md).
