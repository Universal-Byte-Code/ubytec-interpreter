namespace Ubytec.Language.Exceptions
{
    public class SyntaxException(ulong errorCode, string message, string? helpLink = null) : UbytecException(message, helpLink)
    {
        public override ulong ErrorCode => errorCode;
    }
}
