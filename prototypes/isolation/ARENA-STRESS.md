# Sustained arena use and protected loans

The current canonical allocator completes sustained mixed-size use, variable-depth
pending state, incremental text and repeated loans with fault recovery. This milestone
adds fixtures and evidence; it changes neither the allocator ABI nor monitor authority.

## Native persistent arenas

`linux/arena-stress.c` links the compiled Ubytec arena through its existing System V
exports. GCC and Clang each run six arena histories: capacities 4, 16 and 64 KiB,
two deterministic seeds, 24 epochs each and 512 random steps per epoch. Each history
calls `ArenaInit` once. No reinitialization occurs between epochs.

Each compiler completes **73,728 random steps** across 144 epochs. The client owns
32 slots with independent byte arrays and pin counters. Mixed sizes, shrink/grow,
free, nested pins, unpin and writes exercise live blocks and holes. Every step checks
all live logical bytes, exact allocation lookup, pins, physical header bounds,
non-overlap through the block walk, absence of adjacent free blocks, recovered tail
extent and 16-byte canaries on both sides of the backing. Successful allocation and
growth must expose zeroed bytes. Failed oversized allocation/resize must leave the
entire arena unchanged.

Every 64 steps, explicit OOM probes are added. Each epoch then drains all handles
and requires `used == 0`. On the same arena it builds/unwinds a random depth of
1–96 explicit pending-state records and appends 1–1536 ASCII text bytes in variable
chunks, checking all previous text after each append. Finally it allocates
`capacity - 32` bytes successfully and frees them, proving full payload capacity
is usable again after OOM and churn. Pending-state records use an explicit bounded
buffer; this is not physical-stack recursion or infinite-memory support.

GCC, Clang and the sanitized C client produce identical resource counts. ASan/UBSan
instrument the C client, not generated NASM; the byte oracle, block walk and canaries
cover the latter's observable writes. This native test runs in a trusted process;
protected-domain behavior is tested separately below.

## Fragmentation and cost

These are GCC client results from native WSL2/Linux `/tmp`, GCC 9.4 and NASM 2.14.
`peak hole payload` sums free interior payload capacities, excluding headers.
At each sample, available payload is those holes plus tail capacity minus one new
32-byte header when at least 40 tail bytes remain. External fragmentation is
`1 - largest_available_payload / total_available_payload`, zero when none is
available; the table gives the maximum sampled value. This measures dispersion
of available space, not a fraction of reserved memory lost permanently. Maxima in
different columns need not occur at the same instant.

| Backing | Seed index | Peak hole payload | Peak external fragmentation | Epoch median / p95 (ms) |
|---|---:|---:|---:|---:|
| 4 KiB | 0 | 1832 B | 74.0% | 1.483 / 2.264 |
| 4 KiB | 1 | 1800 B | 78.1% | 1.696 / 2.318 |
| 16 KiB | 0 | 4944 B | 88.4% | 6.120 / 6.824 |
| 16 KiB | 1 | 5896 B | 86.6% | 5.916 / 7.022 |
| 64 KiB | 0 | 14160 B | 35.6% | 9.585 / 10.470 |
| 64 KiB | 1 | 14360 B | 37.6% | 9.973 / 10.389 |

Every epoch recovers `used == 0`; no accumulating arena leak is observed in these
histories. Fragmentation remains substantial under mixed live allocations in the
small arenas. Larger free-block indexes would reduce lookup work if it proves
costly, but would not make separated holes contiguous. Coalescing already joins
adjacent free blocks; moving live blocks automatically would invalidate raw pointers.

Times cover the **whole epoch**, including byte comparisons, metadata scans,
pseudorandom client work, failures, text, pending-state and recovery. Percentiles
use 24 epoch samples (nearest rank p95); there is no warmup exclusion. Work changes
between epochs. First/last eight-epoch medians and raw timings are saved for inspection,
but this run establishes neither a pure allocator latency nor an asymptotic cost
trend. Existing controlled workload comparisons remain in [ARENA-PERFORMANCE.md](ARENA-PERFORMANCE.md).

**Decision:** retain first-fit splitting/coalescing/tail growth for this prototype.
These tests do not justify a more complex lookup structure. Before choosing one,
profile allocator-only work on a representative workload with its real number of
simultaneously live blocks. Stable pointers, bounded backing and monitor permissions
remain requirements.

## One protected caller, repeated receiver failures

`ubytec/arena/stress-source.ubc` compiles with `--arena-imports`. The runner checks
the compiler's generated source against the reference generator and the current
canonical arena. The same Linux caller worker performs **1,024 cycles** without
restart or arena reinitialization, varying two allocation sizes from 64 to 568 bytes
and the copied prefix from 16 to 63 bytes.

Per compiler the test performs:

- 1,024 successful RW-destination/RO-source loans, across 1,064 receiver launches.
- 32 receiver faults: a receiver writes its destination copy then attempts to write
  the RO source. Every original source/destination byte must remain unchanged.
- 8 explicit 25 ms deadlines for a deliberately nonterminating receiver, also without
  partial publication. The ordinary caller has no execution deadline.
- 2,048 oversized allocation/resize rejections, followed by normal work in that caller.
- Owner pin preservation across success, fault and deadline; pinned free/resize rejection;
  successful growth with old bytes preserved and newly exposed bytes zeroed after unpin.
- Successful free of both allocations and `used == 0` after every cycle. The host
  also checks packet metadata, unused header bytes and the outer footer canary.

Both GCC and Clang supervisors pass. The measured total protected workload is
approximately 1.76 seconds in this run, including setup, all computation, 1,064
receiver launches and eight explicit waits; it is not an invocation percentile.
The loader's historical `neighbors_preserved` metric concerns bytes 16–255 of an
older packet initialized to 1. It is inapplicable here because those bytes contain
results and arena metadata; `packet_guards_preserved` and fixture assertions validate
this packet instead. Raw loader diagnostics are retained.

## Reproduction and scope

```sh
python3 prototypes/isolation/run_arena_stress.py --output artifacts/arena-stress
```

For Windows compilation/Linux execution, `--assembly-directory` accepts the three
NASM artifacts, inspected generated source and `stress-provenance.json`; the runner
checks hashes of assemblies, source, canonical library and compiler provenance.
Local evidence is in [evidence/arena-stress](evidence/arena-stress), including raw
samples, packet results, source/assembly hashes and compiler identity. CI runs this
milestone and uploads the reports; remote CI execution is not claimed.

This extends Linux validation. It does not introduce ARM source compilation,
concurrency, persistent grants, new opcodes or production sandbox guarantees.
The prior attack matrix and its exclusions still apply.
