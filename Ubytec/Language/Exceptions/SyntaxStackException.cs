namespace Ubytec.Language.Exceptions
{
    /// <summary>
    /// This exception is thrown when an error in the syntax stack is detected.
    /// </summary>
    [CLSCompliant(true)]
    [method: CLSCompliant(false)]
    public class SyntaxStackException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
