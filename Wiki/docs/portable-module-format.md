# Portable Module Format v0

The interpreter can emit and verify the architecture-neutral Portable Module Format
(PMF) defined by the `Universal-Byte-Code/schema` repository.

PMF v0 is a deterministic binary container around the normalized semantic AST and
portable contract/capability metadata. It is deliberately upstream of the x86-64
backend: the container contains no NASM, ELF addresses, host ABI values or other
target-specific code.

## Emit a portable module

```text
dotnet run --project Ubytec/Ubytec.csproj -- examples/answer.ubc \
  -o answer.nasm \
  --portable-module answer.ubcm
```

The normal source compilation and semantic validation still run. The compiler then
encodes the normalized module into `answer.ubcm` while independently producing the
current Linux x86-64 NASM output.

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
- sorted unique capability names.

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

The authoritative framing rules are in `schema/docs/portable-module-format.md`.

## Scope of v0

PMF v0 establishes portable framing and verification but does not pretend that the
existing symbolic AST is already the final executable bytecode. Function names,
local names and other symbolic operands are still represented in the Semantic AST.

The next lowering milestone is an indexed executable section with canonical type,
function, local, import/export and constant tables. That representation can be
added without changing the outer PMF framing or introducing target addresses into
the portable module.
