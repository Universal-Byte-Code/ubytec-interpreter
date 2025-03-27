namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct NULL : IOpCode
        {
            public readonly byte OpCode => 0x0F;

            public string Compile() => ((IOpCode)this).Compile();

            string IOpCode.Compile(params Stack<object>[]? stacks) => "xor rax, rax   ; NULL = 0\n  push rax";
        }
    }
}