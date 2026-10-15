using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.HighLevel;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>A CLI-requested host export that must cross the portable binary boundary before native binding.</summary>
/// <param name="FunctionName">Top-level Ubytec function to export.</param>
/// <param name="Symbol">Native System V symbol requested by the embedding host.</param>
public sealed record PortableRequestedExport(string FunctionName, string Symbol);

/// <summary>
/// Linux System V library ABI adapters generated exclusively from verified UBCM export metadata.
/// The portable x64 backend remains index-only; source names never participate in native code generation.
/// </summary>
public static class PortableSystemVLibraryAbi
{
    private static readonly string[] ArgumentRegisters = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"];
    private static readonly string[] SavedRegisters = ["rbx", "r12", "r13", "r14", "r15"];

    /// <summary>
    /// Appends host-facing System V adapters for every export carried by a verified portable library.
    /// Each adapter calls the backend's index-derived export label using Ubytec's stack ABI.
    /// </summary>
    public static string Attach(
        ReadOnlySpan<byte> moduleBytes,
        PortableX64Compilation nativeCompilation)
    {
        ArgumentNullException.ThrowIfNull(nativeCompilation);

        PortableProcessEntrypoint.Verify(moduleBytes);
        PortableBinaryModule module = PortableBinaryCodec.Decode(moduleBytes);
        if (PortableProcessEntrypoint.Read(module) is not null)
            throw new InvalidDataException("System V export adapters are valid only for portable libraries.");
        if (module.Executable is not { } executable)
            throw new InvalidDataException("System V export adapters require the indexed executable profile.");
        if (nativeCompilation.ExportLabels.Count != executable.Exports.Count)
            throw new InvalidDataException("Native export labels do not match the verified UBCM export table.");

        if (executable.Exports.Count == 0)
            return nativeCompilation.Assembly.ReplaceLineEndings("\n");

        var symbols = new HashSet<string>(StringComparer.Ordinal);
        var output = new StringBuilder(nativeCompilation.Assembly.ReplaceLineEndings("\n"));
        output.AppendLine("section .text");

        for (int index = 0; index < executable.Exports.Count; index++)
        {
            PortableExecutableExport export = executable.Exports[index];
            string symbol = ResolveSymbol(executable, export);
            ValidateNativeSymbol(symbol, symbols);
            ValidateSignature(executable, export, symbol);
            EmitAdapter(output, symbol, nativeCompilation.GetExportLabel(index), export.Arguments.Count);
        }

        output.AppendLine("section .note.GNU-stack noalloc noexec nowrite progbits");
        return output.ToString().ReplaceLineEndings("\n");
    }

    /// <summary>
    /// Adds command-line host exports to semantic portable contracts before UBCM serialization.
    /// This makes --host-export syntactic sugar for an export contract rather than a post-verification escape hatch.
    /// </summary>
    public static PortableModuleContracts AddRequestedExports(
        SourceSemanticCompilation frontend,
        IReadOnlyList<PortableRequestedExport>? requestedExports)
    {
        ArgumentNullException.ThrowIfNull(frontend);
        if (requestedExports is null || requestedExports.Count == 0)
            return frontend.PortableContracts;

        var exports = frontend.PortableContracts.Exports.ToList();
        var symbols = exports.Select(export => export.Symbol).ToHashSet(StringComparer.Ordinal);

        foreach (PortableRequestedExport requested in requestedExports)
        {
            ValidateHostRequestedSymbol(requested.Symbol);
            if (!symbols.Add(requested.Symbol))
                throw new ArgumentException($"Duplicate portable export symbol '{requested.Symbol}'.");

            Func function = frontend.Module.Functions.FirstOrDefault(
                item => string.Equals(item.Name, requested.FunctionName, StringComparison.Ordinal));
            if (string.IsNullOrEmpty(function.Name))
                throw new ArgumentException($"Unknown exported function '{requested.FunctionName}'.");

            PortableBoundaryParameter[] arguments = function.Arguments
                .Select(argument => new PortableBoundaryParameter(
                    PortablePassingMode.Value,
                    argument.Type.Type))
                .ToArray();
            exports.Add(new PortableExportContract(
                function.Name,
                requested.Symbol,
                function.ReturnType.Type,
                arguments));
        }

        return frontend.PortableContracts with { Exports = exports };
    }

