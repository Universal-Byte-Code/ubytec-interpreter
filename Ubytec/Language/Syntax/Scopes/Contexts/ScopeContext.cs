using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.Scopes.Contexts
{
    public class ScopeContext
    {
        public string StartLabel { get; set; } = string.Empty;
        public string EndLabel { get; set; } = string.Empty;
        public UType? ExpectedReturnType { get; set; }

        public bool HasReturn { get; set; } = false;
        public bool HasBreak { get; set; } = false;
        public bool HasContinue { get; set; } = false;

        public bool IsAsync { get; set; }
        public bool IsAtomic { get; set; }
        public bool IsThreaded { get; set; }
        public bool IsMLRelated { get; set; }
        public bool IsQuantum { get; set; }

        public string? DeclaredByKeyword { get; set; }

        public bool IsLoop => StartLabel.StartsWith("loop") || StartLabel.StartsWith("while");
        public bool IsBranch => StartLabel.StartsWith("branch");
        public bool IsReturnable => StartLabel.StartsWith("func_") || StartLabel.StartsWith("block");

        public override string ToString()
        {
            return $"{StartLabel} → {EndLabel} | Return: {HasReturn}, Break: {HasBreak}, Flags: [async={IsAsync}, thread={IsThreaded}, ml={IsMLRelated}, q={IsQuantum}]";
        }

    }
}
