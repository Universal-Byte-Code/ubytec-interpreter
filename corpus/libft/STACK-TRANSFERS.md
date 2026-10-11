# Transferencias adyacentes de pila (Linux x64)

El compilador ofrece `--stack-transfers`, también disponible mediante
`SourceCompiler.Compile(..., optimizeStackTransfers: true)`. Está desactivado
por defecto. No añade opcodes ni cambia las celdas de 64 bits o la ABI.

Un `push registro` seguido inmediatamente de `pop registro` se sustituye por
una escritura en `[rsp - 8]` y, si son registros diferentes, un `mov` entre ellos.
Se conservan el valor, los flags, la profundidad final y la escritura en la celda
consumida. Esa escritura es observable mediante punteros en código unsafe y no
se elimina. Sólo se admiten registros enteros de 64 bits distintos de RSP.

No se atraviesan etiquetas, comentarios, instrucciones, llamadas o saltos. No
se transforma `pop/push`, memoria, inmediatos ni operaciones que usen RSP como
operando. Las señales asíncronas pueden observar otro RSP transitorio entre las
instrucciones; no se promete equivalencia de trazas, depuración paso a paso o
observación asíncrona. Las instrucciones y direcciones del código generado
cambian al activar la opción. No es asignación global de registros.

El optimizador antiguo `Optimizer.OptimizePushPop` sigue desconectado; esta
pasada no utiliza sus búsquedas a través de instrucciones intermedias.

## Reproducción

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_stack_transfers.py --output artifacts/stack-transfers
python3 corpus/libft/run_text.py --stack-transfers --output artifacts/text-stack-transfers
```

El runner compara ambos modos con el mismo compilador: 16 kernels escalares
equivalentes por GCC/Clang y tres cargas del analizador, cinco calentamientos y
30 muestras. Los resultados, profundidad, salida de C y limpieza son requisitos;
la velocidad no constituye un umbral de CI. Los procesos se miden por separado,
primero el modo normal y después el optimizado: no es una medición aleatoria
intercalada ni una garantía de rendimiento universal.

La regresión protegida comprueba el modo optimizado contra el oráculo C y los
ataques existentes. ASan/UBSan cubre componentes C de esa regresión, no el NASM.
Las medidas locales se guardan en [evidence/stack-transfers](evidence/stack-transfers/RESULTS.md).
