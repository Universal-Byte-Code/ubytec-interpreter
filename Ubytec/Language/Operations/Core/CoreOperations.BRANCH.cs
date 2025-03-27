using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BRANCH(object CaseValue, int? LabelIDx, PrimitiveType? BlockType = PrimitiveType.Default, SyntaxExpression? Variables = null) : IBlockOpCode, IOpInheritance
        {
            public readonly byte OpCode => 0x0A;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                // Asumimos el siguiente orden de stacks:
                // stacks[0] => blockEndStack
                // stacks[1] => blockStartStack
                // stacks[2] => blockExpectedTypeStack
                // stacks[3] => blockActualTypeStack

                if (stacks[2].Count == 0 || stacks[3].Count == 0)
                    throw new Exception("BRANCH: El stack de tipos esperados está vacío.");

                var expectedType = (byte)stacks[2].Peek();
                var actualType = (byte)stacks[3].Peek();

                ValidateCasts(expectedType, actualType);
                ValidateCasts(expectedType, (byte?)BlockType ?? (byte)PrimitiveType.Void);

                // Si no se proporciona un labelIDx, se genera uno único.
                string branchLabel = LabelIDx == null ? NextLabel("branch") : $"branch_{LabelIDx}";
                string branchEndLabel = LabelIDx == null ? NextLabel("end_branch") : $"end_branch_{LabelIDx}";

                stacks[0].Push(branchEndLabel);
                stacks[1].Push(branchLabel);

                var output =
                   $"{branchLabel}: ; BRANCH: Salida de bloque(s)\n" +
                   $"pop rax\n" +
                   $"cmp rax, {CaseValue}\n" +
                   $"jne {branchEndLabel}   ; Exit branch if condition is not equal";

                // Genera el salto incondicional a la etiqueta destino indicada por labelIDx
                return output;
            }
        }
    }
}