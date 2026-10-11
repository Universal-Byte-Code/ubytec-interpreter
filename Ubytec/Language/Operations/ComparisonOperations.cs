using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    /// <summary>Operations on 64-bit evaluation stack cells.</summary>
    public static class ComparisonOperations
    {
        /// <summary>Emits EQ on the 64-bit evaluation stack.</summary>
        public readonly record struct EQ : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x40;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(EQ), variables, operands, 0);
                return new EQ();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("e");
        }

        /// <summary>Emits NEQ on the 64-bit evaluation stack.</summary>
        public readonly record struct NEQ : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x41;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(NEQ), variables, operands, 0);
                return new NEQ();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("ne");
        }

        /// <summary>Emits LT on the 64-bit evaluation stack.</summary>
        public readonly record struct LT : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x42;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(LT), variables, operands, 0);
                return new LT();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("l");
        }

        /// <summary>Emits LE on the 64-bit evaluation stack.</summary>
        public readonly record struct LE : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x43;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(LE), variables, operands, 0);
                return new LE();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("le");
        }

        /// <summary>Emits GT on the 64-bit evaluation stack.</summary>
        public readonly record struct GT : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x44;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(GT), variables, operands, 0);
                return new GT();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("g");
        }

        /// <summary>Emits GE on the 64-bit evaluation stack.</summary>
        public readonly record struct GE : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x45;
            /// <inheritdoc/>
            public byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(GE), variables, operands, 0);
                return new GE();
            }

            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("ge");
        }
        /// <summary>Unsigned ordered comparison; produces canonical zero or one.</summary>
        public readonly record struct ULT : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x46;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(ULT), variables, operands, 0);
                return new ULT();
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("b");
        }

        /// <summary>Unsigned ordered comparison; produces canonical zero or one.</summary>
        public readonly record struct ULE : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x47;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(ULE), variables, operands, 0);
                return new ULE();
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("be");
        }

        /// <summary>Unsigned ordered comparison; produces canonical zero or one.</summary>
        public readonly record struct UGT : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x48;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(UGT), variables, operands, 0);
                return new UGT();
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("a");
        }

        /// <summary>Unsigned ordered comparison; produces canonical zero or one.</summary>
        public readonly record struct UGE : IOpCode, IOpCodeFactory
        {
            /// <summary>Encoded opcode byte.</summary>
            public const byte OP = 0x49;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                StackCode.Validate(nameof(UGE), variables, operands, 0);
                return new UGE();
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes) => StackCode.Compare("ae");
        }

    }
}
