using static Ubytec.Language.Syntax.TypeSystem.Types;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Portable;

public enum PortableScalarBoundaryKind { Enter, Budget, Return, Trap, Abort, Terminate, Call }

/// <summary>One admitted semantic boundary; fuel counts attempted verified instructions.</summary>
public sealed record PortableScalarBoundary(ulong Round, PortableScalarBoundaryKind Kind,
    PortablePublishedEvent Event, ulong Fuel, PortableInstructionOccurrence? Occurrence, ulong? Result);

/// <summary>Null result denotes a void or trapped context; lifecycle events distinguish the cases.</summary>
public sealed record PortableScalarOutcome(IReadOnlyList<PortableScalarBoundary> Trace, IReadOnlyList<ulong?> Results,
    PortableTemporalSnapshot SemanticState);

/// <summary>Managed DirectOnly reference. Supports a bounded scalar/control/call subset; rejects
/// unsupported instructions throughout the statically reachable call graph before execution.
/// Guest capabilities, raw memory and switch are not admitted yet.</summary>
public static class PortableTemporalScalarReference
{
    private sealed record Plan(uint Function, PortableInstruction[] Code, PortableInstructionOccurrence[] Sites,
        int[] Targets, PortableInstruction?[] BlockExit, PrimitiveType ReturnType,
        PrimitiveType[] Bindings, int Arguments);
    private sealed class Frame(Plan plan, ulong[] arguments)
    {
        internal readonly Plan Plan = plan;
        internal List<ulong> Stack = new();
        internal ulong?[] Bindings = Init(plan, arguments);
        internal PortableActivationId? Activation;
        internal int Pc;
        private static ulong?[] Init(Plan plan, ulong[] args)
        {
            var values = new ulong?[plan.Bindings.Length];
            for (int i = 0; i < args.Length; i++) values[i] = args[i];
            return values;
        }
    }
    private sealed class State(PortableRuntimeContextId context, Frame root)
    {
        internal readonly PortableRuntimeContextId Context = context;
        internal readonly Stack<Frame> Frames = new(new[] { root });
        internal ulong Fuel;
        internal bool AbortPending;
        internal bool TerminationPending;
        internal ulong? Result;
    }

    private sealed record Prepared(PortableScalarBoundaryKind Kind, int Pc, ulong Fuel,
        List<ulong>? Stack, ulong?[]? Bindings, PortableInstructionOccurrence? Occurrence,
        ulong? Result, uint? Target = null, ulong[]? Arguments = null, string? Fault = null);

    private static ulong Canonical(PrimitiveType type, ulong value) => type switch
    {
        PrimitiveType.Bool => value == 0 ? 0UL : 1UL,
        PrimitiveType.Byte or PrimitiveType.Char8 => (byte)value,
        PrimitiveType.SByte => unchecked((ulong)(long)(sbyte)value),
        PrimitiveType.UInt16 or PrimitiveType.Char16 => (ushort)value,
        PrimitiveType.Int16 => unchecked((ulong)(long)(short)value),
        PrimitiveType.UInt32 => (uint)value,
        PrimitiveType.Int32 => unchecked((ulong)(long)(int)value),
        PrimitiveType.Int64 or PrimitiveType.UInt64 => value,
        _ => throw new InvalidDataException("Not a scalar cell type.")
    };

    private static bool ConvertAt(List<ulong> stack, int index, PrimitiveType type, bool check)
    {
        ulong value = stack[index], canonical = Canonical(type, value);
        if (check && value != canonical) return false;
        stack[index] = canonical;
        return true;
    }

    private static ulong Pop(List<ulong> stack)
    {
        ulong value = stack[^1];
        stack.RemoveAt(stack.Count - 1);
        return value;
    }

    private static ulong Immediate(byte[] bytes)
    {
        ulong value = 0;
        for (int i = 0; i < bytes.Length; i++) value |= (ulong)bytes[i] << (i * 8);
        return value;
    }

