namespace Ubytec.Language.Exceptions
{
    public class FetchLexiconException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
