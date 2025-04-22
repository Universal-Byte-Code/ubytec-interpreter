using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using static Ubytec.Language.Syntax.TypeSystem.Types;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BLOCK(UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x02;

            public static BLOCK CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Sin tipo explícito
                if (operands.Length == 0)
                {
                    return new BLOCK
                    {
                        Variables = new([.. variables])
                    };
                }

                // t_<tipo>: tipo primitivo codificado como byte + flags
                if (operands.Length == 2 &&
                    operands[0] is byte typeByte &&
                    operands[1] is byte flagsByte)
                {
                    var typeWithFlags = UType.FromOperands(typeByte, flagsByte);
                    return new BLOCK
                    {
                        BlockType = typeWithFlags,
                        Variables = new([.. variables])
                    };
                }

                // Tipos personalizados: secuencia de bytes y el último es el flags
                if (operands.Length >= 2 &&
                    operands[^1] is byte finalFlags &&
                    operands[..^1].All(o => o is byte))
                {
                    var typeName = new string(operands[..^1].Cast<byte>().Select(b => (char)b).ToArray());
                    var typeWithFlags = new UType(PrimitiveType.Default, (TypeModifiers)finalFlags);

                    // En este punto se asume que el tipo personalizado será manejado por su nombre y sus flags
                    // Si necesitas guardar el nombre, podrías extender BLOCK con otra propiedad opcional: `CustomTypeName`

                    return new BLOCK
                    {
                        BlockType = typeWithFlags,
                        Variables = new([.. variables])
                    };
                }

                throw new SyntaxException(0x02BADBEEF,
                    $"BLOCK opcode received unrecognized operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                string blockLabel = NextLabel("block");
                string endLabel = NextLabel("end_block");

                scopes.Push(new()
                {
                    StartLabel = blockLabel,
                    EndLabel = endLabel,
                    ExpectedReturnType = BlockType,
                    DeclaredByKeyword = "block"
                });

                return $"{blockLabel}: ; BLOCK start";
            }

        }
    }
}
