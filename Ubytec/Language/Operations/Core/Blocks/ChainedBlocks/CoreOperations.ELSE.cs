using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct ELSE(UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x05;

            public static ELSE CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Caso 1: ELSE sin tipo explícito
                if (operands.Length == 0)
                {
                    return new ELSE
                    {
                        BlockType = new(type: PrimitiveType.Default),
                        Variables = new([.. variables])
                    };
                }

                // Caso 2: ELSE con tipo de bloque explícito
                if (operands.Length == 1 && operands[0] is PrimitiveType blockType)
                {
                    return new ELSE
                    {
                        BlockType =  new(type: blockType),
                        Variables = new([.. variables])
                    };
                }

                throw new SyntaxException(0x05BADBEEF, $"ELSE opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                if (!ValidateConditionalBlockType(BlockType?.Type == PrimitiveType.Default ?
                    PrimitiveType.Bool :
                    BlockType?.Type ?? PrimitiveType.Bool))
                    throw new SyntaxStackException(0x05BAD1CE, $"Invalid ELSE blockType {BlockType}");

                if (scopes.Count == 0)
                    throw new SyntaxStackException(0x05FACADE, "ELSE without matching IF");
                var (scope, _) = scopes.Pop();
                if (scope.DeclaredByKeyword != "if")
                    throw new SyntaxStackException(0x051F1F1F, "ELSE without preceding IF block");

                var elseEndLabel = NextLabel("end_else");
                var elseStartLabel = NextLabel("else");

                scopes.Push(new()
                {
                    StartLabel = elseStartLabel,
                    EndLabel = elseEndLabel,
                    ExpectedReturnType = BlockType?.Type != PrimitiveType.Default
                        ? BlockType
                        : scope.ExpectedReturnType,
                    DeclaredByKeyword = "else"
                });

                return $"  jmp {elseEndLabel}     ; Jump over ELSE part\n{scope.EndLabel}:    ; {scope.StartLabel} END\n{elseStartLabel}:  ; Start ELSE block";
            }
        }
    }
}