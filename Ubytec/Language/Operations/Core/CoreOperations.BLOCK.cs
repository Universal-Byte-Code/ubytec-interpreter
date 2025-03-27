using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BLOCK(PrimitiveType? BlockType = PrimitiveType.Default, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x02;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                string blockLabel = NextLabel("block");
                string endLabel = NextLabel("end_block");

                stacks[0].Push(endLabel);   //  Block end label is pushed to the stack
                stacks[1].Push(blockLabel); //  Block start label is pushed to the stack

                // ✅ Ensure RETURN validation works
                if (BlockType == null) stacks[2].Push((byte)PrimitiveType.Void); //  If no type is provided push a void value
                else stacks[2].Push((byte)BlockType);                                  // Else push the specified type to the stack

                return $"{blockLabel}: ; BLOCK start";
            }
        }
    }
}