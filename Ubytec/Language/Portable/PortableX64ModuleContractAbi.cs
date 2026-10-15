using System.Globalization;
using System.Text;
using Ubytec.Language.AST;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>
/// Projects a verified UBCM ContractManifest into the Linux module-loader ABI. The manifest is not
/// an authority grant: it names import slots and exports. Runtime grants remain supervisor-owned.
/// Every emitted import/export adapter is cross-checked against the verified indexed tables first.
/// </summary>
public static class PortableX64ModuleContractAbi
{
    private const string RuntimeModule = "ubytec.runtime";
    private static readonly string[] ArgumentRegisters = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"];
    private static readonly string[] SavedRegisters = ["rbx", "r12", "r13", "r14", "r15"];

    /// <summary>
    /// Emits source-contract import adapters, host-facing contract exports and the native
    /// <c>.ubytec_contract</c> section exclusively from verified UBCM bytes.
    /// </summary>
    public static PortableX64Compilation Attach(
        ReadOnlySpan<byte> moduleBytes,
        PortableX64Compilation nativeCompilation)
    {
        ArgumentNullException.ThrowIfNull(nativeCompilation);
        PortableProcessEntrypoint.Verify(moduleBytes);
        PortableModuleImage image = PortableModuleFormat.Decode(moduleBytes);
        PortableModuleSection? manifestSection = image.GetSection(PortableModuleSectionKind.ContractManifest);
        if (manifestSection is null)
            return nativeCompilation;

        byte[] manifestBytes = manifestSection.Payload.ToArray();
        if (manifestBytes.Length == 0 || manifestBytes.Length > 4096)
            throw new InvalidDataException("Portable contract manifest must contain 1..4096 bytes.");
        string manifest = StrictAscii(manifestBytes);
        ContractModel contract = ParseManifest(manifest);

        PortableBinaryModule module = PortableBinaryCodec.Decode(moduleBytes);
        PortableExecutableModule executable = module.Executable
            ?? throw new InvalidDataException("Portable module contracts require the indexed executable profile.");
        if (nativeCompilation.ImportLabels.Count != executable.Imports.Count ||
            nativeCompilation.ExportLabels.Count != executable.Exports.Count)
        {
            throw new InvalidDataException("Native labels do not match the verified UBCM boundary tables.");
        }

        string assembly = nativeCompilation.Assembly.ReplaceLineEndings("\n");
        var output = new StringBuilder();
        var externs = new HashSet<string>(StringComparer.Ordinal);
        var claimedImports = new HashSet<int>();
        var claimedExports = new HashSet<int>();

        foreach (ContractImport entry in contract.Imports)
        {
            int importIndex = FindImport(executable, entry, claimedImports);
            PortableExecutableImport import = executable.Imports[importIndex];
            string label = nativeCompilation.GetImportLabel(importIndex);
            assembly = RemoveExtern(assembly, label);
            string signature = Signature(executable, import);
            if (!string.Equals(signature, entry.Signature, StringComparison.Ordinal))
                throw new InvalidDataException($"Contract import '{entry.Alias}' signature disagrees with verified UBCM.");

            if (string.Equals(entry.Signature, ModuleContracts.BufferSignature, StringComparison.Ordinal))
            {
                AddExtern(output, externs, "ubytec_bridge_call");
                EmitBufferImport(output, label, entry.Handle);
            }
            else
            {
                AddExtern(output, externs, "ubytec_bridge_many");
                EmitTypedImport(output, label, entry.Handle, executable, import);
            }
        }

        int nonRuntimeImports = Enumerable.Range(0, executable.Imports.Count)
            .Count(index => !IsRuntimeImport(executable, executable.Imports[index]));
        if (claimedImports.Count != nonRuntimeImports)
            throw new InvalidDataException("Contract manifest does not account for every non-runtime UBCM import slot.");

        foreach (ContractExport entry in contract.Exports)
        {
            int exportIndex = FindExport(executable, entry, claimedExports);
            PortableExecutableExport export = executable.Exports[exportIndex];
            string signature = Signature(executable, export);
            if (!string.Equals(signature, entry.Signature, StringComparison.Ordinal))
                throw new InvalidDataException($"Contract export '{entry.Name}' signature disagrees with verified UBCM.");
            EmitSystemVExport(
                output,
                entry.NativeSymbol,
                nativeCompilation.GetExportLabel(exportIndex),
                export.Arguments.Count);
        }

        output.AppendLine("section .ubytec_contract alloc noexec nowrite progbits");
        output.Append("db ").AppendLine(string.Join(",", manifestBytes));

        var combined = new StringBuilder(assembly);
        combined.AppendLine("section .text");
        combined.Append(output);
        combined.AppendLine("section .note.GNU-stack noalloc noexec nowrite progbits");
        return nativeCompilation with { Assembly = combined.ToString().ReplaceLineEndings("\n") };
    }

