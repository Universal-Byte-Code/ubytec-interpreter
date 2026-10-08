using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>A closed ordinal record lookup with nested scalar byte comparison and exact read ledgers.</summary>
internal sealed record LookupReductionPlan(StackBinding Data, StackBinding Count, StackBinding Key,
    StackBinding Length, StackBinding Index, StackBinding Inner, StackBinding Entry, StackBinding Name,
    int Stride, int LengthOffset)
{
    internal static LookupReductionPlan? TryCreate(FunctionValueIR ir, ScopeContext frame,
        Argument[] arguments, LocalContext? locals, UType result)
    {
        var op = ir.Instructions.Select(i => i.Opcode).ToArray();
        if (result.Type != PrimitiveType.UInt64 || result.Modifiers != TypeModifiers.None ||
            arguments.Length != 4 || locals?.Variables.Length != 4 ||
            locals.Value.Functions.Length != 0 || locals.Value.Actions.Length != 0 || op.Length != 48 ||
            op[0] is not WHILE outer || op[19] is not WHILE inner || op[36] is not IF found ||
            op[1] is not MemoryOperations.LOAD { VariableName: { } data, AccessType: null } ||
            op[2] is not MemoryOperations.LOAD { VariableName: { } index, AccessType: null } ||
            op[6] is not MemoryOperations.STORE { VariableName: { } entry, AccessType: null } ||
            op[11] is not MemoryOperations.LOAD { VariableName: { } length, AccessType: null } ||
            op[16] is not MemoryOperations.STORE { VariableName: { } name, AccessType: null } ||
            op[18] is not MemoryOperations.STORE { VariableName: { } cursor, AccessType: null } ||
            op[24] is not MemoryOperations.LOAD { VariableName: { } key, AccessType: null } ||
            !Condition(outer.Condition, outer.BlockType, "<", index, null, out string count) ||
            !Condition(inner.Condition, inner.BlockType, "<", cursor, length, out _) ||
            !Condition(found.Condition, found.BlockType, "==", cursor, length, out _) ||
            op[3] is not StackOperations.PUSH stridePush || !Constant(stridePush, out int stride) || stride == 0 ||
            op[8] is not StackOperations.PUSH offsetPush || !Constant(offsetPush, out int offset) ||
            op[17] is not StackOperations.PUSH zero || !Constant(zero, out int initialCursor) || initialCursor != 0 ||
            op[46] is not StackOperations.PUSH missing || !Constant(missing, out int notFound) || notFound != 0 ||
            op[4] is not ArithmeticOperations.MUL || op[5] is not ArithmeticOperations.ADD ||
            op[9] is not ArithmeticOperations.ADD || op[12] is not ComparisonOperations.EQ ||
            op[22] is not ArithmeticOperations.ADD || op[26] is not ArithmeticOperations.ADD ||
            op[28] is not ComparisonOperations.NEQ ||
            op[33] is not ArithmeticOperations.INC || op[38] is not ArithmeticOperations.INC || op[43] is not ArithmeticOperations.INC ||
            op[10] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.UInt64 } ||
            op[15] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.UInt64 } ||
            op[23] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.Byte } ||
            op[27] is not MemoryOperations.LOAD { VariableName: null, AccessType: PrimitiveType.Byte } ||
            op[13] is not IF { Condition: null, BlockType: null } || op[29] is not IF { Condition: null, BlockType: null } ||
            op[30] is not BREAK { LabelIDx: null } || op[39] is not RETURN || op[47] is not RETURN ||
            new[] { 31,35,40,41,45 }.Any(i => op[i] is not END)) return null;
        bool Load(int i, string n) => op[i] is MemoryOperations.LOAD { VariableName: { } v, AccessType: null } && v == n;
        bool Store(int i, string n) => op[i] is MemoryOperations.STORE { VariableName: { } v, AccessType: null } && v == n;
        if (!Load(7,entry) || !Load(14,entry) || !Load(20,name) || !Load(21,cursor) || !Load(25,cursor) ||
            !Load(32,cursor) || !Load(37,index) || !Load(42,index) || !Store(34,cursor) || !Store(44,index)) return null;
        string[] names = [data,count,key,length,index,cursor,entry,name];
        if (names.Distinct(StringComparer.Ordinal).Count() != 8 ||
            names.Take(4).Any(n => !arguments.Any(a => a.Name == n)) ||
            names.Skip(4).Any(n => !locals.Value.Variables.Any(v => v.Name == n))) return null;
        var bindings = names.Select(n => frame.Symbols[n]).ToArray();
        if (bindings.Any(b => b.Type.Type != PrimitiveType.UInt64 ||
            (b.Type.Modifiers & ~(TypeModifiers.Const | TypeModifiers.ReadOnly)) != TypeModifiers.None) ||
            bindings.Skip(4).Any(b => b.ReadOnly)) return null;
        return new(bindings[0],bindings[1],bindings[2],bindings[3],bindings[4],bindings[5],bindings[6],bindings[7],stride,offset);
    }

    private static bool Condition(Ubytec.Language.Syntax.Model.SyntaxExpression? expression, UType? type,
        string relation, string leftName, string? rightName, out string right)
    {
        right = "";
        if (type is { } t && (t.Type is not (PrimitiveType.Default or PrimitiveType.UInt64) || t.Modifiers != TypeModifiers.None) ||
            expression?.Syntaxes.Count != 1 || expression.Syntaxes[0] is not ConditionExpressionFragment
                { Left: string l, Operand: { } r, Right: string v } ||
            !l.StartsWith('@') || !v.StartsWith('@') || r != relation || FunctionCode.Identifier(l) != leftName) return false;
        right = FunctionCode.Identifier(v);
        return rightName is null || right == rightName;
    }
    private static bool Constant(StackOperations.PUSH push, out int value)
    {
        value = 0;
        if (push.operands is not { Length: > 0 and <= 8 } bytes) return false;
        ulong n = 0;
        for (int i = 0; i < bytes.Length; i++) n |= (ulong)bytes[i] << (8*i);
        if (n > int.MaxValue) return false;
        value = (int)n;
        return true;
    }

    internal string Emit(ScopeContext frame)
    {
        string p = frame.StartLabel + "_lookup_reduce";
        // Only volatile integer registers and XMM0/1; R11 remains available to hosts.
        // The source has no calls, raw stores or unknown effects. Every written local
        // remains write-through, and each raw read sees the complete original ledger.
        return $$"""
            ; lookup-reductions: nested scalar bytes, stride {{Stride}}, length offset {{LengthOffset}}, observable stack retained
            mov r8, qword {{Index.Address}}
            mov rax, qword {{Data.Address}}
            imul r10, r8, {{Stride}}
            add r10, rax
            mov rcx, qword {{Count.Address}}
            mov rdx, qword {{Length.Address}}
            movq xmm0, qword {{Key.Address}}
            {{p}}_outer:
            cmp r8, rcx
            jae {{p}}_missing
            mov qword {{Entry.Address}}, r10
            mov qword [rsp - 24], {{Stride}}
            mov qword [rsp - 16], {{LengthOffset}}
            lea rax, [r10 + {{LengthOffset}}]
            mov qword [rsp - 8], rax
            ; Length read: RSP=S, ledger=(address, length offset, stride).
            mov rax, qword [rax]
            mov qword [rsp - 8], rax
            mov qword [rsp - 16], rdx
            cmp rax, rdx
            sete al
            movzx eax, al
            mov qword [rsp - 8], rax
            test eax, eax
            jz {{p}}_advance
            mov qword [rsp - 8], r10
            ; Name-pointer read retains key length and stride in the deeper cells.
            mov rax, qword [r10]
            movq xmm1, rax
            mov qword [rsp - 8], rax
            mov qword {{Name.Address}}, rax
            mov qword [rsp - 8], 0
            xor r9d, r9d
            mov qword {{Inner.Address}}, r9
            {{p}}_inner:
            cmp r9, rdx
            jae {{p}}_inner_done
            movq rax, xmm1
            add rax, r9
            mov qword [rsp - 8], rax
            mov qword [rsp - 16], r9
            ; Read the name byte first; do not prewrite the key-byte ledger.
            movzx eax, byte [rax]
            mov qword [rsp - 8], rax
            mov qword [rsp - 24], r9
            movq rax, xmm0
            add rax, r9
            mov qword [rsp - 16], rax
            lea rsp, [rsp - 8]
            ; Key read: RSP=S-8, ledger=(name byte, key address, inner index).
            movzx eax, byte [rax]
            mov qword [rsp - 8], rax
            cmp rax, qword [rsp]
            setne al
            movzx eax, al
            mov qword [rsp], rax
            lea rsp, [rsp + 8]
            test eax, eax
            jnz {{p}}_inner_done
            inc r9
            mov qword {{Inner.Address}}, r9
            mov qword [rsp - 8], r9
            jmp {{p}}_inner
            {{p}}_inner_done:
            cmp r9, rdx
            jne {{p}}_advance
            lea rax, [r8 + 1]
            mov qword [rsp - 8], rax
            jmp {{frame.EndLabel}}
            {{p}}_advance:
            inc r8
            mov qword {{Index.Address}}, r8
            mov qword [rsp - 8], r8
            add r10, {{Stride}}
            jmp {{p}}_outer
            {{p}}_missing:
            xor eax, eax
            mov qword [rsp - 8], rax
            jmp {{frame.EndLabel}}
            """ + "\n";
    }
}