    private static bool IsPrivate(byte op) => op is 0x0D or 0x0F or >= 0x12 and <= 0x17
        or >= 0x19 and <= 0x1C or >= 0x20 and <= 0x2A or >= 0x30 and <= 0x36 or >= 0x40 and <= 0x49;

    private static void Reserve(List<ulong> stack, int count, int limit)
    {
        if (count > limit - stack.Count) throw new InvalidOperationException("Evaluation stack limit.");
    }

    private static void ApplyIndexed(List<ulong> stack, byte op, int index, int limit, bool extendedWord = false)
    {
        if (extendedWord)
        {
            Reserve(stack, 1, limit);
            ulong ReadByte(int offset) => (stack[stack.Count - 1 - offset / 8] >> (8 * (offset % 8))) & 255UL;
            stack.Add(ReadByte(index) | (ReadByte(index + 1) << 8));
            return;
        }
        int position = stack.Count - 1 - index;
        ulong value = stack[position];
        if (op == 0x1D) { Reserve(stack, 1, limit); stack.Add(value); }
        else
        {
            stack.RemoveAt(position);
            if (op == 0x1E) stack.Add(value);
        }
    }

    // Full private scalar core. A false result denotes an attempted arithmetic trap;
    // do not execute division in the host on zero or signed quotient overflow.
    private static bool ApplyPrivate(List<ulong> stack, byte op, int limit)
    {
        void Copy(int depth, int count)
        {
            Reserve(stack, count, limit);
            stack.AddRange(stack.GetRange(stack.Count - depth, count));
        }
        void Rotate(int depth, int count)
        {
            int start = stack.Count - depth;
            var prefix = stack.GetRange(start, count);
            stack.RemoveRange(start, count);
            stack.AddRange(prefix);
        }
        switch (op)
        {
            case 0x0D: stack.Clear(); return true;
            case 0x0F: Reserve(stack, 1, limit); stack.Add(0); return true;
            case 0x12: Pop(stack); return true;
            case 0x13: Copy(1, 1); return true;
            case 0x14: Rotate(2, 1); return true;
            case 0x15: Rotate(3, 1); return true;
            case 0x16: Copy(2, 1); return true;
            case 0x17: stack.RemoveAt(stack.Count - 2); return true;
            case 0x19: Copy(2, 2); return true;
            case 0x1A: Rotate(4, 2); return true;
            case 0x1B: Rotate(6, 2); return true;
            case 0x1C: Copy(4, 2); return true;
            case 0x25: stack[^1] = unchecked(stack[^1] + 1); return true;
            case 0x26: stack[^1] = unchecked(stack[^1] - 1); return true;
            case 0x27: stack[^1] = unchecked(0UL - stack[^1]); return true;
            case 0x28: if (unchecked((long)stack[^1]) < 0) stack[^1] = unchecked(0UL - stack[^1]); return true;
            case 0x33: stack[^1] = ~stack[^1]; return true;
        }

        ulong right = stack[^1], left = stack[^2];
        long l = unchecked((long)left), r = unchecked((long)right);
        if ((op is 0x23 or 0x24 or 0x29 or 0x2A) && right == 0 ||
            (op is 0x23 or 0x24) && l == long.MinValue && r == -1)
            return false;
        static ulong Bool(bool value) => value ? 1UL : 0UL;
        ulong result = op switch
        {
            0x20 => unchecked(left + right), 0x21 => unchecked(left - right), 0x22 => unchecked(left * right),
            0x23 => unchecked((ulong)(l / r)), 0x24 => unchecked((ulong)(l % r)),
            0x29 => left / right, 0x2A => left % right,
            0x30 => left & right, 0x31 => left | right, 0x32 => left ^ right,
            0x34 => left << (int)(right & 63), 0x35 => unchecked((ulong)(l >> (int)(right & 63))),
            0x36 => left >> (int)(right & 63),
            0x40 => Bool(left == right), 0x41 => Bool(left != right),
            0x42 => Bool(l < r), 0x43 => Bool(l <= r), 0x44 => Bool(l > r), 0x45 => Bool(l >= r),
            0x46 => Bool(left < right), 0x47 => Bool(left <= right), 0x48 => Bool(left > right), 0x49 => Bool(left >= right),
            _ => throw new InvalidDataException("Unsupported private operation.")
        };
        stack.RemoveAt(stack.Count - 1);
        stack[^1] = result;
        return true;
    }

