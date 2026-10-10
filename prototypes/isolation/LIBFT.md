# Isolated libft string/copy application

This application reuses ft_strlen and ft_memcpy verbatim from
[the memory corpus](../../corpus/libft/memory.ubc). The runner checks that the
copied implementations have not drifted. A Ubytec caller uses declared imports
to lend source data to a string module, then a dedicated packet to a memory
module. Another explicitly granted module groups both operations in one
receiver invocation. Both versions execute native Ubytec code behind the same
process, syscall and borrowing boundaries.

## Behavior and validation

The packet contains a source capacity, the computed string length, source bytes,
destination bytes, canaries and an eight-byte result cell. A packet is 256 B,
4 KiB or 64 KiB; benchmark strings contain respectively 111, 2031 and 32751
nonzero bytes followed by a terminator. The byte count describes the packet,
not a string of that size.

Split lends only the source capacity to the length function with read permission.
It stores the returned length and lends the dedicated packet to the copy
function with read/write permission. Group performs the same strlen and
memcpy(length+1) inside one receiver. Unused destination bytes, source contents,
the terminator and neighboring canaries must match the C oracle exactly.

The oracle is [chain-reference.c](../../corpus/libft/chain-reference.c), using C
strlen and memcpy on validated terminated input. It produces an expected binary
packet independently; comparison covers every byte, not only a checksum or return
value. The Ubytec corpus routines remain unsafe; this does not add a universal
bounds check to strlen or define C behavior for unterminated invalid strings.

19 checks pass with GCC and Clang: fourteen successful application cases
(seven inputs through both versions) and five denial/fault cases. Inputs cover
empty and ordinary strings, an internal zero, high bytes and maximum capacity
for each packet size. Fault cases cover insufficient write rights, a write on
an actual read-only loan, an address outside the entire maximum loan window,
an ungranted alias and a caller with no grants. Failed calls preserve source,
destination and neighboring packet bytes.

## Running

```sh
python3 prototypes/isolation/run_libft.py --output artifacts/libft-chain
```

The default runner compiles source on Linux. Local evaluation compiled on
Windows .NET and handed NASM to WSL, as recorded in the report/provenance.
--assembly-directory supports that explicit handoff.
--skip-benchmark runs only correctness and containment.

The supervisor's --contracts mode now accepts optional --input and --output
binary paths owned by the trusted host. Input must be a regular file of
32 through 65536 bytes; the root caller receives a dedicated initialized region.
Output copies that region back to a host file after execution. Symlinks are
rejected. Neither flag grants filesystem access to either worker.

See [caller](ubytec/libft/caller.ubc),
[string module](ubytec/libft/strings.ubc),
[memory module](ubytec/libft/memory.ubc) and
[grouped module](ubytec/libft/grouped.ubc).

## Whole-application measurements

100 samples follow ten warmups for each size/version. Measurements use GCC/WSL2,
fresh supervisor startup, ELF parsing and contract resolution, input reading,
one caller worker, IPC and loan copies, receiver workers, validated completion
and reap. Benchmark runs omit output-file writing. Both variants register the
same modules and permissions; source contents and operations are identical.

| Packet | String bytes | Split median / p95 | Group median / p95 |
|---:|---:|---:|---:|
| 256 B | 111 | 8.659 / 9.689 ms | 6.228 / 6.724 ms |
| 4 KiB | 2031 | 8.782 / 9.151 ms | 6.348 / 6.885 ms |
| 64 KiB | 32751 | 9.874 / 10.907 ms | 7.176 / 7.612 ms |

Grouping reduced median application latency by about 27-28% in this run.
Split launches two receiver workers and Group launches one; both still launch
a separate caller worker. This is not an intrinsic instruction cost, an ARM
measurement or a real-time guarantee. The variants run in successive blocks,
so scheduling and host load may affect the comparison.

This evidence favors choosing explicit useful operations at a domain boundary.
It does not justify merging distinct trust domains automatically, reusing
workers or relaxing permissions. The grouped provider needs its own host grant
and contains both corpus routines. Tiny cross-domain operations remain expensive
with fresh-process invocation; these figures should not be presented as ordinary
local Ubytec function-call performance.

See [report](evidence/libft/libft-report.json),
[GCC tests](evidence/libft/libft-tests-gcc.jsonl),
[Clang tests](evidence/libft/libft-tests-clang.jsonl),
[measurements](evidence/libft/libft-benchmark.jsonl) and
[compiler provenance](evidence/libft/compilation.json).
The existing isolation, module and contract suites remain separate checks.

[Typed scalar arguments and independent source/destination loans](LOANS.md) now provide a direct memcpy call boundary with a C oracle and attack tests.

[The stateful text application](TEXT.md) now tests tokenization, ASCII transformation and joining in one domain, separate domains and a grouped receiver, with a C oracle and per-stage permissions.
