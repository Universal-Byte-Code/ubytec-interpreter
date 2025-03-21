namespace Ubytec.Language.Exceptions
{
    internal class FetchLexiconException(ulong errorCode, string message, string? helpLink = null) : UbytecException(message, helpLink)
    {
        public override ulong ErrorCode => errorCode;
    }
}
