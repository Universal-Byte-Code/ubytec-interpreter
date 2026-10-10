using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    /// <summary>Operations on 64-bit evaluation stack cells.</summary>
    public static class BitwiseOperations
    {
        /// <summary>Emits AND on the 64-bit evaluation stack.</summary>
        public readonly record struct AND : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x30;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(AND), variables, operands, 0);
                return new AND();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Binary("and");
        }

        /// <summary>Emits OR on the 64-bit evaluation stack.</summary>
        public readonly record struct OR : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x31;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(OR), variables, operands, 0);
                return new OR();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Binary("or");
        }

        /// <summary>Emits XOR on the 64-bit evaluation stack.</summary>
        public readonly record struct XOR : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x32;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(XOR), variables, operands, 0);
                return new XOR();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Binary("xor");
        }

        /// <summary>Emits NOT on the 64-bit evaluation stack.</summary>
        public readonly record struct NOT : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x33;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(NOT), variables, operands, 0);
                return new NOT();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Unary("not");
        }

        /// <summary>Emits SHL on the 64-bit evaluation stack.</summary>
        public readonly record struct SHL : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x34;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(SHL), variables, operands, 0);
                return new SHL();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rcx\n  pop rax\n  shl rax, cl\n  push rax";
        }

        /// <summary>Arithmetic right shift; the count is masked to six bits.</summary>
        public readonly record struct SHR : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x35;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(SHR), variables, operands, 0);
                return new SHR();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rcx\n  pop rax\n  sar rax, cl\n  push rax";
        }
        /// <summary>Logical right shift with zero fill; count uses its low six bits.</summary>
        public readonly record struct LSHR : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x36;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(LSHR), variables, operands, 0);
                return new LSHR();
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rcx\n  pop rax\n  shr rax, cl\n  push rax";
        }

    }
}
