using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct LOOP(UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory, IEquatable<LOOP>
        {
            public const byte OP = 0x03;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
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
                    if (operands[0] is PrimitiveType typeByte)
                    {
                        return new LOOP
                        {
                            BlockType = new(type: typeByte),
                            Variables = new([.. variables])
                        };
                    }
                }

                // t_<tipo>: tipo primitivo codificado como byte + flags
                if (operands.Length == 2)
                {
                    if (operands[0] is PrimitiveType typeByte &&
                    operands[1] is TypeModifiers flagsByte)
                    {
                        var typeWithFlags = new UType(typeByte, flagsByte, Types.FromPrimitive(typeByte), typeByte.ToString());
                        return new LOOP
                        {
                            BlockType = typeWithFlags,
                            Variables = new([.. variables])
                        };
                    }
                }

                if (operands.Length >= 2)
                {
                    if (operands[^1] is TypeModifiers flagsByte &&
                    operands[..^1].All(c => c is char))
                    {
                        var typeName = new string(operands[..^1].Cast<char>().ToArray());
                        var typeWithFlags = new UType(PrimitiveType.CustomType, flagsByte, UType.TypeIDLUT[typeName], typeName);
                        return new LOOP
                        {
                            BlockType = typeWithFlags,
                            Variables = new([.. variables])
                        };
                    }
                }


                throw new SyntaxException(0x03BADBEEF, $"LOOP opcode received unexpected number of operands: {operands.Length}");
            }


            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes)
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