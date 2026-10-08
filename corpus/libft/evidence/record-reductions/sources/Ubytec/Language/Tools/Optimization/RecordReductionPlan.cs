using System.Text;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>A closed UInt64 field reduction with a constant stride and exact scalar read ledger.</summary>
internal sealed record RecordReductionPlan(StackBinding Data, StackBinding Length,
    StackBinding Index, StackBinding Sum, int Stride, int Offset)
{
    internal static RecordReductionPlan? TryCreate(FunctionValueIR ir, ScopeContext frame,
        Argument[] arguments, LocalContext? locals, UType result)
    {
        var ops = ir.Instructions.Select(i => i.Opcode).ToArray();
        if (result.Type != PrimitiveType.UInt64 || result.Modifiers != TypeModifiers.None ||
            arguments.Length != 2 || locals?.Variables.Length != 2 ||
            locals.Value.Functions.Length != 0 || locals.Value.Actions.Length != 0 || ops.Length != 18 ||
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
            ops[4] is not StackOperations.PUSH stridePush || !TryConstant(stridePush, out int stride) || stride == 0 ||
            ops[5] is not ArithmeticOperations.MUL || ops[6] is not ArithmeticOperations.ADD ||
            ops[7] is not StackOperations.PUSH offsetPush || !TryConstant(offsetPush, out int offset) ||
            ops[8] is not ArithmeticOperations.ADD ||
            ops[9] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.UInt64 } ||
            ops[10] is not ArithmeticOperations.ADD ||
            ops[11] is not MemoryOperations.STORE { VariableName: { } storedSum, AccessType: null } ||
            ops[12] is not MemoryOperations.LOAD { VariableName: { } loadedIndex, AccessType: null } ||
            ops[13] is not ArithmeticOperations.INC ||
            ops[14] is not MemoryOperations.STORE { VariableName: { } storedIndex, AccessType: null } ||
            ops[15] is not END ||
            ops[16] is not MemoryOperations.LOAD { VariableName: { } returnedSum, AccessType: null } ||
            ops[17] is not RETURN)
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
        return new(bindings[0], bindings[1], bindings[2], bindings[3], stride, offset);
    }

    private static bool TryConstant(StackOperations.PUSH push, out int value)
    {
        value = 0;
        if (push.operands is not { Length: > 0 and <= 8 } bytes) return false;
        ulong immediate = 0;
        for (int i = 0; i < bytes.Length; i++) immediate |= (ulong)bytes[i] << (8 * i);
        if (immediate > int.MaxValue) return false;
        value = (int)immediate;
        return true;
    }

    internal string Emit(ScopeContext frame)
    {
        string loop = frame.StartLabel + "_record_reduce", done = loop + "_done";
        var output = new StringBuilder();
        output.AppendLine($"; record-reductions: scalar UInt64, stride {Stride}, offset {Offset}, observable stack retained");
        output.AppendLine($"mov rdx, qword {Data.Address}\n  mov r10, qword {Length.Address}");
        output.AppendLine($"mov r8, qword {Index.Address}\n  mov r9, qword {Sum.Address}");
        // Integer cell arithmetic wraps modulo 2^64, as in the source MUL/ADD.
        // Advancing the pointer by stride is equivalent to recomputing index*stride.
        output.AppendLine($"imul rdi, r8, {Stride}\n  add rdi, rdx\n  add rdi, {Offset}");
        output.AppendLine(loop + ":");
        output.AppendLine($"cmp r8, r10\n  jae {done}");
        // S=RBP-FrameSize. Reproduce all last writes before the single raw read:
        // [S-8]=sum, [S-16]=effective address, [S-24]=offset, [S-32]=stride.
        // This also preserves reads through aliases into locals and residual cells.
        output.AppendLine($"mov qword [rsp - 8], r9\n  mov qword [rsp - 24], {Offset}");
        output.AppendLine($"mov qword [rsp - 32], {Stride}\n  mov qword [rsp - 16], rdi");
        output.AppendLine("lea rsp, [rsp - 8]\n  mov rax, qword [rdi]");
        // Exact eight-byte load, including a load spanning a protection boundary.
        output.AppendLine("mov qword [rsp - 8], rax\n  add r9, rax");
        output.AppendLine($"mov qword {Sum.Address}, r9\n  inc r8\n  mov qword {Index.Address}, r8");
        output.AppendLine($"lea rsp, [rsp + 8]\n  mov qword [rsp - 8], r8\n  add rdi, {Stride}\n  jmp {loop}");
        output.AppendLine(done + ":");
        // Empty loops leave deeper cells intact; LOAD sum still writes the top cell.
        output.AppendLine($"mov rax, r9\n  mov qword [rsp - 8], rax\n  jmp {frame.EndLabel}");
        return output.ToString();
    }
}