    private static string ResolveSymbol(
        PortableExecutableModule executable,
        PortableExecutableExport export)
    {
        if (export.SymbolStringIndex >= executable.Strings.Count)
            throw new InvalidDataException("Export SymbolStringIndex is outside the verified string table.");
        return executable.Strings[checked((int)export.SymbolStringIndex)];
    }

    private static void ValidateNativeSymbol(string symbol, HashSet<string> symbols)
    {
        if (!IsNativeIdentifier(symbol))
            throw new InvalidDataException(
                $"Portable export '{symbol}' cannot be represented as a Linux System V symbol.");
        if (symbol.StartsWith("ubytec_binary_", StringComparison.Ordinal))
            throw new InvalidDataException(
                $"Portable export '{symbol}' collides with the reserved binary-backend namespace.");
        if (!symbols.Add(symbol))
            throw new InvalidDataException($"Duplicate portable export symbol '{symbol}'.");
    }

    private static void ValidateHostRequestedSymbol(string symbol)
    {
        if (!IsNativeIdentifier(symbol) || !symbol.StartsWith("ubytec_host_", StringComparison.Ordinal))
            throw new ArgumentException(
                "Host symbols must begin with ubytec_host_ and contain only ASCII identifier characters.",
                nameof(symbol));
    }

    private static bool IsNativeIdentifier(string symbol)
    {
        if (string.IsNullOrEmpty(symbol) || !(IsAsciiLetter(symbol[0]) || symbol[0] == '_'))
            return false;
        for (int index = 1; index < symbol.Length; index++)
            if (!(IsAsciiLetter(symbol[index]) || char.IsAsciiDigit(symbol[index]) || symbol[index] == '_'))
                return false;
        return true;
    }

    private static bool IsAsciiLetter(char value) =>
        value is >= 'A' and <= 'Z' or >= 'a' and <= 'z';

    private static void ValidateSignature(
        PortableExecutableModule executable,
        PortableExecutableExport export,
        string symbol)
    {
        if (export.FunctionIndex >= executable.Functions.Count)
            throw new InvalidDataException($"Export '{symbol}' FunctionIndex is outside the verified function table.");
        if (export.Arguments.Count > ArgumentRegisters.Length)
            throw new NotSupportedException(
                $"System V export '{symbol}' has more than six arguments.");

        foreach (PortableBoundaryDescriptor argument in export.Arguments)
        {
            PrimitiveType type = ResolvePrimitive(executable, argument.TypeIndex);
            if (!IsSystemVCell(type))
                throw new NotSupportedException(
                    $"System V export '{symbol}' contains unsupported argument carrier type '{type}'.");
        }

        PrimitiveType returnType = ResolvePrimitive(executable, export.ReturnTypeIndex);
        if (returnType != PrimitiveType.Void && !IsSystemVCell(returnType))
            throw new NotSupportedException(
                $"System V export '{symbol}' contains unsupported return carrier type '{returnType}'.");
    }

    private static PrimitiveType ResolvePrimitive(PortableExecutableModule executable, uint typeIndex)
    {
        if (typeIndex >= executable.Types.Count)
            throw new InvalidDataException("Export TypeIndex is outside the verified type table.");
        return executable.Types[checked((int)typeIndex)].Primitive;
    }

    private static bool IsSystemVCell(PrimitiveType type) => type is
        PrimitiveType.Byte or
        PrimitiveType.UInt32 or
        PrimitiveType.Int32 or
        PrimitiveType.UInt64 or
        PrimitiveType.Int64;

    private static void EmitAdapter(
        StringBuilder output,
        string symbol,
        string target,
        int argumentCount)
    {
        output.AppendLine($"global {symbol}");
        output.AppendLine($"{symbol}:");
        output.AppendLine("  push rbp");
        output.AppendLine("  mov rbp, rsp");
        foreach (string register in SavedRegisters)
            output.AppendLine($"  push {register}");
        if (argumentCount % 2 == 0)
            output.AppendLine("  sub rsp, 8");
        for (int index = 0; index < argumentCount; index++)
            output.AppendLine($"  push {ArgumentRegisters[index]}");
        output.AppendLine($"  call {target}");
        output.AppendLine("  lea rsp, [rbp-40]");
        for (int index = SavedRegisters.Length - 1; index >= 0; index--)
            output.AppendLine($"  pop {SavedRegisters[index]}");
        output.AppendLine("  pop rbp");
        output.AppendLine("  ret");
    }
}
