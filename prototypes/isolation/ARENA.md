# Bounded dynamic buffers inside a domain

The first allocator milestone is implemented in Ubytec source, without new
opcodes, syscalls or changes to the sandbox. `corpus/libft/arena.ubc` supplies
`ArenaInit`, `ArenaAlloc`, `ArenaFind`, `ArenaResize`, `ArenaFree`, `ArenaPin`,
`ArenaUnpin` and `ArenaAppendUpper`. The isolated fixture contains exactly those
function bodies and two exported applications.

The monitor prepares the backing region before executing the worker. The
allocator works inside that bounded region; it does not obtain additional OS
memory. This fixture uses an exclusive root read/write loan as backing storage.
It demonstrates allocation within one domain, not a persistent heap service or
an ARM Ubytec backend. The native fixture can reuse existing writable domain
memory in the same way.

## Allocation contract

The caller provides an arena header of 16 bytes followed by up to 65536 backing
bytes. Blocks have 32-byte headers (capacity, logical length, live flag, pin
count), with capacities rounded to eight bytes. The caller must supply the full
storage, initialize once, and keep allocator metadata valid.

Allocation returns an absolute payload pointer, or zero for zero size, a request
above the limit, or exhaustion. First fit splits free blocks when a useful
remainder fits; free joins adjacent free blocks and reclaims suffixes. Newly allocated
payload and padding are zeroed. Interior addresses and inactive blocks are
rejected by the helper lookup.

Resize within capacity updates the logical length and zeroes any newly exposed
bytes. Last-block growth extends in place when backing space permits. Other
growth allocates another block, copies the previous logical bytes, and frees
the previous block only after allocation succeeds. A failed resize
leaves the old pointer, metadata and bytes intact. Resize to zero is rejected;
use free explicitly. There is no live-block compaction or generation-based
handle scheme. Reusing an address can make a
stale pointer refer to a new allocation, as with an unsafe native allocator.

Pins nest, with a bounded counter. Resize and free return zero while pinned;
unpin at zero is rejected. Pins protect against cooperating code moving or
freeing a buffer. They live in ordinary writable domain memory and therefore
cannot enforce authority against malicious code. The protected monitor remains
the authority for inter-domain loans. [Scoped import wrappers](ARENA-CLI.md)
bind pins to returning bridge calls. Raw loads/stores remain unsafe.

## Incremental text application

`TextGrow` consumes explicit-length input in chunks of 1..256 bytes and appends
ASCII uppercase bytes to a geometrically growing buffer. NUL and non-ASCII bytes
are preserved. An extra terminator is reserved in the arena. Input is published
in place only after the complete transformation succeeds; exhaustion returns
-1 and keeps the original input. This is a second text application exercising
dynamic storage, not an allocation retrofit of the tokenization pipeline in
TEXT.md. Allocations and progress are local to one invocation.

The file driver supports input up to 16384 bytes and an arena limit up to 32768
bytes. The limit is explicit and includes block headers and transient overlap
between old and new buffers. Insufficient capacity fails without replacing the
output file. It retains the monitor's current invocation policy and does not
introduce a timeout based on internal progress.

```sh
python3 prototypes/isolation/run_arena.py --output artifacts/arena
python3 prototypes/isolation/arena_text_cli.py --artifacts artifacts/arena \
  --input input.txt --output output.txt --chunk 64 --capacity 32768
```

For input ` hola, mundo ,, ubytec ` the file result is
` HOLA, MUNDO ,, UBYTEC `; delimiters and whitespace are preserved.

## Local verification

Linux x64 in WSL2: **126 cases pass with GCC and 126 with Clang**. The source
compiler emits NASM on Windows, and Linux assembles and executes the same module
through the existing protected supervisor. Evidence contains source and assembly
hashes and compiler provenance. The byte-oriented Python oracle compares entire
packets for 104 allocator/command cases, including 60 seeded sequences. Another
22 application cases check complete published text, original input on OOM,
packet geometry and external canaries. The file driver also passes a successful
transformation and preserves an existing output on exhaustion.

Covered cases include logical shrink/regrowth, zeroed allocation, relocated
growth, nested pins, free-block reuse, tail reclamation, allocation and growth
exhaustion, interior pointers, invalid slots, 64-bit size extremes, empty/binary
text, and chunk sizes 1, 7, 64 and 256. These are functional allocator tests;
they do not add a new proof of malicious-module containment. Existing monitor
boundaries and syscall restrictions are unchanged. [Current allocator measurements](ARENA-PERFORMANCE.md) compare native space,
copy and workload costs. Remote CI execution is not claimed.

The allocator is linear in the number of blocks and can fragment. Buffer growth
may copy bytes for non-tail growth; reserving a realistic initial capacity reduces that cost. [Scoped arena loans](ARENA-LOANS.md) now integrate buffer lifetime with actual
synchronous calls and same-worker recovery, while the monitor retains authority.

[Splitting, coalescing and tail growth](ARENA-PERFORMANCE.md) now reduce occupied space and copies within the same reserved arena.
