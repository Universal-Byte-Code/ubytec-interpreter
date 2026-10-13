using System.Collections.Concurrent;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Operations.Extended
{
    /// <summary>
    /// Canonical identity of an opcode in the recursive extended namespace.
    /// </summary>
    public readonly record struct OpcodeId
    {
        /// <summary>Reserved recursive escape byte.</summary>
        public const byte ESCAPE = 0xFF;

        /// <summary>Number of consecutive leading <c>0xFF</c> escape bytes.</summary>
        public int EscapeDepth { get; }

        /// <summary>Extension group in the range <c>0x00..0xFE</c>.</summary>
        public byte ExtensionGroup { get; }

        /// <summary>Opcode inside the extension group in the range <c>0x00..0xFE</c>.</summary>
        public byte ExtendedOpCode { get; }

        /// <summary>Creates a validated extended opcode identity.</summary>
        public OpcodeId(int escapeDepth, byte extensionGroup, byte extendedOpCode)
        {
            if (escapeDepth < 1)
                throw new ArgumentOutOfRangeException(nameof(escapeDepth), "Extended opcodes require an escape depth of at least one.");
            if (extensionGroup == ESCAPE)
                throw new ArgumentOutOfRangeException(nameof(extensionGroup), "0xFF is reserved for recursive opcode escaping and cannot be allocated as an extension group.");
            if (extendedOpCode == ESCAPE)
                throw new ArgumentOutOfRangeException(nameof(extendedOpCode), "0xFF is reserved for recursive opcode escaping and cannot be allocated as an extended opcode.");

            EscapeDepth = escapeDepth;
            ExtensionGroup = extensionGroup;
            ExtendedOpCode = extendedOpCode;
        }

        /// <summary>Returns the canonical wire prefix for this opcode identity.</summary>
        public byte[] Encode()
        {
            byte[] bytes = new byte[EscapeDepth + 2];
            Array.Fill(bytes, ESCAPE, 0, EscapeDepth);
            bytes[EscapeDepth] = ExtensionGroup;
            bytes[EscapeDepth + 1] = ExtendedOpCode;
            return bytes;
        }

        /// <inheritdoc/>
        public override string ToString() =>
            $"depth={EscapeDepth}, group=0x{ExtensionGroup:X2}, opcode=0x{ExtendedOpCode:X2}";
    }

    /// <summary>
    /// Contract for opcodes that live in the recursive extended space
    /// (<c>0xFF...</c> + ExtensionGroup + ExtendedOpCode).
    /// </summary>
    public interface IExtendedOpCode : IOpCode
    {
        /// <summary>Number of consecutive leading <c>0xFF</c> escape bytes.</summary>
        public int EscapeDepth { get; }

        /// <summary>Byte that identifies the extension group.</summary>
        public byte ExtensionGroup { get; }

        /// <summary>Byte that identifies the opcode within its group.</summary>
        public byte ExtendedOpCode { get; }

        /// <summary>Canonical recursive opcode identity.</summary>
        public OpcodeId OpcodeId => new(EscapeDepth, ExtensionGroup, ExtendedOpCode);
    }

    internal readonly record struct ExtKey(int EscapeDepth, byte Group, byte Code);

    /// <summary>
    /// Thread-safe factory for recursive extended opcodes.
    /// </summary>
    public static class ExtendedOpcodeFactory
    {
        /// <summary>
        /// Defensive limit of this interpreter implementation. The Ubytec specification itself
        /// does not impose a finite maximum escape depth.
        /// </summary>
        public const int MAX_SUPPORTED_ESCAPE_DEPTH = 16;

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
            // Existing extended stack encodings remain depth 1 for wire compatibility.
            Register(1, ExtendedStackOperations.PUSH16.GROUP, ExtendedStackOperations.PUSH16.OP, ExtendedStackOperations.PUSH16.CreateInstruction);
            Register(1, ExtendedStackOperations.DROP16.GROUP, ExtendedStackOperations.DROP16.OP, ExtendedStackOperations.DROP16.CreateInstruction);
            Register(1, ExtendedStackOperations.PICK16.GROUP, ExtendedStackOperations.PICK16.OP, ExtendedStackOperations.PICK16.CreateInstruction);
            Register(1, ExtendedStackOperations.ROLL16.GROUP, ExtendedStackOperations.ROLL16.OP, ExtendedStackOperations.ROLL16.CreateInstruction);
        }

        /// <summary>Registers a depth-1 extended opcode for backwards-compatible callers.</summary>
        public static void Register(
            byte extensionGroup,
            byte extendedOp,
            IOpCodeFactory.OpCodeFactoryDelegate ctor) =>
            Register(1, extensionGroup, extendedOp, ctor);

        /// <summary>Registers (or overwrites) an extended opcode at the specified escape depth.</summary>
        public static void Register(
            int escapeDepth,
            byte extensionGroup,
            byte extendedOp,
            IOpCodeFactory.OpCodeFactoryDelegate ctor)
        {
            ValidateSupportedDepth(escapeDepth);
            var id = new OpcodeId(escapeDepth, extensionGroup, extendedOp);
            _table[new(id.EscapeDepth, id.ExtensionGroup, id.ExtendedOpCode)] = ctor
                ?? throw new ArgumentNullException(nameof(ctor));
        }

        /// <summary>Creates a depth-1 extended opcode for backwards-compatible callers.</summary>
        public static IOpCode Create(
            byte extensionGroup,
            byte extendedOp,
            VariableExpressionFragment[] vars,
            SyntaxToken[] tokens,
            ValueType[] operands) =>
            Create(1, extensionGroup, extendedOp, vars, tokens, operands);

        /// <summary>Creates an extended opcode instance at the specified recursive escape depth.</summary>
        public static IOpCode Create(
            int escapeDepth,
            byte extensionGroup,
            byte extendedOp,
            VariableExpressionFragment[] vars,
            SyntaxToken[] tokens,
            ValueType[] operands)
        {
            ValidateSupportedDepth(escapeDepth);
            var id = new OpcodeId(escapeDepth, extensionGroup, extendedOp);
            if (_table.TryGetValue(new(id.EscapeDepth, id.ExtensionGroup, id.ExtendedOpCode), out var ctor))
                return ctor(vars, tokens, operands);

            throw new NotSupportedException(
                $"Extended opcode {id} is not registered.");
        }

        private static void ValidateSupportedDepth(int escapeDepth)
        {
            if (escapeDepth < 1)
                throw new ArgumentOutOfRangeException(nameof(escapeDepth));
            if (escapeDepth > MAX_SUPPORTED_ESCAPE_DEPTH)
                throw new NotSupportedException(
                    $"Escape depth {escapeDepth} exceeds this runtime's supported maximum of {MAX_SUPPORTED_ESCAPE_DEPTH}.");
        }
    }
}
