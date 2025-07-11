﻿using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct DEFAULT : IOpCode, IOpCodeFactory, IEquatable<DEFAULT>
        {
            public const byte OP = 0x0E;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // DEFAULT no acepta operandos
                if (operands.Length > 0)
                    throw new SyntaxException(0x0EBADBEEF, $"DEFAULT opcode should not receive any operands, but received: {operands.Length}");

                return new DEFAULT();
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes) => "mov rax, 1  ; DEFAULT non-null placeholder\n  push rax";
        }
    }
}