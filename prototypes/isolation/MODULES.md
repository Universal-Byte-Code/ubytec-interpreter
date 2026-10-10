# Independent Ubytec modules on Linux x64

This prototype loads separately linked Ubytec module files into a fresh isolated
worker. The supervisor is linked only with C bootstrap/registry code, not with
the Ubytec functions. The module's ELF entry point and constructors are never
automatically executed.

## Reproduce

Install .NET 9, GCC, Clang, NASM, binutils and Python 3 on Linux x64:

    python3 prototypes/isolation/run_modules.py --sanitizers --output /tmp/ubytec-modules

The runner compiles data.ubc and faults.ubc separately with --library --tail-calls and host
exports, assembles them, and links static ELF images with linux/module.ld.
A third independent native assembly module exercises operations without
source-language counterparts. Private-data fixtures validate direct access to
a module's own data and denial of another module's private address.

With Windows compilation, pass --assembly-directory containing data.nasm and
faults.nasm. This is reported explicitly as a precompiled cross-host handoff.
--compiler-dll selects an already built compiler. --sanitizers repeats the ELF
parser rejection and mutation checks under ASan/UBSan. --skip-benchmark produces a
containment-only report.

A single experimental host invocation is:

    /tmp/ubytec-modules/modules-gcc --call /tmp/ubytec-modules/data.elf ubytec_host_read 1 1 256

Arguments after the symbol are the trusted host's permission ceiling, requested
loan rights and logical length. Rights 1 means RO and 3 means RW. This command
creates a loan initialized to bytes of value 1; reading 256 bytes returns 256.
It is a demonstration host command, not an API for accepting untrusted module
requests or transferring application files. Contracts are chosen by the host.

## Registry and authority

The supervisor's experimental services are register_module, register_function,
call_module and close_registered_module. The existing create_region service
creates dedicated initialized loan regions. No new opcodes, syntax or MetaDB
dependency are introduced.

A registration associates a host module name with an immutable artifact snapshot.
A function registration binds a module, host-visible function name, ELF symbol,
permission ceiling and maximum loan length. Duplicate registrations, missing or
non-code symbols, unsupported rights and invalid sizes are rejected.

call_module checks the registered function, module lifetime, region owner, rights
and length before creating a worker. The rejection tests verify that no worker
was launched. The test host is owner 1; the receiver is the registered module,
and its completion is associated with the supervisor's live invocation. No
module-supplied owner or receiver identifier is used to grant authority.
Module imports and knowing addresses do not grant access.

The worker's IPC service accepts only a bounded completion record. It does not
dispatch registration, permission changes, nested calls or allocation requests.
Forged operation/region/invocation/rights/length fields are rejected against
protected supervisor state. Results and loan bytes remain untrusted data.

## Artifact and execution boundary

