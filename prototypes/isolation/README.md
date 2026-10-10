# Ubytec isolation mechanism prototypes

This is an executable evaluation of the chosen mechanism, not an integrated
Ubytec loader, ARM language backend, stable ABI or production sandbox.

Run on Linux x86-64 (including WSL2):

    sudo apt-get install gcc clang lld qemu-system-arm python3
    python3 prototypes/isolation/run.py --output /tmp/ubytec-isolation-results

The runner builds with warnings treated as errors, requires every expected case
on both targets, and saves JSON evidence. A missing MPU, bootstrap failure,
incomplete UART run, missing case, failed attack or missing benchmark makes the
full run fail. --skip-benchmark produces a containment-only report with
benchmarks_executed=false. No physical ARM timing is inferred from QEMU.

## Contract and trusted components

The common descriptors represent region owner, exported domain/function,
receiver, invocation and read/read-write rights. The experimental four services
are create_region, register_export, invoke and close_domain. Their implementations
are monitor-internal C functions, not instructions, serialized handles or public
language APIs. Module identifiers in payload data grant no authority.

The supervisor binds the receiver to the worker/active exception context. A
completion must match the active region, invocation, rights and logical length.
There is no delegation, persistent loan, nested cross-domain call, parallel loan
or untrusted allocation service. All fixtures are compiled into the executable;
loading arbitrary modules, authenticating deployments and durable resource
management are future integration work.

The enforcement unit is a dedicated hardware region, not an arbitrary byte
slice. It contains only the loan and initialized padding, with no neighboring
owner data. The receiver may access that padding under the region's permissions.
For nonaligned fragments, the copy fixture publishes an independent region and
copies only the logical bytes back on validated completion, preserving canaries.
Direct writable loans are not transactional: writes before a failure need not
be rolled back. Discard the scratch region rather than commit it on failure.

The metadata table is trusted state. MetaDB is not a dependency of this prototype;
a future descriptive contract must never serve as self-issued authority.

## Linux x64

Every call fork/execs a fresh worker. EXEC, rather than fork alone, removes
inherited supervisor memory and authority. Before payload execution, the worker
maps the dedicated loan, reserves inaccessible neighbors, creates an NX guarded
stack, closes all descriptors except one IPC socket, and enables no_new_privs and
seccomp. The loan fd is closed after mapping.

BPF checks AUDIT_ARCH_X86_64, rejects other ABIs and x32 syscall numbers, and allows
only exit/exit_group plus read/write on IPC fd 3 (including the upper argument
word check). Opening files, ptrace, clone, new mappings and permission changes
are prohibited. The supervisor bounds the completion record and waits/reaps
the worker before reusing the loan. A one-second host deadline kills a hung
worker. Code and library mappings remain ordinary process-local native mappings.

Process isolation protects the supervisor; seccomp restricts resource acquisition.
The trusted bootstrap, compiler, dynamic loader, host environment and kernel
are part of the trust boundary. Bootstrap must succeed before any attack counts.
Timing, resource contention and microarchitectural channels are excluded.

## Cortex-M3 MPU

QEMU mps2-an385 runs native Thumb fixtures. No semihosting is enabled, including
for monitor output/termination: results use UART, and the runner terminates QEMU
after an explicit DONE marker. The semihosting attack must fault.

The monitor checks MPU_TYPE, enables MemManage, and configures:
- Module RX code: 0x00010000, 64 KiB.
- Private NX stack: 0x20010000, 4 KiB, with unmapped surroundings.
- Private NX data: 0x20012000, 4 KiB.
- Loan NX data: 0x20020000, power-of-two size, RO or RW.
- Monitor memory/code, peripherals and bit-band aliases: inaccessible to user code.

PRIVDEFENA supplies the privileged monitor's background map only. The module
runs with CONTROL.nPRIV=1 and PSP. Register state is cleared on entry. SVC validates
the exception-return mode, the entire stack frame, executable return PC and
completion arguments before reading/accepting them. Fault recovery constructs
a new exception frame on the saved protected MSP; it never trusts a corrupted
module frame. Pending faults are cleared before resuming the supervisor.

SysTick, which unprivileged code cannot mask via CPSID, bounds infinite loops.
Fault and timer recovery remove the loan mapping before subsequent invocations.
The virtual interval is a functional watchdog, not a real-time guarantee.
DMA, MPU configuration and peripherals are not delegated.

## Evidence and interpretation

The same 13 functional/containment scenarios run on both targets. Additional
Linux syscall cases and ARM privilege, peripheral, alias and exception cases
exercise target-specific bypasses. The report also requires ARM writes of
256 B, 4 KiB and 64 KiB.

Linux benchmarks have 10 warmups and 100 recorded samples per size:
- invocation_and_read: complete fork/exec/bootstrap, region mapping, payload,
  IPC validation and reap. This includes zero-copy loan setup and scheduler cost.
