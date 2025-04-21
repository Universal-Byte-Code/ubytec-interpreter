using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct LOOP(UbytecType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x03;

            public static LOOP CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Caso 1: LOOP sin tipo explícito
                if (operands.Length == 0)
                {
                    return new LOOP
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 2: LOOP con tipo de bloque explícito
                if (operands.Length == 1)
                {
                    var blockType = (PrimitiveType)operands[0];
                    return new LOOP
                    {
                        BlockType = new(type: blockType),
                        Variables = new([.. variables])
                    };
                }

                if (operands.Length >= 2 &&
                    operands[^1] is byte finalFlags &&
                    operands[..^1].All(o => o is byte))
                {
                    var typeName = new string(operands[..^1].Cast<byte>().Select(b => (char)b).ToArray());
                    var typeWithFlags = new UbytecType(PrimitiveType.CustomType, (TypeModifiers)finalFlags);
                    return new LOOP
                    {
                        BlockType = typeWithFlags,
                        Variables = new([.. variables])
                    };
                }


                throw new SyntaxException(0x03BADBEEF, $"LOOP opcode received unexpected number of operands: {operands.Length}");
            }


            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);
            string IOpCode.Compile(CompilationScopes scopes)
            {
                string loopStartLabel = NextLabel("loop");
                string loopEndLabel = NextLabel("end_loop");

                scopes.Push(new() 
                {
                    StartLabel = loopStartLabel,
                    EndLabel = loopEndLabel,
                    ExpectedReturnType = BlockType,
                    DeclaredByKeyword = "loop"
                });

                return $"{loopStartLabel}: ; LOOP start";
            }
        }
    }
}