# Diagnóstico de ejecución de Ubytec

Son medidas en WSL. No se mide tiempo de compilación. No se ha optimizado el programa, las bibliotecas ni el compilador.

## Programa y bibliotecas

La cadena `TextFlush → VectorAt → VectorValidate → ArenaFind` repite recorridos de la arena por cada candidato del diccionario.
Los tiempos perfilados incluyen perturbación de hooks y contadores; no se restan del tiempo normal como si fueran un coste exacto.

| Entrada / vocabulario real | Conteo normal ms | Conteo perfilado ms | Bloques visitados | ArenaFind: % del tiempo perfilado |
|---|---:|---:|---:|---:|
| 4096 bytes / 5 palabras | 2.389 | 8.638 | 43,998 | 19.68% |
| 4096 bytes / 65 palabras | 20.151 | 28.663 | 710,826 | 57.45% |
| 4096 bytes / 257 palabras | 176.297 | 215.834 | 7,729,098 | 85.35% |
| 65536 bytes / 257 palabras | 3877.262 | 4347.123 | 164,204,490 | 87.51% |

En el caso de 64 KiB, los hijos directos de TextFeed separan construcción de palabras de búsqueda/registro:

| Operación | Llamadas | Tiempo inclusivo perfilado ms |
|---|---:|---:|
| ft_tolower | 58983 | 2.274 |
| VectorPush | 58983 | 95.672 |
| TextIsWord | 65536 | 2.970 |
| TextFlush | 6553 | 4235.987 |

TextFlush incluye búsqueda, actualización y creación de palabras nuevas. ArenaFind y VectorValidate están dentro de esos recorridos; sus tiempos no se suman otra vez a los tiempos inclusivos.

## Código generado: comparación equivalente

Mismos datos, registros de 24 bytes, operaciones unsigned, orden de búsqueda y comparación byte a byte. Ambos lados asumen punteros válidos; ninguno usa vectores, arena, asignación, supervisor ni comparaciones de libc.
C se compila a -O2 sin vectorización ni LTO, en una unidad separada. nm y objdump verifican que no hay símbolos externos ni registros SIMD en las referencias. Se conserva la optimización escalar de C.
Cada caso tiene 5 calentamientos y 30 muestras por implementación y compilador C. El coste por llamada incluye el adaptador System V de Ubytec; identity muestra ese coste por separado. Las medianas provienen de lotes de llamadas, no de restar un cronómetro a otro.

| Operación | Cliente C | Ubytec ns/llamada | C ns/llamada | Cociente Ubytec/C |
|---|---|---:|---:|---:|
| identity | gcc | 7.07 | 1.57 | 4.51 |
| identity | clang | 7.09 | 1.88 | 3.77 |
| bytes-65536 | gcc | 490858.38 | 26863.12 | 18.27 |
| bytes-65536 | clang | 505342.19 | 20522.19 | 24.62 |
| records-256 | gcc | 2207.20 | 127.46 | 17.32 |
| records-256 | clang | 2209.24 | 78.62 | 28.10 |
| lookup-256-last | gcc | 14998.38 | 1018.59 | 14.72 |
| lookup-256-last | clang | 15136.99 | 1098.60 | 13.78 |

El ensamblador confirma que los bucles de C mantienen acumuladores y cursores en registros. Ubytec conserva temporales y locales en la pila y emite numerosas parejas push/pop.
Esto demuestra una diferencia en el código generado actual para estas operaciones. No significa que todos los programas Ubytec sean ese número de veces más lentos ni identifica por sí solo cuánto aporta cada instrucción.

| Función Ubytec | Instrucciones estáticas contadas | push/pop estáticos |
|---|---:|---:|
| DiagIdentity | 9 | 4 |
| DiagBytes | 46 | 20 |
| DiagRecords | 58 | 28 |
| DiagLookup | 137 | 62 |

Los conteos estáticos cubren las instrucciones reconocidas por el analizador, excluyen adaptadores y no son conteos dinámicos de instrucciones ejecutadas.

## Resultado y siguiente paso

Hay dos lastres distintos: recorridos repetidos de validación en las bibliotecas y tráfico de pila en el código generado. En este contador, el primero amplifica el coste de la búsqueda lineal.
La mayor ganancia inmediata debe buscarse validando una vez el recorrido privado del diccionario, conservando las APIs de vectores y su comportamiento de fallo. Después se debe optimizar el código generado, empezando por los kernels escalares y comprobando el ABI y los opcodes de pila. Una tabla hash se evaluará con la nueva referencia, sin confundir ese cambio de algoritmo con una mejora del compilador.
Las validaciones de estructuras privadas son distintas de la frontera de aislamiento: las concesiones, permisos y supervisión de módulos siguen siendo responsabilidad del monitor y no se han cambiado.

## Validación y reproducción

16 casos equivalentes por GCC/Clang, 30 muestras por implementación; checks de spans vacíos, longitudes distintas y wrap de UInt64. Cuatro casos perfilados y sus binarios normales coinciden con el oráculo C y liberan la arena. ASan/UBSan pasan en el cliente y la referencia C; NASM no está instrumentado por esos sanitizadores.

```sh
python3 corpus/libft/run_text_diagnostics.py --output /tmp/ubytec-text-diagnostics
```

Para compilación cruzada, usar --compile-only --dotnet PATH y después --assembly-directory PATH con el manifiesto y las mismas fuentes. Evidencia: [informe JSON](diagnostic-report.json), [NASM de los kernels](diag-kernels.nasm), [desensamblado C GCC](provider-gcc.txt), [desensamblado completo](disassembly-gcc.txt).
La configuración de CI ejecuta el diagnóstico sin umbrales de velocidad; CI remoto no se ha ejecutado.