    private static int FindImport(
        PortableExecutableModule executable,
        ContractImport entry,
        HashSet<int> claimed)
    {
        for (int index = 0; index < executable.Imports.Count; index++)
        {
            if (claimed.Contains(index)) continue;
            PortableExecutableImport candidate = executable.Imports[index];
            if (IsRuntimeImport(executable, candidate)) continue;
            if (!string.Equals(ResolveString(executable, candidate.ModuleStringIndex), entry.Module, StringComparison.Ordinal) ||
                !string.Equals(ResolveString(executable, candidate.SymbolStringIndex), entry.Symbol, StringComparison.Ordinal) ||
                !string.Equals(Signature(executable, candidate), entry.Signature, StringComparison.Ordinal))
                continue;
            claimed.Add(index);
            return index;
        }
        throw new InvalidDataException($"Contract import '{entry.Alias}' has no matching verified UBCM ImportIndex.");
    }

    private static int FindExport(
        PortableExecutableModule executable,
        ContractExport entry,
        HashSet<int> claimed)
    {
        for (int index = 0; index < executable.Exports.Count; index++)
        {
            if (claimed.Contains(index)) continue;
            PortableExecutableExport candidate = executable.Exports[index];
            if (!string.Equals(ResolveString(executable, candidate.SymbolStringIndex), entry.Name, StringComparison.Ordinal) ||
                !string.Equals(Signature(executable, candidate), entry.Signature, StringComparison.Ordinal))
                continue;
            claimed.Add(index);
            return index;
        }
        throw new InvalidDataException($"Contract export '{entry.Name}' has no matching verified UBCM ExportIndex.");
    }

    private static bool IsRuntimeImport(PortableExecutableModule executable, PortableExecutableImport import) =>
        string.Equals(ResolveString(executable, import.ModuleStringIndex), RuntimeModule, StringComparison.Ordinal);

    private static string Signature(PortableExecutableModule executable, PortableExecutableImport import) =>
        string.Join(",", import.Arguments.Select(argument => Parameter(executable, argument))) +
        ":" + ResolvePrimitive(executable, import.ReturnTypeIndex);

    private static string Signature(PortableExecutableModule executable, PortableExecutableExport export) =>
        string.Join(",", export.Arguments.Select(argument => Parameter(executable, argument))) +
        ":" + ResolvePrimitive(executable, export.ReturnTypeIndex);

    private static string Parameter(PortableExecutableModule executable, PortableBoundaryDescriptor argument) =>
        argument.PassingMode switch
        {
            PortablePassingMode.LoanRead => "LoanRead",
            PortablePassingMode.LoanWrite => "LoanWrite",
            PortablePassingMode.Value => ResolvePrimitive(executable, argument.TypeIndex).ToString(),
            _ => throw new InvalidDataException("Verified UBCM contains an unknown boundary passing mode.")
        };

    private static PrimitiveType ResolvePrimitive(PortableExecutableModule executable, uint typeIndex)
    {
        if (typeIndex >= executable.Types.Count)
            throw new InvalidDataException("Contract TypeIndex is outside the verified type table.");
        return executable.Types[checked((int)typeIndex)].Primitive;
    }

