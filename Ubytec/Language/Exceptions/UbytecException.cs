using System.Collections;

namespace Ubytec.Language.Exceptions
{
    public abstract class UbytecException(string message, string? helpLink = null) : Exception
    {
        public abstract ulong ErrorCode { get; }

        public override IDictionary Data => new Dictionary<string, object>()
        {
            { "guid", Guid.CreateVersion7() },
            { "errorCode", ErrorCode.ToString("x8")}
        };
        public override string Message => message;
        public override string? HelpLink => helpLink;
    }
}
