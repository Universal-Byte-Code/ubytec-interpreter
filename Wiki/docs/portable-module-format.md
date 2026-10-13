# Portable Module Format v0

The interpreter can emit and verify the architecture-neutral Portable Module Format
(PMF) defined by the `Universal-Byte-Code/schema` repository.

PMF v0 is a deterministic binary container around the normalized semantic AST and
portable contract/capability metadata. It is deliberately upstream of the x86-64
backend: the container contains no NASM, ELF addresses, host ABI values or other
target-specific code.

## Emit a portable module

Emit the canonical AST-based PMF container:

```text
dotnet run --project Ubytec/Ubytec.csproj -- examples/answer.ubc \
  -o answer.nasm \
  --portable-module answer.ubcm
```

Emit the same PMF container with the indexed executable profile as well:

```text
dotnet run --project Ubytec/Ubytec.csproj -- examples/answer.ubc \
  -o answer.nasm \
  --portable-module answer.ubcm \
  --indexed-executable
```

`--indexed-executable` requires `--portable-module`. The AST-only PMF form remains
the default so existing portable artifacts are not silently changed.

The normal source compilation and semantic validation still run. The compiler then
encodes the normalized module into `answer.ubcm` while independently producing the
current Linux x86-64 NASM output.

For modules with source-level imports/exports, the indexed profile consumes the
semantic portable contract view produced during compilation. Source aliases,
runtime bridge handles, generated host adapter symbols and process addresses are
not serialized.

## Verify a portable module

```text
dotnet run --project Ubytec/Ubytec.csproj -- --verify-module answer.ubcm
```

Verification is bounded and does not compile the file. The v0 verifier checks:

- `UBCM` magic and supported format version;
- the 64 MiB runtime size limit and 32-section limit;
- strictly increasing unique section kinds;
- reserved flag bits and unknown critical sections;
- exact end-of-file with no truncation or trailing bytes;
- required critical Semantic AST presence;
- canonical UTF-8 JSON for semantic AST and capability payloads;
- canonical UTF-8/LF contract-manifest text;
- sorted unique capability names;
- all-or-none indexed executable section presence when that profile is included;
- canonical indexed String/Type/Import/Export/Constant tables;
- function code ranges and referenced table-index bounds;
- `CALL` target kinds and local/import target indices;
- frame binding references and supported opcode operand widths;
- module-boundary passing modes and loan carrier types;
- export boundary signatures against their referenced function signatures.

Unknown non-critical sections are retained in the decoded image and may be skipped
by consumers.

## Canonical encoding

The 12-byte file header contains `UBCM`, major/minor version `0.0`, and the section
count. Every section then has a 12-byte little-endian header containing a 16-bit
kind, 16-bit flags and 64-bit payload length.

The reference encoder writes the normalized AST as a minified UTF-8 JSON object
with object properties sorted ordinally. Arrays retain their semantic order.
Encoding the same normalized module therefore produces the same PMF bytes.

Current standard section kinds are:

| Kind | Payload |
| ---: | --- |
| `0x0001` | normalized Semantic AST (required, critical) |
| `0x0002` | import/export Contract manifest (optional, critical) |
| `0x0003` | execution Capability manifest (optional, critical) |
| `0x0010` | indexed String table (profile-critical) |
| `0x0011` | indexed Type table (profile-critical) |
| `0x0012` | indexed Function table (profile-critical) |
| `0x0013` | indexed Import table (profile-critical) |
| `0x0014` | indexed Export table (profile-critical) |
| `0x0015` | indexed Constant table (profile-critical) |
| `0x0016` | indexed Code stream (profile-critical) |

The seven indexed sections are present as a complete group or absent as a complete
group. The authoritative framing rules are in `schema/docs/portable-module-format.md`;
the executable wire contract is in `schema/docs/indexed-executable-v0.md`.

## Indexed executable profile

The indexed profile removes source names from executable references:

- functions use `FunctionIndex`;
- frame arguments/locals use per-function `BindingIndex`;
- language types use `TypeIndex`;
- module imports use `ImportIndex`;
- exported public symbols are resolved through the Export table.

`CALL` keeps core opcode `0x60` and carries an explicit target kind:

```text
60 00 <u32 FunctionIndex>   local call
60 01 <u32 ImportIndex>     supervised module-boundary call
```

`FNADDR` remains local-only. An import is not a portable process address.

Every import declaration remains a distinct authority slot. Two imports may have
byte-identical module/symbol/signature rows but still occupy different
`ImportIndex` values so a loader can grant one and deny the other. Their source
aliases are used only during lowering and are not part of the portable bytes.

For supervised import calls, value arguments consume one caller cell and loan
arguments consume `(local_address, logical_length)`, followed by `budget_ms` and
`result_address`. The imported `CALL` pushes supervisor status; the receiver return
value is written to `result_address`. The exact legacy four-`UInt64`/`Int64` bridge
retains its existing five-control-cell calling form.

## Scope of v0

The indexed profile is architecture-neutral executable Ubytec, not native code. It
contains no x86-64/ARM64 instructions, target relocations, process addresses or host
ABI bindings.

The reference lowerer currently covers the scalar executable subset whose operand
wire contracts are explicitly defined. An opcode or source metadata shape without a
v0 binary contract is rejected rather than silently discarded. Extended opcode
identities remain reserved by the recursive `0xFF` scheme but their profile-specific
operand contracts must be defined before this lowerer accepts them.

Unsafe raw memory operations remain unsafe. Structural verification establishes
framing, reference and operand integrity; it does not claim memory safety.
