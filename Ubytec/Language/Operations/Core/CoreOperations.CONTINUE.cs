namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct CONTINUE(int? LabelIDx) : IOpCode
        {
            public readonly byte OpCode => 0x08;

            public string Compile(Stack<object> blockStartStack) =>
                ((IOpCode)this).Compile(blockStartStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0) throw new Exception("CONTINUE without a valid LOOP to jump to");

                var temp1 = new Stack<string>();

                string? output = null;

                // Traverse upwards until we find a valid loop or block
                while (stacks[0].Count > 0)
                {
                    var blockName = (string)stacks[0].Pop();

                    temp1.Push(blockName);

                    bool isWhileStart = blockName.StartsWith("while");
                    bool isLoopStart = blockName.StartsWith("loop");

                    if (isWhileStart || isLoopStart)
                    {
                        string? key = null;
                        if (isWhileStart) key = "while";
                        if (isLoopStart) key = "loop";

                        if (LabelIDx != null && key != null) output = $"jmp {key}_{LabelIDx} ; CONTINUE {key}_{LabelIDx}";
                        else output = $"jmp {blockName} ; CONTINUE {blockName}";

                        break;
                    }
                }

                foreach (var temp in temp1)
                    stacks[0].Push(temp);

                return output ?? throw new Exception("Invalid CONTINUE instruction...");
            }
        }
    }
}