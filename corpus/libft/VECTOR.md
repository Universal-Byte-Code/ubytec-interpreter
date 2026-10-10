# Generic arena-backed vector

[vector.ubc](vector.ubc) implements a contiguous, dynamically growing vector as
ordinary Ubytec functions. Elements are packed byte records with a caller-selected
width. The implementation adds no opcode, syntax or runtime authority.
The current target is native x64 and the canonical bounded arena.

## Descriptor and ownership

The caller supplies a stable, writable **40-byte zeroed descriptor**, outside the
vector's own data allocation, and an initialized arena. The descriptor consists of
five uint64 cells:

| Offset | Field |
|---:|---|
| 0 | arena address |
| 8 | data allocation address, or 0 when unreserved |
| 16 | live element count |
| 24 | reserved element count |
| 32 | element width in bytes |

VectorInit rejects nonzero descriptors, width 0, widths above 65,504 and arenas
outside the canonical capacity bound. It creates an empty, unreserved vector.
It does not initialize/reset the arena or allocate descriptor storage. The vector
owns its one data allocation; the caller continues to own the descriptor and arena.
Descriptors must not be copied as independent owners of the same allocation.

Width 1 supports binary text, width 8 scalar cells, width 16 pending-state records,
and other widths arbitrary packed records. These are byte layouts, not boxed objects
or managed references. The caller handles pointees/destructors and typed raw access.
VectorValidate checks structural counts, width, the absolute capacity bound, exact
live arena allocation identity and matching allocation logical length. It is a
library consistency check, not a capability or a validator for arbitrary addresses.

## Operations

All status operations return uint64 **1 on success, 0 on rejection/OOM**.
Indices/counts are unsigned. A live vector must originate from successful Init.

| Operation | Behavior |
|---|---|
| VectorInit(vec, arena, width) | Initializes the zeroed descriptor. |
| VectorValidate(vec) | Checks descriptor/allocation consistency. |
| VectorReserve(vec, count) | Grows to exactly count elements if needed; never shrinks. Requests already covered are successful no-ops. |
| VectorEnsure(vec, count) | Normally doubles capacity up to the absolute arena bound; if that allocation fails, retries the exact minimum. |
| VectorPush(vec, element) | Adds one element at the end. |
| VectorInsert(vec, index, element) | Inserts before index, including at length, shifting later records. |
| VectorSet(vec, index, element) | Replaces a live element. |
| VectorGet(vec, index, output) | Copies a live element into an external output buffer. |
| VectorAt(vec, index) | Returns its raw address; 0 for invalid/out-of-range index. |
| VectorLength / VectorCapacity | Return counts; invalid vectors return 0, indistinguishable from empty counts. |
| VectorErase(vec, index, count) | Removes an entirely in-range span, shifts following records and zeros vacated bytes. Count 0 is a valid no-op at indices through length. |
| VectorClear(vec) | Zeros live bytes and sets length 0, retaining capacity. |
| VectorPin / VectorUnpin | Add/remove a nested arena pin on the data allocation; unreserved vectors cannot be pinned. |
| VectorDestroy(vec) | Frees data and zeros the descriptor; it does not free the descriptor itself. A destroyed descriptor must be initialized before reuse. |

Invalid indices, arithmetic bounds, unsupported aliases and failed reservations
leave the descriptor and arena unchanged. Ordinary growth, insertion, replacement,
erasure and release reject pinned data. A covered Reserve/Ensure request or a valid
zero-count Erase is permitted as a no-op while pinned; reads and Get remain available.
Clear rejects pinned data even when already empty.

The absolute maximum count is `(arena_capacity - 32) / width` when that header fits.
Other arena allocations and fragmentation can reduce available space. The arena is
limited to 64 KiB backing; a single width-65,504 element plus its 32-byte block header
can occupy the entire backing. The separate 16-byte arena header is not part of that
capacity. Reserve/Ensure publish new pointer/capacity only after successful allocation.
Failure snapshots verify preservation of existing payloads and pins.

## Raw pointers and aliasing

VectorAt returns a direct pointer. Growth can relocate the data; insertion and
erasure can change which element occupies a location. Do not retain such pointers
across operations that invalidate them. Pin keeps the allocation stable through
cooperating vector/arena APIs. Raw memory operations can bypass this bookkeeping;
monitor-controlled mappings remain the actual cross-domain boundary.

