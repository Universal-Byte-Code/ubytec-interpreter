using Ubytec.Language.Operations;

namespace Ubytec.Language.AST
{
    public static partial class ASTCompiler
    {
        /// <summary>
        /// Encapsulates information about a syntax error during compilation,
        /// including its location, the offending opcode, and an optional inner exception.
        /// </summary>
        public record class CompileSyntaxError
        {
            /// <summary>
            /// Gets the 1-based row number in the source where the error occurred.
            /// </summary>
            public int Row { get; init; }

            /// <summary>
            /// Gets the <see cref="IOpCode"/> instance that triggered this error.
            /// </summary>
            public IOpCode OpCode { get; init; }

            /// <summary>
            /// Gets a descriptive error message.
            /// </summary>
            public string Message { get; init; }

            /// <summary>
            /// Gets the underlying exception, if any, that caused this syntax error.
            /// </summary>
            public Exception? InnerException { get; init; }

            /// <summary>
            /// Initializes a new instance of the <see cref="CompileSyntaxError"/> class.
            /// </summary>
            /// <param name="row">The 1-based row number where the error occurred.</param>
            /// <param name="opCode">The opcode that was being processed.</param>
            /// <param name="message">A descriptive message for the error.</param>
            /// <param name="innerException">
            /// An optional inner <see cref="Exception"/> that caused the error.
            /// </param>
            public CompileSyntaxError(int row, IOpCode opCode, string message, Exception? innerException = null)
            {
                Row = row;
                OpCode = opCode;
                Message = message;
                InnerException = innerException;
            }

            /// <summary>
            /// Returns a formatted string representation of this syntax error,
            /// including row, opcode, message, and inner exception if present.
            /// </summary>
            /// <returns>A human-readable summary of the error.</returns>
            public override string ToString()
            {
                return $"[CompileSyntaxError] Row: {Row}, OpCode: {OpCode}, Message: {Message}" +
                       (InnerException != null ? $", InnerException: {InnerException.Message}" : "");
            }
        }
    }
}
