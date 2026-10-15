using System.Text;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>
/// Reserved supervisor/runtime imports used by language features such as ModuleInvoke and host I/O.
/// The source aliases are lowered into ordinary indexed UBCM imports; x64 binding happens only after
/// the portable module has crossed the independent verifier boundary.
/// </summary>
public static class PortableX64RuntimeImports
{
    private const string RuntimeModule = "ubytec.runtime";
    private const string ModuleInvokeSymbol = "module.invoke";
    private const string HostReadSymbol = "host.read";
    private const string HostWriteSymbol = "host.write";

    /// <summary>Adds the reserved runtime import contracts required by enabled language features.</summary>
    public static PortableModuleContracts AddContracts(
        PortableModuleContracts contracts,
        bool enableModuleCalls,
        bool enableHostIO)
    {
        ArgumentNullException.ThrowIfNull(contracts);
        if (!enableModuleCalls)
            return contracts;

        var imports = contracts.Imports.ToList();
        // ModuleInvoke's internal stack ABI is:
        //   module_handle, buffer, length, rights, budget_ms, result_address
        // Indexed import calls already carry budget_ms + result_address as the two boundary-control
        // cells, so only the first four logical arguments belong in the portable import signature.
        // The handle is UInt32 to distinguish this runtime operation from the legacy four-UInt64
        // buffer contract, whose v0 compatibility calling convention consumes five cells.
        Add(imports, new PortableImportContract(
            "ModuleInvoke",
            RuntimeModule,
            ModuleInvokeSymbol,
            PrimitiveType.Int64,
            [
                new PortableBoundaryParameter(PortablePassingMode.Value, PrimitiveType.UInt32),
                new PortableBoundaryParameter(PortablePassingMode.Value, PrimitiveType.UInt64),
                new PortableBoundaryParameter(PortablePassingMode.Value, PrimitiveType.UInt64),
                new PortableBoundaryParameter(PortablePassingMode.Value, PrimitiveType.UInt64)
            ]));

        if (enableHostIO)
        {
            // HostRead/HostWrite use the established v0 buffer-call convention:
            //   resource_handle, byte_offset, local_buffer, logical_length, result_address
            // The first four cells are the portable boundary arguments and the final result cell is
            // the v0 implicit return-address cell, so the verified CALL consumes five cells.
            Add(imports, new PortableImportContract(
                "HostRead",
                RuntimeModule,
                HostReadSymbol,
                PrimitiveType.Int64,
                ValueCells(4)));
            Add(imports, new PortableImportContract(
                "HostWrite",
                RuntimeModule,
                HostWriteSymbol,
                PrimitiveType.Int64,
                ValueCells(4)));
        }

        return contracts with { Imports = imports };
    }

    /// <summary>
    /// Resolves reserved runtime ImportIndex labels to the native supervisor bridge without exposing
    /// source aliases to the index-only backend. Non-runtime imports remain unresolved for the loader.
    /// </summary>
    public static PortableX64Compilation Attach(
        ReadOnlySpan<byte> moduleBytes,
        PortableX64Compilation nativeCompilation)
    {
        ArgumentNullException.ThrowIfNull(nativeCompilation);
        PortableProcessEntrypoint.Verify(moduleBytes);
        PortableBinaryModule module = PortableBinaryCodec.Decode(moduleBytes);
        PortableExecutableModule executable = module.Executable
            ?? throw new InvalidDataException("Runtime import binding requires the indexed executable profile.");
        if (nativeCompilation.ImportLabels.Count != executable.Imports.Count)
            throw new InvalidDataException("Native import labels do not match the verified UBCM import table.");

        string assembly = nativeCompilation.Assembly.ReplaceLineEndings("\n");
        var adapters = new StringBuilder();
        var externs = new HashSet<string>(StringComparer.Ordinal);

        for (int index = 0; index < executable.Imports.Count; index++)
        {
            PortableExecutableImport import = executable.Imports[index];
            string provider = ResolveString(executable, import.ModuleStringIndex, "module");
            if (!string.Equals(provider, RuntimeModule, StringComparison.Ordinal))
                continue;

            string symbol = ResolveString(executable, import.SymbolStringIndex, "symbol");
            string bridge = symbol switch
            {
                ModuleInvokeSymbol => "ubytec_bridge_call",
                HostReadSymbol => "ubytec_bridge_read",
                HostWriteSymbol => "ubytec_bridge_write",
                _ => throw new InvalidDataException($"Unknown reserved Ubytec runtime import '{symbol}'.")
            };
            int stackCells = symbol == ModuleInvokeSymbol ? 6 : 5;
            ValidateSignature(executable, import, symbol);

            string label = nativeCompilation.GetImportLabel(index);
            assembly = RemoveExtern(assembly, label);
            if (externs.Add(bridge))
                adapters.AppendLine($"extern {bridge}");
            EmitAdapter(adapters, label, bridge, stackCells);
        }

        if (adapters.Length == 0)
            return nativeCompilation;

        var output = new StringBuilder(assembly);
        output.AppendLine("section .text");
        output.Append(adapters);
        output.AppendLine("section .note.GNU-stack noalloc noexec nowrite progbits");
        return nativeCompilation with { Assembly = output.ToString().ReplaceLineEndings("\n") };
    }

