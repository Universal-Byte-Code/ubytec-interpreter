namespace Ubytec.Language.Exceptions
{
    public class LanguageVersionException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {

    }
}
