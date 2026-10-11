# Implemented data opcodes

All data opcodes already declared by the compiler map now emit NASM x86-64
and are available through OpcodeFactory and ASTCompiler.Parse. Extension group
0x10 is registered before its first lookup.

## Evaluation stack contract

Each cell occupies eight bytes on the CPU stack. In the notation below the
rightmost value is the top; index zero refers to that value. Instructions require
enough existing cells; this backend does not insert runtime bounds checks.
Integers wrap modulo 2^64. Binary operands are consumed as left, right.
DIV/MOD and LT/LE/GT/GE interpret cells as signed int64. Explicit UDIV/UMOD
and ULT/ULE/UGT/UGE interpret the same bits as unsigned uint64; binding types
do not implicitly change those instructions. Floating-point and 128-bit
operations remain outside this untyped interface. Untyped raw memory access defaults to qwords; an explicit access type selects 1/2/4/8 bytes. Named LOAD/STORE bindings use their declared integer width.
PUSH rejects floating-point and oversized literals instead of silently converting them.

| Opcode | Instruction | Stack effect |
| --- | --- | --- |
| 11 | PUSH literal | -- literal |
| 12 | POP | a -- |
| 13 | DUP | a -- a a |
| 14 | SWAP | a b -- b a |
| 15 | ROT | a b c -- b c a |
| 16 | OVER | a b -- a b a |
| 17 | NIP | a b -- b |
| 18 | DROP index | Remove the cell at index |
| 19 | TwoDUP | a b -- a b a b |
| 1A | TwoSWAP | a b c d -- c d a b |
| 1B | TwoROT | a b c d e f -- c d e f a b |
| 1C | TwoOVER | a b c d -- a b c d a b |
| 1D | PICK index | Copy the cell at index to the top |
| 1E | ROLL index | Move the cell at index to the top |
| 20-24 | ADD SUB MUL DIV MOD | a b -- result |
| 25-28 | INC DEC NEG ABS | a -- result |
| 29-2A | UDIV UMOD | unsigned a b -- result |
| 30-32 | AND OR XOR | a b -- result |
| 33 | NOT | a -- bitwise complement |
| 34-35 | SHL SHR | value count -- shifted value |
| 36 | LSHR | value count -- zero-filled right shift |
| 40-45 | EQ NEQ LT LE GT GE | a b -- 0 or 1 |
| 46-49 | ULT ULE UGT UGE | unsigned a b -- 0 or 1 |
| 50 | LOAD | address -- qword at address |
| 51 | STORE | address value -- |

PUSH accepts one signed or unsigned integer fitting a cell, or a little-endian
payload of one to eight bytes. Short raw payloads are zero-extended; negative
integer literals are encoded in two's complement. A register load preserves
large constants that x86 push imm32 would sign-extend.

DIV truncates toward zero; MOD has the dividend's sign. Zero divisors and
int64.MinValue / -1 raise the CPU divide exception (including the same operand
pair for MOD). ABS(int64.MinValue) wraps to int64.MinValue.
SHR preserves the sign. Shift counts use their low six bits.
LOAD and STORE operate on caller-provided valid addresses. Without an access type they use eight bytes; typed access uses the declared storage width.

## Extended stack instructions

The wire prefix is FF 10 followed by the instruction code and an unsigned
little-endian index (loByte, hiByte). Factory callers may also pass one integer
index from 0 through 65535. Standard indices range from 0 through 255.

| Extended code | Instruction | Meaning |
| --- | --- | --- |
| 11 | PUSH16 offset | Read an unsigned 16-bit word at RSP + byte offset and push it in a cell |
| 18 | DROP16 index | DROP with a 16-bit cell index |
| 1D | PICK16 index | PICK with a 16-bit cell index |
| 1E | ROLL16 index | ROLL with a 16-bit cell index |

PUSH16 retains its existing documented byte-offset/word-load semantics.
DROP16, PICK16, and ROLL16 use cell indices. Names are case insensitive,
including TwoDUP/TwoSWAP/TwoROT/TwoOVER. Data instructions can appear within
the compiler's existing BLOCK/END syntax.

