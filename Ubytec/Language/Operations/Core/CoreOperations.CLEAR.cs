namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct CLEAR : IOpCode
        {
            public readonly byte OpCode => 0x0D;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "mov rsp, rbp   ; CLEAR - Reset stack pointer to base pointer\n  ; Stack is now empty";
        }
    }
}