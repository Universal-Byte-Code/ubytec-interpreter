# Functions, variables and remaining work

The executable subset now supports complete module source files with integer
functions, fixed local frames, direct calls and integer/void returns. The
[answer example](../../examples/answer.ubc) initializes a counter, increments it,
passes it to Twice, and returns 42.

## Commands

    dotnet run --project Ubytec/Ubytec.csproj -- examples/answer.ubc -o answer.nasm
    nasm -f elf64 answer.nasm -o answer.o
    ld -o answer answer.o

The generated executable targets Linux x86-64. Main has no arguments; its integer
return becomes the process exit status (Linux exposes its low eight bits).
A void Main exits with zero. The compiler itself also runs on Windows.

The CLI defaults to the bundled TextMate grammar, copied from the organization's
[vscode-ubytec grammar](https://github.com/Universal-Byte-Code/vscode-ubytec/blob/master/syntaxes/ubytec.tmLanguage.json).
Pass --grammar to supply another local JSON grammar, --json to export the parsed
module, or --help for usage. Invalid source produces a nonzero compiler exit
status before a NASM file is written.

## Instruction forms

    push 20
    load @counter
    push 1
    add
    store @counter
    load @counter
    call Twice
    return

CALL is assigned primary opcode 0x60 in this interpreter. It resolves its target
by name in the enclosing function/local context/module. Arguments are pushed in
declaration order; the caller removes them after the call. A non-void result is
pushed back onto the evaluation stack.

LOAD/STORE retain their 0x50/0x51 raw-address forms. With a symbol name they address
the current function's argument or local binding instead. The @ prefix is
optional. This symbolic form is carried by the instruction's JSON VariableName;
CALL carries FunctionName. These forms do not define a new binary symbol-table
wire format.

RETURN retains opcode 0x09. Without a type operand it uses the function's declared
result type; an explicit return t_int64 must match it. Non-void functions require
a RETURN on all paths supported by the structural return checker. Void functions
may fall through.

## Frame and value model

Every argument and local slot occupies eight bytes. The last argument is at
RBP + 16; earlier arguments occupy subsequent cells. Locals have stable negative
RBP offsets, separate from evaluation values. CLEAR restores the evaluation stack
to the end of the local frame, preserving locals.

Named loads extend the declared integer width with its signedness. Integer return
values are narrowed and extended to their declared width; boolean returns become
0 or 1. Arithmetic still uses untyped 64-bit integer cells.

The callee preserves RBP and restores RSP in one shared epilogue. RETURN inside
a nested IF jumps there, rather than returning with live locals or temporaries.
The caller cleans argument cells. This is Ubytec's internal stack ABI. Experimental
Linux System V host adapters and protected typed module imports are available;
unrestricted external C calls and a Windows native backend remain pending.

Local-context variables initialize on function entry. Inline t_int64 variable
declarations initialize when reached. Their slots are preallocated for the whole
function; shadowing/duplicate frame names are rejected. Constants and readonly
locals reject STORE.

## Validation coverage and limits

Tests cover source tokenization and parsing, argument order, nested calls,
mutable locals and arguments, signed/unsigned narrow loads and returns, void
returns, both IF branches, early returns, frame restoration, JSON instruction
round trips, and the complete answer program.

The compiler checks evaluation stack depth across straight-line code, BLOCK,
IF/ELSE, LOOP/WHILE and SWITCH/BRANCH paths, including CALL arguments,
RETURN results, back edges and BREAK/CONTINUE targets. See
[Structured control flow](control-flow.md) for precise behavior and limitations.
Raw memory addresses still require caller-managed validity.

## More opcodes to design and implement

The original map's data instructions are implemented. More instructions are
needed to expand the language, but grammar keywords alone are not a binary
opcode specification.

- Conversions and typed arithmetic: explicit casts, floating-point operations and
  128-bit values. Unsigned division/remainder, logical right shifts and unsigned
  ordered comparisons are implemented explicitly; see [opcodes](opcodes.md).
- Memory and host services: OS-backed allocation and further indexed-address abstractions.
  Bounded ArenaAlloc/ArenaResize/ArenaFree and memcpy/memmove/memset are implemented
  as Ubytec library functions. The arena uses caller-owned backing, not OS allocation.
  Raw typed loads/stores are available; memory validity remains caller-managed.
- Calls: unrestricted external calls remain pending. Local FNADDR/CALLI callbacks
  are implemented; see [lists and callback contracts](../../corpus/libft/LISTS.md). Protected typed imports
  and supervisor-controlled host services already exist as Linux prototypes.
- Runtime services: exceptions and direct system calls remain pending. Experimental
  HostRead/HostWrite use explicit supervisor resource grants on Linux; see the
  [complete text application](../../corpus/libft/TEXT.md).

Threading, SIMD/vector instruction families, audio and other specialized keywords in the grammar are
future families. Their operands, semantics and byte assignments must be defined
and aligned with the separate AST schema and editor before treating them as
supported instructions.

Compatible terminal CALL/RETURN pairs can opt in to frame reuse with --tail-calls. See [recursion](recursion.md) for the unsafe frame-lifetime contract, limitations and explicit pending-state stack example.

## Experimental isolated module calls

The Linux library compiler option --module-calls exposes the six-cell ModuleInvoke host import through CALL. Its supervisor selects callable permissions and validates requests; the source import alone grants nothing. See [source contract and executed checks](../../prototypes/isolation/PROGRAM.md).

Source declarations now resolve public exports across multiple isolated modules, with individual host grants. See [contracts and examples](../../prototypes/isolation/CONTRACTS.md).

Source-declared typed imports can pass Int64/UInt64 values and two independent region loans through CALL. A loan consumes an address/length pair in the caller and becomes a protected pointer in the receiver. See [typed contracts, permissions and measurements](../../prototypes/isolation/LOANS.md).

## Experimental frame registers

`--frame-registers` keeps write-through copies of eligible 64-bit frame values across loops in leaf functions. Calls, raw writes and unknown effects retain the original backend. Stack layout and memory writes are preserved. See [conditions, validation and measurements](../../corpus/libft/FRAME-REGISTERS.md).
