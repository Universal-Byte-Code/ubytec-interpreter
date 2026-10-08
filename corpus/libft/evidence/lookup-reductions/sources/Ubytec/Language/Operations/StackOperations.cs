using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    /// <summary>Operations on 64-bit evaluation stack cells.</summary>
    public static class StackOperations
    {
        /// <summary>Pushes a little-endian immediate as a 64-bit stack cell.</summary>
        /// <param name="operands">One to eight little-endian payload bytes.</param>
        public readonly record struct PUSH(byte[] operands) : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x11;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (variables.Length != 0)
                    StackCode.Validate(nameof(PUSH), variables, operands, operands.Length);
                return new PUSH(StackCode.Immediate(operands));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Push(operands);
        }

        /// <summary>Emits POP on the 64-bit evaluation stack.</summary>
        public readonly record struct POP : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x12;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(POP), variables, operands, 0);
                return new POP();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "add rsp, 8";
        }

        /// <summary>Emits DUP on the 64-bit evaluation stack.</summary>
        public readonly record struct DUP : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x13;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(DUP), variables, operands, 0);
                return new DUP();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Pick(0);
        }

        /// <summary>Emits SWAP on the 64-bit evaluation stack.</summary>
        public readonly record struct SWAP : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x14;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(SWAP), variables, operands, 0);
                return new SWAP();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rax\n  pop rcx\n  push rax\n  push rcx";
        }

        /// <summary>Emits ROT on the 64-bit evaluation stack.</summary>
        public readonly record struct ROT : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x15;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(ROT), variables, operands, 0);
                return new ROT();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Remove(2, true);
        }

        /// <summary>Emits OVER on the 64-bit evaluation stack.</summary>
        public readonly record struct OVER : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x16;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(OVER), variables, operands, 0);
                return new OVER();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Pick(1);
        }

        /// <summary>Emits NIP on the 64-bit evaluation stack.</summary>
        public readonly record struct NIP : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x17;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(NIP), variables, operands, 0);
                return new NIP();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Remove(1, false);
        }

        /// <summary>Emits DROP on the 64-bit evaluation stack.</summary>
        /// <param name="stackIndex">Zero-based cell depth from the top of the stack.</param>
        public readonly record struct DROP(byte stackIndex) : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x18;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(DROP), variables, operands, 1);
                return new DROP((byte)StackCode.Index("DROP", operands, byte.MaxValue));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Remove(stackIndex, false);
        }

        /// <summary>Emits TwoDUP on the 64-bit evaluation stack.</summary>
        public readonly record struct TwoDUP : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x19;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(TwoDUP), variables, operands, 0);
                return new TwoDUP();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.DuplicatePair(0);
        }

        /// <summary>Emits TwoSWAP on the 64-bit evaluation stack.</summary>
        public readonly record struct TwoSWAP : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x1A;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(TwoSWAP), variables, operands, 0);
                return new TwoSWAP();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rax\n  pop rcx\n  pop rdx\n  pop r8\n  push rcx\n  push rax\n  push r8\n  push rdx";
        }

        /// <summary>Emits TwoROT on the 64-bit evaluation stack.</summary>
        public readonly record struct TwoROT : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x1B;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(TwoROT), variables, operands, 0);
                return new TwoROT();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rax\n  pop rcx\n  pop rdx\n  pop r8\n  pop r9\n  pop r10\n  push r8\n  push rdx\n  push rcx\n  push rax\n  push r10\n  push r9";
        }

        /// <summary>Emits TwoOVER on the 64-bit evaluation stack.</summary>
        public readonly record struct TwoOVER : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x1C;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(TwoOVER), variables, operands, 0);
                return new TwoOVER();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.DuplicatePair(2);
        }

        /// <summary>Emits PICK on the 64-bit evaluation stack.</summary>
        /// <param name="n">Zero-based cell depth from the top of the stack.</param>
        public readonly record struct PICK(byte n) : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x1D;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(PICK), variables, operands, 1);
                return new PICK((byte)StackCode.Index("PICK", operands, byte.MaxValue));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Pick(n);
        }

        /// <summary>Emits ROLL on the 64-bit evaluation stack.</summary>
        /// <param name="n">Zero-based cell depth from the top of the stack.</param>
        public readonly record struct ROLL(byte n) : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x1E;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(ROLL), variables, operands, 1);
                return new ROLL((byte)StackCode.Index("ROLL", operands, byte.MaxValue));
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Remove(n, true);
        }
    }
}
