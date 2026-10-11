using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BLOCK(UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory, IEquatable<BLOCK>
        {
            public const byte OP = 0x02;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length == 0)
                    return new BLOCK { Variables = new([.. variables]) };

                if (operands.Length == 1 && operands[0] is PrimitiveType typeByte)
                    return new BLOCK { BlockType = new(type: typeByte), Variables = new([.. variables]) };

                if (operands.Length == 2 && operands[0] is PrimitiveType primitive && operands[1] is TypeModifiers flags)
                {
                    var typeWithFlags = new UType(primitive, flags, Types.FromPrimitive(primitive), primitive.ToString());
                    return new BLOCK { BlockType = typeWithFlags, Variables = new([.. variables]) };
                }

                if (operands.Length >= 2 && operands[^1] is TypeModifiers customFlags && operands[..^1].All(o => o is char))
                {
                    var typeName = new string(operands[..^1].Cast<char>().ToArray());
                    var typeWithFlags = new UType(PrimitiveType.CustomType, customFlags, UType.TypeIDLUT[typeName], typeName);
                    return new BLOCK { BlockType = typeWithFlags, Variables = new([.. variables]) };
                }

                throw new SyntaxException(0x02BADBEEF,
                    $"BLOCK opcode received unrecognized operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                string blockLabel = NextLabel(scopes, "block");
                string endLabel = NextLabel(scopes, "end_block");
                scopes.Push(new() { StartLabel = blockLabel, EndLabel = endLabel, ExpectedReturnType = BlockType, DeclaredByKeyword = "block" });
                return $"{blockLabel}: ; BLOCK start";
            }
        }
    }
}
