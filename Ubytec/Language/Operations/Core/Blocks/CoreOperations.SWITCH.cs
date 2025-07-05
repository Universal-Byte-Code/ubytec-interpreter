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
        public readonly record struct SWITCH(int? TableIDx, UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory
        {
            public const byte OP = 0x0B;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Caso 1: SWITCH sin operands → no hay TableIDx ni tipo
                if (operands.Length == 0)
                {
                    return new SWITCH(null)
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 2: SWITCH con solo TableIDx (entero)
                if (operands.Length == 1 && operands[0] is int tableIDx)
                {
                    return new SWITCH(tableIDx)
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 3: SWITCH con TableIDx y BlockType
                if (operands.Length == 2 && operands[0] is int tableIdx2 && operands[1] is UType blockType)
                {
                    return new SWITCH(tableIdx2, blockType)
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 4: SWITCH con solo BlockType (sin TableIDx)
                if (operands.Length == 1 && operands[0] is UType onlyBlockType)
                {
                    return new SWITCH(null, onlyBlockType)
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 5: SWITCH con TableIDx + typeByte + flagsByte
                if (operands.Length == 3 &&
                    operands[0] is int tableIdx3 &&
                    operands[1] is byte typeByte &&
                    operands[2] is byte flagsByte)
                {
                    var typeWithFlags = UType.FromOperands(typeByte, flagsByte);
                    return new SWITCH(tableIdx3, typeWithFlags)
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 6: SWITCH con tipo personalizado codificado (char[] + flags)
                if (operands.Length >= 2 &&
                    operands[^1] is byte finalFlags &&
                    operands[..^1].All(o => o is byte))
                {
                    var typeName = new string(operands[..^1].Cast<byte>().Select(b => (char)b).ToArray());
                    var typeWithFlags = new UType(PrimitiveType.CustomType, (TypeModifiers)finalFlags);
                    return new SWITCH(null, typeWithFlags)
                    {
                        Variables = new([.. variables])
                    };
                }


                throw new SyntaxException(0x0BBADBEEF, $"SWITCH opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                string switchEndLabel = TableIDx == null ? NextLabel("end_switch") : $"end_switch_{TableIDx}";
                string switchStartLabel = TableIDx == null ? NextLabel("switch") : $"switch_{TableIDx}";

                scopes.Push(new ScopeContext()
                {
                    StartLabel = switchStartLabel,
                    EndLabel = switchEndLabel,
                    ExpectedReturnType = BlockType,
                    DeclaredByKeyword = "switch"
                });

                return $"{switchStartLabel}: ; SWITCH: Salto múltiple";
            }
        }
    }
}