    // Only the top frame is privately copied; callers remain suspended until a return commit.
    private static Prepared Prepare(State state, IReadOnlyDictionary<uint, Plan> plans,
        IReadOnlyList<PortableExecutableType> types, int quantum, int maxStackCells, int maxDepth)
    {
        if (state.TerminationPending)
            return new(PortableScalarBoundaryKind.Terminate, 0, state.Fuel, null, null, null, state.Result);
        Frame frame = state.Frames.Peek();
        if (state.AbortPending)
            return new(PortableScalarBoundaryKind.Abort, frame.Pc, state.Fuel, null, null, null, null);
        if (frame.Activation is null)
            return new(PortableScalarBoundaryKind.Enter, frame.Pc, state.Fuel, null, null, null, null);

        var plan = frame.Plan;
        var stack = new List<ulong>(frame.Stack);
        var bindings = (ulong?[])frame.Bindings.Clone();
        int pc = frame.Pc;
        ulong fuel = state.Fuel;
        for (int charged = 0; charged < quantum; charged++)
        {
            if (pc == plan.Code.Length && plan.ReturnType == PrimitiveType.Void)
                return new(PortableScalarBoundaryKind.Return, pc, fuel, stack, bindings, null, null);
            if ((uint)pc >= (uint)plan.Code.Length) throw new InvalidDataException("Missing terminal instruction.");
            int site = pc++;
            var instruction = plan.Code[site];
            var occurrence = plan.Sites[site];
            fuel = checked(fuel + 1);
            Prepared Fault(string reason) => new(PortableScalarBoundaryKind.Trap, pc, fuel, stack,
                bindings, occurrence, null, Fault: reason);
            bool ExitBlock(PortableInstruction? block)
            {
                uint? result = block switch
                {
                    PortableContractBlockInstruction c => c.ResultTypeIndex,
                    PortableBlockInstruction b => b.ResultTypeIndex,
                    _ => null
                };
                return result is not uint index || types[(int)index].Primitive == PrimitiveType.Void ||
                    ConvertAt(stack, stack.Count - 1, types[(int)index].Primitive,
                        block is PortableContractBlockInstruction { Checked: true });
            }

            switch (instruction)
            {
                case PortablePushInstruction push:
                    if (stack.Count >= maxStackCells) throw new InvalidOperationException("Evaluation stack limit.");
                    stack.Add(Immediate(push.Immediate));
                    break;
                case PortableVariableInstruction variable:
                    bindings[(int)variable.BindingIndex] = variable.InitialCell;
                    break;
                case PortableMemoryInstruction memory when memory.Mode == PortableMemoryAccessMode.Binding:
                    int index = checked((int)memory.BindingIndex!.Value);
                    if (memory.OpCode == 0x50)
                    {
                        if (bindings[index] is not ulong value) return Fault("UninitializedBinding");
                        if (stack.Count >= maxStackCells) throw new InvalidOperationException("Evaluation stack limit.");
                        stack.Add(Canonical(plan.Bindings[index], value));
                    }
                    else bindings[index] = Canonical(plan.Bindings[index], Pop(stack));
                    break;
                case PortableContractBlockInstruction contract:
                    int first = stack.Count - contract.InputTypeIndices.Count;
                    for (int i = 0; i < contract.InputTypeIndices.Count; i++)
                        if (!ConvertAt(stack, first + i, types[(int)contract.InputTypeIndices[i]].Primitive, contract.Checked))
                            return Fault("CheckedBlockInput");
                    break;
                case PortableBlockInstruction:
                case PortableOperandFreeInstruction op when op.OpCode is NOP.OP or LOOP.OP:
                    break;
                case PortableOperandFreeInstruction op when op.OpCode is IF.OP or WHILE.OP:
                    if (Pop(stack) == 0) pc = plan.Targets[site];
                    break;
                case PortableOperandFreeInstruction op when op.OpCode == ELSE.OP:
                    pc = plan.Targets[site];
                    break;
                case PortableOperandFreeInstruction op when op.OpCode == END.OP:
                case PortableControlTransferInstruction:
                    if (!ExitBlock(plan.BlockExit[site])) return Fault("CheckedBlockResult");
                    pc = plan.Targets[site];
                    break;
                case PortableStackIndexInstruction indexed:
                    ApplyIndexed(stack, indexed.StackOpCode, indexed.Index, maxStackCells);
                    break;
                case PortableExtendedStackInstruction extended:
                    ApplyIndexed(stack, extended.Operation, extended.Index, maxStackCells, extendedWord: extended.Operation == 0x11);
                    break;
                case PortableOperandFreeInstruction op when IsPrivate(op.OpCode):
                    if (!ApplyPrivate(stack, op.OpCode, maxStackCells)) return Fault("ArithmeticFault");
                    break;
                case PortableCallInstruction call:
                    if (state.Frames.Count >= maxDepth) throw new InvalidOperationException("Activation depth limit.");
                    var target = plans[call.TargetIndex];
                    var args = new ulong[target.Arguments];
                    for (int i = args.Length - 1; i >= 0; i--) args[i] = Pop(stack);
                    return new(PortableScalarBoundaryKind.Call, pc, fuel, stack, bindings, occurrence,
                        null, call.TargetIndex, args);
                case PortableReturnInstruction:
                    return new(PortableScalarBoundaryKind.Return, pc, fuel, stack, bindings, occurrence,
                        plan.ReturnType == PrimitiveType.Void ? null : Canonical(plan.ReturnType, Pop(stack)));
                case PortableOperandFreeInstruction op when op.OpCode == TRAP.OP:
                    return Fault("ExplicitTrap");
                default:
                    throw new InvalidDataException("Unexpected admitted instruction.");
            }
            if (charged + 1 == quantum)
                return new(PortableScalarBoundaryKind.Budget, pc, fuel, stack, bindings, occurrence, null);
        }
        throw new InvalidOperationException("Invalid quantum.");
    }

