using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using Ubytec.Language.Exceptions;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations;

/// <summary>Names and frame bindings shared by functions and data instructions.</summary>
internal static class FunctionCode
{
    internal static string Label(string prefix, string name, Guid id, string suffix) =>
        $"{prefix}_{Convert.ToHexString(Encoding.UTF8.GetBytes(name))}_{id:N}_{suffix}";

    internal static string Identifier(string source)
    {
        string name = source.StartsWith('@') ? source[1..] : source;
        if (!Regex.IsMatch(name, @"\A[A-Za-z_][A-Za-z0-9_]*\z"))
            throw new SyntaxException(0xBAD060, $"Invalid symbol name '{source}'.");
        return name;
    }

    internal static bool IsCellType(UType type) => (type.Modifiers & ~(TypeModifiers.Const | TypeModifiers.ReadOnly)) == TypeModifiers.None &&
        type.Type is PrimitiveType.Bool or PrimitiveType.Char8 or PrimitiveType.Char16 or PrimitiveType.Byte or
            PrimitiveType.SByte or PrimitiveType.Int16 or PrimitiveType.UInt16 or PrimitiveType.Int32 or
            PrimitiveType.UInt32 or PrimitiveType.Int64 or PrimitiveType.UInt64;

    internal static long InitialValue(UType type, object? value)
    {
        if (!IsCellType(type))
            throw new SyntaxException(0xBAD061, $"Local type {type} is not supported by the integer cell backend.");
        if (value is null) return 0;
        string text = Convert.ToString(value, CultureInfo.InvariantCulture) ?? "";
        if (text.Equals("true", StringComparison.OrdinalIgnoreCase)) return 1;
        if (text.Equals("false", StringComparison.OrdinalIgnoreCase)) return 0;
        if (text.Length == 3 && text[0] == '\'' && text[2] == '\'') return text[1];
        if (text.StartsWith("0x", StringComparison.OrdinalIgnoreCase))
            return unchecked((long)ulong.Parse(text[2..], NumberStyles.HexNumber, CultureInfo.InvariantCulture));
        if (text.StartsWith("0b", StringComparison.OrdinalIgnoreCase))
            return unchecked((long)Convert.ToUInt64(text[2..], 2));
        if (long.TryParse(text, NumberStyles.Integer, CultureInfo.InvariantCulture, out long signed)) return signed;
        if (ulong.TryParse(text, NumberStyles.Integer, CultureInfo.InvariantCulture, out ulong unsigned))
            return unchecked((long)unsigned);
        throw new SyntaxException(0xBAD062, $"Invalid integer initializer '{text}'.");
    }

    internal static string Canonicalize(UType type) => type.Type switch
    {
        PrimitiveType.Bool => "test rax, rax\n  setne al\n  movzx eax, al",
        PrimitiveType.Char8 or PrimitiveType.Byte => "movzx eax, al",
        PrimitiveType.SByte => "movsx rax, al",
        PrimitiveType.Char16 or PrimitiveType.UInt16 => "movzx eax, ax",
        PrimitiveType.Int16 => "movsx rax, ax",
        PrimitiveType.UInt32 => "mov eax, eax",
        PrimitiveType.Int32 => "movsxd rax, eax",
        PrimitiveType.Int64 or PrimitiveType.UInt64 => "",
        _ => throw new SyntaxException(0xBAD079, $"Unsupported return type {type}.")
    };

    internal static string Load(StackBinding binding)
    {
        if (binding.Register is { } register) return $"mov rax, {register}";
        string address = binding.Address;
        return binding.Type.Type switch
        {
            PrimitiveType.Bool => $"mov rax, qword {address}\n  " + Canonicalize(binding.Type),
            PrimitiveType.Char8 or PrimitiveType.Byte => $"movzx eax, byte {address}",
            PrimitiveType.SByte => $"movsx rax, byte {address}",
            PrimitiveType.Char16 or PrimitiveType.UInt16 => $"movzx eax, word {address}",
            PrimitiveType.Int16 => $"movsx rax, word {address}",
            PrimitiveType.UInt32 => $"mov eax, dword {address}",
            PrimitiveType.Int32 => $"movsxd rax, dword {address}",
            PrimitiveType.Int64 or PrimitiveType.UInt64 => $"mov rax, qword {address}",
            _ => throw new SyntaxException(0xBAD063, $"Cannot load local type {binding.Type}.")
        };
    }

    internal static string Store(StackBinding binding)
    {
        if (binding.ReadOnly)
            throw new SyntaxException(0xBAD064, $"Cannot store to readonly symbol '{binding.Name}'.");
        return $"pop rax\n  {Canonicalize(binding.Type)}\n  mov qword {binding.Address}, rax" +
            (binding.Register is { } register ? $"\n  mov {register}, rax" : "");
    }
}

/// <summary>A frame-relative variable or argument binding.</summary>
public sealed record StackBinding(string Name, UType Type, int Offset, bool ReadOnly = false)
{
    internal string? Register { get; init; }

    /// <summary>Stable address relative to the function frame pointer.</summary>
    public string Address => $"[rbp {(Offset < 0 ? "-" : "+")} {Math.Abs(Offset)}]";
}

/// <summary>The internal stack calling convention for a callable.</summary>
public sealed record CallableBinding(string Name, string Label, int ArgumentCount, UType ReturnType);
