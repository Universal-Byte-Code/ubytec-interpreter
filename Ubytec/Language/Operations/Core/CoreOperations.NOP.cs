namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct NOP : IOpCode
        {
            public readonly byte OpCode => 0x01;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "nop   ; NOP";
        }
    }
}