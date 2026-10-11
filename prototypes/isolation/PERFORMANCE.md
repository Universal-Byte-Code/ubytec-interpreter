# Bridge profiling and event-driven invocation

The Linux isolation bridge now batches the bounded typed request into a single
write, and sends the reply header plus authorized writable regions together from
the trusted supervisor. The byte-stream format, loan limits and grants are unchanged.
Partial writes/reads and EINTR remain supported. The caller receives every writable
result before publishing any result. A truncated response publishes none.

The supervisor waits for socket readiness, cancellation signals and worker exit
through ppoll and pidfd when supported. Waiting for a completed message no longer
adds a one-millisecond sleep before checking exit. Signals are blocked while
checking cancellation flags, then atomically unblocked by ppoll, avoiding a lost
cancellation between the check and an indefinite wait. Workers remain fresh for
every invocation, with the same seccomp filter, separate address spaces, sealed
metadata, permissions and parent-death behavior.

Older kernels use bounded one-millisecond exit checks when pidfd is unavailable.
This fallback is tested explicitly. No new worker syscall permission is required:
the grouped request uses the already-allowed write; sendmsg and pidfd are confined
to the trusted supervisor.

## Reproducing the comparison

```sh
python3 prototypes/isolation/run_typed.py --output /tmp/ubytec-bridge-typed
```

Use an output directory on the Windows mount for the second storage experiment.
The runner builds an optimized variant and a reference with the former periodic
polling and separate writes, using the same source, source-generated assembly,
permissions, operation and storage location. UBYTEC_BRIDGE_REFERENCE and
UBYTEC_NO_PIDFD are compile-time test controls, not worker-selectable authority.
Each size uses ten paired warmups and 100 measured pairs with alternating order.
Host profiling is enabled in both variants. Each application still creates one
caller and one receiver worker. Output-file writing is omitted.

These are whole-application timings, including process startup, contracts, input,
loan copies, execution and reap. The test inputs are 256 B, 4 KiB and 64 KiB;
actual memcpy counts are 112, 2032 and 32752 bytes, respectively. This is not a
benchmark copying a full 64 KiB loan or a local function-call measurement.

## Measured results

GCC / WSL2. Final measurements ran after regressions, without running other tests
in parallel. The Linux and Windows-mount experiments used identical source and
NASM; each compares its own reference and optimized binaries in alternating pairs.

| Artifact storage | Input | Reference median / p95 | Optimized median / p95 | Median reduction |
|---|---:|---:|---:|---:|
| Linux /tmp | 256 B | 6.334 / 6.799 ms | 4.122 / 4.731 ms | 34.9% |
| Linux /tmp | 4096 B | 6.398 / 6.874 ms | 4.177 / 4.831 ms | 34.7% |
| Linux /tmp | 65536 B | 7.100 / 7.663 ms | 4.895 / 5.308 ms | 31.1% |
| Windows mount | 256 B | 25.196 / 26.998 ms | 23.255 / 26.019 ms | 7.7% |
| Windows mount | 4096 B | 25.099 / 27.286 ms | 23.423 / 25.727 ms | 6.7% |
| Windows mount | 65536 B | 26.178 / 28.174 ms | 24.443 / 26.659 ms | 6.6% |

The approximately two-millisecond gain is consistent with removing the fixed
exit-check delay for both workers. The storage change is a separate effect: do
not attribute the difference between Windows-mount totals and Linux totals to
the bridge optimization. These remain substantial costs for tiny operations.

## Phase interpretation

`--profile` in the supervisor's `--contracts` mode emits `profile-result`.
Normal execution emits no phase report. The runner stores medians of:

- Preparation: from entering main to preparing the root invocation.
- Module registration and image reading: nested portions of preparation.
- Request receipt: body and loan transport after the header has arrived.
- Loan setup: initialized dedicated regions, grant checks and sealed parameters.
- Receiver setup and fork: supervisor-side descriptors and process creation.
- Receiver wait: exec/bootstrap, native execution, completion and wait4.
- Receiver reap field: completion draining and validation after wait4 has returned.
- Reply sending: header and authorized writable bytes queued to the caller.
- Caller wait: includes its receiver call; it is not an independent additive phase.

Per-phase medians do not sum to the total, and some phases intentionally nest.
Receiver ticks are native-operation TSC observations from the untrusted wrapper;
they are diagnostic data, not authoritative time or an ARM performance estimate.
Worker bootstrap cannot be separated from receiver execution using only these
trusted-side timestamps. Peak RSS is per-process, not a simultaneous total.

For the smallest input, optimized phase medians are:

| Storage | Preparation | Receiver fork | Receiver wait | Request receipt | Reply sending |
|---|---:|---:|---:|---:|---:|
| Linux /tmp | 0.136 ms | 0.100 ms | 0.920 ms | 29.5 us | 29.8 us |
| Windows mount | 5.053 ms | 0.104 ms | 2.455 ms | 29.3 us | 31.9 us |

## Validation and evidence

17 typed-call cases pass in each of four configurations: GCC, Clang, reference,
and forced no-pidfd fallback. They retain C equivalence, independent permissions,
failed-write rollback, timeout, explicit cancellation and fresh recovery.
Ten malformed requests and five transport fault-injection cases pass ASan/UBSan.
The latter cover short reads/writes, EINTR, zero-length loans, two 64 KiB loans,
RO/RW order, partial input compaction and truncated reply without copyback.

The previous suites pass again: 51 module/registry/recovery cases per compiler,
28 malformed ELFs and 64 mutations, 26 source-call cases per compiler, 22 contract
cases per compiler plus eight sanitized metadata cases, 19 libft cases per
compiler, 18 native Linux cases, ARM 20 containment plus 21 execution-policy checks
and three sizes, and 20 linked Ubytec containment/recovery cases.

The C# compiler and language syntax were unchanged. Their existing 508-test result
is recorded in retained compiler provenance; the .NET suite was not rerun for this
native-only change. CI now includes the expanded typed runner; no remote CI run
is claimed.

See [Linux comparison](evidence/bridge-performance/typed-linux/typed-report.json),
[Windows-mount comparison](evidence/bridge-performance/typed-windows/typed-report.json)
and [verified provenance](evidence/bridge-performance/compilation.json).
All eight report source manifests match delivered sources.
