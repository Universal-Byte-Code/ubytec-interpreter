using System.Buffers.Binary;
using static Ubytec.Language.Syntax.TypeSystem.Types;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Portable;

/// <summary>Boundary kind of the restricted scalar temporal reference, not a new ISA opcode.</summary>
public enum PortableScalarBoundaryKind { Enter, Budget, Return, Trap, Abort }

/// <summary>One admitted boundary with the existing runtime identity/commit and logical fuel accounting.</summary>
public sealed record PortableScalarBoundary(ulong Round, PortableScalarBoundaryKind Kind,
    PortablePublishedEvent Event, ulong Fuel, PortableInstructionOccurrence? Occurrence, ulong? Result);

/// <summary>Execution outcome in admitted context order. A null result means a trapped context.</summary>
public sealed record PortableScalarOutcome(IReadOnlyList<PortableScalarBoundary> Trace, IReadOnlyList<ulong?> Results);

/// <summary>
/// First actual UBCM temporal reference slice. Accepts only verified DirectOnly modules and
/// selected straight-line zero-argument/local Int64 functions using eight-byte PUSH, ADD,
/// RETURN or explicit TRAP. No host effects, calls, branches, timers or shared memory.
/// This is an interpreter, not native code generation or full temporal-v0 conformance.
/// </summary>
public static class PortableTemporalScalarReference
{
    private sealed record Plan(PortableInstruction[] Code, PortableInstructionOccurrence[] Sites);
    private sealed class State(PortableRuntimeContextId context, uint function, Plan plan)
    {
        internal readonly PortableRuntimeContextId Context = context;
        internal readonly uint Function = function;
        internal readonly Plan Plan = plan;
        internal readonly Stack<ulong> Stack = new();
        internal PortableActivationId? Activation;
        internal int Pc;
        internal ulong Fuel;
        internal bool AbortPending;
        internal bool Done;
        internal ulong? Result;
    }

    /// <summary>Execute one selected function per context in declaration order; one boundary per turn.</summary>
    public static PortableScalarOutcome Run(ReadOnlySpan<byte> image, IReadOnlyList<uint> functions,
        int quantum = 3, int maxEvents = 100_000, int maxInstructions = 1_000_000)
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
                    PortableOperandFreeInstruction op => op.OpCode is 0x20 or TRAP.OP,
                    PortableReturnInstruction ret => ret.TypeIndex is null || ret.TypeIndex == function.ReturnTypeIndex,
                    _ => false
                };
                if (!supported)
                    throw new NotSupportedException($"Unsupported temporal scalar opcode 0x{instruction.OpCode:X2}.");
            }
            // The subset intentionally rejects implicit fallthrough and unreachable tails.
            if (code.Length == 0 || code[^1] is not PortableReturnInstruction &&
                code[^1].OpCode != TRAP.OP ||
                code.Take(code.Length - 1).Any(op => op is PortableReturnInstruction || op.OpCode == TRAP.OP))
                throw new NotSupportedException("Reference requires a single final RETURN or TRAP.");
            plans.Add(index, new Plan(code, sites));
        }

        var identity = new PortableRuntimeIdentity();
        var loaded = identity.Load(bytes, PortableExecutionProfile.DirectOnly, maxInstructions);
        var publication = new PortableEventPublication(identity.Session, maxEvents);
        var states = selected.Select(index => new State(identity.CreateContext(), index, plans[index])).ToArray();
        var trace = new List<PortableScalarBoundary>();
        ulong round = 0;
        while (states.Any(state => !state.Done))
        {
            round = checked(round + 1);
            foreach (State state in states)
            {
                if (state.Done) continue;
                if (trace.Count >= maxEvents)
                    throw new InvalidOperationException("Temporal reference event limit reached.");
                if (state.Activation is null)
                {
                    var entry = identity.EnterObserved(state.Context, loaded, state.Function);
                    state.Activation = entry.Activation;
                    trace.Add(new(round, PortableScalarBoundaryKind.Enter, publication.Publish(entry), 0, null, null));
                    continue;
                }
                var activation = state.Activation.Value;
                if (state.AbortPending)
                {
                    var aborted = identity.CloseObserved(activation, aborted: true);
                    trace.Add(new(round, PortableScalarBoundaryKind.Abort, publication.Publish(aborted),
                        state.Fuel, null, null));
                    state.Done = true;
                    continue;
                }

                for (int charged = 1; charged <= quantum; charged++)
                {
                    if (state.Pc >= state.Plan.Code.Length)
                        throw new InvalidDataException("Missing terminal instruction.");
                    var instruction = state.Plan.Code[state.Pc];
                    var occurrence = state.Plan.Sites[state.Pc++];
                    state.Fuel = checked(state.Fuel + 1);
                    switch (instruction)
                    {
                        case PortablePushInstruction push:
                            state.Stack.Push(BinaryPrimitives.ReadUInt64LittleEndian(push.Immediate));
                            break;
                        case PortableOperandFreeInstruction op when op.OpCode == 0x20:
                            ulong right = state.Stack.Pop(), left = state.Stack.Pop();
                            state.Stack.Push(unchecked(left + right));
                            break;
                        case PortableReturnInstruction:
                            state.Result = state.Stack.Pop();
                            var returned = identity.CloseObserved(activation);
                            trace.Add(new(round, PortableScalarBoundaryKind.Return, publication.Publish(returned),
                                state.Fuel, occurrence, state.Result));
                            state.Done = true;
                            break;
                        case PortableOperandFreeInstruction op when op.OpCode == TRAP.OP:
                            var fault = identity.Record(activation, occurrence.InstructionOffset);
                            trace.Add(new(round, PortableScalarBoundaryKind.Trap, publication.Publish(fault),
                                state.Fuel, occurrence, null));
                            state.AbortPending = true;
                            break;
                        default:
                            throw new InvalidDataException("Unexpected admitted instruction.");
                    }
                    if (state.Done || state.AbortPending) break;
                    if (charged == quantum)
                    {
                        var boundary = identity.Record(activation, occurrence.InstructionOffset);
                        trace.Add(new(round, PortableScalarBoundaryKind.Budget, publication.Publish(boundary),
                            state.Fuel, occurrence, null));
                        break;
                    }
                }
            }
        }
        foreach (State state in states) identity.RetireContext(state.Context);
        identity.Unload(loaded);
        return new PortableScalarOutcome(trace.AsReadOnly(), Array.AsReadOnly(states.Select(s => s.Result).ToArray()));
    }
}
