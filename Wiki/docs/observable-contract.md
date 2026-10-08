# Contrato observable y optimización de Ubytec

El backend Linux x64 permite mezclar operaciones sobre valores con accesos nativos por puntero. Las optimizaciones deben conservar las observaciones admitidas por esa interfaz, incluyendo las que combinan operaciones de distintas familias. La representación interna del compilador puede evolucionar; las garantías ya documentadas sobre memoria y ABI siguen siendo restricciones de compatibilidad.

Este contrato describe el backend existente y las condiciones de sus optimizaciones experimentales. La primera IR de efectos y las copias de marco en registros están implementadas mediante la opción [frame registers](../../corpus/libft/FRAME-REGISTERS.md). El grafo de bloques, SSA y análisis general de alias de la última sección siguen siendo trabajo posterior, sin nuevos opcodes.

## Garantías existentes

La [referencia de opcodes](opcodes.md) sitúa cada celda de evaluación de ocho bytes en la pila de CPU. La [ABI interna](functions.md) sitúa argumentos y variables en posiciones estables relativas a RBP durante la invocación. Estas dos afirmaciones impiden tratar toda la memoria de pila como un detalle invisible sin analizar cómo puede observarla el programa o su anfitrión.

| Interfaz | Observación que debe conservarse | Implementación de referencia |
| --- | --- | --- |
| Operaciones de pila | Valores, orden, profundidad y celdas inferiores vivas | `StackOperations`, `StackCode`, `FunctionStackValidator` |
| Aritmética y comparaciones | Envoltura de 64 bits, interpretación explícita signed/unsigned, resultados y excepciones de división | `ArithmeticOperations`, `ComparisonOperations`, referencia de opcodes |
| PUSH16 | Palabra little endian en un desplazamiento de bytes de la pila, incluso entre dos celdas | `ExtendedStackOperations`, `FunctionStackValidator` |
| LOAD y STORE sin símbolo | Lectura o escritura de 1, 2, 4 u 8 bytes en la dirección proporcionada, con extensión o normalización según el tipo | `MemoryOperations` |
| LOAD y STORE con símbolo | Valor de la celda del argumento o variable; extensión y normalización declaradas | `FunctionCode`, `FunctionEmitter` |
| CALL | Argumentos en orden de declaración, resultado escalar, limpieza por el llamador y restauración del marco | `FunctionOperations`, `FunctionEmitter` |
| FNADDR y CALLI | Dirección nativa del callable y llamada con la ABI interna; firma y validez dinámica son responsabilidad del programa | `FunctionOperations` |
| CLEAR y RETURN | Restauración de pila y marco según sus contratos; CLEAR conserva variables | Implementaciones de CLEAR y RETURN, `FunctionEmitter` |
| Importación protegida | Permisos y préstamos efectivos del monitor, salida y fallos del protocolo | `SourceCompiler`, contratos de `prototypes/isolation` |

En funciones estructuradas, PUSH16 exige suficientes celdas vivas para los dos bytes leídos: `ceil((offset + 2) / 8)`. No ofrece por esta vía una lectura libre fuera de la pila de evaluación. La emisión individual del opcode y la validez de una dirección raw no constituyen por sí mismas una comprobación dinámica de límites.

Los accesos raw pueden observar un argumento mediante una dirección válida suministrada por el anfitrión. El lenguaje fuente no necesita un opcode de dirección de variable para que exista ese alias. Una STORE raw puede cambiar una posterior LOAD con símbolo, y una STORE con símbolo puede cambiar una posterior LOAD raw. Las llamadas directas e indirectas pueden producir el mismo efecto.

FNADDR proporciona además una dirección de código que podría usarse con LOAD raw. Las dos pasadas actuales cambian los bytes y las direcciones del ensamblado. Su equivalencia experimental no incluye introspección de esos bytes ni estabilidad numérica de direcciones entre compilaciones. Esto limita su dominio de uso; no elimina esa posibilidad del lenguaje unsafe general.

## Frontera de equivalencia de las opciones actuales

El contrato se compara sobre programas con direcciones y firmas válidas, RAM ordinaria del marco, y ejecución sin modificaciones concurrentes o asíncronas de esas celdas. Se observan valores y memoria accesible en las operaciones admitidas, resultados de llamadas, efectos externos, restauración de la ABI y comportamiento de control. Una futura optimización debe justificar también preservación de fallos y de ejecución indefinida dentro de su ámbito.

