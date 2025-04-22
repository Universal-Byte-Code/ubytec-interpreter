using System.Text;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct IF() : IBlockOpCode, IOpInheritance
        {
            public readonly UType? BlockType { get; init; } = null;
            public readonly SyntaxExpression? Condition { get; init; } = null;
            public readonly SyntaxExpression? Variables { get; init; } = null;
            public readonly byte OpCode => 0x04;

            public static IF CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // IF sin condición ni tipo explícito
                if (operands.Length == 0)
                {
                    return new IF
                    {
                        Variables = new([.. variables])
                    };
                }

                // IF con condición básica (4 operandos)
                if (operands.Length == 4)
                {
                    var left = operands[0];
                    var opLower = Convert.ToByte(operands[1]);
                    var opUpper = Convert.ToByte(operands[2]);
                    var right = operands[3];

                    string equals = opUpper == 0 ? new string([(char)opLower]) : new string([(char)opLower, (char)opUpper]);

                    return new IF
                    {
                        BlockType = new(type: PrimitiveType.Default),
                        Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }),
                        Variables = new([.. variables])
                    };
                }

                // IF con tipo explícito y condición (5 operandos)
                if (operands.Length == 5 && operands[0] is PrimitiveType blockType)
                {
                    var left = operands[1];
                    var opLower = Convert.ToByte(operands[2]);
                    var opUpper = Convert.ToByte(operands[3]);
                    var right = operands[4];

                    string equals = opUpper == 0 ? new string([(char)opLower]) : new string([(char)opLower, (char)opUpper]);

                    return new IF
                    {
                        BlockType = new(type: blockType),
                        Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }),
                        Variables = new([.. variables])
                    };
                }

                // IF con TypeWithFlags desde 2 bytes: tipo y flags
                if (operands.Length == 2 && operands[0] is byte typeByte && operands[1] is byte flagsByte)
                {
                    var typeWithFlags = UType.FromOperands(typeByte, flagsByte);
                    return new IF
                    {
                        BlockType = typeWithFlags,
                        Variables = new([.. variables])
                    };
                }

                // IF con tipo personalizado codificado como bytes + flag final
                if (operands.Length >= 2 && operands[^1] is byte finalFlags && operands[..^1].All(o => o is byte))
                {
                    var typeName = new string(operands[..^1].Cast<byte>().Select(b => (char)b).ToArray());
                    var typeWithFlags = new UType(PrimitiveType.CustomType, (TypeModifiers)finalFlags);
                    return new IF
                    {
                        BlockType = typeWithFlags,
                        Variables = new([.. variables])
                    };
                }

                throw new SyntaxException(0x04BADBEEF, $"IF opcode received unexpected number of operands: {operands.Length}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                if (!ValidateConditionalBlockType(BlockType?.Type == PrimitiveType.Default ?
                    PrimitiveType.Bool :
                    BlockType?.Type ?? PrimitiveType.Bool))
                    throw new SyntaxStackException(0x04BAD1CE, $"Invalid IF blockType {BlockType}");

                string ifEndLabel = NextLabel("end_if");
                string ifLabel = NextLabel("if");

                scopes.Push(new()
                {
                    StartLabel = ifLabel,
                    EndLabel = ifEndLabel,
                    ExpectedReturnType = BlockType?.Type != PrimitiveType.Default
                        ? BlockType
                        : scopes.PeekOrDefault()?.ExpectedReturnType,
                    DeclaredByKeyword = "if"
                });

                var raxHandling = "  pop rax; IF condition";
                if (Condition != null)
                {
                    var finalCondition = new StringBuilder();
                    foreach (ConditionExpressionFragment conditionFragment in Condition.Syntaxes.Select(v => (ConditionExpressionFragment)v))
                    {
                        var dereferencedConditionFragment = ProcessFragmentDereference(conditionFragment, [.. Variables?.Syntaxes.Cast<VariableExpressionFragment>()]);
                        var processedFragment = ProcessConditionFragment(dereferencedConditionFragment, ifLabel, ifEndLabel);
                        finalCondition.AppendLine(processedFragment);
                    }

                    return finalCondition.ToString();
                }

                return $"{ifLabel}: ; IF START\n{raxHandling}\n  cmp rax, 0\n  je {ifEndLabel}   ; Jump if condition == 0";
            }
        }
    }
}
