namespace Ubytec.Language.Exceptions
{
    /// <summary>
    /// An exception ocurred during syntax tree deserialization
    /// </summary>
    /// <param name="errorCode"></param>
    /// <param name="message"></param>
    /// <param name="helpLink"></param>
    public class SyntaxTreeDeserializationException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
