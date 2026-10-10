# Streaming text application and authorized resource I/O

[text-analyzer.ubc](text-analyzer.ubc) is a complete Linux x64 Ubytec application:
read a file in bounded chunks, count normalized words, sort the records through
a native callback, and write a frequency table. It composes the existing scalar,
byte-memory, arena and vector libraries. No new opcode is required.

The [trusted text host](../../prototypes/isolation/linux/text-host.c) preopens
resources, starts the existing protected worker and serves I/O over its private
IPC channel. File paths and file descriptors never become Ubytec arguments.

## Application contract

- Words are maximal runs of ASCII letters, digits and underscore. A-Z normalize
  to a-z. Every other byte, including NUL and bytes 128..255, is a delimiter.
  This is a byte/ASCII specification, not Unicode tokenization or locale collation.
- Output contains one `word<TAB>decimal_count<LF>` record per distinct word,
  ordered lexicographically by normalized bytes. EOF flushes a pending word.
- Input is processed incrementally; a token may cross any number of read chunks.
  The application retains one pending token and the dictionary, not the whole file.
- Dictionary records are `(text_pointer, byte_length, uint64_count)`, 24 bytes
  each. Names have independent arena allocations without implicit NUL terminators.
  The pending token uses a byte vector. Insertion sort calls TextRecordCompare
  through FNADDR/CALLI; its callback must not mutate the vector or its records.
- Distinct vocabulary and the longest word must fit the bounded arena. A file
  larger than the arena can succeed when its retained state fits. Arbitrarily long
  words or arbitrarily large vocabularies are not promised to succeed.

`TextFlush` validates the mutable token and its byte width before reading it.
For a nonempty token it validates the mutable dictionary and its 24-byte record
width once, then scans the validated data span directly. The scan performs no
allocation or callback and retains no pointer across dictionary growth. Each
flush validates again. Pinned vectors and malformed descriptors fail before
changing counts; an empty valid mutable token remains a successful no-op. These are
cooperative library checks inside the unsafe domain, not a security boundary.

The default worker packet is 65,536 bytes. Its first 256 bytes hold configuration,
vector descriptors, counters and scratch space; the arena header starts at 256.
The arena has at most 65,248 backing bytes, ending before the final 16-byte guard.
The broker's default read chunk is 4,096 bytes; --chunk accepts 1..4096 and
--arena accepts 0..65248. This application-specific maximum accounts for packet
metadata and guards; it does not change ArenaInit's 65,536-byte library limit.

All owned names, vectors and the I/O buffer are released on normal completion and
handled errors. Tests verify arena used=0 and guards. A worker fault is handled
by the supervisor terminating/reaping the domain; application cleanup code is
not claimed to run after such a fault.

## Compiler and service interface

`--host-io` enables the experimental HostRead/HostWrite call bindings and implies
`--library --module-calls`. SourceCompiler exposes the corresponding opt-in.
Names cannot be redefined while enabled. Availability in the compiler is not a
permission grant. The ordinary supervisor without I/O support rejects these requests.

Both calls consume five cells, in declaration order:

```text
resource_handle, byte_offset, local_buffer, logical_length, result_cell_address
call HostRead
```

HostWrite has the same arguments. CALL returns an int64 status and writes the
byte count into the valid writable result cell:

| Status | Meaning |
| --- | --- |
| 0 | Success; count is 0..requested_length. A positive-length read returning zero means EOF. |
| 1 | Resource/permission/range/transfer rejection, or local argument rejection. |
| 2 | Host pread/pwrite failed. |
| 5 | Worker transport or reply validation failed. |

Read transfers publish only after the whole returned prefix is received and the
reply is validated. Bytes beyond that prefix are unchanged. Writes may return a
short positive count; TextWrite advances its offset and retries the remainder.
There is no promise that generic external writes can be rolled back. The text
host solves output publication separately with a staging file.

The current synchronous bridge has no reentrant/concurrent-call contract. Raw
local buffers/result cells must be valid for their requested spans. These remain
unsafe pointer arguments inside the worker, not pointers dereferenced by the
supervisor. Zero-length requests still undergo resource permission/range checks.

## Effective authority and publication

The parent retains a resource table independent of source metadata:

| Handle | Authority granted by the text host |
| --- | --- |
| 0x101 | Read the explicitly selected regular input file, within its captured extent. |
| 0x102 | Write the host-created regular staging file, within the output extent quota. |

