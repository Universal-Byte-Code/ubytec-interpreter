# Source imports, exports and individual grants

Linux module calls now support several imported functions from several separately
compiled modules. The loader resolves public names, compares declared primitive
signatures, and prepares a protected grant table before starting any worker.

Declarations precede the module header:

```text
import ReadTool from tools.Read (t_uint64,t_uint64,t_uint64,t_uint64) -> t_int64
import WriteMemory from memory.Write (t_uint64,t_uint64,t_uint64,t_uint64) -> t_int64
export Main as Main
module (name:"client", version:"0.1", author:"Ubytec") {
    ...
}
```

A provider declares its exports explicitly, for example export Read as Read.
The compiler infers each exported function's signature from its definition,
emits its System V adapter, and embeds a bounded, read-only .ubytec_contract
section in the ELF. SourceCompilation.ContractManifest exposes the same metadata.

Imports require --library --module-calls; provider exports require --library.
Duplicate imports/exports, unsupported signatures, unknown export functions,
shadowing module callables and names that exceed the format's limits fail
compilation. Metadata line endings are fixed to LF on both Windows and Linux.

## Calling an import

The legacy remote signature is four uint64 argument cells returning int64:
receiver buffer, length, foreign-address fixture and monitor-address fixture.
[Typed contracts](LOANS.md) additionally support up to six Int64/UInt64 arguments,
including up to two independently protected loans.

An imported alias consumes five control arguments: local buffer, logical byte
length, requested rights, requested budget_ms and result-cell address. The
compiler supplies its handle automatically. CALL returns the same status as
ModuleInvoke; the receiver's int64 result is stored at the supplied address.

```text
load @buffer
push 16
push 1
push 1000
load @buffer
push 128
add
call ReadTool
```

Thus the declaration describes the receiver signature, while the alias exposes
the supervised borrowing operation. It is an experimental import-call ABI.
See [caller](ubytec/contracts/caller.ubc), [reader](ubytec/contracts/reader.ubc)
and [writer](ubytec/contracts/writer.ubc) for complete programs.

## Host authority

```sh
python3 prototypes/isolation/run_contracts.py --output artifacts/contracts

artifacts/contracts/contracts-gcc --contracts artifacts/contracts/caller.elf Main \
  --module tools artifacts/contracts/reader.elf \
  --module memory artifacts/contracts/writer.elf \
  --grant ReadTool tools.Read 1 16 1000 \
  --grant WriteMemory memory.Write 3 16 1000
```

Each grant pins both the caller alias and its exact receiver module/public
function. Its remaining fields specify rights, maximum bytes and maximum
budget_ms (or none to permit an unlimited request). Each import gets a separate
handle. An import with no grant returns rejection status 1, even if that function
is exported and another function in the same module is permitted.

The loader rejects missing modules/exports, incompatible signatures, unknown or
duplicate grants, duplicate modules, invalid limits and attempts to redirect a
grant to a different receiver. All imports are resolved before execution,
including those without permission. Modules referenced by --module are selected
by the trusted host; logical names are not a filesystem discovery or search path.

Contract parsing uses the sealed artifact snapshot already owned by the loader.
It bounds sections, fields, counts and identifiers; verifies the section is
file-backed read-only data; and verifies each exported symbol is executable.
The supervisor derives sender identity from its worker context. Neither handles,
declarations nor reported signature strings grant authority on their own.

Signatures describe the ABI declared by an artifact. They do not prove that
deliberately malicious native instructions obey that declaration. Process
isolation, syscall restrictions, protected grants and dedicated loan copies
remain the actual boundary. See [borrowing and cancellation](PROGRAM.md).

## Validation and limits

22 contract checks pass with GCC and Clang, plus eight malformed-contract cases
under ASan/UBSan. The main test reads through one module, writes through a second,
then reads through the first again, obtaining 1456 and preserving neighboring
bytes. Another test calls an exported function without permission and receives
rejection without starting a receiver. Explicitly granting it allows the call.

Other tests cover independent rights/size/budget ceilings, no authority from
imports, a mismatched return type, resolution failures, duplicate/redirected
grants and malformed metadata. The compiler suite passes 508 tests, including
seven declaration/format checks.

See [contract report](evidence/contracts/contracts-report.json),
[GCC cases](evidence/contracts/contracts-tests-gcc.jsonl),
[Clang cases](evidence/contracts/contracts-tests-clang.jsonl) and
[compiler provenance](evidence/contracts/compilation.json).
The workflow compiles sources and runs this matrix; no remote CI run is claimed.

The prototype permits up to sixteen imports per caller, sixteen exports per
artifact and eight loaded modules including the caller. Grants are established
at startup and remain individual; there is no receiver delegation, dynamic
permission negotiation, domain-call recursion or concurrent loan. The previous
--program single-target CLI remains supported.

ARM still exercises native MPU fixtures. Broader signatures, MetaDB descriptions
and production authentication remain separate work. Complete application costs
are measured for the libft chain and the independent-loan bridge.

[The libft string/copy application](LIBFT.md) now compares isolated source-level calls against a C oracle and measures separate versus grouped receiver invocations.
