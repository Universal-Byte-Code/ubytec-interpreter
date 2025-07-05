namespace Ubytec.Language.Exceptions
{
    [CLSCompliant(true)]
    [method: CLSCompliant(false)]
    public class LanguageVersionException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {

    }
}
