using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct RETURN(UType? BlockType = null, SyntaxExpression? Variables = null) : IOpVariableScope, IOpCodeFactory, IEquatable<RETURN>
        {
            public const byte OP = 0x09;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Caso 1: sin operandos, solo variables
                if (operands.Length == 0)
                {
                    return new RETURN
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 2: un único tipo explícito como retorno
                if (operands.Length == 1 && operands[0] is UType blockType)
                {
                    return new RETURN
                    {
                        BlockType = blockType,
                        Variables = new([.. variables])
                    };
                }

                throw new SyntaxException(0x09BADBEEF, $"RETURN opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                if (scopes.Count == 0)
                    throw new SyntaxStackException(0x09FACADE, "RETURN found without any open block context");

                scopes.PushReturn(this);

                var functionBlock = scopes.Peek();

                var expectedType = functionBlock.ExpectedReturnType;
                var actualType = BlockType ?? new UType(PrimitiveType.Void, TypeModifiers.None);

                // Validate primitive vs. custom type nature
                if ((expectedType?.Type == PrimitiveType.CustomType) != (actualType.Type == PrimitiveType.CustomType))
                    throw new SyntaxStackException(0x09BAD1C3, "Type mismatch: expected and actual return types differ in kind (custom vs. primitive)");

                // Validate exact primitive/custom type
                if (expectedType?.Type != actualType.Type)
                    throw new SyntaxStackException(0x09BADCAB1E, $"Expected type '{expectedType?.Type}', got '{actualType.Type}'.");

                // Validate nullability
                bool expectedNullable = expectedType?.Modifiers.HasFlag(TypeModifiers.Nullable) ?? false;
                bool actualNullable = actualType.Modifiers.HasFlag(TypeModifiers.Nullable);

                if (expectedNullable != actualNullable)
                    throw new SyntaxStackException(0x09DEADFA11, $"Nullability mismatch: expected {(expectedNullable ? "nullable" : "non-null")}, got {(actualNullable ? "nullable" : "non-null")}.");

                // Validate array-ness
                bool expectedArray = expectedType?.Modifiers.HasFlag(TypeModifiers.IsArray) ?? false;
                bool actualArray = actualType.Modifiers.HasFlag(TypeModifiers.IsArray);

                if (expectedArray != actualArray)
                    throw new SyntaxStackException(0x09BADA11, $"Array mismatch: expected {(expectedArray ? "array" : "single value")}, got {(actualArray ? "array" : "single value")}.");

                // Validate custom flags (nullable-array, nullable-items, etc.)
                foreach (var flag in Enum.GetValues<TypeModifiers>())
                {
                    if (!flag.HasFlag(TypeModifiers.Nullable) && !flag.HasFlag(TypeModifiers.IsArray)) continue;

                    bool expectedFlag = expectedType?.Modifiers.HasFlag(flag) ?? false;
                    bool actualFlag = actualType.Modifiers.HasFlag(flag);

                    if (expectedFlag != actualFlag)
                    {
                        throw new SyntaxStackException(0x09BADF11A, $"Modifier mismatch on '{flag}': expected {(expectedFlag ? "present" : "absent")}, got {(actualFlag ? "present" : "absent")}.");
                    }
                }

                ValidateCasts((byte)(expectedType?.Type ?? PrimitiveType.Void), (byte)actualType.Type);

                var funcBlock = scopes.Find(ctx =>
                    ctx.StartLabel.StartsWith("block") || ctx.StartLabel.StartsWith("func_"))
                    ?? throw new SyntaxStackException(0x09BADB10C, "RETURN without a valid block boundary");

                return $"  pop rax   ; RETURN value\n  ret\n{funcBlock.EndLabel}: ; End of function => {funcBlock.StartLabel}";
            }
        }
    }
}
