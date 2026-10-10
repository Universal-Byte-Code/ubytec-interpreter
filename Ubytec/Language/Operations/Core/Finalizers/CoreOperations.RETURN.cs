using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        /// <summary>Returns to the enclosing function's shared epilogue.</summary>
        /// <param name="BlockType">Optional explicit result type; otherwise the function type is used.</param>
        /// <param name="Variables">Retained expression metadata.</param>
        public readonly record struct RETURN(UType? BlockType = null, SyntaxExpression? Variables = null) : IOpCode, IOpCodeFactory
        {
            /// <summary>RETURN opcode byte.</summary>
            public const byte OP = 0x09;
            /// <inheritdoc/>
            public byte OpCode => OP;
            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length == 0) return new RETURN();
                if (operands.Length == 1 && operands[0] is UType type) return new RETURN(type);
                if (operands.Length is 1 or 2 && operands[0] is PrimitiveType primitive &&
                    (operands.Length == 1 || operands[1] is TypeModifiers))
                    return new RETURN(new UType(primitive, operands.Length == 2 ? (TypeModifiers)operands[1] : TypeModifiers.None));
                throw new SyntaxException(0xBAD071, "RETURN expects no operand or one result type.");
            }
            /// <inheritdoc/>
            public string Compile(CompilationScopes scopes)
            {
                var frame = scopes.All.FirstOrDefault(x => x.DeclaredByKeyword is "func" or "action")
                    ?? throw new SyntaxException(0xBAD072, "RETURN requires a function or action frame.");
                var expected = frame.ExpectedReturnType!.Value;
                if (BlockType is UType actual && (actual.Type != expected.Type || actual.Modifiers != expected.Modifiers))
                    throw new SyntaxException(0xBAD073, $"RETURN type {BlockType} differs from function type {expected}.");
                // Mark each enclosing block as well as the actual function frame.
                foreach (var context in scopes.All)
                {
                    context.HasReturn = true;
                    if (ReferenceEquals(context, frame)) break;
                }
                return (expected.Type == PrimitiveType.Void ? "xor eax, eax" : "pop rax\n  " + FunctionCode.Canonicalize(expected)) +
                    $"\n  jmp {frame.EndLabel}";
            }
        }
    }
}