    private static Plan BuildPlan(PortableExecutableModule module, uint functionIndex,
        PortableInstructionOccurrence[] sites, int maxStackCells)
    {
        var function = module.Functions[(int)functionIndex];
        var code = function.Instructions.ToArray();
        if (code.Length != sites.Length) throw new InvalidDataException("Decoded code and verified boundaries disagree.");
        var bindingTypes = function.ArgumentTypeIndices.Concat(function.LocalTypeIndices)
            .Select(index => module.Types[(int)index].Primitive).ToArray();
        if (bindingTypes.Length > maxStackCells) throw new InvalidOperationException("Frame binding limit.");
        foreach (var instruction in code)
        {
            bool supported = instruction switch
            {
                PortablePushInstruction => true,
                PortableVariableInstruction => true,
                PortableMemoryInstruction memory => memory.Mode == PortableMemoryAccessMode.Binding,
                PortableBlockInstruction or PortableContractBlockInstruction => true,
                PortableCallInstruction call => call.TargetKind == PortableCallTargetKind.LocalFunction,
                PortableStackIndexInstruction indexed => indexed.StackOpCode is 0x18 or 0x1D or 0x1E,
                PortableExtendedStackInstruction extended => extended.Operation is 0x11 or 0x18 or 0x1D or 0x1E,
                PortableOperandFreeInstruction op => IsPrivate(op.OpCode) || op.OpCode is TRAP.OP or NOP.OP
                    or LOOP.OP or END.OP or IF.OP or ELSE.OP or WHILE.OP,
                PortableControlTransferInstruction transfer => transfer.Operation is BREAK.OP or CONTINUE.OP,
                PortableReturnInstruction => true,
                _ => false
            };
            if (!supported) throw new NotSupportedException($"Unsupported temporal scalar opcode 0x{instruction.OpCode:X2}.");
        }

        int[] targets = Enumerable.Range(1, code.Length).ToArray();
        var blockExit = new PortableInstruction?[code.Length];
        var scopes = new Stack<int>();
        var elseSites = new Dictionary<int, int>();
        var exits = new Dictionary<int, int>();
        var breaks = new List<(int Site, int Scope)>();
        for (int i = 0; i < code.Length; i++)
        {
            byte op = code[i].OpCode;
            if (op is LOOP.OP or WHILE.OP or IF.OP or BLOCK.OP) scopes.Push(i);
            else if (op == ELSE.OP)
            {
                int start = scopes.Peek();
                elseSites.Add(start, i);
                targets[start] = i + 1;
            }
            else if (op == END.OP)
            {
                int start = scopes.Pop();
                exits.Add(start, i + 1);
                switch (code[start].OpCode)
                {
                    case LOOP.OP: targets[i] = start + 1; break;
                    case WHILE.OP: targets[i] = start; targets[start] = i + 1; break;
                    case IF.OP:
                        if (elseSites.TryGetValue(start, out int alternative)) targets[alternative] = i + 1;
                        else targets[start] = i + 1;
                        break;
                    case BLOCK.OP: blockExit[i] = code[start]; break;
                }
            }
            else if (code[i] is PortableControlTransferInstruction transfer)
            {
                int start = scopes.Where(s => code[s].OpCode is LOOP.OP or WHILE.OP ||
                    transfer.Operation == BREAK.OP && code[s] is PortableContractBlockInstruction)
                    .ElementAt(checked((int)transfer.TargetOrdinal));
                if (transfer.Operation == CONTINUE.OP) targets[i] = code[start].OpCode == LOOP.OP ? start + 1 : start;
                else breaks.Add((i, start));
            }
        }
        foreach (var site in breaks)
        {
            targets[site.Site] = exits[site.Scope];
            if (code[site.Scope] is PortableContractBlockInstruction block) blockExit[site.Site] = block;
        }
        return new(functionIndex, code, sites, targets, blockExit,
            module.Types[(int)function.ReturnTypeIndex].Primitive, bindingTypes, function.ArgumentTypeIndices.Count);
    }

