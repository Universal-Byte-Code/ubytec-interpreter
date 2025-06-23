namespace Ubytec.Language.Exceptions
{
    public class IlegalTokenException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