Las opciones [stack transfers](../../corpus/libft/STACK-TRANSFERS.md) y [frame values](../../corpus/libft/FRAME-VALUES.md), desactivadas por defecto, ya declaran exclusiones sobre trazas, direcciones del código y observación asíncrona. Frame values requiere RAM ordinaria y excluye lecturas volátiles. Son precondiciones de equivalencia experimental, no una demostración de que toda observación excluida sea ilegítima en Ubytec.

Una equivalencia que incluya temporización exacta, lectura del código, depuración por instrucción, señales que inspeccionan RSP intermedio o memoria modificada por otro agente necesita un contrato específico. No puede añadirse esa promesa a estas pasadas a partir de sus pruebas actuales. Los tiempos de benchmark tampoco constituyen un canal que debamos conservar exactamente: se miden para evaluar la optimización.

La optimización no añade límites de tiempo al programa. Un bucle sin cota puede ser correcto y terminar según entradas futuras. Los límites de una invocación protegida pertenecen al contrato del monitor; el compilador debe conservar las interacciones que permiten continuar o finalizar esa ejecución. Las pruebas con ejecuciones finitas no demuestran equivalencia de todas las ejecuciones infinitas.

## Auditoría de las dos pasadas

### Transferencias adyacentes de pila

`StackTransferOptimizer` reconoce exclusivamente PUSH de registro seguido inmediatamente de POP de registro, con registros enteros de 64 bits distintos de RSP. Sustituye la pareja por una escritura en `[rsp - 8]` y, cuando hace falta, un movimiento entre registros.

Con RAM ordinaria y sin observación entre instrucciones, ambos fragmentos dejan los mismos registros, flags, profundidad y bytes en la celda consumida. La escritura residual se conserva porque un puntero posterior puede leerla. El RSP transitorio y la traza cambian; la equivalencia está condicionada por las exclusiones anteriores. No se atraviesan etiquetas, comentarios, llamadas ni instrucciones intermedias.

La escritura residual es una elección conservadora que preserva una posible observación; no demuestra que cada escritura temporal del backend sea necesaria en todos los programas. Eliminarla requiere descartar ese canal en el caso concreto o establecer otro contrato independientemente de la ganancia buscada.

### Reutilización de valores del marco

`FrameValueOptimizer` mantiene asociaciones entre desplazamientos qword de RBP y registros completos. Una LOAD conocida se sustituye por un MOV de registro o se omite si el destino ya contiene el valor. Todas las STORE se conservan. Una escritura qword invalida cualquier intervalo de ocho bytes solapado, incluso sin alineación.

Las escrituras de registros eliminan sus asociaciones; los MOV completos las propagan. Saltos, etiquetas, llamadas, operaciones de pila, cambios de base del marco, accesos raw y cualquier instrucción desconocida descartan el estado. También lo hacen escrituras parciales y de anchura no reconocida. Esta política impide usar un valor anterior a una modificación mediante un alias desconocido dentro del flujo reconocido.

La justificación exige que una lectura satisfecha previamente siga leyendo la misma RAM ordinaria. No se conserva el número de lecturas, ni se admiten cambios concurrentes de la celda. La pasada no analiza efectos de funciones ni mantiene estado entre bloques. Por eso no mantiene índice o acumulador en registros a través de un bucle: los límites que garantizan su alcance local también limitan su utilidad.

La [evidencia de frame values](../../corpus/libft/evidence/frame-values/RESULTS.md) muestra que DiagBytes y DiagRecords conservan sus lecturas de marco y que las ganancias de ejecución son mixtas. Esa evidencia respalda mantener la opción experimental; no justifica activarla por defecto ni atribuirle asignación global de registros.

## Primera especialización de bucle

La opción [loop reductions](../../corpus/libft/LOOP-REDUCTIONS.md), desactivada por defecto, reconoce una reducción escalar cerrada sobre bytes en la IR de efectos. Mantiene valores en registros y elimina únicamente escrituras temporales sobrescritas antes de cualquier lectura raw. No supone ausencia de alias: conserva la imagen completa de frame y pila antes de cada lectura, después de cada iteración y al retornar.

Una lectura que falla conserva dirección, tipo de fallo, variables, bytes de evaluación y RSP. La especialización lee exactamente un byte, mantiene el orden y deja intacto el respaldo para otras formas o efectos. Su ámbito requiere una pila válida de RAM ordinaria y las exclusiones de observación entre instrucciones ya descritas. El grafo general de bloques sigue pendiente. La opción independiente [block reductions](../../corpus/libft/BLOCK-REDUCTIONS.md) integra SSE2 para este mismo patrón bajo un perfil explícito de entrada de RAM ordinaria estable. Comprueba separación del intervalo virtual respecto de todos los bytes escritos del marco y evaluación, evita envoltura y realiza una lectura escalar antes de cada tramo SIMD contenido en una página de 4 KiB. El respaldo conserva accesos de un byte para aliases, direcciones no aptas y el bucle vacío. La vía SIMD puede agrupar y repetir lecturas dentro del tramo; no está habilitada por `--loop-reductions` y no admite MMIO, lecturas volátiles, permisos cambiantes ni mappings distintos de la misma memoria de pila. Dentro de ese perfil conserva resultado, memoria final, ABI y el ledger de fallos de acceso por página; no transforma la autoridad del monitor.