## Validation

Install .NET 9 and NASM, then run:

    dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release

Set UBYTEC_NASM to the absolute executable path if NASM is not on PATH.
Native execution tests require Windows or Linux x64. They assemble the actual
compiler output and check results, full stack depth, operand order, preserved
lower cells, boundary indices, wrapping, signed comparisons, and a memory
round trip. Parser/factory tests cover every data instruction, extended wire
decoding, and rejection of malformed operands.

## Function integration

CALL (0x60), named LOAD/STORE, VAR initialization, frame-safe CLEAR and RETURN
are documented in the [function reference](functions.md). Factory JSON loading
now recognizes every implemented instruction family.

## Typed raw memory access

LOAD/STORE now accept an optional scalar type token, e.g. load t_byte or
store t_int16, selecting a 1/2/4/8-byte memory access. Signed loads extend the
sign; unsigned loads zero-extend; boolean loads/stores normalize to 0/1.
The stack remains composed of 64-bit cells. STORE consumes address then value
(top of stack is the value). Without a type, raw access retains qword behavior.
Named access uses the binding's type. The opcode bytes remain 0x50/0x51.

The AccessType instruction field is a nullable primitive type identifier.
External schema/editor alignment and a portable binary encoding are still pending.
See the [libft corpus](../../corpus/libft/README.md) for executed
memory-width tests, guarded terminators and comparisons with the C runtime.

## Explicit unsigned instructions

The seven additions occupy previously unassigned bytes in this compiler's map:
UDIV 0x29, UMOD 0x2A, LSHR 0x36, ULT 0x46, ULE 0x47, UGT 0x48 and UGE 0x49.
They take two cells and leave one, have no inline operands, preserve lower cells,
and participate in function stack validation and JSON instruction round trips.
UDIV/UMOD use the complete unsigned 64-bit dividend/divisor. Zero divisors raise
the CPU divide exception; a nonzero divisor cannot overflow this quotient.
LSHR fills with zero and uses the low six bits of the count, including for counts
64, 65 and UINT64_MAX. SHR keeps its arithmetic, sign-preserving behavior.
Unsigned comparisons produce canonical 0/1. ADD/SUB/MUL retain wrapping bitwise
integer behavior, and the existing signed opcodes retain their numbers and meaning.

To compare a length without a signed interpretation, use explicit stack instructions:

```text
load @index
load @count
uge
if
    break
end
```

Named condition sugar still uses the existing comparisons; this milestone does not
add automatic type-directed arithmetic, conversion opcodes or a new portable wire
format. The bundled grammar and compiler agree; synchronization with separately
maintained external editor/schema packages remains future work.
The [string corpus](../../corpus/libft/STRINGS.md) exercises high-bit limits and
native C equivalence, including zero-divisor traps in child processes.

## Local indirect calls

FNADDR 0x61 (`fnaddr Name`) pushes the resolved local callable's x64 address.
CALLI 0x62 (`calli N t_type`) consumes N argument cells followed by the target
address and pushes one canonicalized scalar result unless the type is t_void.
N is in 0..255; scalar integer/character/bool results are supported. No result
modifiers, float or 128-bit types are accepted. The caller cleans the argument
cells. The address must use the internal Ubytec ABI, not a C host ABI.

The compiler checks names, operands and evaluation stack depth, not the dynamic
address or signature. FNADDR uses relative LEA; CALLI uses an ordinary native
call and is not optimized into a tail jump. Imports still use their local monitor
bridge and require the existing opt-in/permissions. No portable function-pointer
wire encoding or external editor/schema integration is claimed.

See [lists and callbacks](../../corpus/libft/LISTS.md) for the complete lifetime,
ownership, failure contract and independent native validation.

## Observable contract and optimization

See the [observable contract and optimization audit](observable-contract.md) for physical stack observations, raw-pointer aliases, native ABI boundaries and the conditions of the experimental optimization passes.
