using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct ELSE(SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x05;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0 || stacks[1].Count == 0)
                    throw new Exception("ELSE without matching IF");

                var ifEndLabel = (string)stacks[0].Pop();
                var ifStart = (string)stacks[1].Pop();
                var elseEndLabel = NextLabel("end_else");
                var elseStartLabel = NextLabel("else");

                stacks[0].Push(elseEndLabel);
                stacks[1].Push(elseStartLabel);

                return $"  jmp {elseEndLabel}     ; Jump over ELSE part\n{ifEndLabel}:    ; {ifStart} END\n{elseStartLabel}:  ; Start ELSE block";
            }
        }
    }
}