La opción adicional `--block-reductions-native` selecciona AVX2 en el momento de compilar cuando CPU y sistema operativo lo soportan; de lo contrario, emite SSE2. Comparte con la vía portable las comprobaciones, el probe de un byte, la granularidad de página, la imagen materializada y el respaldo escalar. Sus cargas de 32 bytes permanecen dentro del tramo autorizado. La selección no concede autoridad ni amplía este perfil de memoria. El artefacto requiere la ISA elegida y no cambia de ruta al trasladarlo a otra CPU; para distribución x64 portable se usa `--block-reductions`. Véanse [mecanismo y evidencia](../../corpus/libft/BLOCK-REDUCTIONS.md).

La opción [record reductions](../../corpus/libft/RECORD-REDUCTIONS.md), también desactivada por defecto, reconoce una suma escalar de campos UInt64 con stride y offset constantes. Mantiene un cursor por inducción y reproduce las cuatro celdas residuales del cálculo de dirección antes de cada carga de ocho bytes. Conserva aliases, envoltura, cargas desalineadas que cruzan páginas, estado de fallo y memoria final sin suponer separación de entrada y pila. No cambia el número ni el orden de lecturas raw ni modifica permisos del monitor. El reconocimiento sigue siendo de un cuerpo cerrado; el grafo de bloques y las búsquedas con ramas quedan pendientes.

## Pruebas de composición del contrato

`Ubytec.Tests/ObservableContractTests.cs` ejecuta el ensamblado real en las ocho combinaciones de transferencias, valores del marco y registros del marco. El anfitrión crea una dirección válida hacia la primera celda de argumento de la función llamada. Las pruebas comprueban:

1. Dos iteraciones que escriben mediante ese puntero y leen el argumento con símbolo producen 44 partiendo de 42.
2. Una STORE con símbolo se observa como 99 mediante LOAD raw de la misma celda.
3. Un callable directo y el mismo callable mediante FNADDR y CALLI modifican la celda; la lectura posterior devuelve 99.
4. PUSH16 con offset 7 sobre dos celdas conocidas devuelve `0x88AA`, leyendo un byte de cada celda.

Los resultados son expectativas independientes del optimizador. La suite existente añade comprobaciones de flags, registros parciales, solapamientos, escrituras residuales y profundidad. Estas pruebas cubren canales concretos de composición; no certifican que se hayan enumerado todos los canales del sistema.

## Validación ejecutada

Los 20 casos nuevos y la suite completa de 661 pruebas pasan sin fallos ni omisiones en Linux x64 mediante WSL, NASM y .NET 10. La configuración de prueba importa las propiedades del repositorio y cambia únicamente el framework de esa ejecución a `net10.0`; los proyectos conservan su destino declarado `net9.0`. Esta ejecución no valida el runtime .NET 9.

Los resultados TRX están en `artifacts/observable-contract/observable-contract.trx` y `artifacts/observable-contract/full.trx`. La configuración temporal reproducible es `artifacts/observable-contract/Runtime.props`. Con SDK .NET 10, NASM y las dependencias resueltas, la suite se ejecuta con:

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release \
  -p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"
