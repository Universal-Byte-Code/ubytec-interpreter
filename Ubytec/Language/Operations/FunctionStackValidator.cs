using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations;

/// <summary>Checks evaluation stack depths across structured function control flow.</summary>
internal static class FunctionStackValidator
{
    private sealed class FlowContext(string kind, int? label, int breakDepth, int? continueDepth)
    {
        internal string Kind { get; } = kind;
        internal int? Label { get; } = label;
        internal int BreakDepth { get; } = breakDepth;
        internal int? ContinueDepth { get; } = continueDepth;
        internal bool HasBreak { get; set; }
    }
    internal static void Validate(SyntaxSentence definition, CompilationScopes scopes, UType result)
    {
        var controls = new List<FlowContext>();
        int? Visit(IEnumerable<SyntaxNode> nodes, int? state)
        {
            foreach (var node in nodes)
            {
                if (state is null) break; // Remaining statements are unreachable.
                int depth = state.Value;
                var children = node.Children ?? [];
                if (node.Entity is null or BLOCK)
                {
                    state = Visit(children, depth);
                    if (node.Entity is BLOCK { BlockType: { } blockType } && state is not null)
                    {
                        if (blockType.Type != PrimitiveType.Void && !FunctionCode.IsCellType(blockType))
                            throw new SyntaxException(0xBAD08D, "Unsupported typed BLOCK result.");
                        int expected = depth + (blockType.Type == PrimitiveType.Void ? 0 : 1);
                        if (state != expected) throw new SyntaxException(0xBAD08E, "BLOCK does not produce its declared result count.");
                    }
                    continue;
                }
                if (node.Entity is not IOpCode op) continue;
                void Need(int cells)
                {
                    if (depth < cells)
                        throw new SyntaxException(0xBAD077, $"{op.GetType().Name} needs {cells} stack cell(s), but only {depth} are available.");
                }
                if (op is IF conditional)
                {
                    int consumed = conditional.Condition is null ? 1 : 0;
                    Need(consumed);
                    depth -= consumed;
                    int alternate = children.FindIndex(x => x.Entity is ELSE);
                    int? left = Visit(alternate < 0 ? children : children.Take(alternate), depth);
                    int? right = alternate < 0 ? depth : Visit(children.Skip(alternate + 1), depth);
                    if (left is not null && right is not null && left != right)
                        throw new SyntaxException(0xBAD078, "IF branches leave different evaluation stack depths.");
                    state = left ?? right;
                    continue;
                }
                if (op is LOOP or WHILE)
                {
                    var w = op is WHILE loop ? loop : (WHILE?)null;
                    int consumed = w is { Condition: null } ? 1 : 0;
                    Need(consumed);
                    int exit = depth - consumed;
                    var context = new FlowContext("loop", w?.LabelIDxs is { Length: 1 } ids ? ids[0] : null, exit, depth);
                    controls.Add(context);
                    int? back;
                    try { back = Visit(children, exit); }
                    finally { controls.RemoveAt(controls.Count - 1); }
                    if (back is not null && back != depth)
                        throw new SyntaxException(0xBAD086, "Loop back edge changes evaluation stack depth.");
                    state = op is WHILE || context.HasBreak ? exit : null;
                    continue;
                }
                if (op is SWITCH selection)
                {
                    Need(1);
                    int baseline = depth - 1;
                    var context = new FlowContext("switch", selection.TableIDx, baseline, null);
                    controls.Add(context);
                    var outcomes = new List<int?>();
                    bool hasDefault = false;
                    try
                    {
                        for (int i = 0; i < children.Count; i++)
                        {
                            var child = children[i];
                            if (child.Entity is END) continue;
                            if (child.Entity is BRANCH branch && !hasDefault)
                            {
                                var branchContext = new FlowContext("branch", branch.LabelIDx, baseline, null);
                                controls.Add(branchContext);
                                try { outcomes.Add(Visit(child.Children ?? [], baseline)); }
                                finally { controls.RemoveAt(controls.Count - 1); }
                                if (branchContext.HasBreak) outcomes.Add(baseline);
                            }
                            else if (child.Entity is DEFAULT && !hasDefault)
                            {
                                hasDefault = true;
                                outcomes.Add(Visit(children.Skip(i + 1), baseline));
                                break;
                            }
                            else throw new SyntaxException(0xBAD087, "SWITCH expects BRANCH blocks followed by an optional DEFAULT.");
                        }
                    }
                    finally { controls.RemoveAt(controls.Count - 1); }
                    if (!hasDefault || context.HasBreak) outcomes.Add(baseline);
                    var depths = outcomes.Where(x => x is not null).Distinct().ToArray();
                    if (depths.Length > 1) throw new SyntaxException(0xBAD088, "SWITCH paths leave different stack depths.");
                    state = depths.Length == 0 ? null : depths[0];
                    continue;
                }
                if (op is BREAK or CONTINUE)
                {
                    bool continuing = op is CONTINUE;
                    int? label = op is BREAK b ? b.LabelIDx : ((CONTINUE)op).LabelIDx;
                    var target = controls.LastOrDefault(x =>
                        (!continuing || x.Kind == "loop") && (label is null || x.Label == label));
                    if (target is null) throw new SyntaxException(0xBAD089, "Control transfer has no enclosing target.");
                    int expected = continuing ? target.ContinueDepth!.Value : target.BreakDepth;
                    if (depth != expected) throw new SyntaxException(0xBAD08A, "Control transfer changes target evaluation stack depth.");
                    if (!continuing) target.HasBreak = true;
                    state = null;
                    continue;
                }
                if (op is BRANCH or ELSE)
                    throw new SyntaxException(0xBAD08B, "Branch marker outside its owning control structure.");
                if (op is RETURN)
                {
                    Need(result.Type == PrimitiveType.Void ? 0 : 1);
                    state = null;
                    continue;
                }
                if (op is TRAP) { state = null; continue; }
                if (op is CLEAR) { state = 0; continue; }
                if (op is FunctionOperations.CALL call)
                {
                    var target = scopes.ResolveCallable(call.FunctionName);
                    Need(target.ArgumentCount);
                    state = depth - target.ArgumentCount + (target.ReturnType.Type == PrimitiveType.Void ? 0 : 1);
                    continue;
                }
                if (op is FunctionOperations.FNADDR address)
                {
                    scopes.ResolveCallable(address.FunctionName);
                    state = depth + 1;
                    continue;
                }
                if (op is FunctionOperations.CALLI indirect)
                {
                    indirect.Validate();
                    Need(indirect.ArgumentCount + 1);
                    state = depth - indirect.ArgumentCount - 1 + (indirect.ReturnType == PrimitiveType.Void ? 0 : 1);
                    continue;
                }
                if (op is MemoryOperations.LOAD load)
                {
                    if (load.VariableName is null) Need(1);
                    state = depth + (load.VariableName is null ? 0 : 1);
                    continue;
                }
                if (op is MemoryOperations.STORE store)
                {
                    int consumed = store.VariableName is null ? 2 : 1;
                    Need(consumed);
                    state = depth - consumed;
                    continue;
                }
                if (op is ExtendedStackOperations.PUSH16 word)
                {
                    Need((word.StackIndex + 2 + 7) / 8);
                    state = depth + 1;
                    continue;
                }
                if (op is ExtendedStackOperations.DROP16 drop) { Need(drop.StackIndex + 1); state = depth - 1; continue; }
                if (op is ExtendedStackOperations.PICK16 pick) { Need(pick.N + 1); state = depth + 1; continue; }
                if (op is ExtendedStackOperations.ROLL16 roll) { Need(roll.N + 1); continue; }

                (int required, int delta) = op switch
                {
                    NULL or DEFAULT or StackOperations.PUSH => (0, 1),
                    StackOperations.POP => (1, -1),
                    StackOperations.DUP => (1, 1),
                    StackOperations.SWAP => (2, 0),
                    StackOperations.ROT => (3, 0),
                    StackOperations.OVER => (2, 1),
                    StackOperations.NIP => (2, -1),
                    StackOperations.DROP x => (x.stackIndex + 1, -1),
                    StackOperations.TwoDUP => (2, 2),
                    StackOperations.TwoSWAP => (4, 0),
                    StackOperations.TwoROT => (6, 0),
                    StackOperations.TwoOVER => (4, 2),
                    StackOperations.PICK x => (x.n + 1, 1),
                    StackOperations.ROLL x => (x.n + 1, 0),
                    _ when op.OpCode is >= 0x20 and <= 0x24 or >= 0x30 and <= 0x32 or 0x29 or 0x2A or >= 0x34 and <= 0x36 or >= 0x40 and <= 0x49 => (2, -1),
                    _ when op.OpCode is >= 0x25 and <= 0x28 or 0x33 => (1, 0),
                    _ => (0, 0)
                };
                Need(required);
                state = depth + delta;
            }
            return state;
        }

        int? current = Visit(definition.Nodes.Reverse(), 0);
        foreach (var child in definition.Sentences) current = Visit(child.Nodes.Reverse(), current);
        if (result.Type != PrimitiveType.Void && current is not null)
            throw new SyntaxException(0xBAD06D, "Non-void function has a reachable path without RETURN.");
    }
}
