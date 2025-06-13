using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language
{
    /// <summary>
    /// Defines an element of the Ubytec language that can be compiled
    /// into its textual or bytecode representation within the given compilation context.
    /// </summary>
    public interface IUbytecEntity
    {
        /// <summary>
        /// Compiles this entity, emitting its code into the current compilation scopes.
        /// </summary>
        /// <param name="scopes">
        /// The <see cref="CompilationScopes"/> used to track nested blocks,
        /// finalizers, and control-flow during compilation.
        /// </param>
        /// <returns>
        /// A string containing the compiled representation of this entity
        /// (e.g., opcode mnemonics, labels, directives).
        /// </returns>
        string Compile(CompilationScopes scopes);
    }
}
