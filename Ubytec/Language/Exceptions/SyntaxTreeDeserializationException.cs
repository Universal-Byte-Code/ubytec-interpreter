namespace Ubytec.Language.Exceptions
{
    public class SyntaxTreeDeserializationException(ulong errorCode, string message, string? helpLink = null) : UbytecException(message, helpLink)
    {
        public override ulong ErrorCode => errorCode;
    }
}
