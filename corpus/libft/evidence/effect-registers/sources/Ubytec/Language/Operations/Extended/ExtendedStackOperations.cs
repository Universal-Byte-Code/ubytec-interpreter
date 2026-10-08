using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations.Extended
{
    /// <summary>Stack operations with 16-bit indices in extension group 0x10.</summary>
    public static class ExtendedStackOperations
    {
        /// <summary>Zero-extends the word at RSP + StackIndex (a byte offset) into a 64-bit stack cell.</summary>
        /// <param name="StackIndex">Unsigned byte offset from RSP.</param>
        [CLSCompliant(false)]
        public readonly record struct PUSH16(ushort StackIndex) : IExtendedOpCode, IOpCodeFactory
        {
            /// <summary>Stack extension group.</summary>
            public const byte GROUP = 0x10;
            /// <summary>Encoded instruction byte within the group.</summary>
            public const byte OP = 0x11;
            /// <inheritdoc/>
            public byte OpCode => 0xFF;
            /// <inheritdoc/>
            public byte ExtensionGroup => GROUP;
            /// <inheritdoc/>
            public byte ExtendedOpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(PUSH16), variables, operands, operands.Length);
                // Wire payloads use loByte, hiByte; source callers may supply one integer.
                if (operands.Length == 2 && operands[0] is byte lo && operands[1] is byte hi)
                    return new PUSH16((ushort)(lo | (hi << 8)));
                return new PUSH16((ushort)StackCode.Index(nameof(PUSH16), operands, ushort.MaxValue));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => $"movzx eax, word [rsp + {StackIndex}]\n  push rax";
        }

        /// <summary>Uses a zero-based cell index measured from the top of the stack.</summary>
        /// <param name="StackIndex">Unsigned cell depth from the top.</param>
        [CLSCompliant(false)]
        public readonly record struct DROP16(ushort StackIndex) : IExtendedOpCode, IOpCodeFactory
        {
            /// <summary>Stack extension group.</summary>
            public const byte GROUP = 0x10;
            /// <summary>Encoded instruction byte within the group.</summary>
            public const byte OP = 0x18;
            /// <inheritdoc/>
            public byte OpCode => 0xFF;
            /// <inheritdoc/>
            public byte ExtensionGroup => GROUP;
            /// <inheritdoc/>
            public byte ExtendedOpCode => OP;
            /// <summary>Instruction name.</summary>
            public string Name => nameof(DROP16);

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(DROP16), variables, operands, operands.Length);
                // Wire payloads use loByte, hiByte; source callers may supply one integer.
                if (operands.Length == 2 && operands[0] is byte lo && operands[1] is byte hi)
                    return new DROP16((ushort)(lo | (hi << 8)));
                return new DROP16((ushort)StackCode.Index(nameof(DROP16), operands, ushort.MaxValue));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Remove(StackIndex, false);
        }

        /// <summary>Uses a zero-based cell index measured from the top of the stack.</summary>
        /// <param name="N">Unsigned cell depth from the top.</param>
        [CLSCompliant(false)]
        public readonly record struct PICK16(ushort N) : IExtendedOpCode, IOpCodeFactory
        {
            /// <summary>Stack extension group.</summary>
            public const byte GROUP = 0x10;
            /// <summary>Encoded instruction byte within the group.</summary>
            public const byte OP = 0x1D;
            /// <inheritdoc/>
            public byte OpCode => 0xFF;
            /// <inheritdoc/>
            public byte ExtensionGroup => GROUP;
            /// <inheritdoc/>
            public byte ExtendedOpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(PICK16), variables, operands, operands.Length);
                // Wire payloads use loByte, hiByte; source callers may supply one integer.
                if (operands.Length == 2 && operands[0] is byte lo && operands[1] is byte hi)
                    return new PICK16((ushort)(lo | (hi << 8)));
                return new PICK16((ushort)StackCode.Index(nameof(PICK16), operands, ushort.MaxValue));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Pick(N);
        }

        /// <summary>Uses a zero-based cell index measured from the top of the stack.</summary>
        /// <param name="N">Unsigned cell depth from the top.</param>
        [CLSCompliant(false)]
        public readonly record struct ROLL16(ushort N) : IExtendedOpCode, IOpCodeFactory
        {
            /// <summary>Stack extension group.</summary>
            public const byte GROUP = 0x10;
            /// <summary>Encoded instruction byte within the group.</summary>
            public const byte OP = 0x1E;
            /// <inheritdoc/>
            public byte OpCode => 0xFF;
            /// <inheritdoc/>
            public byte ExtensionGroup => GROUP;
            /// <inheritdoc/>
            public byte ExtendedOpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(ROLL16), variables, operands, operands.Length);
                // Wire payloads use loByte, hiByte; source callers may supply one integer.
                if (operands.Length == 2 && operands[0] is byte lo && operands[1] is byte hi)
                    return new ROLL16((ushort)(lo | (hi << 8)));
                return new ROLL16((ushort)StackCode.Index(nameof(ROLL16), operands, ushort.MaxValue));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Remove(N, true);
        }
    }
}