    private static string ResolveString(PortableExecutableModule executable, uint stringIndex)
    {
        if (stringIndex >= executable.Strings.Count)
            throw new InvalidDataException("Contract StringIndex is outside the verified string table.");
        return executable.Strings[checked((int)stringIndex)];
    }

    private static void EmitBufferImport(StringBuilder output, string label, int handle)
    {
        output.AppendLine($"{label}:");
        output.AppendLine("  push rbp");
        output.AppendLine("  mov rbp, rsp");
        output.AppendLine($"  mov rdi, {handle}");
        output.AppendLine("  mov rsi, [rbp+48]");
        output.AppendLine("  mov rdx, [rbp+40]");
        output.AppendLine("  mov rcx, [rbp+32]");
        output.AppendLine("  mov r8, [rbp+24]");
        output.AppendLine("  mov r9, [rbp+16]");
        output.AppendLine("  and rsp, -16");
        output.AppendLine("  call ubytec_bridge_call");
        output.AppendLine("  mov rsp, rbp");
        output.AppendLine("  pop rbp");
        output.AppendLine("  ret");
    }

    private static void EmitTypedImport(
        StringBuilder output,
        string label,
        int handle,
        PortableExecutableModule executable,
        PortableExecutableImport import)
    {
        int cells = 2;
        foreach (PortableBoundaryDescriptor argument in import.Arguments)
            cells = checked(cells + (argument.PassingMode is PortablePassingMode.LoanRead or PortablePassingMode.LoanWrite ? 2 : 1));
        int localBytes = Math.Max(24, import.Arguments.Count * 24);
        int cell = 0;
        int Offset(int index) => 16 + (cells - 1 - index) * 8;

        output.AppendLine($"{label}:");
        output.AppendLine("  push rbp");
        output.AppendLine("  mov rbp, rsp");
        output.AppendLine($"  sub rsp, {localBytes}");
        for (int index = 0; index < import.Arguments.Count; index++)
        {
            PortableBoundaryDescriptor argument = import.Arguments[index];
            int record = -localBytes + index * 24;
            int kind = argument.PassingMode switch
            {
                PortablePassingMode.LoanWrite => 1,
                PortablePassingMode.LoanRead => 2,
                PortablePassingMode.Value when ResolvePrimitive(executable, argument.TypeIndex) == PrimitiveType.UInt64 => 3,
                PortablePassingMode.Value when ResolvePrimitive(executable, argument.TypeIndex) == PrimitiveType.Int64 => 4,
                _ => throw new InvalidDataException("Typed source imports support only UInt64, Int64 and loan carriers.")
            };
            output.AppendLine($"  mov qword [rbp{Signed(record)}], {kind}");
            output.AppendLine($"  mov rax, [rbp+{Offset(cell++)}]");
            output.AppendLine($"  mov [rbp{Signed(record + 8)}], rax");
            if (kind <= 2)
            {
                output.AppendLine($"  mov rax, [rbp+{Offset(cell++)}]");
                output.AppendLine($"  mov [rbp{Signed(record + 16)}], rax");
            }
            else
            {
                output.AppendLine($"  mov qword [rbp{Signed(record + 16)}], 0");
            }
        }
        output.AppendLine($"  mov rdi, {handle}");
        output.AppendLine($"  lea rsi, [rbp-{localBytes}]");
        output.AppendLine($"  mov rdx, {import.Arguments.Count}");
        output.AppendLine($"  mov rcx, [rbp+{Offset(cell++)}]");
        output.AppendLine($"  mov r8, [rbp+{Offset(cell)}]");
        output.AppendLine("  and rsp, -16");
        output.AppendLine("  call ubytec_bridge_many");
        output.AppendLine("  mov rsp, rbp");
        output.AppendLine("  pop rbp");
        output.AppendLine("  ret");
    }

    private static string Signed(int offset) => offset < 0 ? offset.ToString(CultureInfo.InvariantCulture) : "+" + offset.ToString(CultureInfo.InvariantCulture);

