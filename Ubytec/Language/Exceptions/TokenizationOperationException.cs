namespace Ubytec.Language.Exceptions
{
    public class TokenizationOperationException(ulong errorCode, string message, string? helpLink = null) : UbytecException(message, helpLink)
    {
        public override ulong ErrorCode => errorCode;
    }
}
