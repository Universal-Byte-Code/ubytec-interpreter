using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Operations.Interfaces
{
    /// <summary>
    /// Defines a factory interface for creating opcodes in the Ubytec language.
    /// </summary>
    public interface IOpCodeFactory
    {
        /// <summary>
        /// Provides a mechanism to create an instruction based on a factory model.
        /// </summary>
        /// <param name="variables"></param>
        /// <param name="tokens"></param>
        /// <param name="operands"></param>
        /// <returns></returns>
        static abstract IOpCode CreateInstruction(
            VariableExpressionFragment[] variables,
            SyntaxToken[] tokens,
            params ValueType[] operands);

        /// <summary>
        /// Represents a factory delegate for creating opcodes.
        /// </summary>
        /// <param name="variables"></param>
        /// <param name="tokens"></param>
        /// <param name="operands"></param>
        /// <returns></returns>
        public delegate IOpCode OpCodeFactoryDelegate(
            VariableExpressionFragment[] variables,
            SyntaxToken[] tokens,
            params ValueType[] operands);
    }

}
