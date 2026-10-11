# Valores del marco en registros

`--frame-registers` mantiene hasta tres copias de parámetros o variables de 64 bits en registros a través de bucles y ramas. Está desactivado por defecto. La API equivalente es `SourceCompiler.Compile(..., optimizeFrameRegisters: true)`. Puede combinarse con `--stack-transfers` y `--frame-values`.

La primera versión usa una IR de efectos de función antes de generar NASM. Distingue accesos al marco, lecturas y escrituras raw, llamadas, control y uso de registros temporales. Es un resumen del programa estructurado; todavía no es un grafo SSA, una prueba general de alias ni un asignador global de registros.

## Condiciones de aplicación

Se seleccionan funciones con bucles, sin llamadas directas o indirectas, escrituras raw ni efectos desconocidos. Se consideran argumentos y variables inicializados al entrar, de tipo Int64 o UInt64. Las declaraciones inline conservan su inicialización en la posición original y sus celdas no se promueven. Las lecturas del cuerpo y de las condiciones reciben prioridad, con más peso dentro de los bucles.

Se reservan R8, R9 y R10 sólo cuando las operaciones originales no los utilizan como temporales. TwoSWAP excluye R8; TwoROT excluye los tres y conserva el backend actual. SWITCH y familias de efectos no reconocidos también conservan el backend actual. Al añadir opcodes debe revisarse su clasificación de efectos y sus registros temporales.

Las copias se cargan después de reservar e inicializar el marco. Una LOAD con símbolo puede hacer PUSH del registro; una condición puede leer ese registro. Cada STORE sigue escribiendo en su celda física y actualiza su copia. No se omiten las escrituras de pila ni se cambia su profundidad o la disposición del marco.

La invariancia buscada es que cada registro reservado contiene el valor de su celda antes de la siguiente operación fuente. La inicialización establece esa relación; las escrituras con símbolo la mantienen; las lecturas raw no la modifican; los caminos de control conservan la relación. Las operaciones que podrían romperla sin conocimiento del compilador provocan el respaldo de la función completa.

## Punteros y observaciones

No se supone que un puntero de entrada sea ajeno al marco. Una lectura raw puede observar una variable que acaba de cambiar: su STORE original sigue ejecutándose. PUSH16 conserva la lectura de bytes de celdas físicas, incluyendo una palabra entre dos celdas. Las pruebas incluyen un puntero del anfitrión hacia un argumento modificado en cada iteración.

La opción comparte las condiciones de RAM ordinaria y ausencia de modificaciones concurrentes o asíncronas del marco de las pasadas existentes. No promete bytes o direcciones de código idénticos, trazas de instrucciones, observación de registros temporales ni equivalencia de depuración por instrucción. Los registros temporales de la ABI interna pueden cambiar; se conservan resultado, argumentos, memoria y restauración de RBP/RSP. Los adaptadores System V conservan sus obligaciones de ABI.

Los accesos raw y las operaciones aritméticas conservan su posición y emisión, incluidos sus posibles fallos. La opción no introduce temporizadores ni cambia un bucle indefinido a un bucle con límite. Las pruebas finitas no demuestran equivalencia para todos los canales o ejecuciones infinitas; véase el [contrato observable](../../Wiki/docs/observable-contract.md).

## Validación y reproducción

```sh
dotnet build Ubytec/Ubytec.csproj -c Release -p:EnableDocFxOnBuild=false
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_frame_registers.py --output artifacts/frame-registers
python3 corpus/libft/run_text.py --stack-transfers --frame-registers --output artifacts/text-frame-registers
```

Los runners aceptan `--compiler` para un DLL previamente construido y `--dotnet` para el ejecutable del SDK. El valor predeterminado conserva la ruta `net9.0` del repositorio.

La validación local completa pasa 695 pruebas en Linux x64 con NASM y .NET 10. Los proyectos conservan `net9.0`; el framework se sobreescribe sólo para esa ejecución mediante el archivo de pruebas de [observable contract](../../Wiki/docs/observable-contract.md). La ejecución no valida .NET 9 ni CI remota. Los 54 casos dirigidos cubren combinaciones de las tres opciones, aliases, llamadas de respaldo, control de flujo, wrapping, bytes de pila, tipos estrechos, inicialización inline y colisiones con temporales.

La aplicación protegida pasa 52 casos por GCC/Clang, 17 casos de préstamos por cada variante, cinco casos de transporte y diez solicitudes malformadas. Los componentes C de la regresión están cubiertos por ASan/UBSan; el NASM generado no está instrumentado por ellos.

## Medidas y decisión

El runner compara transferencias de pila solas con transferencias más registros del marco, con el mismo compilador, fuente, algoritmo y entradas. Para los kernels incluye C escalar, sin vectorización, libc en el proveedor ni LTO. Intercala las variantes dentro del mismo proceso, rota su orden, usa cinco calentamientos y 30 muestras, y guarda mediana, p95 y muestras originales. El analizador completo intercala sus dos variantes y comprueba salida y limpieza de arena; su referencia C valida la salida, sin tratarla como un programa equivalente instrucción por instrucción.

Las mediciones son de ejecución en WSL. Las [muestras y resultados](evidence/frame-registers/RESULTS.md) muestran cerca de 1,60 veces de mejora para recorrer 64 KiB de bytes. Los registros de 24 bytes y la búsqueda muestran ganancias menores. El efecto en el analizador completo varía por compilador y carga; no existe una mejora uniforme demostrada.

La opción sigue siendo experimental. La mejora del recorrido de bytes justifica continuar con la representación de valores, pero las escrituras del marco y el tráfico de la pila de evaluación siguen presentes. Eliminar esos efectos requiere demostrar que no pueden observarse; no se extrapola esta invariancia a funciones con escrituras desconocidas o llamadas.
