namespace Ubytec.Language.Exceptions
{
    internal class FetchLexiconException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
