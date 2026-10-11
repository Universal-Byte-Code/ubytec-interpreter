# Optional integrated arena compilation

The compiler CLI now supports `--arena-imports`. It generates the same scoped
wrappers as the earlier Python tool, bundles the canonical source arena, and
compiles the result in one invocation. The flag implies `--library` and
`--module-calls`; `--generated-source <path>` optionally saves the source used
for compilation. It is written only after successful compilation. Input,
assembly, JSON and inspection output must use distinct inspection paths.

```sh
dotnet build Ubytec/Ubytec.csproj -c Release -p:EnableDocFxOnBuild=false
dotnet Ubytec/bin/Release/net9.0/Ubytec.dll \
  prototypes/isolation/ubytec/arena/dynamic-text-source.ubc \
  --arena-imports --generated-source dynamic-text.generated.ubc \
  -o dynamic-text.nasm
```

This emits NASM; native linking and protected execution still use the existing
host tooling. There is no Python process or lookup of a repository file during
compiler generation: `corpus/libft/arena.ubc` is embedded at build time in
`Ubytec.dll`. The compiler runs from a directory without a corpus checkout.

Source calls `Arena_<Alias>` to use a generated scoped arena wrapper. Plain
`call <Alias>` remains available with its raw ABI, even in this mode. Existing
commands without the flag do not insert arena routines. Tail-call compilation,
host exports and JSON output retain their existing options. The public
`ArenaImportGenerator.Generate` API makes the generated source available to
embedders; plain `SourceCompiler.Compile` retains its previous behavior.

The mode supports the existing typed bridge contract: up to six receiver
arguments and two loans, 64-bit scalars and results. It rejects the reserved
legacy four-scalar buffer ABI, unsupported contracts, repeated generation and
name collisions with wrappers or bundled arena functions. The templates supplied
to this mode should not already contain the bundled arena or generated wrappers.
The lower-level generator API can omit the bundled arena for custom embeddings.
Ranges, pin rollback, previous owner pins and returning-path cleanup have the
same behavior as [the generic wrappers](GENERIC-ARENA.md). Authority remains in
the monitor, and pins remain cooperating local bookkeeping.

## Verification and workflow

**522 .NET tests pass**, including 14 new tests for generation equivalence,
compilation, rejected contracts, collisions and raw-mode compatibility. Native
opcode tests use NASM (`UBYTEC_NASM` when it is not on PATH).

**13 CLI checks pass** from a temporary directory without a corpus: bundled
generation, optional inspection, tail-call compatibility, unchanged raw mode,
invalid option combinations, repeated generation, rejected contracts/name
collisions and refusal to overwrite input or other output with inspection source.
Rejected commands preserve existing source, NASM and inspection files.

The two caller modules for the integration suite were compiled with the new
single command. Saved inspection source exactly matches the prior generated
fixtures. **54 native cases pass per GCC/Clang supervisor**, plus five file-driver
checks. They cover both loan permissions, shared-buffer/nested pins, second-pin
rollback, all bridge outcomes and the complete three-stage arena-backed text
application. Receiver fixtures and the native bridge/monitor are unchanged.

```sh
python3 prototypes/isolation/run_generic_arena.py --output artifacts/generic-arena
python3 prototypes/isolation/generic_text_cli.py \
  --artifacts artifacts/generic-arena --input input.txt --output output.txt
```

The runner now uses `--arena-imports` directly on both templates and validates
the inspection source. It includes CLI checks in its normal Linux compilation
path; the existing CI step therefore exercises this mode and uploads the CLI
report and generated source. Remote CI execution is not claimed.

Local evidence in `evidence/arena-cli` contains the .NET TRX, CLI and native
reports, inspection sources, NASM, source hashes and compiler provenance. The
older `evidence/generic-arena` remains a snapshot of explicit Python generation.
No new performance measurements or ARM source backend are claimed here.