Registration opens a regular file with O_NOFOLLOW, reads a bounded snapshot,
validates it and copies it to a sealed memfd. The seals disallow writing, shrinking,
growing and further seal changes. Replacing or modifying the source file cannot
change the registered snapshot. These are integrity/lifetime protections;
approval of the artifact and contract comes from the trusted host, not a publisher
signature. See [Linux memfd sealing](https://man7.org/linux/man-pages/man2/memfd_create.2.html).

The loader accepts only a bounded static ELF64 little-endian x86-64 subset:
ET_EXEC, at most eight program headers, at most 1,024 section headers, at most
4 MiB of artifact bytes and a 16 MiB reserved virtual-address window starting
at 0x400000000000. Load segments must be page aligned, nonoverlapping and R,
RX or RW. Overflowing offsets, out-of-window mappings, executable stacks,
writable executable segments, interpreters, TLS, dynamic linking and remaining
relocations are rejected. Export symbols must be unique, global, defined and
inside file-backed executable code. Symbol/string tables are bounded before use.
Extended ELF numbering and stripped symbol tables are outside this loader.
See [ELF program headers](https://refspecs.linuxfoundation.org/elf/gabi4+/ch5.pheader.html).

The module linker script separates executable code, read-only data and private
writable data/BSS. The worker reserves the module window without access, populates
only the validated segments with fresh anonymous pages, zeroes BSS/padding and
applies the final permissions. It performs no dynamic relocations or constructors.
The experimental ABI is four uint64 arguments (loan address, logical length,
foreign-address fixture, monitor-address fixture) and one int64 result. This is
a caller-defined convention; ELF symbols do not prove a type signature.

Every call fork/execs the C worker with a minimal environment (LANG=C).
Supervisor mappings, heap, registry and unrelated modules disappear across EXEC.
Only the current sealed artifact, current loan and IPC channel are passed.
After setup, all artifact/loan descriptors and unrelated descriptors are closed.
The loan is RO or RW, its padding is initialized, and its neighbors, private stack
guards and monitor-address fixture are inaccessible. The stack and loan are NX.

Only after no_new_privs and seccomp are installed does the trampoline call the
registered address. The default one-second deadline includes worker loading/bootstrap;
faults and expiry are reaped before reuse. Fresh private memory is loaded on each
call, so changes from a previous call or another module are not inherited.

Direct writable loans are not transactional. The partial-write test demonstrates
that the scratch loan changes before a fault, while the owner destination remains
unchanged because only a successful validated completion commits logical bytes.
Termination withdraws access, not information already copied by the receiver.

## Executed checks

On this local WSL host, both GCC and Clang hosts pass:

- 21 execution cases, including actual Ubytec LOAD/STORE, CALL, recursion and loops,
  own private data, another module's data address, RO denial, code-write denial,
  NX loan execution, forbidden resource opening, forged completion and copy-back.
- 21 subsequent successful reads, one after every execution case.
- 9 registry/lifetime checks: rights ceiling, size, unknown module/function, owner,
  invalid/duplicate registration, seals, original-file replacement and closing.
- 28 deterministic malformed ELF/symbol-table rejection cases.
- 28 parser rejection cases repeated under ASan/UBSan.
- 64 bounded deterministic byte mutations under ASan/UBSan: acceptance of supported changes or a
  controlled rejection, without a loader crash. This is not an exhaustive fuzzing proof.

The native Linux/ARM suites and the earlier statically linked Ubytec suite also
pass. CI is configured to compile source directly on Linux; no remote CI execution
is claimed. Local source compilation used the Windows .NET compiler and handed
NASM to Linux, as recorded in the report.

See [module report](evidence/modules/modules-report.json),
[GCC checks](evidence/modules/modules-tests-gcc.jsonl),
[Clang checks](evidence/modules/modules-tests-clang.jsonl),
[malformed files](evidence/modules/modules-malformed.jsonl),
[measurements](evidence/modules/modules-benchmark.jsonl) and
[compilation provenance](evidence/modules/compilation.json).

## Scope of this milestone

This is a working restricted loader and host-owned registry. It is not a stable
portable ABI, a dynamic dependency loader, general high-level module import
integration or signature-based deployment authentication. There is no worker
reuse, nested cross-domain call, delegation, persistent loan or concurrent loan.
ARM continues to run native MPU fixtures, not compiled Ubytec modules.

Trusted components remain the supervisor/ELF parser, bootstrap, toolchain,
host contract selection, OS and hardware. Finite tests do not establish absence
of all bypasses. Side channels, kernel/hardware faults and real-time guarantees
remain outside the evaluation.

The suite includes 200,000-step self and mutual tail recursion on the guarded 64 KiB stack, plus infinite tail recursion that expires through the watchdog. The non-tail overflow fixture retains pending work and must still fault. See [recursion semantics](../../Wiki/docs/recursion.md).

Ordinary Linux calls now support an optional deadline and external cancellation, independently of service lifetime. See [execution policy](EXECUTION.md). ARM native MPU fixtures now support the same execution policy choice.

[Calls originating in Ubytec](PROGRAM.md) now exercise this mechanism from an isolated source-language caller through a bounded copying bridge in Linux.

Source-declared imports/exports and individual grants now support multiple receiver functions and modules. See [contracts](CONTRACTS.md).
