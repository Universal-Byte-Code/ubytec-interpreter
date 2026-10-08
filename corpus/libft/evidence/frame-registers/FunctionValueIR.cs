using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Operations.CoreOperations;

namespace Ubytec.Language.Tools.Optimization;

[Flags]
internal enum ValueEffects
{
    None = 0, Stack = 1, ReadFrame = 2, WriteFrame = 4, ReadRaw = 8,
    WriteRaw = 16, Call = 32, Control = 64, Unknown = 128
}

/// <summary>Source-level effects retained before register selection and NASM lowering.</summary>
internal sealed record ValueInstruction(IOpCode Opcode, ValueEffects Effects,
    string[] Reads, string[] Writes, int LoopDepth, string[] Clobbers);

/// <summary>A conservative structured-function effect IR; not an SSA or memory-alias solver.</summary>
internal sealed class FunctionValueIR
{
    internal List<ValueInstruction> Instructions { get; } = [];

    internal static FunctionValueIR Lower(SyntaxSentence definition)
    {
        var ir = new FunctionValueIR();
        void Visit(SyntaxNode node, int depth)
        {
            if (node.Entity is IOpCode op)
            {
                if (op is WHILE or LOOP) depth++;
                string[] reads = op switch
                {
                    MemoryOperations.LOAD { VariableName: { } name } => [name],
                    WHILE { Condition: { } condition } => ConditionReads(condition),
                    IF { Condition: { } condition } => ConditionReads(condition),
                    _ => []
                };
                string[] writes = op switch
                {
                    MemoryOperations.STORE { VariableName: { } name } => [name],
                    VAR variable => [variable.Variable.Name],
                    _ => []
                };
                ValueEffects effects = op switch
                {
                    MemoryOperations.LOAD { VariableName: null } => ValueEffects.Stack | ValueEffects.ReadRaw,
                    MemoryOperations.LOAD => ValueEffects.Stack | ValueEffects.ReadFrame,
                    MemoryOperations.STORE { VariableName: null } => ValueEffects.Stack | ValueEffects.WriteRaw,
                    MemoryOperations.STORE or VAR => ValueEffects.WriteFrame | ValueEffects.Stack,
                    FunctionOperations.CALL or FunctionOperations.CALLI => ValueEffects.Call,
                    FunctionOperations.FNADDR => ValueEffects.Stack,
                    WHILE or LOOP or IF or ELSE or BLOCK or END or BREAK or CONTINUE or RETURN or TRAP => ValueEffects.Control,
                    CLEAR or NULL or DEFAULT => ValueEffects.Stack,
                    _ => op.GetType().DeclaringType == typeof(StackOperations) ||
                        op.GetType().DeclaringType == typeof(ArithmeticOperations) ||
                        op.GetType().DeclaringType == typeof(BitwiseOperations) ||
                        op.GetType().DeclaringType == typeof(ComparisonOperations) ||
                        op.GetType().DeclaringType == typeof(ExtendedStackOperations)
                            ? ValueEffects.Stack : ValueEffects.Unknown
                };
                if (reads.Length != 0) effects |= ValueEffects.ReadFrame;
                string[] clobbers = op switch
                {
                    StackOperations.TwoSWAP => ["r8"],
                    StackOperations.TwoROT => ["r8", "r9", "r10"],
                    _ => []
                };
                ir.Instructions.Add(new(op, effects, reads, writes, depth, clobbers));
            }
            foreach (var child in node.Children ?? []) Visit(child, depth);
        }
        void Sentence(SyntaxSentence sentence)
        {
            foreach (var node in sentence.Nodes.Reverse()) Visit(node, 0);
            foreach (var child in sentence.Sentences) Sentence(child);
        }
        Sentence(definition);
        return ir;
    }

    private static string[] ConditionReads(SyntaxExpression expression) => expression.Syntaxes
        .OfType<ConditionExpressionFragment>()
        .SelectMany(condition => new[] { condition.Left, condition.Right })
        .Select(value => Convert.ToString(value, System.Globalization.CultureInfo.InvariantCulture) ?? "")
        .Where(value => value.StartsWith('@')).Select(FunctionCode.Identifier).ToArray();
}
