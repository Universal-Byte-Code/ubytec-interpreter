namespace Ubytec.Language.Operations
{
    public interface IOpCode
    {
        public byte OpCode { get; }
        public string Compile(params Stack<object>[]? stacks);
    }
}
