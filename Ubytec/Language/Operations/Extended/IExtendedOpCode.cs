using System.Collections.Concurrent;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Operations.Extended
{
    /// <summary>
    /// Contract for opcodes that live in the extended space
    /// (0xFF + ExtensionGroup + ExtendedOpCode).
    /// </summary>
    public interface IExtendedOpCode : IOpCode
    {
        /// <summary>High-order byte that identifies the extension group.</summary>
        public byte ExtensionGroup { get; }

        /// <summary>Low-order byte that identifies the opcode within its group.</summary>
        public byte ExtendedOpCode { get; }
    }

    internal readonly record struct ExtKey(byte Group, byte Code);

    /// <summary>
    /// Thread-safe factory for extended (<c>0xFF</c>) opcodes.
    /// </summary>
    public static class ExtendedOpcodeFactory
    {
        /// <remarks>
        /// <para>
        /// * ConcurrentDictionary keeps look-ups lock-free.<br/>
        /// * Value = same delegate shape used by standard opcodes.
        /// </para>
        /// </remarks>
        private static readonly ConcurrentDictionary<
            ExtKey,
            IOpCodeFactory.OpCodeFactoryDelegate> _table = new();

        static ExtendedOpcodeFactory()
        {
            // Value-type static constructors are not triggered by a factory lookup.
            // Register built-ins here so their first use is through Create.
            Register(ExtendedStackOperations.PUSH16.GROUP, ExtendedStackOperations.PUSH16.OP, ExtendedStackOperations.PUSH16.CreateInstruction);
            Register(ExtendedStackOperations.DROP16.GROUP, ExtendedStackOperations.DROP16.OP, ExtendedStackOperations.DROP16.CreateInstruction);
            Register(ExtendedStackOperations.PICK16.GROUP, ExtendedStackOperations.PICK16.OP, ExtendedStackOperations.PICK16.CreateInstruction);
            Register(ExtendedStackOperations.ROLL16.GROUP, ExtendedStackOperations.ROLL16.OP, ExtendedStackOperations.ROLL16.CreateInstruction);
        }

        /// <summary>Registers (or overwrites) an extended opcode.</summary>
        public static void Register(
            byte extensionGroup,
            byte extendedOp,
            IOpCodeFactory.OpCodeFactoryDelegate ctor)
        {
            _table[new(extensionGroup, extendedOp)] = ctor
                ?? throw new ArgumentNullException(nameof(ctor));
        }

        /// <summary>Creates an extended opcode instance.</summary>
        public static IOpCode Create(
            byte extensionGroup,
            byte extendedOp,
            VariableExpressionFragment[] vars,
            SyntaxToken[] tokens,
            ValueType[] operands)
        {
            if (_table.TryGetValue(new(extensionGroup, extendedOp), out var ctor))
                return ctor(vars, tokens, operands);

            throw new NotSupportedException(
                $"Extended opcode 0xFF {extensionGroup:X2} {extendedOp:X2} is not registered.");
        }
    }
}
