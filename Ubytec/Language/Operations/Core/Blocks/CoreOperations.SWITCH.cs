using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct SWITCH(int? TableIDx, UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory, IEquatable<SWITCH>
        {
            public const byte OP = 0x0B;
            public readonly byte OpCode => OP;
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length == 0) return new SWITCH(null) { Variables = new([.. variables]) };
                if (operands.Length == 1 && operands[0] is not UType and not PrimitiveType) return new SWITCH(StackCode.Index(nameof(SWITCH), operands, int.MaxValue)) { Variables = new([.. variables]) };
                if (operands.Length == 2 && operands[0] is int tableIdx2 && operands[1] is UType blockType) return new SWITCH(tableIdx2, blockType) { Variables = new([.. variables]) };
                if (operands.Length == 1 && operands[0] is UType onlyBlockType) return new SWITCH(null, onlyBlockType) { Variables = new([.. variables]) };
                if (operands.Length == 3 && operands[0] is int tableIdx3 && operands[1] is byte typeByte && operands[2] is byte flagsByte) return new SWITCH(tableIdx3, UType.FromOperands(typeByte, flagsByte)) { Variables = new([.. variables]) };
                if (TryCustomBlockType(operands, out var customBlockType)) return new SWITCH(null, customBlockType) { Variables = new([.. variables]) };
                throw new SyntaxException(0x0BBADBEEF, $"SWITCH opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }
            private static bool TryCustomBlockType(ValueType[] operands, out UType blockType)
            {
                if (operands.Length < 2 || operands[^1] is not byte flags || operands[..^1].Any(static operand => operand is not byte)) { blockType = default; return false; }
                blockType = new UType(PrimitiveType.CustomType, (TypeModifiers)flags); return true;
            }
            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                var frame = scopes.All.FirstOrDefault(x => x.DeclaredByKeyword is "func" or "action");
                if (frame is null || frame.SwitchSlots.Count == 0) throw new SyntaxStackException(0xBAD083, "SWITCH requires a preallocated function frame slot.");
                string start = NextLabel(scopes, "switch"), end = NextLabel(scopes, "end_switch");
                int offset = frame.SwitchSlots.Dequeue();
                scopes.Push(new ScopeContext { StartLabel = start, EndLabel = end, DeclaredByKeyword = "switch", LabelIndex = TableIDx, SwitchOffset = offset, ExpectedReturnType = BlockType });
                return $"{start}:\n  pop rax\n  mov qword [rbp - {-offset}], rax";
            }
        }
    }
}
