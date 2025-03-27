namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct TRAP : IOpCode
        {
            public readonly byte OpCode => 0x00;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "ud2   ; TRAP";
        }
    }
}