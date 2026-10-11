# Stateful Ubytec text application

This executable experiment receives a bounded byte sequence, splits on commas,
trims ASCII whitespace at field edges, drops empty fields, uppercases ASCII a-z
and joins nonempty fields with |. Interior whitespace, NUL and non-ASCII bytes
are preserved. Lengths are explicit; NUL does not end the input. An output
terminator is written inside the provided capacity and omitted from the plain
output file.

```text
 hola, mundo ,, ubytec  ->  HOLA|MUNDO|UBYTEC
```

The program is written in Ubytec. The host supplies IO and initialized buffers;
the trusted monitor supplies process isolation and loan lifetimes. No language,
opcode, compiler or isolation-runtime changes were necessary.

## Three executable variants

- Mono executes all stages as ordinary calls inside the caller domain.
- Split invokes isolated lexer, mapper and writer modules in succession.
- Group invokes one receiver containing the same three ordinary Ubytec routines.

The implementations use the same canonical function bodies. The runner checks
for drift against [the text corpus](../../corpus/libft/text.ubc) and the original
ft_isspace, ft_toupper and ft_memcpy implementations. These are bounded application
routines, not an allocating replacement for the standard libft ft_split API.

The lexer preflights token capacity, then produces a count and (offset, length)
descriptor table. The mapper writes uppercase bytes to a separate working buffer.
The writer validates descriptors and output capacity before copying the selected
fields into the result. A caller-owned workspace keeps that state between calls,
although every receiver process is new. No persistent receiver process or loan
is used.

## Running with files

```sh
python3 prototypes/isolation/run_text.py --output artifacts/text
printf ' hola, mundo ,, ubytec ' > /tmp/ubytec-text-input.txt
python3 prototypes/isolation/text_cli.py --artifacts artifacts/text \
  --mode split --input /tmp/ubytec-text-input.txt --output /tmp/ubytec-text-output.txt
cat /tmp/ubytec-text-output.txt
```

Choose mono, split or group. --fields selects capacity (default 16, maximum 256).
--output-capacity includes the required terminator; by default it is input length
plus one. The driver grants only the normal operations required by the selected
mode. Diagnostic fault exports remain ungranted. A failed operation leaves an
existing plain output file unchanged. The supervisor has no worker filesystem
permissions; only the host handles files.

Run the test runner with --skip-benchmark for checks alone. Local validation used
the Windows compiler and --assembly-directory NASM handoff to Linux. The default
runner builds source on Linux. The current root-loan limit is 64 KiB for the
entire test packet (header, input, state, working buffer, output and canaries),
not a 64 KiB text-input allowance. Receiver calls request a 1000 ms deadline;
these are bounded processing tasks, while the runtime's optional-deadline policy
remains unchanged.

## Permissions and failures

Split grants independent ranges:

| Stage | Writable loan | Read-only loan |
|---|---|---|
| Lexer | State header and descriptor table | Original input |
| Mapper | Normalized working bytes | Original input |
| Writer | Output capacity | State plus normalized working bytes |

The state and working bytes are contiguous in the caller for the writer's loan.
The mapper receives only a dedicated copy of its own slice, so forging a pointer
one byte before that slice hits a guard, rather than reaching the table.
The original input is never writable in a receiver. The writer cannot modify
its read-only state/working view.

Group requires a broader writable grant covering state, working bytes and output.
Grouping is suitable when those stages belong to the same trust domain. It does
not preserve the per-stage restrictions of Split, and it does not automatically
merge independent trust domains.

The monitor discards partial writable results on native faults. Parse and build
routines also preflight their capacities to avoid partial table/output writes on
ordinary errors. Whole-pipeline rollback is not provided: successful earlier
stages can leave their authorized intermediate state when a later stage fails.
Input and final output remain preserved in the tested failure cases.

Application errors are -10 (geometry), -11 (token capacity), -12 (output capacity)
and -13 (descriptor validity). A nonzero bridge status becomes -100 minus that
status. The driver checks result length, count, terminator, original input and
canaries before writing the plain output.

## Validation

190 cases pass under each GCC and Clang supervisor. These include 57 normal/error
inputs across all three variants: empty, binary, repeated/trailing delimiters,
all ASCII whitespace forms, exact/insufficient capacities, 256 fields, long fields,
large inputs, deterministic random cases, invalid geometry, short packets and
64-bit values with the high bit set. Comparison covers the whole packet, including
state, normalized bytes, source preservation, unused capacity and canaries.

Twelve corrupted-descriptor cases cover populated and empty tables in all three
variants. Six permission/fault cases cover source RO writes, mapper escape toward
the table, writer partial writes followed by RO faults, absent permissions and
insufficient output rights; a fresh invocation then succeeds. The independent C
oracle passes 61 ASan/UBSan checks. Four plain-file driver cases verify all modes
and preservation of an existing output file on failure.

This exercises a six-argument exported grouped function and the corresponding
ten-cell imported-call adapter, without expanding the existing ABI limits.
The C# compiler and isolation runtime were unchanged; their prior suites were
not rerun for this application-only addition. CI now runs the new source-build
application suite; no remote CI run is claimed. ARM remains native MPU fixtures,
without an ARM compiler backend or this text application on ARM.

See [application report](evidence/text/text-report.json),
[compiler and assembly provenance](evidence/text/compilation.json),
[caller](ubytec/text/caller.ubc), [single domain](ubytec/text/mono.ubc),
[lexer](ubytec/text/lexer.ubc), [mapper](ubytec/text/mapper.ubc),
[writer](ubytec/text/writer.ubc) and [grouped receiver](ubytec/text/grouped.ubc).

## Whole-application measurements

GCC / WSL2 with artifacts and IO on Linux /tmp. Each size has ten warmups and
100 samples per variant, rotating order on every trial. All variants perform the
same operations on 32 fields. Measurements include fresh supervisor startup,
ELF/contracts, input, workers, loan copies, computation, completion and reap;
profiling is enabled and output-file writing is omitted. C is the correctness
oracle, not a performance comparator in these figures.

| Input bytes | Mono median / p95 | Split median / p95 | Group median / p95 |
|---:|---:|---:|---:|
| 256 | 2.798 / 3.406 ms | 7.020 / 8.380 ms | 4.391 / 5.083 ms |
| 4096 | 3.016 / 3.724 ms | 7.810 / 8.846 ms | 4.730 / 5.726 ms |
| 16384 | 3.554 / 4.123 ms | 8.272 / 9.454 ms | 5.366 / 6.174 ms |

Grouping reduced median whole-application latency by 35.1–39.4% in this run.
Mono creates one worker; Group creates two; Split creates four (the caller plus
three sequential receivers). Split and Group resolve the same provider artifacts;
Mono loads only its single artifact. Preparation therefore differs as part of
the application configuration. These are not isolated CALL instruction costs,
C throughput comparisons or real-time guarantees. RSS peaks are recorded per
caller and receiver in the report, not added as simultaneous memory usage.

The result supports putting useful amounts of work behind each selected trust
boundary. It also demonstrates that independently restricted stages are workable
when their extra invocation cost is warranted by the trust model.
