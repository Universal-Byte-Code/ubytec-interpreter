using System.Collections;

namespace Ubytec.Language.Exceptions
{
    /// <summary>
    /// Represents the base class for all custom exceptions in the Ubytec language infrastructure.
    /// Encapsulates an error code and optional help link.
    /// </summary>
    public abstract class UbytecException(ulong errorCode, string message, string? helpLink = null) : Exception
    {
        /// <summary>
        /// Provides structured data for the exception, including a generated GUID and a hexadecimal error code.
        /// </summary>
        public override IDictionary Data => new Dictionary<string, object>
        {
            { "guid", Guid.CreateVersion7() },
            { "errorCode", errorCode.ToString("x8") }
        };

        /// <summary>
        /// Gets the message that describes the current exception.
        /// </summary>
        public override string Message => message;

        /// <summary>
        /// Gets or sets a link to the help file associated with this exception.
        /// </summary>
        public override string? HelpLink => helpLink;
    }
}
