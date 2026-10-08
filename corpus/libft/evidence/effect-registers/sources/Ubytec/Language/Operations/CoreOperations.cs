using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        private static string NextLabel(string prefix) => $"{prefix}_{Guid.NewGuid():N}";
        private static bool ValidateConditionalBlockType(PrimitiveType type) => type.IsNumeric() || type.IsBool();
        private static string GenerateWhileCondition(Ubytec.Language.Syntax.ExpressionFragments.ConditionExpressionFragment? condition, string endLabel) =>
            $"pop rax\n  test rax, rax\n  je {endLabel}";
    }
}