    public static PortableScalarOutcome Run(ReadOnlySpan<byte> image, IReadOnlyList<uint> functions,
        int quantum = 3, int maxEvents = 100_000, int maxInstructions = 1_000_000, bool parallel = false,
        int maxStackCells = 4096, int maxDepth = 128)
    {
        ArgumentNullException.ThrowIfNull(functions);
        if (quantum <= 0 || maxEvents <= 0 || maxInstructions <= 0 || maxStackCells <= 0 || maxDepth <= 0 ||
            functions.Count is < 1 or > 128)
            throw new ArgumentOutOfRangeException(nameof(quantum), "Invalid reference limits or context count.");
        uint[] selected = functions.ToArray();
        byte[] bytes = image.ToArray();
        var verified = PortableBinaryVerifier.IdentifyInstructions(bytes, maxInstructions, PortableExecutionProfile.DirectOnly);
        var module = PortableBinaryCodec.Decode(bytes).Executable!;
        var byFunction = verified.GroupBy(site => site.FunctionIndex).ToDictionary(g => g.Key, g => g.ToArray());
        var plans = new Dictionary<uint, Plan>();
        foreach (uint index in selected)
        {
            if (index >= (uint)module.Functions.Count) throw new InvalidDataException("Unknown function index.");
            if (module.Functions[(int)index].ArgumentTypeIndices.Count != 0)
                throw new NotSupportedException("Initial contexts require zero-argument functions.");
        }
        var pending = new Queue<uint>(selected.Distinct());
        while (pending.TryDequeue(out uint index))
        {
            if (plans.ContainsKey(index)) continue;
            var plan = BuildPlan(module, index, byFunction.GetValueOrDefault(index) ?? [], maxStackCells);
            plans.Add(index, plan);
            foreach (var call in plan.Code.OfType<PortableCallInstruction>()) pending.Enqueue(call.TargetIndex);
        }

        var coordinator = new PortableTemporalCoordinator(maxEvents);
        var identity = coordinator.Identity;
        var loaded = identity.Load(bytes, PortableExecutionProfile.DirectOnly, maxInstructions);
        var publication = coordinator.Publication;
        var states = selected.Select(index => new State(coordinator.CreateContext(), new Frame(plans[index], []))).ToArray();
        var byContext = states.ToDictionary(state => state.Context);
        var trace = new List<PortableScalarBoundary>();
        while (coordinator.LiveCount != 0)
        {
            coordinator.RunScalarRound(key => Prepare(byContext[key.Context], plans, module.Types, quantum, maxStackCells, maxDepth),
                (key, next) =>
            {
                publication.RequireCapacity();
                var state = byContext[key.Context];
                state.Fuel = next.Fuel;
                var data = new PortableScalarEventData(coordinator.Round, next.Kind, next.Fuel,
                    next.Occurrence, next.Result, next.Target, next.Fault);
                PortablePublishedEvent published;
                if (next.Kind == PortableScalarBoundaryKind.Terminate)
                {
                    coordinator.TerminateScalar(key);
                    published = coordinator.Events[^1];
                }
                else
                {
                    var frame = state.Frames.Peek();
                    frame.Pc = next.Pc;
                    if (next.Stack is not null) frame.Stack = next.Stack;
                    if (next.Bindings is not null) frame.Bindings = next.Bindings;
                    switch (next.Kind)
                    {
                        case PortableScalarBoundaryKind.Enter:
                            var entry = identity.EnterObserved(key.Context, loaded, frame.Plan.Function);
                            frame.Activation = entry.Activation;
                            published = publication.PublishScalar(entry, data);
                            break;
                        case PortableScalarBoundaryKind.Return:
                        case PortableScalarBoundaryKind.Abort:
                            bool aborted = next.Kind == PortableScalarBoundaryKind.Abort;
                            if (!aborted && next.Result.HasValue && state.Frames.Count > 1 &&
                                state.Frames.Skip(1).First().Stack.Count >= maxStackCells)
                                throw new InvalidOperationException("Evaluation stack limit.");
                            published = publication.PublishScalar(identity.CloseObserved(frame.Activation!.Value, aborted), data);
                            state.Frames.Pop();
                            if (state.Frames.Count == 0)
                            {
                                state.Result = next.Result;
                                state.TerminationPending = true;
                            }
                            else if (!aborted && next.Result is ulong result) state.Frames.Peek().Stack.Add(result);
                            break;
                        case PortableScalarBoundaryKind.Call:
                        case PortableScalarBoundaryKind.Trap:
                        case PortableScalarBoundaryKind.Budget:
                            published = publication.PublishScalar(identity.Record(frame.Activation!.Value,
                                next.Occurrence!.Value.InstructionOffset), data);
                            if (next.Kind == PortableScalarBoundaryKind.Call)
                                state.Frames.Push(new Frame(plans[next.Target!.Value], next.Arguments!));
                            if (next.Kind == PortableScalarBoundaryKind.Trap) state.AbortPending = true;
                            break;
                        default: throw new InvalidOperationException("Unknown boundary.");
                    }
                }
                trace.Add(new(coordinator.Round, next.Kind, published, next.Fuel, next.Occurrence, next.Result));
            }, parallel);
        }
        identity.Unload(loaded);
        return new PortableScalarOutcome(trace.AsReadOnly(), Array.AsReadOnly(states.Select(s => s.Result).ToArray()), coordinator.Capture());
    }
}
