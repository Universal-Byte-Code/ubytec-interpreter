using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations;

/// <summary>Raw typed memory access and frame-bound symbol access.</summary>
public static class MemoryOperations
{
    /// <summary>Loads a raw address with optional storage type, or a named frame binding.</summary>
    public readonly record struct LOAD(string? VariableName = null, PrimitiveType? AccessType = null) : IOpCode, IOpCodeFactory
    {
        public const byte OP = 0x50;
        public byte OpCode => OP;
        public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
        {
            var type = ParseType(nameof(LOAD), variables, operands);
            return new LOAD(type is null ? Symbol(tokens) : TypedTokens(tokens), type);
        }
        public string Compile(CompilationScopes scopes)
        {
            if (VariableName is not null)
            {
                if (AccessType is not null) throw new SyntaxException(0xBAD091, "Named LOAD already has a declared binding type.");
                var binding = scopes.ResolveSymbol(VariableName);
                return binding.Register is { } register ? $"push {register}" : FunctionCode.Load(binding) + "\n  push rax";
            }
            var type = new UType(AccessType ?? PrimitiveType.UInt64);
            ValidateType(type);
            string load = type.Type switch
            {
                PrimitiveType.Bool => "movzx eax, byte [rax]\n  test eax, eax\n  setne al\n  movzx eax, al",
                PrimitiveType.Byte or PrimitiveType.Char8 => "movzx eax, byte [rax]",
                PrimitiveType.SByte => "movsx rax, byte [rax]",
                PrimitiveType.UInt16 or PrimitiveType.Char16 => "movzx eax, word [rax]",
                PrimitiveType.Int16 => "movsx rax, word [rax]",
                PrimitiveType.UInt32 => "mov eax, dword [rax]",
                PrimitiveType.Int32 => "movsxd rax, dword [rax]",
                _ => "mov rax, qword [rax]"
            };
            return "pop rax\n  " + load + "\n  push rax";
        }
    }

    /// <summary>Stores (address value --) with optional storage type, or a named binding.</summary>
    public readonly record struct STORE(string? VariableName = null, PrimitiveType? AccessType = null) : IOpCode, IOpCodeFactory
    {
        public const byte OP = 0x51;
        public byte OpCode => OP;
        public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
        {
            var type = ParseType(nameof(STORE), variables, operands);
            return new STORE(type is null ? Symbol(tokens) : TypedTokens(tokens), type);
        }
        public string Compile(CompilationScopes scopes)
        {
            if (VariableName is not null)
            {
                if (AccessType is not null) throw new SyntaxException(0xBAD092, "Named STORE already has a declared binding type.");
                return FunctionCode.Store(scopes.ResolveSymbol(VariableName));
            }
            var type = new UType(AccessType ?? PrimitiveType.UInt64);
            ValidateType(type);
            string store = type.Type switch
            {
                PrimitiveType.Bool => "test rcx, rcx\n  setne cl\n  mov byte [rax], cl",
                PrimitiveType.Byte or PrimitiveType.SByte or PrimitiveType.Char8 => "mov byte [rax], cl",
                PrimitiveType.UInt16 or PrimitiveType.Int16 or PrimitiveType.Char16 => "mov word [rax], cx",
                PrimitiveType.UInt32 or PrimitiveType.Int32 => "mov dword [rax], ecx",
                _ => "mov qword [rax], rcx"
            };
            return "pop rcx\n  pop rax\n  " + store;
        }
    }

    private static PrimitiveType? ParseType(string name, VariableExpressionFragment[] variables, ValueType[] operands)
    {
        if (variables.Length != 0) throw new SyntaxException(0xBAD093, $"{name} does not accept inline variable declarations.");
        if (operands.Length == 0) return null;
        UType type = operands switch
        {
            [UType value] => value,
            [PrimitiveType primitive] => new(primitive),
            [PrimitiveType primitive, TypeModifiers flags] => new(primitive, flags),
            _ => throw new SyntaxException(0xBAD094, $"{name} expects no operand or one scalar access type.")
        };
        ValidateType(type);
        return type.Type;
    }

    private static void ValidateType(UType type)
    {
        if (type.Modifiers != TypeModifiers.None || !FunctionCode.IsCellType(type))
            throw new SyntaxException(0xBAD095, $"Unsupported raw memory access type {type}.");
    }

    private static string? TypedTokens(SyntaxToken[] tokens)
    {
        if (tokens.Length != 0 && (tokens.Length != 2 || !tokens[1].Source.StartsWith("t_", StringComparison.OrdinalIgnoreCase)))
            throw new SyntaxException(0xBAD096, "Typed LOAD/STORE expect exactly one type token and no symbol.");
        return null;
    }

    private static string? Symbol(SyntaxToken[] tokens) => tokens.Length switch
    {
        0 or 1 => null,
        2 => FunctionCode.Identifier(tokens[1].Source),
        _ => throw new SyntaxException(0xBAD066, "LOAD/STORE expect at most one symbol name.")
    };
}
