using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        private static string NextLabel(CompilationScopes scopes, string prefix) => scopes.NextLabel(prefix);

        private static bool ValidateConditionalBlockType(PrimitiveType type) => type.IsNumeric() || type.IsBool();

        private static string GenerateWhileCondition(
            Ubytec.Language.Syntax.ExpressionFragments.ConditionExpressionFragment? condition,
            string endLabel) =>
            $"pop rax\n  test rax, rax\n  je {endLabel}";

        private static IOpCode CreateOperandless(ValueType[] operands, ulong errorCode,
            string opcodeName, Func<IOpCode> factory)
        {
            if (operands.Length != 0)
                throw new SyntaxException(errorCode,
                    $"{opcodeName} opcode should not receive any operands, but received: {operands.Length}");
            return factory();
        }
    }
}
