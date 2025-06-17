namespace Ubytec.Language.Exceptions
{
    public class SyntaxStackException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
