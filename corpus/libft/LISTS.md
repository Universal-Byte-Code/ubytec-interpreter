# Indirect calls and arena-backed lists

This milestone adds local native callbacks and the linked-list part of the libft
corpus. The lists are ordinary Ubytec functions in [lists.ubc](lists.ubc); the
compiler additions are FNADDR and CALLI. No automatic ownership, closures,
exception unwinding or new module permissions are introduced.

## Callback contract

| Instruction | Assigned byte | Stack effect |
| --- | --- | --- |
| `fnaddr Name` | `0x61` | Push one address of a callable visible in the current compilation scope. |
| `calli N t_type` | `0x62` | Consume N argument cells followed by the target address; push one canonicalized integer result unless the type is `t_void`. |

N is an explicit integer literal in 0..255. Supported results are the existing
1/2/4/8-byte integer and character types, bool and void, without type modifiers.
Arguments are pushed in declaration order, exactly as for CALL. The last cell
is the address. All arguments still occupy eight-byte cells. The caller removes
the argument cells after the call, and the target restores its frame and returns
its result in RAX. For example:

```text
load @content
fnaddr Visit
calli 1 t_void
```

A callback can also be stored in a t_uint64 local, in raw memory or passed as an
argument. FNADDR emits a relative LEA so code relocation does not bake in a
fixed process address. The resulting value is an x64 code address with the
internal Ubytec stack ABI: it is not a C/System V function pointer, serialized
handle, captured environment or portable binary value. Its lifetime ends when
that code mapping is removed. Pass state explicitly in arguments or content.

The compiler resolves FNADDR names, checks CALLI operands and its evaluation
stack effect, and rejects unsupported result types. It does not dynamically
verify the target, its argument count or its signature. The caller must provide
a callable address with the correct internal ABI. CALLI interprets/canonicalizes
the returned cell according to its explicit result type. A forged pointer,
wrong ABI or wrong argument count remains unsafe. Null and non-executable
addresses fault; they are not converted into an error result.

CALLI uses ordinary physical call frames, including with --tail-calls enabled.
The existing optimization of compatible direct CALL/RETURN pairs is unchanged.
This milestone does not promise infinite recursion or install execution deadlines.
JSON opcode round trips are supported. External editor/schema synchronization
and a portable bytecode operand encoding remain pending.

## List representation and API

A node is a separate arena allocation of logical length 16 bytes:

| Offset | Value |
| --- | --- |
| 0 | Raw content pointer, possibly zero. |
| 8 | Next node pointer, zero at the end. |

A head reference is a caller-owned, writable eight-byte cell containing the first
node address. It must not overlap owned nodes, their contents or the arena's
metadata. Lists are exclusively owned, acyclic chains; nodes belong to the stated
arena and may not be shared between lists. Content representation and ownership
are defined by the caller. Nodes do not contain a hidden allocation for content.

| Function | Result/behavior |
| --- | --- |
| `ft_lstnew_arena(arena, content)` | Allocate a detached node; zero on allocation failure. Content ownership transfers only if the caller accepts the new node. |
| `ft_lstsize(head)` | Count nodes; empty gives zero. |
| `ft_lstlast(head)` | Last node; empty gives zero. |
| `ft_lstadd_front_arena(arena, headref, node)` | Attach a detached node at the front; status 1/0. |
| `ft_lstadd_back_arena(arena, headref, node)` | Attach at the back; status 1/0. |
| `ft_lstdelone_arena(arena, node, destroy)` | Invoke destroy(content) and release the node; status 1/0. Does not unlink the node. |
| `ft_lstclear_arena(arena, headref, destroy)` | Preflight every node, set head to zero, destroy contents and release nodes; status 1/0. |
| `ft_lstiter(head, visit)` | Invoke visit(content) in list order; status 1/0. |
| `ft_lstmap_arena(arena, head, transform, destroy)` | Build independently owned transformed contents and nodes; zero for empty input or failure. |

The arena-qualified names acknowledge the allocator argument and status returns;
they are libft-inspired operations, not declarations of binary compatibility
with the 42 C API. size, last and iter require valid acyclic input and do not
perform allocation ownership validation. iter permits mutation of content through
the supplied callback; it does not permit topology changes.

ListNodeCheck/ListCheck are library helpers: ArenaFind must locate each exact
live node with logical length 16. Mutable operations reject nonzero node pins.
ListCheck bounds traversal to 1,365 nodes (the maximum possible with the existing
65,536-byte arena and 48-byte minimum node block), rejecting cycles/invalid links
before cleanup callbacks run. Additions reject a node already in the destination
chain and nodes whose next link is nonzero. All raw addresses and arena metadata
must already be valid. These checks are cooperative library rules, not hardware
capabilities or validation of arbitrary machine addresses.

