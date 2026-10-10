# Text performance baseline (Linux x64)

The benchmark measures the current analyzer; saved evidence records the version
measured, including the historical baseline before lookup optimization. It changes no
opcode, public language interface, allocator contract or isolation permission.
The default is five warmups followed by thirty measured samples per case and
C compiler variant (GCC/Clang clients and brokers link the same generated NASM).
Timing is evidence, never a CI speed threshold.

## What is measured

* **Native feed/count, sort and emit:** a trusted C client calls the generated
  System V adapters. Input is resident in memory. Initialization, cleanup and
  output verification are outside each timed interval. Feed includes the final
  token flush; sort receives a freshly built dictionary on every iteration.
  Emit renders into a bounded memory sink through the existing HostWrite adapter.
  These runs have no process sandbox; they measure computation, not containment.
* **Protected analyzer:** a new worker executes through the existing broker.
  Wall time includes GNU time/process launch, ELF registration, worker creation,
  reading, computation, IPC, staging, fsync, publication and teardown. Output is
  checked against the independent oracle after stopping the timer.
* **Protected transport:** another Ubytec fixture copies the authorized input to
  the authorized staged output, without tokenization or dictionary operations.
  It uses the same sandbox and read/write grants. Its payload and number of writes
  differ from the analyzer, so subtracting the two times is **not** an exact
  transport-overhead measurement. The empty case provides an invocation baseline.
* **C-linear:** the same ASCII tokenization, linear search and insertion sort,
  timed in process. It uses malloc/realloc and libc rather than the validated
  Ubytec vector and arena implementation. The ratio compares implementations of
  the same algorithm, not identical instructions or allocation semantics.
* **C oracle end to end:** the existing whole-file reference, including its
  process launch and file output. It uses qsort and does not provide the protected
  worker's guarantees or durable publication. This is a program-level comparison.

C uses CLOCK_MONOTONIC; Python uses time.monotonic_ns. JSON contains raw nanosecond
samples, median, nearest-rank p95 (`ceil(0.95*n)`), and throughput calculated from
the median where the phase processes the whole input. Single-sample smoke results
are explicitly marked `statistical_baseline: false`.

## Corpus and memory

There are 45 deterministic cases: the Cartesian product of 4 KiB / 64 KiB / 1 MiB,
4 / 64 / 256 requested words, uniform / skewed distributions and 64 / 4096-byte
blocks; eight additional descending/random order cases at 64 KiB; and empty input.
Truncation at the exact byte length can introduce a final partial word; the oracle
records the actual vocabulary. Input, expected output, composed sources, NASM,
compiler and source manifests are hashed.

A separate instrumented native binary records the maximum `arena.used` after
every allocation and resize, including allocations nested inside a relocating
resize before the old allocation is freed. This is occupied backing extent,
including block headers and holes, not live payload or process RSS. The probe cell
is outside the canonical arena header and belongs only to the benchmark harness;
the instrumented binary is never used for timing or protected execution. It
reserves the same I/O buffer capacity as the protected analyzer. Every iteration
checks output, descriptors, arena release and surrounding canaries.

Native process RSS comes from getrusage(RUSAGE_SELF) and is a cumulative process
high-water mark. It includes the trusted client's resident whole input and oracle
output, so it is not the module's memory budget. Launch/fork accounting can also
affect RSS values, especially under WSL. Protected worker RSS comes from the existing wait4 result;
supervisor RSS is added by a generated diagnostic broker using getrusage. GNU
time's peak value is also retained, but must not be substituted for either domain's
own metric. Zero RSS is unavailable rather than zero memory consumption.

The filesystem cache is warmed; it is not dropped between runs. CPU frequency,
other system activity, fsync and WSL scheduling can affect results. WSL is labeled
in the report and its values must not be presented as bare-metal measurements.

## Reproduction

Requirements: .NET 9, Python 3, NASM, GCC, Clang, GNU binutils and GNU time, on Linux.

```sh
python3 corpus/libft/run_text.py --output /tmp/ubytec-text-correctness
python3 corpus/libft/run_text_benchmark.py --output /tmp/ubytec-text-benchmark
```

