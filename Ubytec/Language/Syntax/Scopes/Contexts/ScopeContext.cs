using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.Scopes.Contexts
{
    /// <summary>
    /// Represents a lexical scope or block context during compilation,
    /// tracking labels, expected return types, control-flow flags, and modifiers.
    /// </summary>
    public class ScopeContext
    {
        /// <summary>Symbols owned by this function frame.</summary>
        public Dictionary<string, Ubytec.Language.Operations.StackBinding> Symbols { get; } = new(StringComparer.Ordinal);
        /// <summary>Callables visible in this scope.</summary>
        public Dictionary<string, Ubytec.Language.Operations.CallableBinding> Callables { get; } = new(StringComparer.Ordinal);
        /// <summary>Local storage below RBP, in bytes.</summary>
        public int FrameSize { get; set; }
        /// <summary>Reload write-through copies after effects that may modify frame memory or volatile registers.</summary>
        internal bool ReloadRegistersAfterEffects { get; set; }
        /// <summary>Incoming argument-cell capacity of the current function.</summary>
        public int ArgumentCount { get; set; }
        public int? LabelIndex { get; set; }
        public Queue<int> SwitchSlots { get; } = new();
        public int? SwitchOffset { get; set; }
        public bool HasDefault { get; set; }

        /// <summary>
        /// Gets or sets the unique label marking the start of this scope.
        /// </summary>
        public string StartLabel { get; set; } = string.Empty;

        /// <summary>
        /// Gets or sets the unique label marking the end of this scope.
        /// </summary>
        public string EndLabel { get; set; } = string.Empty;

        /// <summary>
        /// Gets or sets the expected return type for this scope, if it represents a function or returnable block.
        /// </summary>
        public UType? ExpectedReturnType { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether a <c>return</c> has been encountered in this scope.
        /// </summary>
        public bool HasReturn { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether a <c>break</c> has been encountered in this scope.
        /// </summary>
        public bool HasBreak { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether a <c>continue</c> has been encountered in this scope.
        /// </summary>
        public bool HasContinue { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this scope is marked <c>async</c>.
        /// </summary>
        public bool IsAsync { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this scope is marked <c>atomic</c>.
        /// </summary>
        public bool IsAtomic { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this scope is marked <c>threaded</c>.
        /// </summary>
        public bool IsThreaded { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this scope is related to machine learning constructs.
        /// </summary>
        public bool IsMLRelated { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this scope is marked for quantum execution.
        /// </summary>
        public bool IsQuantum { get; set; }

        /// <summary>
        /// Gets or sets the keyword that declared this scope block, if any (e.g., "if", "while").
        /// </summary>
        public string? DeclaredByKeyword { get; set; }

        /// <summary>
        /// Gets a value indicating whether this scope represents a loop construct.
        /// </summary>
        public bool IsLoop => DeclaredByKeyword is "loop" or "while"
                           || (DeclaredByKeyword is null
                               && (StartLabel.StartsWith("loop", StringComparison.Ordinal)
                                   || StartLabel.StartsWith("while", StringComparison.Ordinal)));

        /// <summary>
        /// Gets a value indicating whether this scope represents a branch construct.
        /// </summary>
        public bool IsBranch => DeclaredByKeyword == "branch"
                             || (DeclaredByKeyword is null
                                 && StartLabel.StartsWith("branch", StringComparison.Ordinal));

        /// <summary>
        /// Gets a value indicating whether this scope represents a function that may require RETURN.
        /// </summary>
        public bool IsReturnable => DeclaredByKeyword == "func";

        /// <summary>
        /// Returns a human-readable description of this scope context, including labels and flags.
        /// </summary>
        /// <returns>
        /// A string in the format:
        /// "StartLabel → EndLabel | Return: {HasReturn}, Break: {HasBreak}, Flags: [async={IsAsync}, atomic={IsAtomic}, thread={IsThreaded}, ml={IsMLRelated}, q={IsQuantum}]"
        /// </returns>
        public override string ToString()
        {
            return $"{StartLabel} → {EndLabel} | Return: {HasReturn}, Break: {HasBreak}, Flags: " +
                   $"[async={IsAsync}, atomic={IsAtomic}, thread={IsThreaded}, ml={IsMLRelated}, q={IsQuantum}]";
        }
    }
}
