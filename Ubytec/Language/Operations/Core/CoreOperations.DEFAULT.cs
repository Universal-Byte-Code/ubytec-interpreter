namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct DEFAULT : IOpCode
        {
            public readonly byte OpCode => 0x0E;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "mov rax, 1  ; DEFAULT non-null placeholder\n  push rax";
        }
    }
}