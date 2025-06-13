using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Interfaces;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.ExpressionFragments
{
    /// <summary>
    /// A fragment representing a variable declaration or reference in a Ubytec expression.
    /// Carries the variable's type, its identifier name, and an optional initial value.
    /// </summary>
    /// <param name="Type">The <see cref="UType"/> of the variable.</param>
    /// <param name="Name">The identifier name of the variable.</param>
    /// <param name="Value">
    /// The initial value assigned to the variable; 
    /// may be <c>null</c> if no explicit initializer is present.
    /// </param>
    public readonly record struct VariableExpressionFragment(UType Type, string Name, object? Value)
        : IUbytecExpressionFragment
    {
        /// <summary>
        /// Gets the lexical <see cref="SyntaxToken"/> sequence that produced this fragment.
        /// </summary>
        [JsonInclude]
        public required SyntaxToken[] Tokens { get; init; } = [];
    }
}
