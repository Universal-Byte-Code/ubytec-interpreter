# Reducciones escalares de campos con stride

`--record-reductions` es una opción experimental del backend Linux x64, desactivada por defecto. La API es `SourceCompiler.Compile(..., optimizeRecordReductions: true)`. Reconoce en la IR un recorrido cerrado que suma campos `t_uint64` usando `data + index * stride + offset`, con dos argumentos y dos locales `t_uint64`, comparación unsigned `<`, incremento y retorno del acumulador. Reconoce operaciones y bindings, independientemente de nombres, tamaños o constantes específicas del benchmark.

La primera versión acepta stride constante entre 1 y `Int32.MaxValue` y offset entre 0 y `Int32.MaxValue`, ambos emitidos mediante PUSH. El offset puede quedar fuera del stride; siguen siendo direcciones raw, y la optimización no declara que el intervalo forme una estructura válida ni concede permisos. Los tipos, condiciones o efectos distintos usan el backend anterior. La emisión original conserva la validación de tipos, readonly, scopes y retorno antes de sustituir el cuerpo.

## Cursor y accesos

El índice, acumulador, base y límite se cargan en registros. La dirección inicial se calcula una vez; cada vuelta avanza el cursor por stride. La identidad `data + (index + 1) * stride + offset = (data + index * stride + offset) + stride` se evalúa módulo `2^64`, conservando la aritmética de celdas del origen, incluso cuando producto o dirección envuelven. El índice unsigned no envuelve en una vuelta ejecutada porque es estrictamente menor que un límite UInt64.

Se ejecuta exactamente **una carga de ocho bytes por iteración**, en el orden original y sin leer otros campos ni huecos del registro. Una carga desalineada mantiene su anchura, incluida una carga que cruza una frontera de protección. Se conservan las variables y todas las celdas residuales que deja el patrón. Se requiere una pila y un marco válidos en RAM ordinaria y el [perfil observable del backend](../../Wiki/docs/observable-contract.md), que excluye observar registros temporales o instrucciones intermedias y modificaciones asíncronas del marco. Esta ruta escalar no agrupa ni repite las lecturas raw.

## Ledger y aliases

Con `S = RBP - FrameSize`, inmediatamente antes de la lectura se materializa:

| Dirección | Valor |
| --- | --- |
| `S-8` | acumulador anterior |
| `S-16` | dirección efectiva del campo |
| `S-24` | offset constante |
| `S-32` | stride constante |

Ambos locales están actualizados y `RSP = S-8`, igual que después de consumir la dirección en el LOAD original. Una lectura fallida conserva señal, código, dirección del fallo, dos variables, estas cuatro celdas y RSP. En una carga que cruza página, la dirección efectiva y la dirección de fallo pueden diferir; ambas se verifican por separado.

Después de una lectura correcta, el back edge conserva `S-8 = índice siguiente`, `S-16 = último campo leído`, `S-24 = offset` y `S-32 = stride`, además de ambos locales. El retorno escribe la suma en `S-8`; un bucle vacío conserva las celdas más profundas.

El cuerpo cerrado no contiene otra lectura raw, llamada ni efecto que observe las escrituras temporales sobrescritas durante el cálculo de dirección. Reproducir sus últimas escrituras antes de la carga permite eliminar las anteriores y preservar incluso lecturas que apuntan a las propias variables o celdas consumidas. No se supone `noalias` ni se necesita un guard de separación: el ledger se publica en cada iteración. La dirección se mantiene en registros, pero todos los bytes que puede leer ese alias tienen los valores originales.

El cuerpo medido pasa de **40 a 17 instrucciones estáticas**, de ocho PUSH/POP a ninguno y de 14 a ocho escrituras por vuelta, comparando contra stack transfers y frame registers ya activados. El producto por stride queda fuera del bucle. Los recuentos son de emisión estática y no equivalen a instrucciones o accesos medidos en hardware.

## Relación con registros y MetaDB

El patrón admite layouts distintos del fixture de 24 bytes con campo en offset 16: la matriz ejecuta strides 1, 7, 8, 24, 32 y 40, offsets diversos y campos desalineados. Un layout basado en bloques, stride o metadatos puede producir este recorrido, pero MetaDB no cambia su autoridad ni su representación por activar la opción. Esta integración tampoco es un optimizador general de columnas, un vectorizador de registros ni un grafo SSA.

Las búsquedas con ramas y bucles anidados, como `DiagLookup`, quedan como el siguiente frente de IR. La aplicación de texto contiene llamadas y otras operaciones fuera del patrón cerrado; el runner registra cuántas funciones reconoce y mide el programa completo para distinguir mejoras del kernel de mejoras de la aplicación.

## Reproducción

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_record_reduction_loans.py --output artifacts/record-reductions/protected
python3 corpus/libft/run_text.py --stack-transfers --frame-registers --record-reductions \
  --output artifacts/text-record-reductions
python3 corpus/libft/run_record_reductions.py --output artifacts/record-reductions/paired
```

Los runners aceptan `--dotnet` y `--compiler`. La validación local utiliza .NET 10 mediante `artifacts/observable-contract/Runtime.props`; los proyectos conservan `net9.0`. El driver de registros admite `--verify-only` para ejecutar auditoría, señales y límites sin medir. Las medidas se ejecutan tras las regresiones, sin otras compilaciones o pruebas simultáneas.

El comparador incluye backend anterior, reducción nueva, GCC/Clang escalares y GCC/Clang nativos con el mismo algoritmo. Las referencias C usan `memcpy` de ocho bytes para definir también lecturas desalineadas; su código y flags quedan conservados. Las muestras rotatorias incluyen cinco calentamientos y 40 medidas de los kernels. La comparación del texto utiliza cinco calentamientos y 30 muestras por modo y anfitrión, con output y limpieza de arena comprobados. No se aplica un umbral de velocidad en CI.

La [evidencia ejecutada](evidence/record-reductions/RESULTS.md) incluye snapshots, muestras, desensamblados, pruebas y sus limitaciones.
