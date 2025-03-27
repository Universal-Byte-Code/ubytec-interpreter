using Ubytec.Language.Syntax.ExpressionFragments;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct VAR(VariableExpressionFragment Variable) : IOpCode
        {
            public readonly byte OpCode => 0x10;

            public string Compile() => ((IOpCode)this).Compile();

            string IOpCode.Compile(params Stack<object>[]? stacks) => string.Empty;
        }
    }
}