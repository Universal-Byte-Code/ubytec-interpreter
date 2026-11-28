using System.Buffers.Binary;
using static Ubytec.Language.Syntax.TypeSystem.Types;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Portable;

/// <summary>Boundary kind of the restricted scalar temporal reference, not a new ISA opcode.</summary>
public enum PortableScalarBoundaryKind { Enter, Budget, Return, Trap, Abort, Terminate }

/// <summary>One admitted boundary with the existing runtime identity/commit and logical fuel accounting.</summary>
public sealed record PortableScalarBoundary(ulong Round, PortableScalarBoundaryKind Kind,
    PortablePublishedEvent Event, ulong Fuel, PortableInstructionOccurrence? Occurrence, ulong? Result);

/// <summary>Execution outcome in admitted context order. A null result means a trapped context.</summary>
public sealed record PortableScalarOutcome(IReadOnlyList<PortableScalarBoundary> Trace, IReadOnlyList<ulong?> Results, PortableTemporalSnapshot SemanticState);

/// <summary>
/// First actual UBCM temporal reference slice. Accepts only verified DirectOnly modules and
/// selected zero-argument/local Int64 functions using eight-byte PUSH, ADD, NOP,
/// LOOP/END, loop BREAK/CONTINUE, RETURN or explicit TRAP. No host effects, calls,
/// conditional branches, timers or shared memory.
/// This is an interpreter, not native code generation or full temporal-v0 conformance.
/// </summary>
public static class PortableTemporalScalarReference
{
    private sealed record Plan(PortableInstruction[] Code, PortableInstructionOccurrence[] Sites, int[] Targets);
    private sealed class State(PortableRuntimeContextId context, uint function, Plan plan)
    {
        internal readonly PortableRuntimeContextId Context = context;
        internal readonly uint Function = function;
        internal readonly Plan Plan = plan;
        internal Stack<ulong> Stack = new();
        internal PortableActivationId? Activation;
        internal int Pc;
        internal ulong Fuel;
        internal bool AbortPending;
        internal bool TerminationPending;
        internal ulong? Result;
    }

    private sealed record Prepared(PortableScalarBoundaryKind Kind, int Pc, ulong Fuel,
        Stack<ulong>? Stack, PortableInstructionOccurrence? Occurrence, ulong? Result);

    // Private evaluation reads only this context's snapshot and immutable verified plan.
    // No identity allocation, host calls or shared commits may happen here.
    private static Prepared Prepare(State state, int quantum)
    {
        if (state.TerminationPending)
            return new(PortableScalarBoundaryKind.Terminate, state.Pc, state.Fuel, null, null, state.Result);
        if (state.Activation is null)
            return new(PortableScalarBoundaryKind.Enter, state.Pc, state.Fuel, null, null, null);
        if (state.AbortPending)
            return new(PortableScalarBoundaryKind.Abort, state.Pc, state.Fuel, null, null, null);

        var stack = new Stack<ulong>(state.Stack.Reverse());
        int pc = state.Pc;
        ulong fuel = state.Fuel;
        for (int charged = 0; charged < quantum; charged++)
        {
            if (pc >= state.Plan.Code.Length) throw new InvalidDataException("Missing terminal instruction.");
            var instruction = state.Plan.Code[pc];
            var occurrence = state.Plan.Sites[pc++];
            fuel = checked(fuel + 1);
            switch (instruction)
            {
                case PortablePushInstruction push:
                    stack.Push(BinaryPrimitives.ReadUInt64LittleEndian(push.Immediate));
                    break;
                case PortableOperandFreeInstruction op when op.OpCode is NOP.OP or LOOP.OP:
                    break;
                case PortableOperandFreeInstruction op when op.OpCode == END.OP:
                case PortableControlTransferInstruction:
                    pc = state.Plan.Targets[pc - 1];
                    break;
                case PortableOperandFreeInstruction op when op.OpCode == 0x20:
                    ulong right = stack.Pop(), left = stack.Pop();
                    stack.Push(unchecked(left + right));
                    break;
                case PortableReturnInstruction:
                    return new(PortableScalarBoundaryKind.Return, pc, fuel, stack, occurrence, stack.Pop());
                case PortableOperandFreeInstruction op when op.OpCode == TRAP.OP:
                    return new(PortableScalarBoundaryKind.Trap, pc, fuel, stack, occurrence, null);
                default:
                    throw new InvalidDataException("Unexpected admitted instruction.");
            }
            if (charged + 1 == quantum)
                return new(PortableScalarBoundaryKind.Budget, pc, fuel, stack, occurrence, null);
        }
        throw new InvalidOperationException("Invalid quantum.");
    }

