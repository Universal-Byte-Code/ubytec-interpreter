using System.Text;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct WHILE(UType? BlockType = null, SyntaxExpression? Condition = null, int[]? LabelIDxs = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x0C;

            public static WHILE CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Caso 1: WHILE sin condición explícita
                if (operands.Length == 0)
                {
                    return new WHILE
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 2: WHILE con condición y sin tipo explícito
                if (operands.Length == 4)
                {
                    var left = operands[0];
                    var opLower = Convert.ToByte(operands[1]);
                    var opUpper = Convert.ToByte(operands[2]);
                    var right = operands[3];

                    string equals = opUpper == 0
                        ? new string([(char)opLower])
                        : new string([(char)opLower, (char)opUpper]);

                    return new WHILE
                    {
                        BlockType = new(type: PrimitiveType.Default),
                        Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }),
                        Variables = new([.. variables])
                    };
                }

                // Caso 3: WHILE con tipo explícito + condición
                if (operands.Length == 5)
                {
                    var blockType = (PrimitiveType)operands[0];
                    var left = operands[1];
                    var opLower = Convert.ToByte(operands[2]);
                    var opUpper = Convert.ToByte(operands[3]);
                    var right = operands[4];

                    string equals = opUpper == 0
                        ? new string([(char)opLower])
                        : new string([(char)opLower, (char)opUpper]);

                    return new WHILE
                    {
                        BlockType = new(type: blockType),
                        Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }),
                        Variables = new([.. variables])
                    };
                }

                // Caso 4: WHILE con tipo explícito codificado como bytes (typeByte + flagsByte)
                if (operands.Length == 2 && operands[0] is byte typeByte && operands[1] is byte flagsByte)
                {
                    var typeWithFlags = UType.FromOperands(typeByte, flagsByte);
                    return new WHILE
                    {
                        BlockType = typeWithFlags,
                        Variables = new([.. variables])
                    };
                }

                // Caso 5: WHILE con tipo personalizado codificado como nombre + flags
                if (operands.Length >= 2 &&
                    operands[^1] is byte finalFlags &&
                    operands[..^1].All(o => o is byte))
                {
                    var typeName = new string(operands[..^1].Cast<byte>().Select(b => (char)b).ToArray());
                    var typeWithFlags = new UType(PrimitiveType.CustomType, (TypeModifiers)finalFlags);
                    return new WHILE
                    {
                        BlockType = typeWithFlags,
                        Variables = new([.. variables])
                    };
                }

                // Fallback: Solo tipo de bloque
                if (operands.Length == 1)
                {
                    var blockType = (PrimitiveType)operands[0];
                    return new WHILE
                    {
                        BlockType = new(type: blockType),
                        Variables = new([.. variables])
                    };
                }


                throw new SyntaxException(0x0CBADBEEF, $"WHILE opcode received unexpected number of operands: {operands.Length}");
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                if (!ValidateConditionalBlockType(BlockType?.Type == PrimitiveType.Default ?
                    PrimitiveType.Bool :
                    BlockType?.Type ?? PrimitiveType.Bool))
                    throw new SyntaxStackException(0x0CBAD1CE, $"Invalid WHILE blockType {BlockType}");

                string? whileStartLabel;
                string? whileEndLabel;

                if (LabelIDxs is { Length: > 0 })
                {
                    StringBuilder output = new();
                    foreach (var labelIDx in LabelIDxs)
                    {
                        whileEndLabel = $"end_while_{labelIDx}";
                        whileStartLabel = $"while_{labelIDx}";

                        foreach (var condExpression in Condition?.Syntaxes.Cast<ConditionExpressionFragment>() ?? [])
                            output.AppendLine($"{whileStartLabel}: ; WHILE start\n{GenerateWhileCondition(condExpression, whileEndLabel)}");

                        // Push to block stack (ensures proper END handling)
                        scopes.Push(new ScopeContext()
                        {
                            StartLabel = whileStartLabel,
                            EndLabel = whileEndLabel,
                            ExpectedReturnType = BlockType,
                            DeclaredByKeyword = nameof(WHILE).ToLower()
                        });
                    }
                    return output.ToString();
                }

                // **Default Structured WHILE (No Operand Given)**
                whileStartLabel = NextLabel("while");
                whileEndLabel = NextLabel("end_while");

                // Push to block stack (ensures proper END handling)

                scopes.Push(new ScopeContext()
                {
                    StartLabel = whileStartLabel,
                    EndLabel = whileEndLabel,
                    ExpectedReturnType = BlockType,
                    DeclaredByKeyword = nameof(WHILE).ToLower()
                });

                StringBuilder returnOutput = new();
                foreach (var condExpression in Condition?.Syntaxes.Cast<ConditionExpressionFragment>() ?? [])
                    returnOutput.AppendLine($"{whileStartLabel}: ; WHILE start\n{GenerateWhileCondition(condExpression, whileEndLabel)}");
                return returnOutput.ToString();
            }
        }
    }
}