# Native Ubytec temporal runtime (bootstrap)
 
The implementation language of the runtime is Ubytec. The existing C# temporal reference is retained as an executable oracle, not a dependency of the native scheduler. Compose the files in `sources.txt` with `TemporalRuntimeSource.Compose`, then compile the resulting source via the normal semantic source -> indexed UBCM -> x64 pipeline. No Python, additional opcode encoding, or C# turn callback is involved in native execution.

## Admission and ABI (internal, not frozen)
 
This slice consumes the exact Code bytes of one zero-argument/local Int64 function. The supported wire forms are TRAP, NOP, CLEAR, NULL, PUSH (1–8 byte little-endian immediate), all core stack operations 0x12–0x1E, arithmetic 0x20–0x2A, bitwise 0x30–0x36, comparisons 0x40–0x49, inferred RETURN (09 00), and the four extended-stack forms (FF 10 op u16). Structured control adds untyped BLOCK (mode 0), LOOP, IF, ELSE, END, BREAK, CONTINUE and WHILE. No new wire opcode is allocated. The public module entry now performs bounded admission of complete PMF bytes for this restricted executable projection; it is not a general PMF verifier. The caller must supply valid, non-overlapping native buffers with the documented extents and an immutable code slice; the runtime itself uses UnsafeCells because it operates on these trusted host buffers. Guest stack cells are not host pointers. Unknown/truncated instructions, resource exhaustion and invalid stack depths produce infrastructure failure, not a successful guest event.
 
- `TemporalTurn(count, state, cells, capacity, quantum, plan)` executes one primary boundary. State has six u64 cells (instruction ordinal, depth, cumulative fuel, phase, last instruction byte offset, result). The caller supplies zero initial state and a capacity-sized u64 evaluation stack. Phase zero denotes pending entry; phase five denotes terminated; phase six denotes failed. Boundary results are 0 Enter, 1 Budget, 2 Return, 3 Trap, 4 Abort, 5 Terminate, 6 Failure. Terminal lifecycle transitions charge no guest fuel.
- `TemporalRun(code, length, states, stacks, contexts, capacity, quantum, ledger, limit, plan)` owns the entire serial scheduling loop. States require contexts * 64 bytes (six state cells, local sequence and logical clock); stacks require contexts * capacity * 8 bytes; ledger requires limit * 72 bytes. Contexts are 1..128; capacity 1..4096; limit at most 1,000,000; positive quantum. Context creation is emitted in round zero. Each round visits nonterminated contexts in ascending order. Return value is committed row count, or zero on failure (discard the partial ledger). No host scheduling callback.
- A row is nine little-endian u64 cells: round, context ordinal, local event sequence, Lamport time, commit ordinal, boundary kind, cumulative guest fuel, Code offset (0xffffffff for synthetic transitions), result. Kind 7 is creation (coordinator ordinal zero; result is created ordinal). Other result fields are zero unless Return. Context/instance/activation GUID/digest are not serialized in this projection; loaded instance and single activation are implicit in this restricted bootstrap. This projection is not the complete temporal event schema.

## Internal organization and refactoring constraints

Source is physically split into ten UBC files with an explicit ordered manifest. The compiler still receives one module; cross-fragment calls are ordinary direct UBC calls. This is static source composition, not separately linked binary modules. Context, plan and ledger layouts are independent and owned by `records.ubc`. Do not allocate guest wire opcodes or change the ledger ABI as a side effect of refactoring.

| Component | Functions |
| --- | --- |
| Cell access | TemporalCellAddress/Get/Set |
| Stack | TemporalStackGet, Pick, Remove, Rotate, CopyPair, StackByte/Word |
| Scalar dispatch | TemporalPrivateDepth/Apply, TemporalDepthShape, TemporalUnary/Binary, TemporalArithmeticSafe |
| Admission | TemporalAdmit, TemporalValidateSection, TemporalValidateRootSignature, TemporalDecode, TemporalPlanPrepare, TemporalLinkScopes, TemporalResolveBreaks, TemporalAnalyzeDepth, TemporalValidateTransfers |
| Interpreter | TemporalTurn, TemporalSaveBoundary, TemporalSetPhase |
| Scheduler | TemporalRunPrepared, TemporalRun, TemporalRunModule |
| Event projection | TemporalLedgerRow/Write |

Use typed block contracts where they express real stack transformations, structured SWITCH dispatch for opcode selection, and one implementation of each state transition. Preserve differential traces, fuel, malformed-input rejection and native test results. Numeric wire constants remain visible in decoding/dispatch until there is an explicit source-level constant mechanism; do not introduce a second registry. The test harness resolves entry indices by semantic function name rather than hard-coded positions. The manifest is checked for missing, extra and duplicate source files. PMF traversal and profile policy are separate: bounded section framing precedes the per-kind payload validators; root signature validation follows required-section checks. The plan is compact and independent of event identity. Named plan and context accessors keep layout selectors inside `records.ubc`; the ledger is written only by its dedicated writer. Numeric wire opcodes remain registry values.

## Scalar execution

