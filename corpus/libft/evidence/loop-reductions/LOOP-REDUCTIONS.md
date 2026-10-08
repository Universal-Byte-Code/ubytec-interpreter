# Reducciones escalares de bytes

`--loop-reductions` activa una especialización del backend Linux x64, desactivada por defecto. La API equivalente es `SourceCompiler.Compile(..., optimizeLoopReductions: true)`. Puede combinarse con `--stack-transfers`, `--frame-values` y `--frame-registers`.

El compilador reconoce una secuencia de operaciones en la IR de efectos, antes de generar NASM. No reconoce el nombre de la función, las direcciones del benchmark ni sus tamaños. La primera versión admite una función con dos argumentos y dos locales `t_uint64`, una comparación unsigned `<`, una lectura `t_byte`, suma con envoltura de 64 bits y avance del índice. El índice y el acumulador pueden tener inicializadores distintos de cero; el orden de argumentos y locales puede variar. Por ejemplo:

```text
func Fold(t_uint64 data,t_uint64 length) -> t_uint64 {
local { t_uint64 i 0 t_uint64 sum 0 }
while @i < @length
load @sum
load @data
load @i
add
load t_byte
add
store @sum
load @i
inc
store @i
end
load @sum
return
}
```

El backend mantiene dirección base, límite, índice y suma en registros. Sustituye las transferencias temporales por un registro explícito de los bytes observables de pila. El bucle tiene 18 instrucciones, una lectura raw y siete escrituras por iteración; la versión con transferencias y registros de marco tenía 28 instrucciones, cuatro lecturas y diez escrituras. Son accesos arquitectónicos, no un recuento de transacciones de DRAM.

La generación original se ejecuta también para validar tipos, readonly, retornos y scopes. Si la forma, las anchuras, el tipo de comparación o los efectos no coinciden, se conserva ese backend. La opción no implementa SSA, asignación general de registros ni vectorización. Las copias de `frame-registers` no se emiten para una función que ya tiene esta especialización; siguen disponibles para otras funciones.

## Memoria y fallos

Se aplica el [contrato observable](../../Wiki/docs/observable-contract.md) existente: RAM ordinaria del frame y de la pila, sin modificaciones concurrentes o asíncronas ni introspección de código o trazas por instrucción. No se presupone que el puntero de entrada esté separado del frame o de la pila.

Sea `S = RBP - FrameSize`, `i` el índice y `s` la suma antes de una iteración. Antes de cada lectura raw se conserva:

| Estado | Valor |
| --- | --- |
| `[S-8]` | `s` |
| `[S-16]` | `data + i`, con envoltura de 64 bits |
| `[S-24]` | `i` |
| RSP en la lectura | `S-8` |
| Variables del frame | Índice y suma de la iteración anterior ya completada |

Esto incluye un puntero que lea bytes de una de esas celdas, aunque sea desalineado. Las escrituras previas que se sobrescriben dentro de la secuencia pura no tienen un observador entre ellas y su última imagen se materializa antes de la lectura. Las celdas deben ser RAM ordinaria válida; no se pretende preservar fallos por pila insuficiente ni observaciones entre instrucciones.

Después de completar la iteración, `[S-8]` contiene el siguiente índice, `[S-16]` el byte leído y `[S-24]` el índice anterior; las variables del frame ya tienen los valores nuevos. Al retornar, `[S-8]` contiene la suma devuelta. Las celdas inferiores conservan su imagen residual, incluso cuando el bucle está vacío.

Se mantiene exactamente una lectura de un byte por iteración, en el orden original, sin ampliar accesos ni anticipar la lectura siguiente. Una lectura raw que falla conserva la dirección, el tipo de fallo, el frame, los bytes de evaluación y RSP. El archivo de registros temporales completo y la dirección de la instrucción que falla no forman parte de la ABI de valores; no se promete identidad para un depurador por instrucción. No se añaden límites de tiempo.

## Reproducción

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_loop_reductions.py --output artifacts/loop-reductions
python3 corpus/libft/run_text.py --stack-transfers --frame-registers \
  --loop-reductions --output artifacts/text-loop-reductions
```

Los runners aceptan `--dotnet` y `--compiler` para un DLL previamente construido. El valor predeterminado mantiene el destino `net9.0` del repositorio. El runner de medidas intercala el compilador anterior, la nueva especialización, GCC/Clang escalar, GCC/Clang con `-O3 -march=native` y los prototipos SIMD. Usa cinco calentamientos y 40 muestras; no impone un umbral de velocidad en CI. Los fixtures con páginas inaccesibles comprueban límites y los fallos se capturan en procesos hijos con una pila de señales independiente.

La evidencia y el alcance de la ejecución local están en [resultados](evidence/loop-reductions/RESULTS.md). El prototipo AVX2 del comparador sigue sin estar integrado en Ubytec. Los tiempos de este bucle no equivalen a los de la aplicación completa.
