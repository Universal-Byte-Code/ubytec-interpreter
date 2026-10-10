# Local evaluation and integration decision

The hardware-domain mechanism passes the prototype containment matrix on both
selected targets. Proceed with it as the basis for a future Ubytec loader; do not
describe these fixtures as a production security proof or a completed language
integration.

## Executed evidence

- Linux x86-64: 18 cases passed.
- QEMU Cortex-M3 mps2-an385: 20 containment cases and 21 execution-policy checks passed, plus 256 B / 4 KiB / 64 KiB writes.
- Native C is built with -Wall -Wextra -Werror.
- report.json accepted=true and benchmarks_executed=true.
- SHA-256 fingerprints match every delivered C/header/assembly/linker/runner source.
- CI is configured in isolation.yml. No remote CI run is claimed.

Environment: WSL2 kernel 5.10.16.3, GCC 9.4.0, Clang 10.0.0, QEMU 4.2.1.
The trusted test driver represents the lending owner; fixtures represent the
receiving hostile module. This is not yet two dynamically loaded Ubytec modules.

See [machine-readable report](evidence/report.json),
[Linux cases](evidence/linux-tests.jsonl),
[ARM UART evidence](evidence/arm-tests.log),
[measurements](evidence/linux-benchmark.jsonl) and
[ARM linker map](evidence/arm.map).

## Linux measurements

10 warmups and 100 samples per size; invocation includes process creation,
bootstrap, dedicated-memory mapping, native byte reading, IPC validation and reap.

| Logical bytes | Invocation median | Invocation p95 | Loan mapping | Peak worker RSS |
|---:|---:|---:|---:|---:|
| 256 | 2.201 ms | 2.395 ms | 4 KiB | 1192 KiB |
| 4096 | 2.256 ms | 2.574 ms | 4 KiB | 1192 KiB |
| 65536 | 2.429 ms | 2.615 ms | 64 KiB | 1252 KiB |

Copy-only timing and protected-worker TSC ticks are retained in the JSON.
The supervisor's polling cadence, process bootstrap and WSL scheduling contribute
to these measurements. TSC values are not converted into physical cycles or
compared with emulator timing. The local supervisor byte-reading baseline is
reported separately from the actual protected-worker measurement.

Calls should group useful work. Crossing the boundary for every primitive
arithmetic or byte access would be expensive in this implementation. This says
nothing about the minimum possible cost of an MPU switch or an optimized loader.

## ARM resources and faults

The emulated processor exposes eight MPU regions; the prototype uses at most four
for code, stack, private data and the active loan. Allocated ELF sections:
vectors 64 B, monitor text/rodata 9924 B, module code 600 B, data 4 B, BSS 52 B.
The layout reserves 64 KiB for monitor RAM/stack and a 64 KiB module code region;
module stack and private data reserve 4 KiB each, and loans map 256 B, 4 KiB or
64 KiB. ELF section size is not the total reserved runtime footprint.

Data violations produce MemManage faults; PPB permission changes may produce
BusFault/HardFault; NX execution produces an instruction access fault. A corrupt
exception stack is recovered using protected supervisor state. SVC requests
outside the allowed stack or with forged arguments are rejected. CPSID cannot
silence the watchdog while unprivileged. Bit-band aliases, devices, attempts to
raise privilege and semihosting do not obtain authority.

No physical board has been tested and no timing or real-time claim is made.

## Decision and remaining limits

Retain hardware-enforced domains plus a trusted monitor. Dedicated RO/RW loans
preserve direct low-level accesses without adding a check to each instruction.
Use scratch/copy regions for nonaligned fragments and commit only logical bytes
after validated completion. Terminate/remove the receiving context before reuse.

The first integration should keep this contract, define a portable host-call
and pointer ABI, and implement authenticated loading and resource bounds before
optimizing worker reuse. Reuse must not preserve stale mappings, authority or
access to previous grants. The ARM backend and physical-board validation are
separate future work.

