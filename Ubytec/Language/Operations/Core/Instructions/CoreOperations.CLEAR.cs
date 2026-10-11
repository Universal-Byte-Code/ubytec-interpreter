using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct CLEAR : IOpCode, IOpCodeFactory, IEquatable<CLEAR>
        {
            public const byte OP = 0x0D;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands) =>
                CreateOperandless(operands, 0x0DBADBEEF, nameof(CLEAR), static () => new CLEAR());

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                var frame = scopes.All.FirstOrDefault(x => x.DeclaredByKeyword is "func" or "action");
                return frame is null || frame.FrameSize == 0 ? "mov rsp, rbp" : $"lea rsp, [rbp - {frame.FrameSize}]";
            }

            public string Compile(CompilationScopes scopes)
            {
                return ((IOpCode)this).Compile(scopes);
            }
        }
    }
}
