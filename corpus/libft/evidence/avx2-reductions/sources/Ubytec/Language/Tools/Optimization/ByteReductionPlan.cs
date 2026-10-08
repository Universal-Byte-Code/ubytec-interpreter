using System.Text;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>A scalar byte reduction with an explicit observable-stack ledger.</summary>
internal sealed record ByteReductionPlan(StackBinding Data, StackBinding Length,
    StackBinding Index, StackBinding Sum)
{
    internal static ByteReductionPlan? TryCreate(FunctionValueIR ir, ScopeContext frame,
        Argument[] arguments, LocalContext? locals, UType result)
    {
        // Recognize operations and bindings, never function names or benchmark inputs.
        // Keep the initial implementation deliberately closed to extra effects/branches.
        var ops = ir.Instructions.Select(i => i.Opcode).ToArray();
        if (result.Type != PrimitiveType.UInt64 || result.Modifiers != TypeModifiers.None ||
            arguments.Length != 2 || locals?.Variables.Length != 2 ||
            locals.Value.Functions.Length != 0 || locals.Value.Actions.Length != 0 || ops.Length != 14 ||
            ops[0] is not WHILE { Condition: { } condition } loop ||
            condition.Syntaxes.Count != 1 || condition.Syntaxes[0] is not ConditionExpressionFragment
                { Left: string left, Operand: "<", Right: string right } ||
            !left.StartsWith('@') || !right.StartsWith('@') ||
            loop.BlockType is { } comparison &&
                (comparison.Type is not (PrimitiveType.Default or PrimitiveType.UInt64) ||
                 comparison.Modifiers != TypeModifiers.None) ||
            ops[1] is not MemoryOperations.LOAD { VariableName: { } sum, AccessType: null } ||
            ops[2] is not MemoryOperations.LOAD { VariableName: { } data, AccessType: null } ||
            ops[3] is not MemoryOperations.LOAD { VariableName: { } index, AccessType: null } ||
            ops[4] is not ArithmeticOperations.ADD ||
            ops[5] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.Byte } ||
            ops[6] is not ArithmeticOperations.ADD ||
            ops[7] is not MemoryOperations.STORE { VariableName: { } storedSum, AccessType: null } ||
            ops[8] is not MemoryOperations.LOAD { VariableName: { } loadedIndex, AccessType: null } ||
            ops[9] is not ArithmeticOperations.INC ||
            ops[10] is not MemoryOperations.STORE { VariableName: { } storedIndex, AccessType: null } ||
            ops[11] is not END ||
            ops[12] is not MemoryOperations.LOAD { VariableName: { } returnedSum, AccessType: null } ||
            ops[13] is not RETURN)
            return null;

        string length = FunctionCode.Identifier(right);
        if (FunctionCode.Identifier(left) != index || storedSum != sum || loadedIndex != index ||
            storedIndex != index || returnedSum != sum ||
            new[] { data, length, index, sum }.Distinct(StringComparer.Ordinal).Count() != 4 ||
            !arguments.Any(a => a.Name == data) || !arguments.Any(a => a.Name == length) ||
            !locals.Value.Variables.Any(v => v.Name == index) || !locals.Value.Variables.Any(v => v.Name == sum))
            return null;
        var bindings = new[] { data, length, index, sum }.Select(n => frame.Symbols[n]).ToArray();
        if (bindings.Any(b => b.Type.Type != PrimitiveType.UInt64 ||
            (b.Type.Modifiers & ~(TypeModifiers.Const | TypeModifiers.ReadOnly)) != TypeModifiers.None) ||
            bindings[2].ReadOnly || bindings[3].ReadOnly)
            return null;
        return new(bindings[0], bindings[1], bindings[2], bindings[3]);
    }

    internal string Emit(ScopeContext frame)
    {
        string loop = frame.StartLabel + "_byte_reduce", done = loop + "_done";
        var output = new StringBuilder();
        output.AppendLine("; loop-reductions: scalar bytes, observable stack retained");
        output.AppendLine($"mov rdx, qword {Data.Address}");
        output.AppendLine($"mov r10, qword {Length.Address}");
        output.AppendLine($"mov r8, qword {Index.Address}");
        output.AppendLine($"mov r9, qword {Sum.Address}");
        output.AppendLine(loop + ":");
        output.AppendLine($"cmp r8, r10\n  jae {done}");

        // S = RBP - FrameSize. Before the raw byte read, the original backend has:
        // [S-8] = sum, [S-16] = data+index, [S-24] = index, RSP = S-8.
        // Earlier writes to these same ordinary RAM cells cannot be observed by this
        // closed instruction sequence. Reproduce its last writes before the read.
        output.AppendLine("mov qword [rsp - 8], r9");
        output.AppendLine("mov qword [rsp - 24], r8");
        output.AppendLine("mov rcx, r8\n  mov rax, rdx\n  add rax, rcx");
        output.AppendLine("mov qword [rsp - 16], rax\n  lea rsp, [rsp - 8]");
        // Read exactly one byte in the original order, including address wrapping.
        // A failing read sees the original frame, stack bytes, RSP and effective address.
        output.AppendLine("movzx eax, byte [rax]");
        output.AppendLine("mov qword [rsp - 8], rax\n  add r9, rax");
        output.AppendLine($"mov qword {Sum.Address}, r9");
        output.AppendLine("inc r8");
        output.AppendLine($"mov qword {Index.Address}, r8");
        // Back edge: [S-8]=next index, [S-16]=last byte, [S-24]=previous index.
        output.AppendLine($"lea rsp, [rsp + 8]\n  mov qword [rsp - 8], r8\n  jmp {loop}");
        output.AppendLine(done + ":");
        // LOAD sum; RETURN leaves the returned value in the consumed top cell,
        // even for an empty loop. Preserve the deeper residual bytes as well.
        output.AppendLine($"mov rax, r9\n  mov qword [rsp - 8], rax\n  jmp {frame.EndLabel}");
        return output.ToString();
    }
}
