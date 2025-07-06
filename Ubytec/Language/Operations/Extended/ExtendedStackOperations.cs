using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations.Extended
{
    [CLSCompliant(true)]
    public static class ExtendedStackOperations
    {
        /// <summary>
        /// Pushes a 16-bit value located at <c>SP + <paramref name="StackIndex"/></c>
        /// onto the evaluation stack.
        ///
        /// Wire format: <c>FF&amp;nbsp;10&amp;nbsp;11&amp;nbsp;loByte&amp;nbsp;hiByte</c><br/>
        /// (`0xFF` marker · extension group 0x10 · opcode 0x11 · little-endian index)
        /// </summary>
        [type:CLSCompliant(false)]
        [method: CLSCompliant(false)]
        public readonly record struct PUSH16(ushort StackIndex)
            : IExtendedOpCode, IOpCodeFactory
        {
            // ───── Extension identity ───────────────────────────────────────────
            public const byte GROUP = 0x10;
            public const byte OP = 0x11;

            /// <inheritdoc/>
            public byte OpCode => 0xFF;   // primary byte
            /// <inheritdoc/>
            public byte ExtensionGroup => GROUP;  // 0x10
            /// <inheritdoc/>
            public byte ExtendedOpCode => OP;     // 0x11

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(
                VariableExpressionFragment[] vars,
                SyntaxToken[] tokens,
                params ValueType[] operands)
            {
                if (operands.Length != 1 || operands[0] is not ushort index)
                    throw new SyntaxException(
                        0xBAD0716,
                        "PUSH16 expects exactly one ushort operand (stack index).");

                return new PUSH16(index);
            }

            // ───── Compilation ──────────────────────────────────────────────────
            string IUbytecEntity.Compile(CompilationScopes scopes) =>
                $"push16 0x{StackIndex:X4}";   // textual form; backend converts to bytes

            // ───── Self-registration at module load ─────────────────────────────
            static PUSH16() =>
                ExtendedOpcodeFactory.Register(GROUP, OP, CreateInstruction);
        }

        [type: CLSCompliant(false)]
        [method: CLSCompliant(false)]   
        public readonly record struct DROP16(ushort StackIndex) : IExtendedOpCode
        {
            public byte OpCode => 0xFF;
            public readonly string Name => nameof(DROP16);
            public readonly byte ExtensionGroup => 0x10;
            public readonly byte ExtendedOpCode => 0x18;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }

        [type: CLSCompliant(false)]
        [method: CLSCompliant(false)]
        public readonly record struct PICK16(ushort N) : IExtendedOpCode
        {
            public byte OpCode => 0xFF;
            public readonly byte ExtensionGroup => 0x10;
            public readonly byte ExtendedOpCode => 0x1D;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }

        [type: CLSCompliant(false)]
        [method: CLSCompliant(false)]
        public readonly record struct ROLL16(ushort N) : IExtendedOpCode
        {
            public byte OpCode => 0xFF;
            public readonly byte ExtensionGroup => 0x10;
            public readonly byte ExtendedOpCode => 0x1E;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
    }
}
