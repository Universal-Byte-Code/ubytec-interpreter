# Bounded strings and arena-backed strings

The libft corpus now implements eight additional byte/string functions and three
arena-backed allocation functions in ordinary Ubytec source. This milestone also
adds seven explicit unsigned integer instructions, driven by count limits with
the high bit set. No monitor or borrowing-authority changes are introduced.

## Function contracts

Addresses/counts use the current x64 `t_uint64` representation. Callers supply valid
memory and manage lifetimes. Byte access remains direct and unsafe. Sources are
NUL-terminated unless a function explicitly accepts a bounded prefix.

| Function | Result and access contract |
|---|---|
| ft_strchr / ft_strrchr | First/last matching byte before or at the first NUL; 0 if absent. The character argument is reduced to its low eight bits; searching 0 finds the terminator. |
| ft_memchr | First matching byte among at most count bytes, including embedded NUL; 0 if absent. Count 0 does not dereference the input. |
| ft_strnlen | Bytes before NUL or count, whichever comes first. It reads no byte at index count. |
| ft_strncmp | Compares unsigned bytes until a difference, NUL or count; signed int32 difference. C results are compared by sign. Count 0 reads neither input. |
| ft_strlcpy | Copies at most capacity−1 source bytes, then NUL when capacity > 0. Returns full source length; destination is unused at capacity 0. |
| ft_strlcat | Scans destination only within capacity; appends and terminates when a NUL exists there. Returns bounded initial destination length plus source length. Unterminated destination is unchanged. |
| ft_strnstr | First substring entirely within count haystack bytes and before its NUL. Empty needle returns haystack. No haystack byte is read at index count. |

Copy/concatenation require nonoverlapping source and destination. A zero destination
capacity still requires a readable terminated source because its length is returned.
The counted readers support unterminated readable prefixes up to the stated count.
All character operations preserve source memory, including bytes after embedded NUL.
`StringLength` is an internal helper, not an additional public libft API.

Counts use explicit UGE/UGT where needed. UINT64_MAX and 2^63 are valid unsigned
limits: short terminated strings still stop at NUL. This does not make invalid
addresses or undersized readable memory valid. The existing signed DIV/MOD/SHR and
ordered comparisons keep their semantics. [The opcode reference](../../Wiki/docs/opcodes.md)
records UDIV 0x29, UMOD 0x2A, LSHR 0x36 and ULT/ULE/UGT/UGE 0x46–0x49.

## Allocation functions

`ft_strdup_arena(arena, source)` duplicates the string including NUL.
`ft_substr_arena(arena, source, start, count)` clamps count to the remaining source;
start at/beyond source length or count 0 produces an allocated empty string.
`ft_strjoin_arena(arena, left, right)` concatenates both strings with one NUL.
The names explicitly distinguish their extra arena argument from malloc-based libft.

Successful results are owned live arena allocations; release them with ArenaFree.
On allocation failure they return 0, preserve the original arena and existing
allocations/pins, and publish no partial string. Logical lengths include NUL.
Lengths that cannot fit the canonical arena are rejected; joining validates both
lengths before addition. The backing is bounded at 64 KiB and includes 32-byte block
headers. A 65,503-byte string plus NUL occupies exactly all 65,536 backing bytes in
an empty arena; the arena's separate 16-byte header is outside that capacity.
The source may be a live allocation in that arena if its pointer/lifetime is valid.
Pins remain local bookkeeping; monitor grants remain protected authority.

## Composition and reproduction

The counted string module compiles on its own. The allocation module references
StringLength/ft_strlcpy and the canonical ArenaAlloc. `run_strings.py` composes their
function bodies in one ordinary module and writes the inspectable source; it adds
no include syntax or allocation opcode.

```sh
python3 corpus/libft/run_strings.py --output artifacts/libft-strings
```

To prepare source without executing native tests:

```sh
python3 corpus/libft/run_strings.py --prepare-only --output artifacts/libft-strings
dotnet Ubytec/bin/Release/net9.0/Ubytec.dll artifacts/libft-strings/strings-composed.ubc --library -o artifacts/libft-strings/strings-composed.nasm
```

`--assembly-directory` accepts compiled NASM, exact composed source and
`strings-provenance.json` for Windows-compilation/Linux-execution handoff. The runner
checks source equivalence, artifact hashes and compiler provenance before testing.

## Executed evidence

The full .NET suite passes **545 tests** on Windows x64 with NASM. Added tests exercise
all seven unsigned instructions with boundary/random full-width values, lower-cell
preservation, source parsing, underflow rejection, extra-operand rejection and JSON
round trips. Native string tests use UCRT/libc, guard pages, unchanged sources,
neighbor bytes, truncation, empty strings, embedded NUL, bytes 128–255, exact prefixes,
2^63/UINT64_MAX limits, allocation OOM/recovery and the exact 64 KiB backing limit.
For strchr/strrchr, the .NET C reference explicitly narrows the argument to signed
8-bit char before calling the supported x64 runtimes; UCRT strrchr otherwise treats
positive 128–255 differently. Ubytec is tested with the original full int32 argument.

The independent [C client/reference](strings-reference.c) passes **117,580 checks**
with GCC, Clang and ASan/UBSan on Linux x64. Standard searches/comparisons use libc;
strlcpy/strlcat/strnstr use references built from strlen/strnlen/memchr/memcpy/memcmp.
It runs 512 deterministic generated string rounds and 256 allocation rounds,
checks exact guard-page ends and source/canary preservation, preserves complete
arena snapshots on failure, recovers on the same arena, and tests maximal lengths.
Unsigned arithmetic/comparisons match C uint64_t on boundaries and 10,000 generated
pairs; both zero-divisor operations terminate a child with SIGFPE.
Sanitizers instrument the C client/reference, not generated NASM; guard pages,
byte comparisons and canaries independently check the generated accesses.

[Saved evidence](evidence/strings) includes the successful TRX, source/assembly
manifests, exact composed source, raw native results and compiler identity. CI runs
the corpus on Linux and preserves evidence; remote CI execution is not claimed.
The general float/128-bit arithmetic, explicit casts, indirect callbacks, portable
pointer/wire ABI and OS-backed allocation remain separate future work.
