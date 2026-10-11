# Generated arena calls for typed imports

`generate_arena_imports.py` generalizes the scoped-loan pattern to any existing
typed import supported by the experimental bridge: up to six receiver arguments,
up to two loans, 64-bit signed/unsigned scalars and a 64-bit result. It generates
ordinary reviewable Ubytec source. [The integrated compiler mode](ARENA-CLI.md)
now generates and compiles it with `--arena-imports`, optionally retaining
inspection source. The standalone Python generator remains a reference tool.
There is no new opcode or monitor change; raw imported calls do not automatically
acquire arena pins.

For `import Copy from memory.Copy (t_loan_rw,t_loan_ro,t_uint64) -> t_int64`,
the generated function is:

```text
Arena_Copy(dst_arena, dst_allocation, dst_offset, dst_length,
           src_arena, src_allocation, src_offset, src_length,
           count, budget_ms, resultcell) -> bridge_status
```

Each loan becomes four UInt64 arguments identifying its arena, live allocation,
offset and logical byte length. Scalars retain their declared order and type.
Budget (0 means none) and native-result pointer follow the declared arguments.
The wrapper returns the bridge status; the native result is stored separately,
including its full 64-bit bit pattern. Zero-loan imports also get wrappers.
The reserved legacy four-UInt64/Int64 buffer ABI is rejected by this generator;
its original raw adapter is unchanged. Use typed loan declarations for arena
calls. Unsupported types and wrapper name collisions are rejected explicitly.

## Lifetime and authority

The wrapper initializes the result cell, finds each live allocation, and checks
all ranges against logical length before acquiring any pins. It compares the
offset first, then subtracts it before checking length, avoiding overflow.
Payload subranges can be lent without exposing allocator headers or neighboring
blocks. Zero-length spans are valid at an allocation boundary.

Pins are acquired in argument order. Failure acquiring a later pin releases only
pins already acquired by that wrapper, in reverse order. Normal returns from
success, denial, fault, timeout, cancellation and transport failure use the same
reverse cleanup. Existing owner pins survive. Two arguments referring to one
allocation acquire and release two pins; second-pin failure preserves the exact
prior count. The generator does not merge loans or turn copying into shared
alias semantics: each argument has an independent snapshot; successful RW
copyback follows declaration order, as documented in LOANS.md.

Pin metadata remains unsafe writable domain state, suitable for cooperating
code. The monitor independently enforces caller identity, grants, rights, length
ceilings, budgets and protected mappings. Concurrency, persistent loans and
nested cross-domain calls remain excluded. A terminated caller does not return
through cleanup; its entire worker is discarded. These wrappers concern calls
that return a bridge result to a continuing owner.

## Text application

`dynamic-text-source.ubc` now uses generated wrappers for the existing lexer,
mapper and writer imports. It allocates input, descriptor/workspace and output
buffers inside the arena. Tokenization receives only descriptor storage RW and
input RO; transformation receives only the normalized-text subrange RW and
input RO; joining receives output RW and workspace RO. It publishes a complete
successful result outside the arena before freeing all three allocations.
Input bytes and external canaries are preserved; application or bridge failure
does not publish output. Earlier stage writes remain in the caller's workspace
until cleanup, rather than becoming a whole-pipeline rollback transaction.

The file driver accepts at most 8192 input bytes, 256 fields and an arena limit
of 32768 bytes. The arena is bounded reserved storage and can exhaust; it is not
an unbounded OS heap. The complete transformation is explicit-length byte
tokenization by comma, whitespace trimming, empty-field removal, ASCII uppercase
and joining with `|`. Interior NUL and non-ASCII bytes are preserved.

```sh
# Generate reviewable source from a template with typed imports.
python3 prototypes/isolation/generate_arena_imports.py \
  prototypes/isolation/ubytec/arena/dynamic-text-source.ubc \
  --arena-library corpus/libft/arena.ubc -o dynamic-text.ubc

# Compile and validate all generated source and receiver artifacts.
python3 prototypes/isolation/run_generic_arena.py --output artifacts/generic-arena

# Transform an actual file through three isolated receiver invocations.
python3 prototypes/isolation/generic_text_cli.py \
  --artifacts artifacts/generic-arena --input input.txt --output output.txt
```

` hola, mundo ,, ubytec ` becomes `HOLA|MUNDO|UBYTEC`.
Failed allocation, insufficient field capacity or failed execution preserves an
existing output file. Source templates and generated fixtures are retained;
the runner checks exact regeneration equality before compilation/execution.

## Evidence

Local Linux x64/WSL2 execution passes **54 cases with GCC and 54 with Clang**:
21 two-buffer/ABI/lifetime cases and 33 text cases. The ABI cases cover RW/RO,
RW/RW and RO/RW orderings; six arguments and interleaved full-width signed/
unsigned scalars; no-argument and zero-loan calls; subranges, zero lengths,
high-bit offset/length rejection, invalid allocation addresses, nested pins,
shared allocation arguments, saturated second pins and exact rollback, missing
grants, native negative results, read-only write faults, partial write failure,
timeout, cancellation and a test-only injected transport failure.

Each ABI case performs a successful recovery call in the same root worker and
checks payloads, both block headers, pin counts, final free/used=0, receiver
launch counts and untouched neighboring bytes. Text results use an independent
byte transformation oracle, including 20 seeded inputs, binary/empty inputs,
allocation and output exhaustion, token overflow, denied grants and read-only
ceilings. Five file-driver checks cover normal, binary and empty results, plus
preservation of an existing output on arena/field exhaustion. Generator checks
cover four valid signatures, six rejected contracts/collisions, two regeneration
comparisons and two command-line generation runs.

The three new artifacts were source-compiled with the existing .NET compiler;
the unchanged text receiver assemblies were reused. NASM, source/assembly hashes
and compiler provenance are stored under `evidence/generic-arena`. The CI workflow
now includes this suite, but remote CI execution is not claimed. The original explicit-generation milestone did not change the compiler or
monitor. See [integrated compilation](ARENA-CLI.md) for the subsequent compiler
CLI integration and current evidence. No new performance numbers or ARM backend
are claimed.
