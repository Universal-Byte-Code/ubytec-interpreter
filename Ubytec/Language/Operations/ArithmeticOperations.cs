using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    /// <summary>Operations on 64-bit evaluation stack cells.</summary>
    public static class ArithmeticOperations
    {
        /// <summary>Emits ADD on the 64-bit evaluation stack.</summary>
        public readonly record struct ADD : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x20;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(ADD), variables, operands, 0);
                return new ADD();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Binary("add");
        }

        /// <summary>Emits SUB on the 64-bit evaluation stack.</summary>
        public readonly record struct SUB : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x21;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(SUB), variables, operands, 0);
                return new SUB();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Binary("sub");
        }

        /// <summary>Emits MUL on the 64-bit evaluation stack.</summary>
        public readonly record struct MUL : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x22;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(MUL), variables, operands, 0);
                return new MUL();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Binary("imul");
        }

        /// <summary>Signed division; traps on zero divisors and quotient overflow.</summary>
        public readonly record struct DIV : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x23;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(DIV), variables, operands, 0);
                return new DIV();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rcx\n  pop rax\n  cqo\n  idiv rcx\n  push rax";
        }

        /// <summary>Signed remainder; traps on zero divisors and quotient overflow.</summary>
        public readonly record struct MOD : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x24;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(MOD), variables, operands, 0);
                return new MOD();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rcx\n  pop rax\n  cqo\n  idiv rcx\n  push rdx";
        }

        /// <summary>Emits INC on the 64-bit evaluation stack.</summary>
        public readonly record struct INC : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x25;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(INC), variables, operands, 0);
                return new INC();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Unary("inc");
        }

        /// <summary>Emits DEC on the 64-bit evaluation stack.</summary>
        public readonly record struct DEC : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x26;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(DEC), variables, operands, 0);
                return new DEC();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Unary("dec");
        }

        /// <summary>Emits NEG on the 64-bit evaluation stack.</summary>
        public readonly record struct NEG : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x27;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(NEG), variables, operands, 0);
                return new NEG();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Unary("neg");
        }

        /// <summary>Emits ABS on the 64-bit evaluation stack.</summary>
        public readonly record struct ABS : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x28;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(ABS), variables, operands, 0);
                return new ABS();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rax\n  cqo\n  xor rax, rdx\n  sub rax, rdx\n  push rax";
        }
        /// <summary>Unsigned division; a zero divisor raises the CPU divide exception.</summary>
        public readonly record struct UDIV : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x29;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(UDIV), variables, operands, 0);
                return new UDIV();
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rcx\n  pop rax\n  xor edx, edx\n  div rcx\n  push rax";
        }

        /// <summary>Unsigned remainder; a zero divisor raises the CPU divide exception.</summary>
        public readonly record struct UMOD : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x2A;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(UMOD), variables, operands, 0);
                return new UMOD();
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => "pop rcx\n  pop rax\n  xor edx, edx\n  div rcx\n  push rdx";
        }

    }
}
