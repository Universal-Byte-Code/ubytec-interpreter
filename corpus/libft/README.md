# libft corpus

This is the first executable library corpus for Ubytec, inspired by 42's libft.
The implementations in [scalar.ubc](scalar.ubc) are Ubytec instructions and
functions, compiled through the normal lexer, parser, AST and x64 backend.

Implemented public functions:
ft_isalpha, ft_isdigit, ft_isalnum, ft_isascii, ft_isprint, ft_toupper,
ft_tolower and ft_atoi. ft_isspace is an internal helper used by ft_atoi.

## Contract

- Character classification and conversion follow ASCII in the C locale.
- Classifiers return canonical 0/1. C returns arbitrary nonzero truth values,
  so comparisons normalize C results before checking equality.
- The ctype comparison domain is EOF (-1) and every unsigned-char value 0..255.
- ft_atoi skips C whitespace, accepts one optional sign, accumulates decimal
  digits and stops at the first other byte or NUL. It returns a signed int32.
- Only representable int32 conversions are compared with C: C does not provide
  a portable result contract for atoi overflow. This milestone does not define
  Ubytec overflow behavior for arbitrarily long, out-of-range input strings.
- The string address is carried as t_uint64 in the current native x64 backend.
  It is a borrowed, valid NUL-terminated byte buffer; no allocation is performed.
  This is not a portable pointer ABI. Experimental Linux System V adapters now
permit C clients to call these integer/pointer functions; see the root README.

## Independent reference and execution

Run the entire corpus with NASM installed:

    dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release -p:EnableDocFxOnBuild=false

Set UBYTEC_NASM if the assembler is not on PATH. The same suite is configured
for Windows and Linux x64. Local verification does not imply a remote CI run.

The automated oracle calls compiled C runtime functions independently of Ubytec:
Windows UCRT with an explicit C locale; Linux libc with a C locale and strtol_l
for representable decimal-int conversions. This requires no local C compiler.

[reference.c](reference.c) is an equivalent portable command-line oracle for
manual use with a C compiler. It normalizes character predicates and uses
atoi directly. The isascii predicate is expressed in C because it is not ISO C.

## Coverage

- Seven character functions, 257 inputs each: 1,799 C/Ubytec comparisons.
- 34 curated atoi inputs plus 128 deterministic generated int32 cases.
- Empty strings, every C whitespace character, signs, leading zeros, suffixes,
  embedded NUL, bytes above ASCII, and both int32 boundaries.
- Input buffers are checked for mutation after atoi.
- Four strings terminate immediately before an inaccessible page, establishing
  that the reader does not access memory beyond the required terminating NUL.
- Raw memory load/store tests cover unaligned signed/unsigned 8/16/32/64-bit
  accesses, character types and canonical booleans. Stores preserve neighboring
  bytes; typed memory instructions also survive JSON instruction round trips.

## Compiler work driven by the corpus

The bundled grammar now accepts underscores throughout identifiers.
Module-level function declarations are parsed explicitly, avoiding silent
omission when a function name is not correctly classified. Decimal signs
separated by TextMate are joined before operand parsing.

LOAD 0x50 and STORE 0x51 retain their existing numbers. An optional scalar type
selects the storage width:

    load @text
    load t_byte

    load @destination
    push 65
    store t_byte

Without a type, raw access remains qword-sized. Named LOAD/STORE use the binding's
declared type. The AccessType AST field contains the primitive type identifier;
a complete portable binary wire format and the external schema/editor alignment
remain pending. Arrays, nullable/modified access types, floats and 128-bit accesses
are rejected by this backend rather than emitted with an incorrect width.

Bounded string operations and arena-backed duplication/substrings/joining are now
implemented; see [STRINGS.md](STRINGS.md). The dynamic vector is now implemented; see [VECTOR.md](VECTOR.md). Lists with indirect callbacks are also implemented; see [LISTS.md](LISTS.md).

## Byte memory corpus

