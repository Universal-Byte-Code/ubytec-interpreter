# Scoped calls with arena buffers

The arena now has a tested integration pattern for synchronous inter-domain
calls. `ubytec/arena/loan-caller.ubc` combines the unchanged source allocator
with `ArenaInvoke`; `loan-receiver.ubc` provides normal and malicious receivers.
The helper selects a declared import, locates a live allocation, derives its
logical length from the block header, pins it, makes the imported call, and
unpins through one common epilogue for every returned bridge status.

Only the payload's logical bytes are lent. The allocator header, capacity,
padding, pin count and neighboring blocks are excluded from that loan. The
monitor independently validates the actual caller context, import grant,
signature, rights, length ceiling and execution budget. It creates a dedicated
initialized copy region, launches an independent receiver, waits for termination
and reaping, and only then sends successful results back. Failed calls do not
commit receiver payload writes. No monitor or bridge implementation changes
were needed for this integration; it uses their existing protected lifecycle.

Local pins prevent cooperating source code from freeing or resizing the buffer
while the helper owns a borrow. They remain ordinary writable domain metadata,
not security capabilities. A malicious root can bypass the helper or change its
own allocator. It cannot thereby expand the receiver's hardware mapping or
acquire a monitor grant. There is no privileged monitor registry of individual
arena allocations, automatic compiler insertion of pins, or new opcode.

Because calls are synchronous and concurrent execution is excluded, the owner
does not execute while the receiver is active. The helper's free/resize probes
run after pinning and before entering the bridge. They do not simulate a
concurrent free. The hardware boundary protects the separate snapshot even if
unsafe local code bypasses pin bookkeeping. A caller killed before reaching the
epilogue loses its entire worker; its local heap is not reused as persistent
state. This fixture specifically tests continuing owners that receive a result.

## Validation

**12 cases pass with GCC and 12 with Clang**, executing source-compiled Ubytec
inside the Linux protected worker:

- Successful write commits only the eight logical payload bytes.
- Accesses toward an allocator header or outside the loan fault; prior receiver
  writes are not committed.
- A write to a read-only loan faults without changing the owner buffer.
- A finite 25 ms budget contains a spinning receiver; an unbounded receiver is
  stopped by explicit SIGUSR1 cancellation.
- Missing grants and insufficient length ceilings reject the receiver launch.
- Nested owner pins survive the helper's own unpin and still block free.
- An invalid local operation exits through cleanup without making an import.
- A test-only transport artifact fails its first write and returns bridge status
  5; normal transport remains unchanged.
- A receiver returning -77 completes normally, so its writes commit. A negative
  function result is not a bridge or isolation failure.

Every case makes a second successful call with the same buffer from the same
root worker, then resizes and frees it. Tests inspect bridge status, native
result, blocked operations, pin count, receiver launch count, full block headers,
copied bytes, final used=0, and all untouched neighboring bytes/canaries. This
checks recovery within one invocation rather than relying only on a fresh heap.
Cancellation uses a bounded external test controller; ordinary unbounded calls
still have no automatic timeout based on progress.

```sh
python3 prototypes/isolation/run_arena_loans.py --output artifacts/arena-loans
```

Local execution used .NET compilation on Windows and Linux NASM/WSL2 execution.
Source/assembly hashes and compiler identity accompany the report under
`evidence/arena-loans`. The existing 113-case arena report remains separate;
these 12 cases are additional integration tests. No new performance measurements,
ARM source backend or remote CI execution are claimed. The workflow now runs
this suite after the existing allocator suite and uploads both reports.

[Generated arena imports](GENERIC-ARENA.md) now generalize this scoped-call pattern
across typed declared imports, with cleanup on every returning path. Persistent
loans, shared aliasing, concurrency and nested cross-domain calls remain outside
the prototype contract.
