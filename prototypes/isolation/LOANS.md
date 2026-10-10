# Typed scalar arguments and independent region loans

The experimental Linux call bridge now accepts signed/unsigned 64-bit scalar
arguments and up to two independently protected regions. A native receiver gets
only the scalar values and the addresses of its own dedicated mappings. It never
receives the caller's original addresses or its input packet.

## Source contract

```text
import Copy from memory.Copy (t_loan_rw,t_loan_ro,t_uint64) -> t_int64
export Main as Main
module (name:"client", version:"0.1", author:"Ubytec") {
    ...
}
```

A typed imported call consumes arguments in declaration order: each scalar is
one cell, each loan is a pair `(local_address, logical_length)`. After those
arguments come `budget_ms` (zero requests no deadline) and the local result-cell
address. CALL returns status; the receiver's full 64-bit return value is written
to that result cell. For Copy the seven caller cells are:

```text
destination, destination_length, source, source_length, count, budget_ms, result_address
```

The receiver has three scalar ABI parameters, since the loan addresses replace
these two pairs. Lengths enforce host grants; they are not additional receiver
arguments. Pass lengths as explicit scalar parameters if an operation needs them.
This prototype does not prove `count <= length` from the signature: operations
must validate their scalar ranges. Hardware protects the page-rounded mapping;
initialized padding inside that page is accessible. It contains no neighboring
caller data. Host copyback covers only the authorized logical bytes.

The provider annotates its export and uses ordinary pointer cells internally:

```text
export Copy as Copy (t_loan_rw,t_loan_ro,t_uint64) -> t_int64
module (name:"memory", version:"0.1", author:"Ubytec") {
func Copy(t_uint64 destination,t_uint64 source,t_uint64 count) -> t_int64 {
    load @destination
    load @source
    load @count
    call ft_memcpy
    drop 0
    load @count
    return
}
    ...
}
```

The compiler checks the annotation against the function's actual scalar ABI.
The test provider reuses the exact ft_memcpy implementation from the libft corpus.
See [provider](ubytec/typed/memory.ubc) and [caller](ubytec/typed/caller.ubc).

## Authority and lifetime

```sh
python3 prototypes/isolation/run_typed.py --output artifacts/typed

artifacts/typed/typed-gcc --contracts artifacts/typed/caller.elf Main \
  --module memory artifacts/typed/memory.elf \
  --grant-many Copy memory.Copy 3 65536 1 65536 1000 \
  --input input.bin --output output.bin
```

The two `(rights, maximum_bytes)` grant pairs follow loan order, independently
of scalar positions. Rights 1 permit reading; rights 3 permit reading/writing.
An unused pair must be `0 0`; both pairs are unused for scalar-only functions.
The final field is the maximum requested deadline, or `none`. Grants pin both
the alias and exact module/export. Metadata declares a contract; the protected
host table supplies authority. Handles or loan types alone do not grant access.

Each invocation snapshots loans into separate, initialized, page-aligned regions.
The receiver maps each with its own permissions. Parameter metadata is sealed
by the supervisor and its bootstrap descriptors are closed before untrusted
code executes. Scalar values are copied unchanged; caller addresses are not
resolved in the supervisor. Sender identity is the protected worker context.

Only successful calls return logical bytes from writable regions. The bridge
receives all writable results before publishing them; faults, timeout and
cancellation commit none. The monitor reaps the receiver before destroying or
reusing the loan. Copied information cannot be revoked. Overlapping caller loans
are independent snapshots; successful writable copybacks follow declaration
order. This does not provide shared alias semantics across domains.

## Validation

17 checks pass with GCC and Clang: seven byte-for-byte C memcpy comparisons
(including zero-length, binary, partial and boundary cases), source-write fault,
destination escape, fault after a partial destination write, rights and size
ceilings, absent authority, timeout, signed/full-width scalar values, explicit
cancellation of an unbounded call and a fresh invocation after failure.
Comparison covers the whole test input, preserving source, destination tail and
neighbor canaries. A small layout is used only to feed the test caller; the
receiver ABI is destination/source/count instead of that aggregate packet.

Ten malformed requests pass ASan/UBSan checks, including excessive argument/loan
counts, invalid kinds/lengths, nonzero unused records, bad magic, scalar payload
length and an attempt to use the service from a receiver context. These exercise
the actual monitor validator without launching native unsafe workers under the
sanitizer. They supplement the existing ELF and contract parser tests.

Run with `--skip-benchmark` for checks alone. `--assembly-directory` accepts an
explicit Windows-compiler/Linux-assembler handoff. Local compiler provenance,
assembly hashes, source fingerprints and linked ELF hashes accompany the report.
The CI workflow compiles source directly; no remote CI execution is claimed.

See [report](evidence/typed/typed-report.json) and
[compiler provenance](evidence/typed/compilation.json).

## Scope

Up to six receiver arguments, two loans and Int64/UInt64 returns are supported.
This first version does not marshal floats, structs, narrow integer parameters
or arbitrary argument counts. The legacy four-UInt64/Int64 signature is reserved
for the existing one-buffer bridge; use a different signature for typed calls.
The root supervisor entry still uses that legacy four-cell fixture ABI.

The bridge has bounded staging buffers (64 KiB legacy plus two 64 KiB typed
buffers); virtual storage is not equivalent to resident memory. Measurements
include peak caller/receiver RSS reported by wait4, not total simultaneous system
memory. No worker reuse, nested domain calls, concurrency, delegation, persistent
loans or ARM source backend is added. ARM retains the separately tested native
MPU fixtures. MetaDB and authenticated deployment remain later integration work.

## Historical measurements before event-driven waits

GCC / WSL2, ten warmups and 100 samples per size, measured in successive
blocks after regression tests finished. These include supervisor startup, ELF
contracts, host input, caller worker, two region copies, receiver, writable
copyback and reap; output-file writing is omitted.

| Test input | Copied bytes | Median | p95 | Peak caller / receiver RSS |
|---:|---:|---:|---:|---:|
| 256 B | 112 | 26.740 ms | 28.848 ms | 1512 / 1504 KiB |
| 4096 B | 2032 | 26.940 ms | 29.677 ms | 1512 / 1504 KiB |
| 65536 B | 32752 | 27.999 ms | 31.570 ms | 1628 / 1560 KiB |

These costs are high for a small memcpy. They measure this fresh-process bridge,
not local Ubytec calls or native memcpy throughput. The former packet application
performed strlen plus memcpy and used a different ABI; its historical timings
are not a controlled comparison against this new call. The bridge also has
10 ms polling intervals while transferring request pieces. Those waits wake on
readiness, so the interval is not a mandatory delay. The subsequent controlled
[profiling and event-driven comparison](PERFORMANCE.md) separates storage effects
and measures the optimized bridge. Containment remains
the acceptance criterion. RSS is a per-process peak, not their simultaneous sum.

[Profiling and event-driven invocation](PERFORMANCE.md) now includes an alternating reference comparison, a tested no-pidfd fallback and fragmented-transport checks.
