using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Syntax.ExpressionFragments
{
    /// <summary>
    /// A fragment representing a conditional expression in Ubytec syntax,
    /// consisting of a left operand, an operator, and a right operand.
    /// </summary>
    /// <param name="Left">
    /// The left-hand side of the condition; can be any supported literal or expression result.
    /// </param>
    /// <param name="Operand">
    /// The operator string (e.g., "==", "&lt;", ">=") used in the condition;
    /// may be <c>null</c> if the operator is implicit or not yet determined.
    /// </param>
    /// <param name="Right">
    /// The right-hand side of the condition; can be any supported literal or expression result.
    /// </param>
    public readonly record struct ConditionExpressionFragment(object? Left, string? Operand, object? Right)
        : IUbytecExpressionFragment
    {
        /// <summary>
        /// Gets the lexical <see cref="SyntaxToken"/> sequence that produced this condition fragment.
        /// </summary>
        [JsonInclude]
        public required SyntaxToken[] Tokens { get; init; } = [];
    }
}
