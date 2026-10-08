# Arena splitting, coalescing and in-place tail growth

The source allocator now performs three improvements without changing its
16-byte arena header, 32-byte block header, eight-byte capacity granularity or
public call signatures. The bundled compiler resource and all active fixtures
use the same canonical `corpus/libft/arena.ubc` body. `baseline-v1.ubc` preserves
the previous implementation solely for reproducible comparisons.

Allocation uses first fit. A sufficiently large free block is split only when
the remainder can contain its 32-byte header and at least eight payload bytes.
Otherwise the entire free block is used. All newly allocated payload/padding is
zeroed. Free rejects pinned buffers, marks logical length zero, joins adjacent
free blocks during one linear scan and reclaims free suffixes. Coalescing does
not cross a live block or change its data, logical length or pins.

Resize rejects pinned buffers first. Within current capacity it retains the
pointer and zeroes newly exposed logical bytes. If the live block is last and
the reserved arena has enough remaining space, it extends capacity in place,
zeroes newly exposed bytes/padding and updates used without a copy. Other growth
retains the allocate/copy/free fallback, with the previous pointer and contents
preserved on allocation failure. Shrink does not split a live block. This version
does not consume a following interior free block for in-place growth, compact
live blocks, provide generation handles or obtain additional OS memory.

## Validation

The isolated Linux allocator/application suite passes **126 cases per GCC and
Clang supervisor**, comparing entire packets with a byte oracle. New cases cover
exact tail limits, pin rejection, fallback relocation, split thresholds, repeated
splits, joining in both free orders, pinned neighbors and inactive interior
pointers after joining. The 60 seeded command sequences remain covered.

**12 scoped-loan cases and 54 generic import/application cases also pass per
supervisor**, including same-worker recovery after all bridge outcomes. Tests
were adjusted to check the new block layout rather than require relocation.
The complete **522-test .NET suite passes**, including regenerated-source
equivalence with the new embedded arena. The 13 CLI checks and file drivers
pass. The monitor, bridge protocol, permissions and protected call lifecycle
are unchanged; no ARM source backend is introduced by this change.

## Space and copy results

The benchmark links compiled Ubytec arena functions into a trusted native C
client, with separate v1/current symbols. This is a same-process operation
benchmark, not an isolated-worker invocation benchmark. Footprint is the peak
occupied extent inside the backing arena, including block headers and holes but
excluding the 16-byte arena header. Reserved memory is the same for both
variants; these results do not imply a halving of process RSS.

With 16 KiB backing storage, both versions complete the same text workload (4095
bytes in chunks up to 64, plus terminator) and explicit pending-state workload
(256 records of 16 bytes, validated while unwinding). The latter represents heap
state for recursion using an explicit loop; it does not enable infinite physical
call-stack recursion.

| Workload | Peak used v1 → current | Copied bytes v1 → current | Median µs v1 → current | p95 µs v1 → current |
|---|---:|---:|---:|---:|
| text_growth | 8256 → 4128 | 3968 → 0 | 170.732 → 93.668 | 205.042 → 118.453 |
| pending_state | 8464 → 4128 | 4080 → 0 | 163.863 → 45.765 | 176.789 → 51.471 |

Text uses half the peak occupied extent; pending state falls from 8464 to 4128
bytes. Both eliminate growth copies for these last-block workloads. With only
8 KiB backing storage, v1 exhausts after 1984 text bytes or 128 state records;
the new allocator completes all 4095 text bytes and 256 records.

In a 512-byte split/reuse workload, eight rounds each attempt three 80-byte
allocations from a freed 256-byte interior block and remaining tail space.
The new allocator completes 24 allocations; v1 completes 16 and rejects eight,
with the same 496-byte peak extent. In a 384-byte coalescing workload, two freed
64-byte neighbors become one usable block: a 128-byte request succeeds in the
new implementation and fails in v1, while surrounding live bytes stay intact.

## Timing method and limits

The table reports medians and p95 of **100 batch averages**, each batch containing
100 complete workload attempts, after 10 warmup batches. Variant order rotates
per sample. Resource collection/scanning is performed separately from timing;
client writes and correctness validation remain part of the timed workload.
The p95 therefore concerns batch averages, not individual invocation latency or
an allocator primitive's standalone latency. Measurements ran natively in WSL2
from Linux `/tmp`, on an AMD Ryzen 7 1700, GCC 9.4.0 and NASM 2.14.02.

Only the first two rows complete identical work in both variants. Other raw
timings remain in the JSON report but are not interpreted as speedup ratios:
v1 rejects some attempted work that the new allocator completes. Coalescing and
additional block bookkeeping can add cost; successful allocation density is the
benefit. No process-launch/seccomp performance improvement is claimed here.

```sh
python3 prototypes/isolation/run_arena.py --output artifacts/arena
python3 prototypes/isolation/run_arena_benchmark.py --output artifacts/arena-benchmark
```

Current source and assembly hashes, the .NET TRX, allocator/loan/generic reports,
raw benchmark samples and compiler provenance are saved in `evidence/arena-growth`.
Earlier evidence folders remain historical snapshots. CI now runs the benchmark
and uploads its evidence; remote CI execution is not claimed.
