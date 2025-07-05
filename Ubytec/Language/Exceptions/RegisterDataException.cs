namespace Ubytec.Language.Exceptions
{
    [CLSCompliant(true)]
    [method: CLSCompliant(false)]
    public class RegisterDataException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
