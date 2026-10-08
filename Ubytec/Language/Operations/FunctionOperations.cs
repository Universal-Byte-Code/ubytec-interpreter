using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations;

/// <summary>Calls using the internal Ubytec stack convention.</summary>
public static class FunctionOperations
{
    /// <summary>Consumes the target's arguments and pushes its result when non-void.</summary>
    /// <param name="FunctionName">Name of a callable in the enclosing module or local context.</param>
    public readonly record struct CALL(string FunctionName) : IOpCode, IOpCodeFactory
    {
        /// <summary>Assigned byte for the new CALL instruction.</summary>
        public const byte OP = 0x60;
        /// <inheritdoc/>
        public byte OpCode => OP;

        /// <inheritdoc/>
        public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
        {
            StackCode.Validate(nameof(CALL), variables, operands, 0);
            if (tokens.Length != 2)
                throw new SyntaxException(0xBAD065, "CALL requires exactly one function name.");
            return new CALL(FunctionCode.Identifier(tokens[1].Source));
        }

        internal string? CompileTail(CompilationScopes scopes)
        {
            if (!scopes.OptimizeTailCalls) return null;
            var frame = scopes.All.FirstOrDefault(x => x.DeclaredByKeyword is "func" or "action");
            if (frame is null) return null;
            var target = scopes.ResolveCallable(FunctionName);
            if (target.ArgumentCount != frame.ArgumentCount || frame.ExpectedReturnType is not { } result ||
                target.ReturnType.Type != result.Type || target.ReturnType.Modifiers != result.Modifiers)
                return null;
            var output = new System.Text.StringBuilder("; tail call: reuse incoming argument cells\n");
            // Arguments have already been evaluated below RBP. Copy in pop order into the
            // incoming area above the saved frame/return address, without overlapping sources.
            for (int i = 0; i < target.ArgumentCount; i++)
                output.AppendLine($"pop rax\n  mov qword [rbp + {16 + i * 8}], rax");
            output.AppendLine("mov rsp, rbp\n  pop rbp");
            return output.AppendLine($"jmp {target.Label}").ToString();
        }

        /// <inheritdoc/>
        public string Compile(CompilationScopes scopes)
        {
            var target = scopes.ResolveCallable(FunctionName);
            return $"call {target.Label}" +
                (target.ArgumentCount > 0 ? $"\n  add rsp, {target.ArgumentCount * 8}" : "") +
                (target.ReturnType.Type != PrimitiveType.Void ? "\n  push rax" : "");
        }
    }
    /// <summary>Pushes a local callable's address using the internal stack ABI.</summary>
    public readonly record struct FNADDR(string FunctionName) : IOpCode, IOpCodeFactory
    {
        public const byte OP = 0x61;
        public byte OpCode => OP;
        public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
        {
            StackCode.Validate(nameof(FNADDR), variables, operands, 0);
            if (tokens.Length != 2) throw new SyntaxException(0xBAD0A0, "FNADDR requires exactly one callable name.");
            return new FNADDR(FunctionCode.Identifier(tokens[1].Source));
        }
        public string Compile(CompilationScopes scopes) =>
            $"lea rax, [rel {scopes.ResolveCallable(FunctionName).Label}]\n  push rax";
    }

    /// <summary>Calls a raw internal-ABI address above ArgumentCount argument cells.</summary>
    public readonly record struct CALLI(int ArgumentCount, PrimitiveType ReturnType) : IOpCode, IOpCodeFactory
    {
        public const byte OP = 0x62;
        public byte OpCode => OP;
        internal void Validate()
        {
            if (ArgumentCount is < 0 or > 255 ||
                (ReturnType != PrimitiveType.Void && !FunctionCode.IsCellType(new UType(ReturnType))))
                throw new SyntaxException(0xBAD0A1, "CALLI supports 0..255 arguments and a scalar integer or void result.");
        }
        public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
        {
            if (variables.Length != 0 || (tokens.Length != 0 && (tokens.Length != 3 || !tokens[2].Source.StartsWith("t_", StringComparison.OrdinalIgnoreCase))) || operands.Length < 2)
                throw new SyntaxException(0xBAD0A2, "CALLI expects an argument count and an unmodified result type.");
            int count = StackCode.Index(nameof(CALLI), [operands[0]], 255);
            UType result = operands[1..] switch
            {
                [UType type] => type,
                [PrimitiveType type] => new(type),
                [PrimitiveType type, TypeModifiers flags] => new(type, flags),
                _ => throw new SyntaxException(0xBAD0A3, "CALLI expects one result type.")
            };
            if (result.Modifiers != TypeModifiers.None)
                throw new SyntaxException(0xBAD0A4, "CALLI result modifiers are unsupported.");
            var instruction = new CALLI(count, result.Type);
            instruction.Validate();
            return instruction;
        }
        public string Compile(CompilationScopes scopes)
        {
            Validate();
            return "pop rax\n  call rax" +
                (ArgumentCount != 0 ? $"\n  add rsp, {ArgumentCount * 8}" : "") +
                (ReturnType != PrimitiveType.Void ? "\n  " + FunctionCode.Canonicalize(new UType(ReturnType)) + "\n  push rax" : "");
        }
    }

}
