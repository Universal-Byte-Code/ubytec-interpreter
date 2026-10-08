# Text benchmark results

Environment: Linux-5.10.16.3-microsoft-standard-WSL2-x86_64-with-glibc2.29; WSL: True. Warmups: 5; samples: 30. Statistical baseline: True.

All times below are medians in milliseconds. Protected transport copies the input;
it is a separate workload, not an overhead obtained by subtraction.

| Case | Compiler | Feed | Sort | Emit | Protected analyzer | Transport | C oracle | Arena peak bytes |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| 4096-v4-uniform-b64 | gcc | 2.367 | 0.014 | 0.004 | 19.730 | 20.623 | 2.199 | 736 |
| 4096-v4-uniform-b64 | clang | 2.393 | 0.014 | 0.004 | 19.626 | 19.926 | 2.098 | 736 |
| 4096-v4-uniform-b4096 | gcc | 2.393 | 0.014 | 0.004 | 15.285 | 10.143 | 2.025 | 4768 |
| 4096-v4-uniform-b4096 | clang | 2.409 | 0.014 | 0.004 | 14.580 | 9.893 | 2.102 | 4768 |
| 4096-v64-uniform-b4096 | gcc | 19.825 | 1.098 | 0.223 | 54.568 | 10.771 | 2.211 | 12096 |
| 4096-v64-uniform-b4096 | clang | 20.213 | 1.121 | 0.221 | 55.753 | 10.092 | 2.467 | 12096 |
| 4096-v256-uniform-b4096 | gcc | 186.675 | 15.626 | 3.141 | 304.925 | 10.522 | 2.584 | 35200 |
| 4096-v256-uniform-b4096 | clang | 186.415 | 15.754 | 3.132 | 303.527 | 12.226 | 2.484 | 35200 |
| 65536-v64-uniform-b4096 | gcc | 332.217 | 1.100 | 0.222 | 373.065 | 19.377 | 3.721 | 12096 |
| 65536-v64-uniform-b4096 | clang | 329.414 | 1.119 | 0.231 | 371.186 | 19.593 | 3.802 | 12096 |
| 1048576-v4-uniform-b4096 | gcc | 621.899 | 0.015 | 0.005 | 695.694 | 68.976 | 10.404 | 4768 |
| 1048576-v4-uniform-b4096 | clang | 622.062 | 0.015 | 0.005 | 702.815 | 76.482 | 10.656 | 4768 |
| sort-v64-descending-b4096 | gcc | 331.676 | 15.004 | 0.222 | 386.374 | 19.633 | 3.753 | 12096 |
| sort-v64-descending-b4096 | clang | 331.996 | 14.893 | 0.222 | 388.583 | 19.661 | 3.852 | 12096 |
| empty | gcc | 0.000 | 0.000 | 0.000 | 9.099 | 9.381 | 2.183 | 4128 |
| empty | clang | 0.000 | 0.000 | 0.000 | 9.570 | 8.511 | 2.045 | 4128 |

Feed/count median share of measured native phases across nonempty cases: 99.2%.
Investigate dictionary lookup and vector/arena validation costs first.
This identifies a phase; it does not prove which helper inside that phase dominates.
No opcode or isolation guarantee was changed.
