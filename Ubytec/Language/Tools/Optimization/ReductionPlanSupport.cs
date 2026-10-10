using System.Text;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>Shared recognition and emission primitives for closed scalar reduction plans.</summary>
internal static class ReductionPlanSupport
{
    internal static bool TryPrepareSimpleScalarPlan(FunctionValueIR ir, ScopeContext frame,
        Argument[] arguments, LocalContext? locals, UType result, int expectedInstructionCount,
        int tailStart, out IOpCode[] ops, out StackBinding[] bindings)
    {
        ops = ir.Instructions.Select(instruction => instruction.Opcode).ToArray();
        bindings = [];
        if (ops.Length != expectedInstructionCount || ops[0] is not WHILE loop ||
            !TryMatchAccumulatorHead(ops, out string sum, out string data, out string index) ||
            !TryMatchAccumulatorTail(ops, tailStart, out string storedSum, out string loadedIndex,
                out string storedIndex, out string returnedSum))
            return false;

        return TryResolveSimpleScalarBindings(frame, arguments, locals, result, loop,
            data, index, sum, storedSum, loadedIndex, storedIndex, returnedSum, out bindings);
    }

    private static bool TryMatchAccumulatorHead(IReadOnlyList<IOpCode> ops,
        out string sum, out string data, out string index)
    {
        sum = data = index = string.Empty;
        if (ops.Count < 4 ||
            ops[1] is not MemoryOperations.LOAD { VariableName: { } sumName, AccessType: null } ||
            ops[2] is not MemoryOperations.LOAD { VariableName: { } dataName, AccessType: null } ||
            ops[3] is not MemoryOperations.LOAD { VariableName: { } indexName, AccessType: null })
            return false;

        sum = sumName;
        data = dataName;
        index = indexName;
        return true;
    }

    private static bool TryMatchAccumulatorTail(IReadOnlyList<IOpCode> ops, int start,
        out string storedSum, out string loadedIndex, out string storedIndex, out string returnedSum)
    {
        storedSum = loadedIndex = storedIndex = returnedSum = string.Empty;
        if (start < 0 || start + 6 >= ops.Count ||
            ops[start] is not MemoryOperations.STORE { VariableName: { } sumName, AccessType: null } ||
            ops[start + 1] is not MemoryOperations.LOAD { VariableName: { } loadedName, AccessType: null } ||
            ops[start + 2] is not ArithmeticOperations.INC ||
            ops[start + 3] is not MemoryOperations.STORE { VariableName: { } storedName, AccessType: null } ||
            ops[start + 4] is not END ||
            ops[start + 5] is not MemoryOperations.LOAD { VariableName: { } returnedName, AccessType: null } ||
            ops[start + 6] is not RETURN)
            return false;

        storedSum = sumName;
        loadedIndex = loadedName;
        storedIndex = storedName;
        returnedSum = returnedName;
        return true;
    }

    private static bool TryResolveSimpleScalarBindings(ScopeContext frame, Argument[] arguments,
        LocalContext? locals, UType result, WHILE loop, string data, string index, string sum,
        string storedSum, string loadedIndex, string storedIndex, string returnedSum,
        out StackBinding[] bindings)
    {
        bindings = [];
        if (result.Type != PrimitiveType.UInt64 || result.Modifiers != TypeModifiers.None ||
            arguments.Length != 2 || locals is not { } local || local.Variables.Length != 2 ||
            local.Functions.Length != 0 || local.Actions.Length != 0 ||
            loop.Condition is not { } condition || condition.Syntaxes.Count != 1 ||
            condition.Syntaxes[0] is not ConditionExpressionFragment
                { Left: string left, Operand: "<", Right: string right } ||
            !left.StartsWith('@') || !right.StartsWith('@') ||
            loop.BlockType is { } comparison &&
                (comparison.Type is not (PrimitiveType.Default or PrimitiveType.UInt64) ||
                 comparison.Modifiers != TypeModifiers.None))
            return false;

        string length = FunctionCode.Identifier(right);
        string[] names = [data, length, index, sum];
        if (FunctionCode.Identifier(left) != index || storedSum != sum || loadedIndex != index ||
            storedIndex != index || returnedSum != sum ||
            names.Distinct(StringComparer.Ordinal).Count() != names.Length ||
            !arguments.Any(a => a.Name == data) || !arguments.Any(a => a.Name == length) ||
            !local.Variables.Any(v => v.Name == index) || !local.Variables.Any(v => v.Name == sum))
            return false;

        var resolved = names.Select(name => frame.Symbols[name]).ToArray();
        if (resolved.Any(binding => binding.Type.Type != PrimitiveType.UInt64 ||
            (binding.Type.Modifiers & ~(TypeModifiers.Const | TypeModifiers.ReadOnly)) != TypeModifiers.None) ||
            resolved[2].ReadOnly || resolved[3].ReadOnly)
            return false;

        bindings = resolved;
        return true;
    }

    internal static (StringBuilder Output, string Loop, string Done) BeginAccumulatorEmitter(
        ScopeContext frame, string suffix, string description, StackBinding data,
        StackBinding length, StackBinding index, StackBinding sum, string? preheader = null)
    {
        string loop = frame.StartLabel + suffix;
        string done = loop + "_done";
        var output = new StringBuilder();
        output.AppendLine(description);
        output.AppendLine($"mov rdx, qword {data.Address}");
        output.AppendLine($"mov r10, qword {length.Address}");
        output.AppendLine($"mov r8, qword {index.Address}");
        output.AppendLine($"mov r9, qword {sum.Address}");
        if (preheader is not null)
            output.AppendLine(preheader);
        output.AppendLine(loop + ":");
        output.AppendLine($"cmp r8, r10\n  jae {done}");
        return (output, loop, done);
    }

    internal static string CompleteAccumulatorEmitter(StringBuilder output, string done,
        ScopeContext frame)
    {
        output.AppendLine(done + ":");
        output.AppendLine($"mov rax, r9\n  mov qword [rsp - 8], rax\n  jmp {frame.EndLabel}");
        return output.ToString();
    }
}
