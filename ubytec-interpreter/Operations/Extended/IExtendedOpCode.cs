namespace ubytec_interpreter.Operations.Extended
{
    public interface IExtendedOpCode : IOpCode
    {
        public byte ExtensionGroup { get; }
        public byte ExtendedOpCode { get; }
    }
}