    private static void EmitSystemVExport(
        StringBuilder output,
        string symbol,
        string target,
        int argumentCount)
    {
        if (argumentCount > ArgumentRegisters.Length)
            throw new NotSupportedException($"Contract export '{symbol}' has more than six arguments.");
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

    private static void AddExtern(StringBuilder output, HashSet<string> externs, string symbol)
    {
        if (externs.Add(symbol)) output.AppendLine($"extern {symbol}");
    }

    private static string RemoveExtern(string assembly, string label)
    {
        string directive = $"extern {label}\n";
        int position = assembly.IndexOf(directive, StringComparison.Ordinal);
        if (position < 0)
            throw new InvalidDataException($"Contract ImportIndex label '{label}' is not declared by the x64 backend.");
        if (assembly.IndexOf(directive, position + directive.Length, StringComparison.Ordinal) >= 0)
            throw new InvalidDataException($"Contract ImportIndex label '{label}' has multiple extern declarations.");
        return assembly.Remove(position, directive.Length);
    }

    private static ContractModel ParseManifest(string manifest)
    {
        string[] lines = manifest.Split('\n');
        if (lines.Length < 3 || lines[0] != "UBC1" || lines[^2] != "END" || lines[^1].Length != 0)
            throw new InvalidDataException("Portable contract manifest has invalid UBC1 framing.");

        var imports = new List<ContractImport>();
        var exports = new List<ContractExport>();
        var handles = new HashSet<int>();
        var aliases = new HashSet<string>(StringComparer.Ordinal);
        var exportNames = new HashSet<string>(StringComparer.Ordinal);
        var nativeSymbols = new HashSet<string>(StringComparer.Ordinal);

        foreach (string line in lines.Skip(1).SkipLast(2))
        {
            string[] fields = line.Split('|');
            if (fields.Length == 6 && fields[0] == "I")
            {
                if (!int.TryParse(fields[1], NumberStyles.None, CultureInfo.InvariantCulture, out int handle) || handle is < 1 or > 16 ||
                    !handles.Add(handle) || !Identifier(fields[2]) || !aliases.Add(fields[2]) ||
                    !Identifier(fields[3]) || !Identifier(fields[4]) || string.IsNullOrEmpty(fields[5]))
                    throw new InvalidDataException("Portable contract manifest contains an invalid import row.");
                imports.Add(new ContractImport(handle, fields[2], fields[3], fields[4], fields[5]));
                continue;
            }
            if (fields.Length == 4 && fields[0] == "E")
            {
                if (!Identifier(fields[1]) || !exportNames.Add(fields[1]) ||
                    !NativeIdentifier(fields[2]) || !nativeSymbols.Add(fields[2]) || string.IsNullOrEmpty(fields[3]))
                    throw new InvalidDataException("Portable contract manifest contains an invalid export row.");
                exports.Add(new ContractExport(fields[1], fields[2], fields[3]));
                continue;
            }
            throw new InvalidDataException("Portable contract manifest contains an unknown row.");
        }
        return new ContractModel(imports, exports);
    }

    private static bool Identifier(string value) =>
        value.Length is >= 1 and <= 63 && NativeIdentifier(value);

    private static bool NativeIdentifier(string value)
    {
        if (string.IsNullOrEmpty(value) || !(AsciiLetter(value[0]) || value[0] == '_')) return false;
        for (int index = 1; index < value.Length; index++)
            if (!(AsciiLetter(value[index]) || char.IsAsciiDigit(value[index]) || value[index] == '_')) return false;
        return true;
    }

    private static bool AsciiLetter(char value) => value is >= 'A' and <= 'Z' or >= 'a' and <= 'z';

    private static string StrictAscii(byte[] bytes)
    {
        if (bytes.Any(value => value is > 0x7F or 0))
            throw new InvalidDataException("Portable contract manifest must be non-NUL ASCII.");
        return Encoding.ASCII.GetString(bytes);
    }

    private sealed record ContractModel(
        IReadOnlyList<ContractImport> Imports,
        IReadOnlyList<ContractExport> Exports);
    private sealed record ContractImport(int Handle, string Alias, string Module, string Symbol, string Signature);
    private sealed record ContractExport(string Name, string NativeSymbol, string Signature);
}
