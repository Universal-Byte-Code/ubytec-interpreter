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
        public readonly record struct BRANCH(object CaseValue, int? LabelIDx = null, UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory
        {
            public const byte OP = 0x0A;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Caso 1: BRANCH con CaseValue únicamente
                if (operands.Length == 1)
                {
                    return new BRANCH(operands[0])
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 2: BRANCH con CaseValue y LabelIDx
                if (operands.Length == 2 && operands[1] is int labelIdx)
                {
                    return new BRANCH(operands[0], labelIdx)
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 3: BRANCH con CaseValue, LabelIDx y BlockType
                if (operands.Length == 3 && operands[1] is int labelIdx3 && operands[2] is UType blockType3)
                {
                    return new BRANCH(operands[0], labelIdx3, blockType3)
                    {
                        Variables = new([.. variables])
                    };
                }

                // Caso 4: BRANCH con CaseValue y BlockType (sin LabelIDx)
                if (operands.Length == 2 && operands[1] is UType blockType2)
                {
                    return new BRANCH(operands[0], null, blockType2)
                    {
                        Variables = new([.. variables])
                    };
                }

                throw new SyntaxException(0x0ABADBEEF, $"BRANCH opcode received unexpected operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                if (scopes.Count == 0)
                    throw new SyntaxStackException(0x0AFACADE, "BRANCH without matching SWITCH");

                var parentSwitch = scopes.Find(ctx => ctx.DeclaredByKeyword == "switch")
                    ?? throw new SyntaxStackException(0xBADA001A, "BRANCH must be nested inside a SWITCH block");

                string branchLabel = LabelIDx == null ? NextLabel("branch") : $"branch_{LabelIDx}";
                string branchEndLabel = LabelIDx == null ? NextLabel("end_branch") : $"end_branch_{LabelIDx}";

                scopes.Push(new()
                {
                    StartLabel = branchLabel,
                    EndLabel = branchEndLabel,
                    ExpectedReturnType = BlockType,
                    DeclaredByKeyword = "branch"
                });

                return
                    $"{branchLabel}: ; Start BRANCH block\n" +
                    $"  pop rax\n" +
                    $"  cmp rax, {CaseValue}\n" +
                    $"  jne {branchEndLabel} ; Skip branch if condition fails";
            }
        }
    }
}