    /// <summary>Execute one selected function per context in declaration order; one boundary per turn.</summary>
    public static PortableScalarOutcome Run(ReadOnlySpan<byte> image, IReadOnlyList<uint> functions,
        int quantum = 3, int maxEvents = 100_000, int maxInstructions = 1_000_000, bool parallel = false)
    {
        ArgumentNullException.ThrowIfNull(functions);
        if (quantum <= 0 || maxEvents <= 0 || maxInstructions <= 0 ||
            functions.Count is < 1 or > 128)
            throw new ArgumentOutOfRangeException(nameof(quantum), "Invalid reference limits or context count.");
        uint[] selected = functions.ToArray();
        byte[] bytes = image.ToArray();
        var verified = PortableBinaryVerifier.IdentifyInstructions(bytes, maxInstructions, PortableExecutionProfile.DirectOnly);
        var module = PortableBinaryCodec.Decode(bytes).Executable!;
        if (module.Imports.Count != 0)
            throw new NotSupportedException("Reference does not admit imported effects.");
        var byFunction = verified.GroupBy(site => site.FunctionIndex)
            .ToDictionary(group => group.Key, group => group.ToArray());
        var plans = new Dictionary<uint, Plan>();
        foreach (uint index in selected.Distinct())
        {
            if (index >= (uint)module.Functions.Count)
                throw new InvalidDataException("Unknown function index.");
            var function = module.Functions[(int)index];
            var type = module.Types[(int)function.ReturnTypeIndex];
            if (function.ArgumentTypeIndices.Count != 0 || function.LocalTypeIndices.Count != 0 ||
                type.Primitive != PrimitiveType.Int64 || type.FixedArraySize != 1 || (uint)type.Modifiers != 0)
                throw new NotSupportedException("Reference requires zero-argument/local scalar Int64 functions.");
            var code = function.Instructions.ToArray();
            var sites = byFunction[index];
            if (code.Length != sites.Length)
                throw new InvalidDataException("Decoded code and verified boundaries disagree.");
            foreach (var instruction in code)
            {
                bool supported = instruction switch
                {
                    PortablePushInstruction push => push.Immediate.Length == 8,
                    PortableOperandFreeInstruction op => op.OpCode is 0x20 or TRAP.OP or NOP.OP or LOOP.OP or END.OP,
                    PortableControlTransferInstruction transfer => transfer.Operation is BREAK.OP or CONTINUE.OP,
                    PortableReturnInstruction ret => ret.TypeIndex is null || ret.TypeIndex == function.ReturnTypeIndex,
                    _ => false
                };
                if (!supported)
                    throw new NotSupportedException($"Unsupported temporal scalar opcode 0x{instruction.OpCode:X2}.");
            }
            // Resolve only loop scopes, never native labels. LOOP charges on entry;
            // END/CONTINUE target the first body instruction. BREAK skips END.
            int[] targets = new int[code.Length];
            var loops = new Stack<int>();
            var exits = new Dictionary<int, int>();
            var breaks = new List<(int Site, int Loop)>();
            for (int i = 0; i < code.Length; i++)
            {
                if (code[i].OpCode == LOOP.OP) loops.Push(i);
                else if (code[i].OpCode == END.OP)
                {
                    int start = loops.Pop();
                    targets[i] = start + 1;
                    exits.Add(start, i + 1);
                }
                else if (code[i] is PortableControlTransferInstruction transfer)
                {
                    int start = loops.ElementAt(checked((int)transfer.TargetOrdinal));
                    if (transfer.Operation == CONTINUE.OP) targets[i] = start + 1;
                    else breaks.Add((i, start));
                }
            }
            foreach (var site in breaks) targets[site.Site] = exits[site.Loop];
            plans.Add(index, new Plan(code, sites, targets));
        }

        var coordinator = new PortableTemporalCoordinator(maxEvents);
        var identity = coordinator.Identity;
        var loaded = identity.Load(bytes, PortableExecutionProfile.DirectOnly, maxInstructions);
        var publication = coordinator.Publication;
        var states = selected.Select(index => new State(coordinator.CreateContext(), index, plans[index])).ToArray();
        var byContext = states.ToDictionary(state => state.Context);
        var trace = new List<PortableScalarBoundary>();
        while (coordinator.LiveCount != 0)
        {
            coordinator.RunScalarRound(key => Prepare(byContext[key.Context], quantum), (key, next) =>
            {
                var id = key.Context;
                publication.RequireCapacity();
                var state = byContext[id];
                state.Pc = next.Pc;
                state.Fuel = next.Fuel;
                if (next.Stack is not null) state.Stack = next.Stack;
                var data = new PortableScalarEventData(coordinator.Round, next.Kind, next.Fuel, next.Occurrence, next.Result);
                PortablePublishedEvent published;
                switch (next.Kind)
                {
                    case PortableScalarBoundaryKind.Enter:
                        var entry = identity.EnterObserved(id, loaded, state.Function);
                        state.Activation = entry.Activation;
                        published = publication.PublishScalar(entry, data);
                        break;
                    case PortableScalarBoundaryKind.Return:
                    case PortableScalarBoundaryKind.Abort:
                        bool aborted = next.Kind == PortableScalarBoundaryKind.Abort;
                        published = publication.PublishScalar(identity.CloseObserved(state.Activation!.Value, aborted), data);
                        state.Result = next.Result;
                        state.TerminationPending = true;
                        break;
                    case PortableScalarBoundaryKind.Terminate:
                        coordinator.TerminateScalar(key);
                        published = coordinator.Events[^1];
                        break;
                    case PortableScalarBoundaryKind.Trap:
                    case PortableScalarBoundaryKind.Budget:
                        published = publication.PublishScalar(identity.Record(state.Activation!.Value,
                            next.Occurrence!.Value.InstructionOffset), data);
                        state.AbortPending = next.Kind == PortableScalarBoundaryKind.Trap;
                        break;
                    default: throw new InvalidOperationException("Unknown boundary.");
                }
                trace.Add(new(coordinator.Round, next.Kind, published, next.Fuel, next.Occurrence, next.Result));
            }, parallel);
        }
        identity.Unload(loaded);
        return new PortableScalarOutcome(trace.AsReadOnly(), Array.AsReadOnly(states.Select(s => s.Result).ToArray()), coordinator.Capture());
    }
}
