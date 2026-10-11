# Reutilización de valores del marco (Linux x64)

`--frame-values` activa una pasada experimental, desactivada por defecto.
La API ofrece `SourceCompiler.Compile(..., optimizeFrameValues: true)`.
Puede combinarse con `--stack-transfers`; se aplica después de esa pasada.

La pasada registra qué registros de 64 bits contienen el valor actual de una
celda `qword [rbp +/- desplazamiento]`. Una lectura posterior dentro del mismo
tramo recto puede convertirse en un movimiento entre registros o eliminarse
si el registro de destino ya contiene el valor. Conserva todas las escrituras.

Las escrituras de celdas del marco invalidan las celdas solapadas, incluso con
desplazamientos sin alinear. Los movimientos entre registros propagan el valor;
los cálculos invalidan sus destinos. Los registros parciales, instrucciones no
reconocidas, accesos por punteros, escrituras fuera del marco, cambios de RBP/RSP,
operaciones de pila, llamadas, etiquetas y saltos descartan la información.
No se crea estado compartido entre compilaciones ni entre funciones.

La opción supone memoria RAM ordinaria de parámetros y variables del marco.
No promete equivalencia para lecturas volátiles, modificaciones concurrentes o
asíncronas de ese marco, trazas de instrucciones o direcciones del código.
Permanece desactivada por defecto. No es una asignación global de registros y no
reserva registros nuevos ni cambia la ABI o los opcodes.

## Validación y reproducción

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_stack_transfers.py --frame-values --output artifacts/frame-values
python3 corpus/libft/run_text.py --stack-transfers --frame-values --output artifacts/text-frame-values
```

Con `--frame-values`, el runner compara transferencias de pila solas con
transferencias más reutilización del marco, usando el mismo compilador y las
mismas entradas. Mantiene cinco calentamientos y 30 muestras por GCC/Clang.
Sin esa opción, conserva la comparación original del runner. Los tiempos son
de ejecución, no de compilación; no constituyen umbrales de CI. Cada modo se
mide en un proceso separado y en orden fijo, no intercalado aleatoriamente.

Las pruebas nativas cubren movimientos, valores de 64 bits, flags, registros
parciales, alias por puntero, celdas solapadas y barreras. La regresión protegida
comprueba salidas, limpieza y ataques. ASan/UBSan cubre componentes C, no NASM.

Los resultados locales están en [evidence/frame-values](evidence/frame-values/RESULTS.md).