Trust remains in the toolchain, trusted bootstrap/monitor, OS, hardware protection
and declared host configuration. Finite attack tests provide evidence, not an
absence-of-all-bypasses theorem. Microarchitectural side channels, kernel/hardware
failure, DMA delegation, persistent grants, concurrency and real-time guarantees
are outside this evaluation. Direct writable loans have no rollback promise.

## Compiled Ubytec integration

The Linux boundary now executes compiler-generated Ubytec fixtures through an
experimental System V integer adapter. Ten source-language cases and ten
successful recovery invocations pass. The same tests also pass when the host
trampoline is built with Clang. The full native Linux and ARM regression matrices
continue to pass. Local .NET compiler/ABI tests are recorded separately in the
work report; no remote CI execution is claimed.

The compiled cases validate LOAD/STORE authorization, four ordered integer
arguments (including raw addresses), CALL between Ubytec functions, recursive
stack overflow, watchdog expiry, a withheld previous grant, copy-back canaries
and a full 64-bit returned result (4294967297).

See [integration report](evidence/ubytec-report.json),
[compiled cases](evidence/ubytec-tests.jsonl),
[generated assembly](evidence/attacks.nasm) and
[compiled-worker measurements](evidence/ubytec-benchmark.jsonl).
This local run explicitly handed Windows-compiled NASM to the Linux runner.
The report records that handoff and hashes the input; CI is configured to compile
the source directly with .NET on Linux.

| Logical bytes | Ubytec invocation median | Ubytec invocation p95 |
|---:|---:|---:|
| 256 | 2.201 ms | 2.395 ms | 4 KiB | 1192 KiB |
| 4096 | 2.256 ms | 2.574 ms | 4 KiB | 1192 KiB |
| 65536 | 2.429 ms | 2.615 ms | 64 KiB | 1252 KiB |

These figures include process creation, bootstrap, byte reading, completion and
reap on this WSL host; they do not isolate the boundary's intrinsic cost.
The module is statically linked into the worker for the experiment. Arbitrary
module loading, a stable portable ABI, resource services and the ARM language
backend remain future milestones. Permission and syscall attacks continue to
run as native fixtures because those operations have no source-level counterpart
in the tested Ubytec subset.


## Independently loaded modules

The subsequent [Linux module milestone](MODULES.md) loads two separately compiled
Ubytec ELF files and a separate hostile native fixture. The supervisor is not
linked with those functions. Its protected registry binds each artifact snapshot,
export name, RO/RW ceiling and maximum loan length before invocation.

51 checks pass with each of GCC and Clang: 21 execution cases, 21 subsequent
successful recovery calls and nine registry/lifetime cases. The ELF loader
rejects 28 malformed images/tables, repeats those checks under ASan/UBSan and
handles 64 bounded mutations without a crash. Modified original files cannot
change registered sealed snapshots. Module private memory is fresh per call;
its ELF entry point and constructors are not automatically executed.

See [module evidence](evidence/modules/modules-report.json),
[sanitized parser checks](evidence/modules/modules-sanitized.jsonl) and
[compilation provenance](evidence/modules/compilation.json).
The native Linux/ARM matrices and the earlier linked Ubytec suite pass again.
Source fingerprints match delivered sources; local source compilation used the
Windows .NET compiler with an explicit Linux NASM handoff. No remote CI run is
claimed.

| Logical bytes | Module invocation median | Module invocation p95 | Peak worker RSS |
|---:|---:|---:|---:|
| 256 | 2.201 ms | 2.395 ms | 4 KiB | 1192 KiB |
| 4096 | 2.256 ms | 2.574 ms | 4 KiB | 1192 KiB |
| 65536 | 2.429 ms | 2.615 ms | 64 KiB | 1252 KiB |