Resource rights use read=1/write=2; they are separate from memory-loan rights.
Every request checks the protected caller context (currently module 0 only), the
known handle, direction, maximum transfer, offset and extent without overflowing
range arithmetic. The caller supplies no identity or pathname. Resources close
when the invocation ends. There is no delegation or persistent file handle grant.
The existing worker closes inherited descriptors except its IPC channel and keeps
the existing no_new_privs/seccomp policy. It cannot open arbitrary files through
these services. Other module imports/loans keep their previous monitor checks.

Input must be a regular file opened read-only with final-component O_NOFOLLOW.
The output stage is a fresh sibling file. A live input/output inode alias is
rejected. After the worker has been reaped, the host publishes the stage via
rename only for a normal result of zero and the checked successful application
state. Controlled errors and worker faults remove the stage and preserve an
existing output. --output explicitly selects the file to replace on success.

The default output extent quota is 8 MiB; --quota accepts a byte extent. This
bounds file positions, not the cumulative number of writes or CPU time. The
honest analyzer writes sequentially. The parent grant is a containment policy,
not proof that a deliberately malicious module computes truthful frequencies.

The input extent is captured at open, not an immutable file-content snapshot.
Concurrent external edits are outside the oracle's stable-input assumptions.
Rename provides publication semantics; power-loss durability, parent SIGKILL
cleanup, side channels and kernel/hardware faults are not added guarantees.
There are no implicit execution deadlines. Cancellation remains under the
existing supervisor contract. This milestone does not implement Windows file
services, an ARM Ubytec backend or portable file/function-pointer bytecode.
MetaDB may later describe contracts; effective authority stays in the parent.

## Results, failures and validation

TextMain returns 0 on success, -1 for invalid application configuration, -2 for
bounded storage/count failure, -3 for a read-service error, -4 for sort failure
and -5 for a write-service error. It writes byte/word/unique/emitted counters into
the application packet. These counters are diagnostics, never authority inputs.

Executed checks:

- 601 .NET tests passed, including 14 new compiler/application-helper cases.
  These cover byte classification, chunk boundaries, binary delimiters, order,
  full-width decimal counts, pinned-sort rejection and cleanup after OOM.
- 38 success inputs matched the independent whole-file [C oracle](text-reference.c)
  byte for byte. GCC, Clang and sanitized C variants agree. The corpus includes
  an input of 1,150,000 bytes, words of 20,000 bytes, empty and all-byte inputs,
  reverse-ordered vocabulary and deterministic randomized inputs.
- Each GCC/Clang protected host passed 52 complete cases: the 38 successes,
  nine controlled OOM/permission/quota failures, an adversarial permission probe,
  a fault after a write, legacy-supervisor rejection and two file-setup rejections.
  Existing outputs and input hashes remain unchanged on the applicable failures.
- The [service tests](../../prototypes/isolation/linux/host-io-test.c) passed
  84 checks per variant, covering identity, permissions, ranges, EOF, zero-length
  requests, malformed headers and I/O errors.
- The [transport tests](../../prototypes/isolation/linux/host-io-transfer-test.c)
  passed 12 fragmented/EINTR/malformed/partial-reply cases and two local rejections
  per variant. Failed read publication preserves the destination buffer.
- Existing typed loans passed 17 cases in each GCC, Clang, reference and fallback
  variant, plus 10 malformed-request and five fragmented-transfer checks.

Sanitizers instrument the C oracle, service and transport tests, not generated
NASM. Complete protected applications run with the GCC/Clang supervisors. No
performance comparison, remote CI result or production deployment is claimed.

## Run and inspect

With Linux x64, .NET 9, NASM, GCC and Clang installed:

```sh
python3 corpus/libft/run_text.py --output artifacts/text
artifacts/text/text-host-gcc --caller artifacts/text/text-composed.elf \
  --input entrada.txt --output frecuencias.tsv
```

The first command compiles and validates the application and regressions; the
second runs your file. --prepare-only emits inspectable source; --compile-only
emits source, NASM and provenance without claiming execution. --assembly-directory
accepts staged output only when source/compiler provenance and hashes match.

See the saved [summary](evidence/text/summary.json), [example output](evidence/text/example-output.tsv)
and [runner](run_text.py). Evidence includes final composed sources/NASM, compiler
hashes, oracle/application reports, typed regressions and the full .NET TRX.
