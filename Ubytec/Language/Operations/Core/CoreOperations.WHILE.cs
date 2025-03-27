using System.Text;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct WHILE(PrimitiveType? BlockType = PrimitiveType.Default, SyntaxExpression? Condition = null, int[]? LabelIDxs = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x0C;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            private static bool ValidateWhileType(PrimitiveType blockType) => IsNumeric(blockType) || IsBool(blockType);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (!ValidateWhileType(BlockType == PrimitiveType.Default ?
                    PrimitiveType.Bool :
                    BlockType ?? PrimitiveType.Bool))
                    throw new Exception($"Invalid IF blockType {BlockType}");

                string? whileStartLabel;
                string? whileEndLabel;

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
                        stacks[0].Push(whileEndLabel);
                        stacks[1].Push(whileStartLabel);
                    }
                    return output.ToString();
                }

                // **Default Structured WHILE (No Operand Given)**
                whileStartLabel = NextLabel("while");
                whileEndLabel = NextLabel("end_while");

                // Push to block stack (ensures proper END handling)
                stacks[0].Push(whileEndLabel);
                stacks[1].Push(whileStartLabel);

                StringBuilder returnOutput = new();
                foreach (var condExpression in Condition?.Syntaxes.Cast<ConditionExpressionFragment>() ?? [])
                    returnOutput.AppendLine($"{whileStartLabel}: ; WHILE start\n{GenerateWhileCondition(condExpression, whileEndLabel)}");
                return returnOutput.ToString();
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
}