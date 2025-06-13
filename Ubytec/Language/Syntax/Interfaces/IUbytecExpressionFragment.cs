using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Syntax.Interfaces
{
    /// <summary>
    /// Defines a fragment of a high-level Ubytec expression.
    /// Each fragment carries the lexical tokens that compose it.
    /// </summary>
    public interface IUbytecExpressionFragment
    {
        /// <summary>
        /// Gets the sequence of <see cref="SyntaxToken"/> instances
        /// that represent this expression fragment.
        /// </summary>
        SyntaxToken[] Tokens { get; init; }
    }
}