The first command retains all existing permission, fault, out-of-memory, output
preservation and typed-call regression tests. The second can take hours with the
current linear dictionary/validated-vector implementation. Output is checkpointed
after every completed case; `accepted` stays false until every selected case passes.

```sh
# Functional smoke; not a statistical baseline.
python3 corpus/libft/run_text_benchmark.py --warmup 0 --samples 1 \
  --case empty --case 4096-v64-uniform-b4096 --output /tmp/ubytec-bench-smoke
# Thirty-sample measurement of selected cases.
python3 corpus/libft/run_text_benchmark.py \
  --case empty --case 4096-v4-uniform-b4096 --output /tmp/ubytec-bench-selected
```

For cross-compilation, `--compile-only --dotnet PATH` writes NASM and
`benchmark-provenance.json`; transfer these alongside the source tree and run with
`--assembly-directory PATH`. The runner verifies exact source/assembly manifests.
Never run independent benchmarks concurrently if their timings will be compared.

## Acceptance and next change

All accepted samples must match both C oracles, preserve the input, pass cleanup
and guards, and have no broker denial. Existing failure tests remain mandatory;
failed/OOM executions never become successful timing samples. There is no minimum
speed requirement. Saved evidence distinguishes functional coverage, selected
statistical measurements and a complete default statistical run.

The measured dominant cost determines the next milestone: dictionary indexing
when counting dominates, O(n log n) sorting when sorting dominates, and batching
when frequent protected transfers dominate. Any recommendation must retain the
current permission and memory-failure guarantees.

## Executed evidence

Saved [evidence summary](evidence/text-benchmark/summary.json): all 45 functional
cases pass with GCC and Clang. Eight selected cases have five warmups and thirty
samples per variant. The full 45-case thirty-sample run was not executed; its
default command remains available. These are WSL results, not bare-metal figures.
The 601 .NET tests and 52 protected regression cases per GCC/Clang broker pass;
the existing typed-call regressions also pass. CI configuration was updated but
remote CI has not been run.

Selected GCC medians below; protected time includes the whole command and durable
output publication, as described above. The exact-length inputs introduce one
partial word, so actual vocabulary is shown rather than the requested label.

| Input | Actual vocabulary | Native feed/count | Protected command median | Protected p95 |
|---|---:|---:|---:|---:|
| Empty | 0 | <0.001 ms | 9.10 ms | 13.66 ms |
| 4 KiB, 4096-byte blocks | 5 | 2.39 ms | 15.29 ms | 20.23 ms |
| 4 KiB, 4096-byte blocks | 65 | 19.83 ms | 54.57 ms | 62.65 ms |
| 4 KiB, 4096-byte blocks | 257 | 186.68 ms | 304.93 ms | 318.06 ms |
| 64 KiB, 4096-byte blocks | 65 | 332.22 ms | 373.07 ms | 388.72 ms |
| 1 MiB, 4096-byte blocks | 5 | 621.90 ms | 695.69 ms | 720.22 ms |

[Statistical table](evidence/text-benchmark/measurement/benchmark-summary.md) and
[raw report](evidence/text-benchmark/measurement/benchmark-report.json) include
both compiler variants, sort/emission, C comparisons, transport and memory.
[Functional report](evidence/text-benchmark/validation/benchmark-report.json)
covers the full matrix with one sample and is labeled non-statistical.

Feed/count accounts for a median 99.24% of measured native phase time across the
seven nonempty statistical cases. The next milestone should optimize dictionary
access and investigate repeated vector/arena validation on the counting path,
preserving public vector contracts and failure behavior. Phase timings establish
where to work; they do not yet prove which individual helper dominates. Sorting
and batching can be assessed again after that change.

## Detailed diagnosis

The [executed diagnostic](evidence/text-diagnostics/RESULTS.md) separates token
construction, dictionary processing and validation calls, and compares equivalent
scalar C/Ubytec kernels with assembly audits. It finds costs in both repeated
arena lookup and the current compiler stack traffic. No production optimization
has been applied in that milestone.

La optimización posterior de búsqueda tiene [resultados y evidencia separados](evidence/text-lookup/RESULTS.md).