Clear preflights the whole chain, so a pinned later node rejects the operation
without invoking any destroy callback or partially freeing earlier nodes. Read-only
mapping may traverse pinned source nodes. Content pins, readability, writability
and loan permissions are the caller's responsibility: the library cannot infer
the ownership or storage layout of arbitrary content. It protects node topology,
not every byte reachable through a content pointer.

## Callback ownership and failure

visit and destroy use `(content) -> t_void`; transform uses
`(content) -> t_uint64`. For nonempty inputs, required callbacks must be nonzero.
Empty iter/clear succeed without a callback; map of an empty list returns zero.

Callbacks must return normally and preserve source nodes, links and list ownership.
They may allocate/free their own content, but may not free, pin, unpin or change
the nodes being traversed, or mutate the head reference. Destroy must fulfill the
content ownership contract. The library cannot roll back arbitrary callback side
effects or recover from a fault/nonreturning callback.

A successful transform returns a new, independently owned, nonzero content pointer
that destroy can dispose of. Returning zero indicates transformation/allocation
failure. Returning an alias of source content is outside this ownership contract.
If node allocation fails after a successful transform, map first destroys that
fresh content, then destroys all earlier mapped contents and nodes. If a transform
returns zero, map destroys only the earlier partial result. The input list and its
content remain unchanged by a conforming transform. Callback counters and other
explicit external side effects are not rolled back.

The arena supplies bounded storage, reuses freed blocks and coalesces neighbors.
Failure cleanup releases all allocations owned by the partial result; it does not
promise that allocator metadata/free-space bytes reproduce a previous snapshot.
The content destroy callback determines which non-node resources are released.

## Module boundary

A raw function address applies to code mapped in the current domain. It is not an
authority grant for another module. FNADDR of an enabled import obtains the local
import/bridge entry, whose invocation still uses the existing supervisor protocol.
Imports remain unavailable without --module-calls. Protected cross-domain calls
continue to require monitor permissions. This milestone does not add persistent
callbacks across domains, delegation, nested module calls or a new isolation
mechanism. Existing Linux and ARM prototype boundaries are unchanged; no ARM
Ubytec backend is implied.

## Executed validation and evidence

- 587 .NET tests passed, including 25 indirect-call and 9 list cases. Native tests
  cover argument order, preserved lower cells, zero/void/narrow results, eight
  arguments, recursive callbacks, invalid signatures, JSON and import compilation.
- The independent [C sequence model](lists-reference.c) executed 10,000 randomized
  operations in two histories. Each step checks order, values, exact live node/content
  allocations, callback counts and order hashes, arena accounting and outer guards.
- GCC, Clang and GCC AddressSanitizer/UndefinedBehaviorSanitizer each passed 571,082
  checks with identical results. Required operations in the ample-memory histories
  must succeed; arbitrary rejection cannot pass the model.
- Directed failures cover transform rejection, content allocation failure, node
  allocation failure after a transform and after a mapped prefix, duplicate nodes,
  cycles, whole-list pin preflight and read-only mapping of pinned source nodes.
- Null and RW/NX callback targets raise SIGSEGV in separate native child processes.
  These are fault tests, not evidence of a new sandbox or cross-domain guarantee.

Sanitizers instrument the C client/model, not generated NASM. Model byte comparisons,
allocation accounting and canaries cover assembly-visible behavior. No performance
measurements or remote CI execution are claimed.

Run the suite with NASM installed (UBYTEC_NASM may specify its path):

```text
dotnet test Ubytec.Tests/Ubytec.Tests.csproj -c Release -p:EnableDocFxOnBuild=false
python3 corpus/libft/run_lists.py --output artifacts/lists
```

The Python runner requires Linux x64, .NET 9, NASM, GCC and Clang for execution.
--prepare-only writes inspectable source without claiming compilation or tests;
--compile-only emits assembly/provenance without claiming native validation.
--assembly-directory accepts precompiled output only when source/assembly hashes
match the recorded compiler provenance. The fixture uses ordinary host adapters;
the protected-module export limit remains unchanged.

Saved [evidence](evidence/lists/summary.json) includes reports, native results,
compiler/source/assembly hashes, composed Ubytec/NASM and the full .NET TRX.
The [fixture callbacks](lists-fixtures.ubc) allocate transformed content and
record traversal/destruction order using explicitly supplied content state.
