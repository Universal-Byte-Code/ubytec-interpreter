using System.Linq;
using System.Text;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        private static readonly Dictionary<string, int> _prefixToLabelCounterMap = [];

        // Generate a unique label for jumps
        private static string NextLabel(string prefix)
        {
            _prefixToLabelCounterMap.TryAdd(prefix, 0);
            return $"{prefix}_{_prefixToLabelCounterMap[prefix]++}";
        }

        private static bool ValidateConditionalBlockType(PrimitiveType blockType) => IsNumeric(blockType) || IsBool(blockType);
        private static string ProcessConditionFragment(ConditionExpressionFragment fragment, string ifLabel, string ifEndLabel)
        {
            var sb = new StringBuilder();
            // Si el lado izquierdo es un fragmento, procesa recursivamente.
            if (fragment.Left is ConditionExpressionFragment leftFragment)
                sb.AppendLine(ProcessConditionFragment(leftFragment, ifLabel, ifEndLabel));

            // Si el lado derecho es un fragmento, procesa recursivamente.
            if (fragment.Right is ConditionExpressionFragment rightFragment)
                sb.AppendLine(ProcessConditionFragment(rightFragment, ifLabel, ifEndLabel));

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
        /// <summary>
        /// Similar logic to your IF’s condition. If Condition != null,
        /// do “mov rax, left; cmp rax, right; [jumpInstruction] endLabel”.
        /// Otherwise do “pop rax; cmp rax, 0; je endLabel”.
        /// </summary>
        private static string GenerateWhileCondition(ConditionExpressionFragment? cond, string endLabel)
        {
            if (cond is null)
                return $"  pop rax ; WHILE Condition\n  cmp rax, 0\n  je {endLabel}   ; Exit loop if condition == 0";

            // Condition-based approach
            // We replicate the logic from your IF
            var left = cond.Value.Left;
            var right = cond.Value.Right;
            var op = cond.Value.Operand;

            // The jump instruction is "inverse" => if condition is *not* satisfied, jump out.
            // The mapping is the same as your IF example:
            string jumpInstruction = op switch
            {
                "==" => "jne",  // if left != right => exit
                "!=" => "je",   // if left == right => exit
                "<" => "jge",  // if left >= right => exit
                "<=" => "jg",   // if left > right  => exit
                ">" => "jle",  // if left <= right => exit
                ">=" => "jl",   // if left < right  => exit
                _ => "jne"
            };

            return $"  mov rax, {left}    ; Evaluate left\n  cmp rax, {right}   ; Compare with right\n  {jumpInstruction} {endLabel}    ; Jump if condition is false";
        }
    }
}