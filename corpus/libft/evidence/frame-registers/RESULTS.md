# Registros del marco y resultados

Comparación de `--stack-transfers` con `--stack-transfers --frame-registers`, usando el mismo compilador y fuentes. Ejecución Linux x64 sobre WSL; cinco calentamientos, 30 muestras y orden rotatorio intercalado dentro del mismo proceso. Tiempos de ejecución por llamada; p95 y muestras en `report.json`.

| Kernel | Base ns GCC | Registros ns GCC | Factor GCC | Factor Clang |
| --- | ---: | ---: | ---: | ---: |
| bytes-256 | 1345.81 | 854.67 | 1.57x | 1.59x |
| bytes-4096 | 21643.56 | 13713.48 | 1.58x | 1.58x |
| bytes-65536 | 347437.75 | 216646.66 | 1.60x | 1.61x |
| records-256 | 1407.81 | 1274.48 | 1.10x | 1.16x |
| lookup-256-last | 11346.77 | 10169.65 | 1.12x | 1.10x |
| lookup-256-missing | 5074.51 | 4596.06 | 1.10x | 1.07x |

La referencia C se compila sin vectorización ni LTO y sin llamadas externas en el proveedor. C sigue siendo más rápido: en bytes de 64 KiB, aproximadamente 26,7 microsegundos GCC y 20,5 microsegundos Clang, frente a 216,6 y 214,8 microsegundos de Ubytec optimizado. Las cifras no demuestran paridad con C.

| Texto y fase feed | Base ms GCC | Registros ms GCC | Factor GCC | Factor Clang |
| --- | ---: | ---: | ---: | ---: |
| 4096-v4-uniform-b4096 | 2.204 | 2.107 | 1.05x | 0.99x |
| 4096-v256-uniform-b4096 | 9.517 | 9.258 | 1.03x | 1.18x |
| 65536-v64-uniform-b4096 | 46.500 | 45.264 | 1.03x | 1.11x |

El texto conserva algoritmo e inputs entre los dos modos de Ubytec. Feed incluye el cierre del último token. Salida y limpieza de arena coinciden con la referencia. No se han medido nuevas latencias completas bajo el supervisor. Las ganancias del texto son variables y el caso pequeño con Clang presenta una ligera regresión.

Los recuentos estáticos de lecturas del marco incluyen las precargas: DiagBytes y DiagRecords pasan de siete a cuatro; DiagLookup de 18 a nueve. En DiagBytes y DiagRecords, tres lecturas se desplazan a la entrada; el cuerpo repite sólo la carga no seleccionada. No son recuentos de accesos ejecutados.

695 pruebas completas y 54 casos dirigidos pasan con .NET 10, NASM y Linux x64. Los proyectos conservan net9.0; no se valida .NET 9 ni CI remota. La regresión protegida pasa 52 casos por GCC/Clang, 17 pruebas de préstamos por variante, cinco de transporte y diez solicitudes malformadas. ASan/UBSan cubre los componentes C, no NASM.

Los primeros fixtures del tipo estrecho se corrigieron para usar el token admitido t_sbyte y la inicialización 255 empleada por el corpus. La prueba final verifica también el resultado del backend sin optimización. Las ejecuciones anteriores con fixtures incorrectos no se cuentan como validación.

La opción permanece desactivada por defecto. Se reservan copias de hasta tres celdas en registros; las escrituras del marco y la pila se conservan. Se excluyen funciones con llamadas, STORE raw o efectos desconocidos. Esta primera IR de efectos no es asignación global de registros ni análisis general de alias.

Hashes del compilador, fuentes y ensamblados comprobados contra los archivos que originaron las medidas y la regresión protegida.