```

Estas 661 pruebas corresponden al hito inicial del contrato. La opción posterior frame registers amplía la matriz a ocho combinaciones y añade pruebas de bucles, aliases de lectura y temporales. Su validación completa pasa 695 pruebas; véanse [resultados y alcance](../../corpus/libft/evidence/frame-registers/RESULTS.md). Ninguna opción se activa por defecto.

## Diseño de una representación intermedia para bucles

La primera IR de efectos ya opera antes de producir NASM y mantiene copias de marco a través del control estructurado conservando escrituras. La ampliación a asignación global debería operar sobre un grafo de bloques con instrucciones y efectos explícitos. El estado de entrada de cada bloque contiene la pila lógica, versiones de argumentos y variables, y el estado de memoria. Las uniones de ramas y las vueltas de bucle combinan esos estados mediante valores de unión, en lugar de olvidar todo al encontrar una etiqueta.

| Efecto | Información necesaria | Regla conservadora |
| --- | --- | --- |
| Valor puro | Entradas, anchura, resultado y posibilidad de fallo | Mantener el valor en registro sin cambiar semántica aritmética ni ocultar una excepción |
| Celda del marco | Identidad, anchura, intervalo y exposición | Reutilizar o promover sólo si los aliases y observaciones lo permiten |
| Memoria raw | Dirección, anchura, lectura o escritura, posible alias | Mantener el orden; invalidar asociaciones afectadas; dirección desconocida puede tocar pila y marco |
| Pila observable | Celdas vivas, bytes, direcciones físicas y escrituras residuales | PUSH16 debe reconstruir exactamente sus bytes; no basta con conservar profundidad |
| Llamada | Argumentos, resultado, ABI y resumen fiable de efectos | Materializar lo que puede observar el destino e invalidar lo que puede modificar |
| Frontera del monitor | Regiones, permisos, préstamo y resultado | Conservar las operaciones autorizadas y el orden exigido por el protocolo |

La materialización debe tener en cuenta celdas consumidas que aún puedan leerse por puntero, además de valores vivos. Si se cambia la profundidad física, deben conservarse las direcciones observables o demostrar que no son accesibles. No basta con volcar los locales justo antes de una llamada. Ante un alias que no pueda resolverse, el primer backend puede conservar la emisión actual de la función completa.

Para DiagBytes, el objetivo es mantener índice y acumulador a través de las iteraciones. Para DiagRecords se añade considerar un puntero que avance 24 bytes. Sin embargo, los punteros de entrada no están declarados ajenos al marco ni a la pila. Leer una dirección suministrada por el anfitrión podría observar una variable o escritura temporal; no se supondrá que son búferes separados sólo porque lo sean en el benchmark. Hará falta una prueba estática, un contrato de región existente o una especialización con comprobación y camino de respaldo. No se introducirán anotaciones noalias de forma implícita.

La primera integración deberá conservar el backend actual como referencia y comparar resultados, memoria y ABI para alias y no alias, anchuras, ramas, llamadas, salida del bucle y fallos. Las medidas usarán el mismo algoritmo e inputs, calentamiento y muestras intercaladas. Una mejora de velocidad no sustituye a la justificación de equivalencia ni a la validación de contención del monitor.

## Búsquedas con comparación anidada

La opción `--lookup-reductions` reconoce una búsqueda ordinal estructurada de registros con comparación escalar de bytes. Conserva los cuatro locales, tres celdas residuales, lecturas exactas y RSP en los cuatro puntos de fallo. No presupone ausencia de alias. Es otro patrón cerrado sobre la IR existente; la asignación global de CFG/SSA y los bucles con efectos adicionales siguen pendientes. Véanse el [contrato de búsqueda](../../corpus/libft/LOOKUP-REDUCTIONS.md) y los [resultados](../../corpus/libft/evidence/lookup-reductions/RESULTS.md).

## Copias a través de llamadas y escrituras crudas

`--effect-registers` extiende las copias de bindings Int64/UInt64 a funciones con llamadas y escrituras crudas. Cada escritura nombrada sigue publicándose en el frame; después de un STORE crudo o una llamada que retorna se recargan las copias. Conserva control estructurado, ABI, frame y celdas residuales, sin suponer ausencia de alias. La IR registra anchuras crudas y fronteras de invalidación; el análisis interprocedural y SSA siguen pendientes. Véanse el [contrato](../../corpus/libft/EFFECT-REGISTERS.md) y los [resultados en el programa real](../../corpus/libft/evidence/effect-registers/RESULTS.md).

## Relación con los papers

[When Is Forgetting Legitimate](https://doi.org/10.5281/zenodo.22968992), secciones 5, 6 y 9, fundamenta la separación entre obligaciones del origen y la realización, la necesidad de comprobar roles combinados y los límites de una batería finita de pruebas. La definición del contrato debe ser independiente de la transformación que se quiere justificar. No proporciona un algoritmo de asignación de registros.

[Real Structure Is Not Yet Unity](https://doi.org/10.5281/zenodo.22968944), sección 8.6, distingue una frontera declarada de una organización que sostiene el perfil. La aplicación de ingeniería a los módulos de Ubytec es que MetaDB describe y el monitor protegido ejerce autoridad efectiva; el paper no demuestra la seguridad del prototipo.

[Commercium Without Common Ground](https://doi.org/10.5281/zenodo.22968837) distingue compatibilidad para la interacción de origen común. La aplicación aquí es que preservar una interfaz no obliga a preservar toda la organización física de una realización. Esa compatibilidad tampoco concede permisos de memoria. Las reglas de compilación y aislamiento anteriores son decisiones de ingeniería apoyadas en el código y sus contratos.