Each size has ten warmups and 100 recorded samples. Invocation includes fresh
process creation, bounded ELF loading, mapping, reading, validation and reap.
The module window reserves 16 MiB of virtual addresses; this is not 16 MiB of
resident memory. TSC measurements are retained in JSON, without comparison with
physical or emulated ARM timing.

Artifact/contract approval belongs to the host. Signature-based deployment
authentication, general language import integration, dynamic linking, a stable
portable ABI, worker reuse and the ARM compiler backend remain future milestones.


## Tail recursion milestone

Opt-in --tail-calls reuses compatible terminal CALL/RETURN frames, including self
and mutual recursion. Default compilation keeps physical frames for unsafe
programs that need their lifetime or addresses. See
[the exact contract and limitations](../../Wiki/docs/recursion.md).

The full .NET native/compiler suite passes 492 tests. Separate modules complete
200,000 self steps and 200,000 mutual decrements on the 64 KiB guarded stack.
Infinite tail recursion expires through the watchdog rather than exhausting
the stack, and its recovery read passes. Non-tail recursion with pending work
still faults on overflow. The 51 module checks pass under GCC and Clang; native
Linux/ARM and linked Ubytec regression suites also pass.

The factorial example compares pending machine frames, a tail accumulator and
one eight-byte explicit state per level for n=0..20. Its bounded explicit buffer
preserves canaries and rejects insufficient capacity before writing. This is
a tested manual transformation, not automatic elimination of arbitrary pending
state or an implementation of unbounded memory.

See [optional Linux and ARM invocation deadlines](EXECUTION.md) for ordinary calls with unpredictable completion and explicit cancellation.

[Calls originating in Ubytec](PROGRAM.md) now exercise this mechanism from an isolated source-language caller through a bounded copying bridge in Linux.

Source-declared imports/exports and individual grants now support multiple receiver functions and modules. See [contracts](CONTRACTS.md).


[The libft string/copy application](LIBFT.md) now compares isolated source-level calls against a C oracle and measures separate versus grouped receiver invocations.

[Typed scalar arguments and independent source/destination loans](LOANS.md) now provide a direct memcpy call boundary with a C oracle and attack tests.

[Bridge phase profiling and event-driven invocation](PERFORMANCE.md) compares the former protocol with grouped transfers and readiness/exit waits on both Linux and Windows-mounted storage.

[The stateful text application](TEXT.md) now tests tokenization, ASCII transformation and joining in one domain, separate domains and a grouped receiver, with a C oracle and per-stage permissions.

[The bounded arena milestone](ARENA.md) passes allocation, resize, pin and incremental text checks in Linux workers.

[Scoped arena calls](ARENA-LOANS.md) now cover malicious receivers and cleanup/recovery after success, denial, fault, timeout, cancellation and transport failure.

[Generated arena imports](GENERIC-ARENA.md) now support two independent loan permissions, cleanup of prior pins and the complete arena-backed text pipeline.

[Integrated arena compilation](ARENA-CLI.md) generates and compiles scoped import wrappers with one optional compiler flag, retaining inspectable source and raw calls.

[Allocator space/copy improvements](ARENA-PERFORMANCE.md) add splitting, adjacent-free coalescing and in-place tail growth, with a preserved v1 baseline and native workload evidence.

[Sustained arena histories and repeated protected loans](ARENA-STRESS.md) add byte/pin oracles, OOM recovery, fragmentation measurements and 1,024 cycles in one caller.

[Generic vector lifecycle](../../corpus/libft/VECTOR.md) now validates pin-preserving loans, fault/deadline recovery and relocation/free after unpin in a persistent Linux caller.

## Authorized file I/O application

The [streaming text analyzer](../../corpus/libft/TEXT.md) now exercises
supervisor-owned read/write resources in a protected worker. Grants bind explicit
regular files, directions, transfer/extent limits and the protected caller context.
Output publication waits for successful completion; prior typed-loan tests still pass.
