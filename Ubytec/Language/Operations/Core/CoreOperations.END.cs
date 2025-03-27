using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct END : IOpCode
        {
            public readonly byte OpCode => 0x06;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0 || stacks[1].Count == 0 || stacks[2].Count == 0)
                    throw new Exception("END found without matching BLOCK, IF, or LOOP");

                var blockEnd = (string)stacks[0].Pop();
                var blockStart = (string)stacks[1].Pop();
                var expectedType = Convert.ToByte(stacks[2].Pop());
                var actualType = stacks[3].Count > 0 ? Convert.ToByte(stacks[3].Pop()) : (byte)PrimitiveType.Void;

                ValidateCasts(expectedType, actualType);

                var output = string.Empty;

                if (blockStart.StartsWith("while"))
                {
                    // WHILE loops need counter checking before breaking
                    output +=
                        "  pop rax       ; Load loop counter\n" +
                        "  dec rax       ; Decrement counter\n" +
                        "  push rax      ; Store updated counter\n" +
                        "  cmp rax, 0    ; Check if counter is zero\n" +
                        $"  je {blockEnd} ; Exit loop if counter == 0\n" +
                        $"  jmp {blockStart} ; Otherwise, continue loop\n";
                }

                output += $"{blockEnd}: ; END of {blockStart}";

                return output;
            }
        }
    }
}