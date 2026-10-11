# Calls originating in Ubytec modules

Source-declared imports/exports and individual grants now support multiple receiver functions and modules. See [contracts](CONTRACTS.md).

The Linux prototype now runs a Ubytec caller in an isolated worker. Its existing
CALL instruction invokes an explicitly enabled host import, ModuleInvoke. The
trusted supervisor validates that caller domain's authorization, invokes a
separately compiled target in another worker, and returns a status and scalar
value to the caller. It never executes either module's code.

This is the first source-language integration of the tested mechanism. The
experimental API uses one host-configured target per caller. It is not a general
module import resolver, a stable ABI, or an ARM Ubytec backend.

## Source contract

Compile the caller as a library with --module-calls. Without that option,
ModuleInvoke is an unknown function. The option reserves that name at module
scope and links an adapter to the worker-side bridge runtime. No opcode is added.

ModuleInvoke consumes six cells in this order:

| Argument | Meaning |
|---|---|
| handle | Host-issued callable handle; this prototype grants handle 1 |
| buffer | Address in the caller's accessible memory |
| length | Logical bytes to lend, 1 through 65536 |
| rights | 1 for reading, 3 for reading and writing |
| budget_ms | Positive requested budget, or 0 for no deadline |
| result_address | Address of an eight-byte result cell in the caller |

It pushes one integer status. On success the result cell contains the target's
full 64-bit return value. On failure it is zero. Caller pointers are never
dereferenced in the supervisor or passed directly into the receiver.

| Status | Meaning |
|---:|---|
| 0 | Validated return |
| 1 | Rejected handle, rights, size or budget |
| 2 | Receiver fault |
| 3 | Receiver timeout |
| 4 | Receiver cancellation |
| 5 | Receiver bootstrap, protocol or local transport failure |

For example, a function with a buffer argument can lend its first sixteen bytes:

```text
push 1
load @buffer
push 16
push 1
push 1000
load @buffer
push 128
add
call ModuleInvoke
return
```

This returns the status; the scalar value is stored at buffer+128. The output
cell must belong to caller memory. See [complete caller source](ubytec/modules/caller.ubc)
for value-returning, copy, timeout, unlimited and rejection examples.

## Building and executing

```sh
python3 prototypes/isolation/run_modules.py --sanitizers --output artifacts/modules
python3 prototypes/isolation/run_program.py --modules artifacts/modules --output artifacts/program

artifacts/program/program-gcc --program \
  artifacts/program/caller-gcc.elf ubytec_host_value \
  artifacts/modules/data.elf ubytec_host_read 1 16 1000
```

The CLI arguments after the target symbol are the permitted rights, maximum
logical length and maximum requested budget (milliseconds, or none). These
permissions come from the trusted host, not from source imports or knowledge of
a symbol/address. With a finite maximum, requests for zero/no deadline or larger
budgets are rejected. With none, the caller may request no deadline or a finite
budget up to the prototype limit of one hour.

The root caller has no automatic deadline in this prototype. SIGUSR1 cancels
the currently executing receiver and delivers status 4 to the caller. If no
receiver is active it cancels the caller. SIGINT/SIGTERM stop the program and
reap both workers. Unexpected supervisor death requests SIGKILL for both through
the existing parent-death mechanism.

The runner builds the compiler and caller from source by default. The optional
--caller-assembly supports the explicitly recorded Windows compiler/NASM handoff
used for the local WSL evaluation.

## Memory and authority

The worker-side runtime snapshots the requested bytes before sending a bounded
request on its existing IPC descriptor. Invalid caller pointers fault inside
that worker. Its reusable 64 KiB transfer buffer belongs to the caller domain;
its code has no authority to grant permissions.

The supervisor identifies the requester from the worker context, validates the
bounded frame and handle against protected host state, and creates a fresh
dedicated region. Logical bytes contain the snapshot; mapping padding is zero.
The receiver gets that region with the approved rights, not the caller's other
memory, output cell, globals or stack.

After the receiver is killed or returns, the supervisor reaps it. Only a
validated success with read/write rights copies exactly the logical bytes back.
Partial writes followed by a fault, timeout or cancellation never commit to the
caller. Read-only calls return their scalar result without copying data back.

The caller remains a separate worker while waiting. The two workers never share
a loan mapping. This milestone deliberately expands the original single-worker
fixtures to one supervisor-brokered call hop using copies. Receivers cannot
delegate, invoke further domains or acquire another handle. Requests for that
service from the receiver context are rejected and contained. There is no
recursive domain-call chain, concurrent grant or worker reuse.

Returns and bytes from either unsafe module remain untrusted data. Reported
status values are not a new authority mechanism or proof of application-level
correctness.

## Validation

26 checks pass with each native compiler: authorized source calls, full scalar
results, bounded copy-back, repeated calls, rights/size/handle/budget rejection,
unlimited return, timeout, four memory attacks, failed partial copy, forged
completion, caller pointer fault, finite/unlimited cancellation, delegation
denial, two malicious caller frames, supervisor death and full program stop.
The .NET suite passes 497 tests, including five bridge compilation checks.

See [program report](evidence/program/program-report.json),
[GCC checks](evidence/program/program-tests-gcc.jsonl),
[Clang checks](evidence/program/program-tests-clang.jsonl) and
[local compiler provenance](evidence/program/compilation.json).
The CI workflow includes source compilation and these tests; no remote CI run
is claimed.

ARM still validates the supervision contract through native MPU fixtures.
Integration into ARM-generated Ubytec, multiple registered imports, richer
signatures and performance characterization of the new call path remain future
work. The copying bridge adds IPC and copy cost to existing process-invocation
measurements; those older measurements do not measure this complete path.

[The libft string/copy application](LIBFT.md) now compares isolated source-level calls against a C oracle and measures separate versus grouped receiver invocations.
