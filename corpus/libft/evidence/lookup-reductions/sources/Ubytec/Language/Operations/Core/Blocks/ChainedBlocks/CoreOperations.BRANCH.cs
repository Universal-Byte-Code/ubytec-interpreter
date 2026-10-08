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
        public readonly record struct BRANCH(object CaseValue, int? LabelIDx = null, UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory, IEquatable<BRANCH>
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
                if (operands.Length == 2 && operands[1] is not UType and not PrimitiveType)
                {
                    return new BRANCH(operands[0], StackCode.Index(nameof(BRANCH), [operands[1]], int.MaxValue))
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
                var parent = scopes.PeekOrDefault();
                if (parent?.DeclaredByKeyword != "switch" || parent.HasDefault)
                    throw new SyntaxStackException(0xBAD084, "BRANCH must be directly inside SWITCH, before DEFAULT.");
                string start = NextLabel("branch"), end = NextLabel("end_branch");
                long value = FunctionCode.InitialValue(new(PrimitiveType.Int64), CaseValue);
                scopes.Push(new() { StartLabel = start, EndLabel = end, DeclaredByKeyword = "branch",
                    LabelIndex = LabelIDx, ExpectedReturnType = BlockType });
                return $"{start}:\n  mov rax, {value}\n  cmp qword [rbp - {-parent.SwitchOffset}], rax\n  jne {end}";
            }
        }
    }
}
