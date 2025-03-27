using System.Text;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct IF() : IBlockOpCode, IOpInheritance
        {
            public readonly PrimitiveType? BlockType { get; init; } = PrimitiveType.Default;
            public readonly SyntaxExpression? Condition { get; init; } = null;
            public readonly SyntaxExpression? Variables { get; init; } = null;
            public readonly byte OpCode => 0x04;

            public static IF CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // IF sin condición explícita.
                if (operands.Length == 0)
                {
                    return new IF
                    {
                        Variables = new([.. variables])
                    };
                }
                // Caso: IF left [op] right
                // Se esperan 4 operandos: left, equalsLower, equalsUpper, right.
                else if (operands.Length == 4) // Caso sin bloque tipo: left, opLower, opUpper, right
                {
                    var left = operands[0];
                    var opLower = Convert.ToByte(operands[1]);
                    var opUpper = Convert.ToByte(operands[2]);

                    // Para operadores de un solo carácter, opUpper será 0.
                    string equals = opUpper == 0 ? new string([(char)opLower]) : new string([(char)opLower, (char)opUpper]);
                    var right = operands[3];
                    var ifOpCode = new IF 
                    { 
                        BlockType = PrimitiveType.Default,
                        Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }),
                        Variables = new([.. variables])
                    };

                    return ifOpCode;
                }

                // Caso: IF t_<tipo> left [op] right
                // Se esperan 5 operandos: blockType, left, equalsLower, equalsUpper, right.
                else if (operands.Length == 5)
                {
                    var blockType = (PrimitiveType)operands[0];
                    var left = operands[1];
                    var equalsLower = Convert.ToByte(operands[2]);
                    var equalsUpper = Convert.ToByte(operands[3]);
                    string equals = equalsUpper == 0 ? new string([(char)equalsLower]) : new string([(char)equalsLower, (char)equalsUpper]);
                    var right = operands[4];

                    return new IF 
                    {
                        BlockType = blockType,
                        Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }),
                        Variables = new([.. variables])
                    };
                }
                // Fallback: Si se proporciona solo el bloque tipo.
                else
                {
                    var blockType = (PrimitiveType)operands[0];
                    return new IF
                    {
                        BlockType = blockType,
                        Variables = new([.. variables])
                    };
                }
            }

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (!ValidateIfType(BlockType == PrimitiveType.Default ?
                    PrimitiveType.Bool :
                    BlockType ?? PrimitiveType.Bool))
                    throw new Exception($"Invalid IF blockType {BlockType}");

                string ifEndLabel = NextLabel("end_if");
                string ifLabel = NextLabel("if");

                stacks[0].Push(ifEndLabel);   //  If end label is pushed to the stack
                stacks[1].Push(ifLabel);      //  If start label is pushed to the stack

                // ✅ Ensure RETURN validation works
                if (BlockType == null || BlockType == PrimitiveType.Default)
                {
                    stacks[2].Push((byte)PrimitiveType.Bool); //  If no type is provided push a bool value
                    stacks[3].Push((byte)PrimitiveType.Bool); //  If no type is provided push a bool value
                }
                else
                {
                    stacks[2].Push((byte)BlockType); // Else push the specified type to the stack
                    stacks[3].Push((byte)BlockType); // Else push the specified type to the stack
                }

                var raxHandling = "  pop rax; IF condition";
                if (Condition != null)
                {
                    var finalConditon = new StringBuilder();
                    foreach (ConditionExpressionFragment conditionFragment in Condition.Value.Syntaxes.Select(v => (ConditionExpressionFragment)v))
                    {
                        var dereferencedConditionFragment = ProcessFragmentDereference(conditionFragment, [..Variables?.Syntaxes.Cast<VariableExpressionFragment>()]);
                        var processedFragment = ProcessFragment(dereferencedConditionFragment, ifLabel, ifEndLabel);
                        finalConditon.AppendLine(processedFragment);
                    }

                    return finalConditon.ToString();
                }

                return $"{ifLabel}: ; IF START\n{raxHandling}\n  cmp rax, 0\n  je {ifEndLabel}   ; Jump if condition == 0";
            }

            private static bool ValidateIfType(PrimitiveType blockType) => IsNumeric(blockType) || IsBool(blockType);
            private static string ProcessFragment(ConditionExpressionFragment fragment, string ifLabel, string ifEndLabel)
            {
                var sb = new StringBuilder();
                // Si el lado izquierdo es un fragmento, procesa recursivamente.
                if (fragment.Left is ConditionExpressionFragment leftFragment)
                    sb.AppendLine(ProcessFragment(leftFragment, ifLabel, ifEndLabel));

                // Si el lado derecho es un fragmento, procesa recursivamente.
                if (fragment.Right is ConditionExpressionFragment rightFragment)
                    sb.AppendLine(ProcessFragment(rightFragment, ifLabel, ifEndLabel));

                // Se asume que Condition.Value.left y Condition.Value.right se pueden convertir a una representación
                // adecuada para el ensamblador (por ejemplo, literales, registros o direcciones de memoria).
                var raxHandling = $"  mov rax, {fragment.Left}  ; Evalúa la parte izquierda\n" +
                              $"  cmp rax, {fragment.Right}  ; Compara con la parte derecha";

                // Determinamos la instrucción de salto inverso según el operador.
                // La idea es: si la comparación NO cumple lo esperado, se salta al final del IF.
                string jumpInstruction = fragment.Operand switch
                {
                    "==" => "jne",  // Si left != right, la condición es falsa.
                    "!=" => "je",   // Si left == right, la condición es falsa.
                    "<" => "jge",  // Si left >= right, la condición es falsa.
                    "<=" => "jg",   // Si left > right, la condición es falsa.
                    ">" => "jle",  // Si left <= right, la condición es falsa.
                    ">=" => "jl",   // Si left < right, la condición es falsa.
                    _ => "jne"   // Por defecto, usamos "jne"
                };

                sb.AppendLine($"{ifLabel}: ; IF START\n{raxHandling}\n  {jumpInstruction} {ifEndLabel}   ; Salta si la condición es falsa");

                return sb.ToString();
            }
            private static ConditionExpressionFragment ProcessFragmentDereference(ConditionExpressionFragment conditionFragment, VariableExpressionFragment[] variables)
            {
                var usedConditionFragment = conditionFragment;
                var leftText = conditionFragment.Left?.ToString();
                var rightText = conditionFragment.Right?.ToString();
                bool isDerefLeft = leftText?.StartsWith('@') ?? false;
                bool isDerefRight = rightText?.StartsWith('@') ?? false;

                if (isDerefLeft || isDerefRight)
                {
                    if (isDerefLeft)
                    {
                        var variableName = leftText![1..];
                        var variableFragment = variables?.First(x => x.Name == variableName)
                            ?? throw new NotImplementedException();
                        usedConditionFragment = new ConditionExpressionFragment(variableFragment.Value, conditionFragment.Operand, conditionFragment.Right) 
                        { 
                            Tokens = 
                            [
                                variableFragment.Tokens[1],
                                conditionFragment.Tokens[1],
                                conditionFragment.Tokens[2]
                            ]
                        };
                    }
                    if (isDerefRight)
                    {
                        var variableName = rightText![1..];
                        var variableFragment = variables?.First(x => x.Name == variableName)
                            ?? throw new NotImplementedException();
                        usedConditionFragment = new ConditionExpressionFragment(conditionFragment.Left, conditionFragment.Operand, variableFragment.Value)
                        {
                            Tokens =
                            [
                                conditionFragment.Tokens[0],
                                conditionFragment.Tokens[1],
                                variableFragment.Tokens[1]
                            ]
                        };
                    }
                }

                return usedConditionFragment;
            }

        }
    }
}