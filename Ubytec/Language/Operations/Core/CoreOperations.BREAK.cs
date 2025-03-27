namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BREAK(int? LabelIDx) : IOpCode
        {
            public readonly byte OpCode => 0x07;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0 || stacks[1].Count == 0)
                    throw new Exception("BREAK without a valid BLOCK or LOOP to exit");

                var temp1 = new Stack<string>();
                var temp2 = new Stack<string>();

                var output = string.Empty;

                // Traverse upwards until we find a valid loop or block
                while (stacks[0].Count > 0)
                {
                    var blockEnd = (string)stacks[0].Pop();
                    var blockName = (string)stacks[1].Pop();

                    temp1.Push(blockEnd);
                    temp2.Push(blockName);

                    bool isWhileStart = blockName.StartsWith("while");
                    bool isLoopStart = blockName.StartsWith("loop");
                    bool isBranchStart = blockName.StartsWith("branch");

                    if (isWhileStart || isLoopStart || isBranchStart)
                    {
                        string? key = null;

                        if (isWhileStart) key = "whileEnd";
                        if (isLoopStart) key = "loopEnd";

                        if (isBranchStart)
                        {
                            key = "branchEnd";

                            string? switchEndLabel = null;
                            foreach (var item in stacks[0])
                                if (item is string s && s.StartsWith("switchEnd"))
                                {
                                    switchEndLabel = s;
                                    break;
                                }

                            if (!string.IsNullOrEmpty(switchEndLabel)) output += $"jmp {switchEndLabel}   ; Salta al fin del SWITCH\n";
                            if (LabelIDx != null && key != null) output += $"{key}_{LabelIDx}: ; BREAK SWITCH - {blockName}";
                            else output += $"{blockEnd}: ; BREAK SWITCH - {blockName}";
                        }
                        else
                        {
                            if (LabelIDx != null && key != null) output = $"jmp {key}_{LabelIDx} ; BREAK - Exit {blockName}";
                            else output = $"jmp {blockEnd} ; BREAK - Exit {blockName}";
                        }

                        break;
                    }
                }

                foreach (var temp in temp1)
                    stacks[0].Push(temp);
                foreach (var temp in temp2)
                    stacks[1].Push(temp);

                return output;
            }
        }
    }
}