Push/Insert/Set accept a stable readable external record or exactly one aligned,
live element of that same vector. For an internal source, insertion captures its
index before growth and resolves its new location after relocation/shifting. Appending
an existing element therefore works even when the buffer moves. Partial internal
record windows, unused-capacity sources, ranges crossing into the data allocation,
overflowing ranges and overlap with the descriptor are rejected. Get requires an
external writable output record and rejects overlap with the descriptor/data.
Inputs and outputs otherwise remain caller-managed valid memory.

Unused reserved logical bytes remain zero through library-only operations. Raw writes
or receiver writes outside a legitimately lent live span are not covered by that
library invariant. No automatic compaction, generational handles, concurrent mutation,
OS allocation, destructor callbacks or persistent borrowing are introduced.

## Applications

[vector-apps.ubc](vector-apps.ubc) includes:

- VectorStateSum(vec, scratch, depth): uses an initially empty width-16 vector to
  retain index/value records, then unwinds in reverse. Scratch is a separate valid
  writable 16-byte buffer. It returns the accumulated value, -1 on memory exhaustion
  after clearing its working records, -2 for an invalid/pinned/wrong-width/nonempty
  vector, or -3 for a state/operation mismatch. This is explicit pending-state storage,
  not automatic conversion of arbitrary recursion or infinite-memory support.
- VectorAppendText(vec, scratch, source, count): appends ASCII-uppercase bytes to a
  width-1 vector, preserving embedded NUL and non-ASCII bytes. The source is a stable
  readable external span; scratch is a separate writable byte. It reserves the complete
  result before appending, so OOM/size rejection preserves the previous vector. There
  is no implicit NUL terminator. Valid memory is still a caller precondition.

Tests cover depths 0, 1, 2, 63, 128 and 256, then exhaustion at an unbounded requested
depth and recovery in the same vector. Text tests compare 128 binary batches with C
toupper in the initial C locale and preserve complete snapshots on oversized requests.

## Executed validation

The full .NET suite passes **553 tests** on Windows x64 with NASM. New native source
tests cover widths 1, 3, 8, 16 and 255, self-insertion, reads, erasure, pin rejection,
OOM/invalid capacity preservation, reuse and both applications.

The independent [C model](vector-reference.c) passes **628,292 checks** with GCC,
Clang and ASan/UBSan. Each variant performs **20,000 random operations** in ten
histories: five widths across 4 and 16 KiB arenas. A separate byte array models
logical records using C memcpy/memmove and tracks lengths and pins. Every step
compares status, live and unused bytes, metadata, allocation length/pins and outer
canaries; every rejection compares complete descriptor/arena snapshots. All histories
release every allocation and recover `used == 0`.

Directed checks force self-insertion across relocation, reject partial/unused/descriptor
aliases, prove the geometric-to-exact fallback under memory pressure, preserve an
OOM snapshot and recover after freeing a neighboring allocation, and exercise a
maximum-size element in a 64 KiB arena. Sanitizers instrument the C model/client,
not generated NASM; snapshots, byte comparisons and canaries cover generated writes.
No allocator or vector performance claim is inferred from correctness counts.

The [protected caller fixture](../../prototypes/isolation/ubytec/arena/vector-loans-source.ubc)
passes **64 cycles per GCC/Clang supervisor** without restarting its caller. It loans
only live vector bytes through existing generated arena wrappers: RW destination,
RO source. It checks owner-pin preservation, mutation/growth/free rejection while
pinned, eight receiver faults, two explicit 25 ms deadlines, unchanged original bytes
on failure, successful copy, relocation after unpin and final descriptor clearing and
arena recovery each cycle. There are 74 fresh receiver launches per run. The caller
has no execution deadline. This extends Linux validation; no ARM source backend or
new monitor service is claimed. Raw legacy neighbor diagnostics concern an older
packet layout; fixture guard assertions validate this packet instead.

## Reproduction and evidence

```sh
python3 corpus/libft/run_vector.py --output artifacts/vector
```

The runner composes the canonical arena, scalar corpus, vector and application bodies
in an inspectable source module. For the trusted C client it uses the existing
`--host-export` System V adapters; the protected module still uses source exports
and the existing monitor limits. No new include syntax is added.
`--prepare-only` prepares source without testing; `--assembly-directory` accepts exact
compiled sources, NASM, generated wrappers and vector-provenance.json for a Windows/
Linux handoff. It validates hashes and generated source against the reference generator.

[Saved evidence](evidence/vector) contains the successful TRX, full source/assembly
manifests, composed/generated sources, raw native and protected results, packet outputs
and compiler identity. CI runs the milestone and preserves artifacts; remote CI execution
is not claimed. Existing isolation exclusions and bounded unsafe memory contracts remain.