[memory.ubc](memory.ubc) implements ft_strlen, ft_memcmp, ft_memset, ft_memcpy
and ft_memmove using ordinary Ubytec functions, control flow, byte LOAD/STORE
and CALL. No new opcodes are needed for these abstractions.

- strlen reads through the first NUL and returns a t_uint64 byte count.
- memcmp compares unsigned bytes up to count, stopping at the first difference.
  Its signed int32 result is compared with C by sign, since C does not promise
  a particular magnitude.
- memset stores the low eight bits of its int32 value.
- memcpy requires nonoverlapping ranges. memmove supports overlap in either
  direction and identical addresses; forward moves reuse ft_memcpy.
- All three writers return the original destination address.
- Addresses and counts use the current x64 t_uint64 representation. Callers
  own memory validity and lifetime. There are no bounds, null or ownership
  checks. Zero-count operations perform no memory access; this Ubytec behavior
  is tested separately rather than relying on null pointers in a C oracle.

The native tests compare buffers and return addresses with UCRT/libc, exercise
unaligned offsets, truncated fill values, every mismatch position for selected
lengths, and overlapping moves. Guard pages check the end of strings and exact
read/write limits. A composition test calls ft_memset and immediately returns
to raw address arithmetic and STORE in the same function.

The compiler's existing evaluation-stack analysis is a structural restriction,
not a memory-safety mechanism: it rejects underflow and unequal branch/loop
depths, but does not validate addresses. Dynamic growth of the evaluation stack
across loop iterations is currently rejected. Supporting that requires defining
how dynamic stack effects compose with CALL and structured control transfers;
the byte memory corpus does not require relaxing these rules.

The [isolated string/copy application](../../prototypes/isolation/LIBFT.md) reuses the memory corpus through source-declared module contracts and compares complete output packets with chain-reference.c.

[The bounded text application](../../prototypes/isolation/TEXT.md) composes these scalar and memory routines with a caller-owned descriptor table. text.ubc and text-reference.c cover explicit-length tokenization, uppercase copying and joining, without requiring allocation or new opcodes.

[The bounded arena](../../prototypes/isolation/ARENA.md) adds source-level dynamic buffers and incremental uppercase text without new opcodes.

[Generated arena imports](../../prototypes/isolation/GENERIC-ARENA.md) apply allocator lifetime management to the complete isolated text application.

## Bounded strings and allocation composition

[strings.ubc](strings.ubc) adds ft_strchr, ft_strrchr, ft_memchr, ft_strnlen,
ft_strncmp, ft_strlcpy, ft_strlcat and ft_strnstr. [arena-strings.ubc](arena-strings.ubc)
adds explicitly arena-parameterized ft_strdup_arena, ft_substr_arena and
ft_strjoin_arena. These three compose the current canonical arena with the string
module; they do not allocate through the OS. [STRINGS.md](STRINGS.md) defines their
contracts, composition command and evidence. Seven explicit unsigned opcodes are
registered in the bundled grammar, factory, parser and function stack validator.

## Generic dynamic vector

[vector.ubc](vector.ubc) adds a packed-record vector on the canonical arena, with
reserve/growth, self-insertion, get/set, erase/clear, pin/unpin and release.
[vector-apps.ubc](vector-apps.ubc) uses it for explicit pending state and binary ASCII
text accumulation. [VECTOR.md](VECTOR.md) records contracts, C-oracle results,
protected borrowing checks and reproduction commands. No new opcode is required.

## Complete streaming application

The [text analyzer](TEXT.md) reads an authorized file in chunks, counts ASCII words,
sorts records through a callback and publishes a frequency table only on success.
It combines scalar/memory functions, arena storage, vectors and protected host I/O,
with an independent C oracle and executed failure/permission tests.

## Text performance baseline

The [text benchmark](TEXT-BENCHMARK.md) separates native counting/sorting/emission,
protected file execution and a protected transport fixture. It compares C
implementations, records arena/RSS metrics and raw median/p95 timing samples,
and verifies outputs and cleanup without imposing CI speed thresholds.
