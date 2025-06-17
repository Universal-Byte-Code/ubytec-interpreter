namespace Ubytec.Language.Exceptions
{
    public class RegisterDataException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
