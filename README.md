# Ubytec interpreter

Prototype compiler for Universal Byte Code, implemented in C#/.NET 9.
The current backend emits NASM for Linux x86-64.

Implemented and tested: integer stack operations, arithmetic, bits, comparisons,
raw memory access, frame-bound locals and arguments, direct CALL, and integer or
void returns. The TextMate grammar is bundled locally.

## Compile a source file

    dotnet run --project Ubytec/Ubytec.csproj -- examples/answer.ubc -o answer.nasm

On Linux, assemble and link the result with NASM and the system linker:

    nasm -f elf64 answer.nasm -o answer.o
    ld -o answer answer.o
    ./answer

The example computes 42; its process exit status is 42. The compiler can run on
Windows, but its standalone executable output targets Linux.

Optional CLI arguments: --grammar path/to/grammar.json and --json module.json.
Use --help for usage. Parse and compilation failures return exit status 1.

## Tests and supported subset

    dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release

Native tests require NASM and Windows/Linux x64. Set UBYTEC_NASM when the
executable is not on PATH.

See [data opcodes](Wiki/docs/opcodes.md) and
[functions, variables and remaining work](Wiki/docs/functions.md), and
[verified structured control flow](Wiki/docs/control-flow.md).
Floating-point arithmetic, 128-bit values, unrestricted external calls and
general high-level expressions remain outside the tested executable subset.
Explicit unsigned integer instructions, bounded source-level allocation and
protected Linux module calls are implemented and tested.

The [libft corpus](corpus/libft/README.md) implements character functions, atoi, strlen and byte memory operations in Ubytec and compares their execution against the host C runtime.

The [module isolation prototypes](prototypes/isolation/README.md) evaluate Linux process/seccomp domains and ARM MPU domains with native attack fixtures. [Local results](prototypes/isolation/RESULTS.md) record measured containment and costs; Linux additionally runs compiled Ubytec attack functions with per-call memory loans; ARM remains a native mechanism prototype.


Compile a host library without a process entry point:

    dotnet run --project Ubytec/Ubytec.csproj -- corpus/libft/memory.ubc --library --host-export ft_strlen=ubytec_host_strlen -o memory.nasm

The experimental Linux System V adapter supports up to six integer scalar
arguments and an integer or void result. It enables host-to-Ubytec calls;
source-to-source calls through protected Linux modules are available with
--module-calls. Unrestricted external C calls remain future work.

The [independent module loader](prototypes/isolation/MODULES.md) now loads separately compiled Ubytec ELF artifacts into fresh Linux workers and enforces supervisor-owned export, RO/RW and length contracts.

[Tail calls and recursion](Wiki/docs/recursion.md): --tail-calls enables compatible frame reuse. [The recursion example](examples/recursion.ubc) compares pending-state recursion, an accumulator and a bounded explicit stack.

[Optional arena compilation](prototypes/isolation/ARENA-CLI.md): `--arena-imports` bundles the bounded arena and scoped typed-import wrappers and implies `--library --module-calls`. Use `--generated-source path.ubc` to inspect the compiled source; raw calls remain available.

[The string corpus](corpus/libft/STRINGS.md) adds bounded searches, comparisons, copies, concatenation and arena-backed strings, with independent C references and guard-page tests.

[The generic dynamic vector](corpus/libft/VECTOR.md) builds packed-record collections on the arena, including self-insertion across relocation, explicit pending state, binary text accumulation and scoped module loans.

Local native callbacks and arena-backed libft lists are implemented; see
[contracts and executed checks](corpus/libft/LISTS.md).

A complete streaming word-frequency application now combines these libraries with
explicitly authorized file I/O; see [usage, contracts and validation](corpus/libft/TEXT.md).

## Text performance baseline

The [text benchmark](corpus/libft/TEXT-BENCHMARK.md) separates native counting/sorting/emission,
protected file execution and a protected transport fixture. It compares C
implementations, records arena/RSS metrics and raw median/p95 timing samples,
and verifies outputs and cleanup without imposing CI speed thresholds.