`TemporalPrivateDepth` classifies the admitted opcode into its required and resulting top-window cell counts. `TemporalDepthShape` validates the window and computes the next depth using a typed BLOCK, with the prefix preserved; CLEAR resets depth explicitly. Both admission and execution share this rule. `TemporalPrivateApply` implements private cell operations in Ubytec; execution charges one guest instruction regardless of helper instruction count. Integer arithmetic wraps modulo 2^64 except DIV/MOD/UDIV/UMOD, which trap on zero, and signed DIV/MOD also trap on min-int / -1 before native division. ABS of min-int preserves its bit pattern. Shift counts use the low six bits; signed and unsigned comparisons yield canonical 0/1. PUSH16 is a zero-extended two-byte read in the native top-first stack byte layout (including cross-cell words); the other extended forms index cells, not bytes. Internal dispatch value 273 distinguishes PUSH16 from core PUSH; it is not a new guest opcode.

## Complete module admission

- `TemporalAdmit(image, length, capacity, view, plan)` reads the actual PMF header and section headers in Ubytec, enforces version 0.0, 12-byte framing, ordered unique section kinds, bounded payload lengths, required section set, critical flags and context wire version 3 / DirectOnly. It admits exactly one top-level zero-argument/local Int64 function, empty string/import/export/constant tables, no contract/capability manifests or callable slots, and optional entrypoint 0 or NoIndex. Unknown noncritical extensions are skipped. The AST payload is opaque and nonempty; canonical JSON and unused type entries are not validated. The executable type used by the function is checked, including modifiers, array extent, name and reserved fields.
- It independently decodes all supported instruction forms, including unreachable code, and constructs a structured control plan before scheduling. Unknown instructions, unmatched scopes, invalid control ordinals, incompatible reachable stack depths and reachable fallthrough past Code fail before any scheduler event is published. Infinite loops are permitted but bounded by scheduler resources.
- `TemporalRunModule(image, length, states, stacks, contexts, capacity, quantum, ledger, limit, plan, view)` calls admission then runs the scheduler. The host supplies a separate 16-byte scratch view; admission writes the pointer/length only on success. Immutable disjoint buffer preconditions still apply. This is executable-projection admission, not authentication or a sandbox for arbitrary native callers.

## Structured control plan

The internal plan is indexed by instruction ordinal, never by guest-controlled address. `TemporalPlanPrepare(code, length, capacity, plan)` supports Code lengths 1..4096 bytes and cell capacity 1..4096. For Code length B, the host provides at least 8 + 26*B bytes (or 8 + 26*min(module byte length, 4096) for module entry). The actual initialized/usable layout for N decoded instructions is:

| Region | Size | Purpose |
| --- | ---: | --- |
| Header | 8 bytes | Instruction count N |
| Records | 24*N bytes | One record per instruction start |
| Work queue | 2*N bytes | Bounded admission worklist of instruction ordinals |

Record offsets 0,2,4,6,8,10,12,14 contain u16 normalized opcode, successor, transfer target, parent+1, ELSE+1, expected depth+1, scope exit and original Code byte offset. Offset 16 is the full u64 decoded operand. The logical accessor selectors 0..5,6,7,8 retain operand at selector 6, exit at 7 and original offset at 8. No record is allocated for immediate or extension bytes. Under the admitted size/cell bounds, ordinals, terminal successor, depth+1 and original offsets fit in u16; decoded values and control operands retain all their bits. Worst-case scratch drops from 72*B to 8+26*B; the actual used extent is 8+26*N.

The original byte offset is recorded at decode and remains the ledger identity; it is not replaced by the internal PC ordinal. This is an internal representation change, not a new wire format or a complete executable identity implementation. The raw and module entrypoints both admit once and delegate to `TemporalRunPrepared`. The interpreter consumes the immutable plan and does not decode guest bytes again. Lexical links, worklist stack-depth checks, BREAK/CONTINUE target entry-depth constraints and one-fuel-per-attempt semantics are unchanged. Typed/contracted BLOCK, SWITCH/BRANCH/DEFAULT, frames/calls and guest capabilities remain outside the guest subset. Code and plan remain immutable during scheduling.

## Validation
 
`PortableSelfHostedTemporalTests` compiles the Ubytec runtime, assembles and runs its native scheduler, and compares its projected rows against the C# oracle on actual verified UBCM code, including exact-quantum return, multi-context order, signed/unsigned arithmetic, shifts, comparisons, stack permutations and cross-cell PUSH16, and trap/abort. Explicit stack vectors compare results against direct native lowering as a third reference. It tests malformed/unsupported code and resource limits separately, checks guard bytes beyond the compact scratch extent, and checks exact original offsets, full-width immediates and maximum Code length. The C# test harness supplies host buffers and bytes; it does not select turns, evaluate guest opcodes or assign event order for the native run.
 
Next: contracted BLOCK and SWITCH with type/branch merge rules, generalize PMF admission beyond the restricted projection, explicit activation stacks, full registry disposition and coverage, resource handles and mediated effects, journal/replay and native capability interface. The bootstrap uses a single code stream shared by all initial contexts; it does not yet support arbitrary modules, parallel workers, protected process isolation or full temporal-v0 conformance. Retain the managed oracle until differential coverage is established.
