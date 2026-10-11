# Optional execution deadlines in Linux and ARM

A normal invocation may finish at an unpredictable time. A loop that waits for
input, searches until a condition is met, or retries an operation does not need
to be classified as a service. Loop syntax does not select a timeout.

The Linux module prototype now accepts a trusted host execution policy:

```sh
modules-gcc --call data.elf ubytec_host_read 1 1 256 1000
modules-gcc --call data.elf ubytec_host_tail_infinite 1 1 256 none
```

The optional final policy is a positive millisecond budget (1 through 3600000)
or `none`. Omitting it preserves the prototype's 1000 ms default. The default
is a compatibility/testing policy, not a language rule. The module cannot
extend its budget or declare itself useful. Only the supervisor selects policy.

With `none`, elapsed time alone never cancels the invocation. Natural return,
a contained fault, or external cancellation ends it. SIGUSR1 cancels the active
invocation; SIGINT and SIGTERM stop it as well. The result distinguishes
`cancelled` from `timeout`. Cancellation kills and reaps the worker before
releasing its loan. An unexpected supervisor death requests SIGKILL through
Linux PR_SET_PDEATHSIG, with a parent-identity race check before exec.

There is no reliable general test that proves an arbitrary computation is making
useful progress. A heartbeat, instruction count, or changing state alone cannot
justify that decision. The host may choose an explicit budget when its workload
requires one, or retain cancellation control without a deadline.

## External event fixture

```sh
modules-gcc --call hostile.elf ubytec_host_wait_input 1 1 256 none --input-byte
```

This native assembly fixture loops around a read on its bounded IPC channel.
The trusted supervisor forwards one byte from stdin, and the fixture returns
its value. The test supplies byte 42 after 1.2 seconds and verifies normal
completion, no timeout, and a reaped worker. This is a fixture for supervision;
it does not introduce a Ubytec input opcode or general I/O API.

The start event reports a worker PID and policy, not successful bootstrap.
Completion still requires the existing validated result protocol.

## Validation and limits

Each compiler runs 11 additional checks: late external-event completion, three
cancellation signals, a finite 100 ms budget, a write fault under an unlimited
policy, and five invalid budgets. Existing module containment, recovery, parser
sanitizer and mutation tests remain in place. See
[GCC execution checks](evidence/modules/execution-tests-gcc.jsonl),
[Clang execution checks](evidence/modules/execution-tests-clang.jsonl) and
[module report](evidence/modules/modules-report.json).

Unlimited time does not grant unlimited memory, a larger stack, additional
syscalls, new mappings, or permission to other regions. A loan remains active
until the invocation ends; read/write effects are not rolled back on cancellation.
A long invocation occupies its domain and the prototype's serialized loan slot.

Linux uses independent compiled modules; ARM uses native MPU fixtures with
optional deadlines and cancellation as described below. There is no persistent-worker
reuse or service lifecycle API in this milestone.

## ARM execution policy

The Cortex-M3 MPU monitor now applies the same choice to ordinary invocations:
a positive SysTick budget, or zero for no deadline. The default fixture wrapper
still selects ten ticks. Ticks are an emulator supervision unit, not milliseconds
or a physical performance measurement.

SysTick remains enabled without a deadline so the privileged monitor can receive
events and cancel a running module. A native fixture waits on a dedicated word
in its private region. After twelve ticks, beyond the old ten-tick watchdog, the
test controller sends an event over QEMU's UART and the monitor writes value 42
to that word; the module completes through the existing validated SVC protocol.

The UART is accessible only to the monitor and its trusted test controller.
Five-byte frames contain an event/cancel command and the current invocation
number. Wrong invocation numbers are ignored, parser state resets between calls,
and queued bytes are drained before entry. This is a test control channel, not
an authenticated production management interface. Modules cannot send their
own cancellation policies or access the UART.

Cancellation has outcome 6, distinct from timeout (4), completion (1), faults
(2/3), and protocol rejection (5). Invalid host contracts return 7 before entry.
Both finite and unlimited invocations can be cancelled, including a fixture
that attempts to mask interrupts. On every return path, the monitor disables
the timer, clears pending SysTick and disables the loan MPU region before reuse.

The 21 additional ARM checks cover six execution scenarios, six subsequent stale
pointer attempts without a grant, six successful fresh calls, and three invalid
host contracts. The event test first sends a cancellation for another invocation
and verifies it does not stop the active call. Every check requires the loan
region and timer to be disabled afterward. See [ARM evidence](evidence/arm-tests.log)
and [report](evidence/report.json).

These remain native C/assembly fixtures in QEMU. This milestone does not add an
ARM Ubytec code generator or source-language syntax for execution policies.

[Calls originating in Ubytec](PROGRAM.md) now exercise this mechanism from an isolated source-language caller through a bounded copying bridge in Linux.

Source-declared imports/exports and individual grants now support multiple receiver functions and modules. See [contracts](CONTRACTS.md).
