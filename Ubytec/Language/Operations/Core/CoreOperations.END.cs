using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct END : IOpCode, IOpCodeFactory, IEquatable<END>
        {
            public const byte OP = 0x06;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (operands.Length > 0)
                    throw new SyntaxException(0x06BADBEEF, $"END opcode should not receive any operands, but received: {operands.Length}");

                return new END();
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                if (scopes.Count == 0)
                    throw new SyntaxStackException(0x06FACADE, "END without matching block start or expected type.");

                scopes.ValidateFinalScope();

                var blockContext = scopes.TryPopUntil(_ => true)
                    ?? throw new SyntaxStackException(0x06E0FFFACE, "END could not find a block to close.");


                var sb = new System.Text.StringBuilder();

                switch (blockContext.DeclaredByKeyword)
                {
                    case "while":
                        sb.AppendLine("  pop rax       ; Load loop counter")
                          .AppendLine("  dec rax       ; Decrement counter")
                          .AppendLine("  push rax      ; Store updated counter")
                          .AppendLine("  cmp rax, 0    ; Check if counter is zero")
                          .AppendLine($"  je {blockContext.EndLabel} ; Exit loop if counter == 0")
                          .AppendLine($"  jmp {blockContext.StartLabel} ; Continue loop if not zero");
                        break;

                    case "loop":
                        sb.AppendLine($"  jmp {blockContext.StartLabel} ; LOOP: continue iteration");
                        break;

                    case "branch":
                    case "switch":
                    case "block":
                    case "func":
                    case "if":
                    case "else":
                        // No salto necesario
                        break;

                    default:
                        throw new SyntaxStackException(0x06DEADBEEF, $"Unknown block type '{blockContext.DeclaredByKeyword}' in END.");
                }

                sb.AppendLine($"{blockContext.EndLabel}: ; END of {blockContext.StartLabel}");
                return sb.ToString();
            }
        }
    }
}
