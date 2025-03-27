using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct SWITCH(int? TableIDx, PrimitiveType? BlockType = PrimitiveType.Default, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x0B;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                // Asumimos que stacks[0] es el blockEndStack.
                // Asumimos que stacks[1] es el blockStartStack.
                // Asumimos que stacks[2] es el blockExpectedTypeStack.
                // Asumimos que stacks[3] es el blockActualTypeStack.

                string? switchEndLabel;
                string? switchStartLabel;
                if (TableIDx == null)
                {
                    switchEndLabel = NextLabel("end_switch");
                    switchStartLabel = NextLabel("switch");
                }
                else
                {
                    switchEndLabel = $"end_switch_{TableIDx}";
                    switchStartLabel = $"switch_{TableIDx}";
                }

                stacks[0].Push(switchEndLabel);
                stacks[1].Push(switchStartLabel);

                // Se empuja el blockType para que, más adelante, la validación de RETURN funcione correctamente.
                if (BlockType != null)
                {
                    stacks[2].Push((byte)BlockType);
                    stacks[3].Push((byte)BlockType);
                }
                else
                {
                    stacks[2].Push((byte)PrimitiveType.Void); // Push void
                    stacks[3].Push((byte)PrimitiveType.Void); // Push void
                }

                return $"{switchStartLabel}: ; SWITCH: Salto múltiple\n";
            }
        }
    }
}