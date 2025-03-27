using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Syntaxes;
using static Ubytec.Language.Syntax.Enum.Primitives;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct RETURN(SyntaxExpression? Variables = null) : IOpInheritance
        {
            public readonly byte OpCode => 0x09;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                string? endLabel = string.Empty;
                string? startLabel = string.Empty;

                var poppedEnds = new Stack<string>();
                var poppedStarts = new Stack<string>();
                bool foundFunctionBoundary = false;

                var expectedType = Convert.ToByte(stacks[2].Pop());
                var actualType = stacks[3].Count > 0 ? Convert.ToByte(stacks[3].Pop()) : (byte)0x00;

                ValidateCasts(expectedType, actualType);

                // Mecanismo de repush para conservar los bloques exteriores
                // Los bloques internos que pertenecen a la función actual se desapilan y NO se re-push;
                // en cambio, si se encuentra un bloque que indica el límite de la función (por ej., "func_" o "block"),
                // se reintroduce ese elemento para no perder el contexto del bloque externo.
                var tempStart = new Stack<string>();
                var tempEnd = new Stack<string>();

                // Vamos desapilando hasta dar con una subrutina
                while (stacks[0].Count > 0)
                {
                    var tmpEnd = (string)stacks[0].Pop();
                    var tmpStart = (string)stacks[1].Pop();

                    if (tmpStart.StartsWith("block") || tmpStart.StartsWith("func_"))
                    {
                        // Hemos encontrado el límite de la función
                        foundFunctionBoundary = true;

                        endLabel = tmpEnd;
                        startLabel = tmpStart;

                        // Repush
                        poppedEnds.Push(tmpEnd);
                        poppedStarts.Push(tmpStart);

                        break;
                    }
                    else
                    {
                        // Los bloques internos (como if, while, etc.) que se desapilan pertenecen a la función que se termina.
                        // Se guardan en temporales en caso de querer hacer debug o alguna acción extra,
                        // pero no se re-push, ya que se deben descartar al hacer return.
                        tempStart.Push(tmpStart);
                        tempEnd.Push(tmpEnd);
                    }
                }

                if (!foundFunctionBoundary)
                    // No se encontró un bloque de función: error o caso especial
                    throw new Exception("RETURN without a valid function boundary.");


                // Rearmamos la cadena final
                var output = $"  pop rax   ; RETURN value\n  ret\n{endLabel}: ; End of function => {startLabel}";

                // Devolvemos el resultado
                return output;
            }
        }
    }
}