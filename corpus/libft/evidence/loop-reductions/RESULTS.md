# Loop reductions: integración y resultados

Fecha de la sesión: 2026-10-06. Destino Linux x64 mediante WSL, AMD Ryzen 7 1700. GCC/Clang son las versiones locales registradas en el JSON; no se extrapola a otros compiladores o máquinas.

## Cambio integrado

`--loop-reductions` reconoce desde la IR una reducción cerrada sobre bytes y emite un bucle escalar de valores en registros. El nombre de la función y los tamaños no intervienen en el reconocimiento. La opción es experimental y permanece desactivada por defecto.

El bucle generado pasa de **28 instrucciones, cuatro lecturas y diez escrituras** a **18 instrucciones, una lectura y siete escrituras por iteración**. Se conservan todas las últimas imágenes observables del frame y de la pila; sólo desaparecen escrituras temporales sobrescritas antes de que un acceso raw pueda leerlas. Los accesos contados son arquitectónicos, no transacciones DRAM. La opción no introduce una asignación general de registros, SSA ni SIMD.

La versión de referencia usa `--stack-transfers --frame-registers`; la nueva añade `--loop-reductions`. Ambas se construyen con el mismo DLL y la misma fuente. Los detalles del patrón, su respaldo y el registro de memoria están en [contrato de la opción](LOOP-REDUCTIONS.md) y [fuente del plan](ByteReductionPlan.cs).

## Medidas

Tiempos en **microsegundos**, por invocación de la suma. Cinco calentamientos y 40 muestras intercaladas dentro del mismo proceso, con orden rotatorio. Se incluyen los adaptadores System V y la ABI interna de las dos variantes Ubytec. Cada muestra comprueba el resultado; el JSONL conserva todos los tiempos y lotes.

| Entrada | Mediana anterior | Mediana nueva | p95 anterior | p95 nuevo | Aceleración mediana |
| --- | ---: | ---: | ---: | ---: | ---: |
| 256 bytes | 1.076 | 0.746 | 4.688 | 2.863 | 1.44× |
| 4,096 bytes | 13.754 | 9.627 | 19.891 | 13.136 | 1.43× |
| 65,536 bytes | 217.623 | 151.033 | 313.202 | 206.527 | 1.44× |

Para 64 KiB, el C escalar mide 27.334 µs con GCC y 21.522 µs con Clang. Con `-O3 -march=native`, las medianas son 13.958 y 10.471 µs. El prototipo AVX2 mide 1.297 µs; el C con intrínsecos equivalentes tiene resultados similares.

La integración escalar reduce el trabajo del backend y todavía conserva siete escrituras por byte. El prototipo SIMD sigue separado del compilador y utiliza un perfil de buffer ordinario con límites conocidos; los ejemplos C tampoco prometen la imagen física de la pila de Ubytec. Estos perfiles no justifican eliminar sus canales observables de forma implícita. Tampoco se atribuye esta aceleración a todo el analizador de texto.

## Validación

- **741 pruebas completas**, sin fallos ni omisiones, en Linux x64, NASM y .NET 10. De ellas, 46 corresponden a la opción nueva. El TRX dirigido previo contiene 45 casos; el caso adicional de direcciones con envoltura está en el TRX completo final.
- Ocho combinaciones de las opciones anteriores: semillas, índice inicial distinto de cero, suma con envoltura, memoria final, bucle vacío con puntero inválido, aliases sobre locales y celdas vivas o consumidas, lecturas desalineadas y cambios de orden de argumentos/locales. Hay resultados independientes para los aliases de un byte y para direcciones que se forman mediante envoltura de 64 bits.
- **11,396 comprobaciones** de límites y resultados sobre 11 variantes: tamaños pequeños, 256 entradas aleatorias, 32 desalineaciones y buffers junto a páginas inaccesibles. No se leen bytes fuera del rango.
- Seis lecturas fallidas por cada anfitrión GCC/Clang, ejecutadas en procesos hijos. Coinciden señal, dirección, índice y suma del frame, las tres celdas de evaluación y RSP. La pila alternativa de señales evita que el observador sobrescriba esas celdas. El registro completo de temporales y los bytes/direcciones de código no forman parte de esa equivalencia.
- **52 casos protegidos por cada anfitrión GCC/Clang**; 17 casos de préstamos por cada una de cuatro variantes; cinco casos de transporte y diez solicitudes malformadas. Las comprobaciones C del servicio, transporte y oráculo pasan con ASan/UBSan. NASM no está instrumentado por esos sanitizadores. El analizador de esta regresión no coincide con el patrón nuevo y comprueba el camino de respaldo, permisos y limpieza; no demuestra una ganancia de tiempo en esa aplicación.

El repositorio conserva su destino declarado `net9.0`. La ejecución local importa sus propiedades y cambia el framework a `net10.0` mediante `artifacts/observable-contract/Runtime.props`. No se ha ejecutado .NET 9 ni la CI remota. La CI incorpora el comparador, las pruebas de fallos y la regresión protegida, sin umbrales de velocidad.

## Evidencia y reproducción

`report.json` contiene hashes de fuentes, DLL y ensamblados, auditoría del bucle, medidas y pruebas de fallo. `comparison-samples.jsonl` contiene muestras originales; los archivos `.disasm` muestran el código máquina. Se guardan snapshots de las fuentes de la integración, ambos NASM y los informes/TRX de la regresión.

SHA-256 del compilador validado: `67eaf0a7721ed8f96b12713f8799486d5bff5b85396affb90b7c53b0490d2708`.

```sh
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release
python3 corpus/libft/run_loop_reductions.py --output artifacts/loop-reductions
python3 corpus/libft/run_text.py --stack-transfers --frame-registers \
  --loop-reductions --output artifacts/text-loop-reductions
```

Con el SDK local usado en esta sesión se añade `-p:DirectoryBuildPropsPath="$PWD/artifacts/observable-contract/Runtime.props"` a `dotnet test`, y los runners reciben `--dotnet /mnt/x/codex/resources/runtimes/dotnet-10-linux-x64/dotnet --compiler Ubytec/bin/Release/net10.0/Ubytec.dll`.

La siguiente especialización SIMD necesita un perfil de región que permita demostrar límites, ausencia de aliases sobre memoria observable del frame/pila y condiciones de acceso. La lectura raw general conserva el respaldo escalar. Los resultados actuales no constituyen una prueba de equivalencia de todos los programas unsafe.