    private static void Add(List<PortableImportContract> imports, PortableImportContract contract)
    {
        if (imports.Any(import => string.Equals(import.SourceAlias, contract.SourceAlias, StringComparison.Ordinal)))
            throw new InvalidDataException($"Portable runtime import alias '{contract.SourceAlias}' is already defined.");
        imports.Add(contract);
    }

    private static PortableBoundaryParameter[] ValueCells(int count) =>
        Enumerable.Range(0, count)
            .Select(_ => new PortableBoundaryParameter(PortablePassingMode.Value, PrimitiveType.UInt64))
            .ToArray();

    private static string ResolveString(PortableExecutableModule executable, uint index, string field)
    {
        if (index >= executable.Strings.Count)
            throw new InvalidDataException($"Runtime import {field} StringIndex is outside the verified string table.");
        return executable.Strings[checked((int)index)];
    }

    private static void ValidateSignature(
        PortableExecutableModule executable,
        PortableExecutableImport import,
        string symbol)
    {
        if (ResolvePrimitive(executable, import.ReturnTypeIndex) != PrimitiveType.Int64)
            throw new InvalidDataException($"Reserved runtime import '{symbol}' must return Int64.");

        PrimitiveType[] expected = symbol switch
        {
            ModuleInvokeSymbol => [PrimitiveType.UInt32, PrimitiveType.UInt64, PrimitiveType.UInt64, PrimitiveType.UInt64],
            HostReadSymbol or HostWriteSymbol =>
                [PrimitiveType.UInt64, PrimitiveType.UInt64, PrimitiveType.UInt64, PrimitiveType.UInt64],
            _ => throw new InvalidDataException($"Unknown reserved Ubytec runtime import '{symbol}'.")
        };

        if (import.Arguments.Count != expected.Length)
            throw new InvalidDataException($"Reserved runtime import '{symbol}' has an invalid verified argument count.");
        for (int index = 0; index < expected.Length; index++)
        {
            PortableBoundaryDescriptor argument = import.Arguments[index];
            if (argument.PassingMode != PortablePassingMode.Value ||
                ResolvePrimitive(executable, argument.TypeIndex) != expected[index])
            {
                throw new InvalidDataException($"Reserved runtime import '{symbol}' has an invalid verified signature.");
            }
        }
    }

    private static PrimitiveType ResolvePrimitive(PortableExecutableModule executable, uint typeIndex)
    {
        if (typeIndex >= executable.Types.Count)
            throw new InvalidDataException("Runtime import TypeIndex is outside the verified type table.");
        return executable.Types[checked((int)typeIndex)].Primitive;
    }

    private static string RemoveExtern(string assembly, string label)
    {
        string directive = $"extern {label}\n";
        int position = assembly.IndexOf(directive, StringComparison.Ordinal);
        if (position < 0)
            throw new InvalidDataException($"Runtime ImportIndex label '{label}' is not declared by the x64 backend.");
        if (assembly.IndexOf(directive, position + directive.Length, StringComparison.Ordinal) >= 0)
            throw new InvalidDataException($"Runtime ImportIndex label '{label}' has multiple extern declarations.");
        return assembly.Remove(position, directive.Length);
    }

    private static void EmitAdapter(
        StringBuilder output,
        string label,
        string bridge,
        int argumentCount)
    {
        output.AppendLine($"{label}:");
        output.AppendLine("  push rbp");
        output.AppendLine("  mov rbp, rsp");
        string[] registers = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"];
        for (int index = 0; index < argumentCount; index++)
        {
            int offset = 16 + (argumentCount - 1 - index) * 8;
            output.AppendLine($"  mov {registers[index]}, [rbp+{offset}]");
        }
        output.AppendLine("  and rsp, -16");
        output.AppendLine($"  call {bridge}");
        output.AppendLine("  mov rsp, rbp");
        output.AppendLine("  pop rbp");
        output.AppendLine("  ret");
    }
}