- copy_only: per-copy time averaged over 1,000 copies within each sample.
- local_byte_read_baseline: supervisor baseline, not the protected worker.
- worker_byte_read: serialized TSC ticks around the actual native payload.
  These are virtualized timestamp-counter ticks, not claimed physical CPU cycles.

The supervisor's 1 ms polling/reap cadence contributes to invocation latency.
Do not treat these numbers as the intrinsic cost of a context switch or MPU.
Peak worker RSS includes its bootstrap; ELF allocated sections and reserved ARM
stack/private/loan sizes are reported separately. Reports are measurements of
this host and toolchain, not universal budgets.

Read [RESULTS.md](RESULTS.md) for the local decision and measurements.
The evidence in evidence/report.json includes source hashes; generated binaries
and intermediate output stay outside versioned source.

## Remaining work

For broader Ubytec integration: define the portable pointer/host-call ABI, bounded
resource APIs and authenticated loading; execute on physical ARM hardware; review
the monitor and OS assumptions independently; then optimize call batching without
weakening isolation. No general side-channel or kernel/hardware-failure guarantee
is made by passing this finite fixture suite.

References:
- https://kernel.org/doc/html/latest/userspace-api/seccomp_filter.html
- https://arm-software.github.io/CMSIS_5/5.7.0/Core/html/group__mpu__functions.html
- https://www.qemu.org/docs/master/system/arm/mps2.html

## Compiled Ubytec integration (Linux)

The Linux worker also accepts statically linked functions generated from
[ubytec/attacks.ubc](ubytec/attacks.ubc). Run with .NET 9 and NASM installed:

    python3 prototypes/isolation/run_ubytec.py --output /tmp/ubytec-integration

This runner compiles the source, assembles ELF64, links the existing supervisor
with UBYTEC_ENABLED, and requires ten Ubytec cases plus a fresh successful read
after every case. LOAD/STORE, named arguments, local variables, CALL, recursion
and loops execute as native compiler output after seccomp is enabled. A return
value of 4294967297 checks that IPC preserves all 64 bits.

--compiler-dll selects an already built compiler. --assembly explicitly accepts
assembly compiled on another host; its report labels this as a precompiled
handoff, not compilation by the Linux runner. Both modes hash source, assembly
and linked artifacts. --skip-benchmark marks measurements as skipped.

Library compilation uses --library to omit the process entry point and
--host-export Function=ubytec_host_symbol to generate a System V integer adapter.
The adapter accepts zero to six scalar integer arguments in rdi/rsi/rdx/rcx/r8/r9,
pushes arguments in Ubytec declaration order, preserves System V callee-saved
registers and returns the scalar result in rax. Pointers cross as uint64 address
values; access rights come from process mappings, never the value or its type.
The ubytec_host_ prefix reserves adapter symbols separately from internal labels.
The adapter is an experimental Linux ABI; it adds no Ubytec-to-host external
CALL operation, Windows ABI or ARM code generator.

The C trampoline and IPC wrapper reside inside the untrusted worker. A hostile
module may overwrite its own process memory or forge completion data; the trusted
supervisor still validates the bounded completion against the active call and
reaps the process before region reuse. Returned values are untrusted data.

The compiled suite covers read, write, RO write denial, foreign/monitor/neighbor
pointers, stack overflow, timeout, stale pointer and copy-back with canaries.
The native suite continues to cover syscall, permission and forged-message attacks
that do not currently have corresponding source-language instructions. Full
arbitrary-module loading, authenticated exports and bounded public resource APIs
remain future work. ARM fixtures remain C/assembly.

## Independent module loading

[MODULES.md](MODULES.md) describes the restricted Linux ELF loader, supervisor-owned function contracts, sealed artifact snapshots, attacks and measurements. This additional prototype loads modules compiled separately from the supervisor.

See [optional Linux and ARM invocation deadlines](EXECUTION.md) for ordinary calls with unpredictable completion and explicit cancellation.

[Calls originating in Ubytec](PROGRAM.md) now exercise this mechanism from an isolated source-language caller through a bounded copying bridge in Linux.

Source-declared imports/exports and individual grants now support multiple receiver functions and modules. See [contracts](CONTRACTS.md).


[The libft string/copy application](LIBFT.md) now compares isolated source-level calls against a C oracle and measures separate versus grouped receiver invocations.

[Typed scalar arguments and independent source/destination loans](LOANS.md) now provide a direct memcpy call boundary with a C oracle and attack tests.

[Bridge phase profiling and event-driven invocation](PERFORMANCE.md) compares the former protocol with grouped transfers and readiness/exit waits on both Linux and Windows-mounted storage.

[The stateful text application](TEXT.md) now tests tokenization, ASCII transformation and joining in one domain, separate domains and a grouped receiver, with a C oracle and per-stage permissions.

[Bounded dynamic buffers and incremental text](ARENA.md) now exercise a source-level arena inside one protected domain.

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
