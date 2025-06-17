namespace Ubytec.Language.Exceptions
{
    internal class IlegalTokenException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
