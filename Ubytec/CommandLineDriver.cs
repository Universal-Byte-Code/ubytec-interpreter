/*
 * <Your-Product-Name>
 * Copyright (c) <Year-From>-<Year-To> <Your-Company-Name>
 *
 * Please configure this header in your SonarCloud/SonarQube quality profile.
 * You can also set it in SonarLint.xml additional file for SonarLint or standalone NuGet analyzer.
 */
#pragma warning disable S3990 // Codacy analyzes this new file in a synthetic assembly; the real assembly is marked CLSCompliant in Program.cs.
#pragma warning disable S3992 // Codacy analyzes this new file in a synthetic assembly; the real assembly is marked ComVisible in Program.cs.
using System.Text;
using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Portable;
using Ubytec.Language.Tools;

namespace Ubytec;

/// <summary>End-to-end command-line driver for legacy and portable-native compilation paths.</summary>
internal static class CommandLineDriver
{
    private static readonly string CanonicalLineEnding = ((char)10).ToString();

    private static readonly IReadOnlyDictionary<string, Action<Options>> FlagSetters =
        new Dictionary<string, Action<Options>>(StringComparer.Ordinal)
        {
            ["--portable-x64"] = options => options.PortableX64 = true,
            ["--indexed-executable"] = options => options.IndexedExecutable = true,
            ["--arena-imports"] = options => options.ArenaImports = true,
            ["--host-io"] = options => options.HostIo = true,
            ["--module-calls"] = options => options.ModuleCalls = true,
            ["--effect-registers"] = options => options.EffectRegisters = true,
            ["--lookup-reductions"] = options => options.LookupReductions = true,
            ["--record-reductions"] = options => options.RecordReductions = true,
            ["--block-reductions-native"] = options => options.NativeBlockReductions = true,
            ["--block-reductions"] = options => options.BlockReductions = true,
            ["--loop-reductions"] = options => options.LoopReductions = true,
            ["--frame-registers"] = options => options.FrameRegisters = true,
            ["--frame-values"] = options => options.FrameValues = true,
            ["--stack-transfers"] = options => options.StackTransfers = true,
            ["--tail-calls"] = options => options.TailCalls = true,
            ["--library"] = options => options.Library = true,
            ["--no-metadata"] = options => options.EmitMetadata = false
        };

    internal static int Run(string[] args)
    {
        if (args.Length == 1 && string.Equals(args[0], "--format-stdin", StringComparison.Ordinal))
        {
            Console.Write(UbcFormatter.Format(Console.In.ReadToEnd()));
            return 0;
        }

        if (args.Length == 2 && string.Equals(args[0], "--verify-module", StringComparison.Ordinal))
            return VerifyPortableModule(args[1]);

        if (NeedsHelp(args))
        {
            PrintHelp();
            return 0;
        }

        try
        {
            Options options = Parse(args);
            ApplyImplications(options);
            Validate(options);
            Execute(options);
            return 0;
        }
        catch (Exception error)
        {
            Console.Error.WriteLine(error.Message);
            return 1;
        }
    }

    private static int VerifyPortableModule(string path)
    {
        try
        {
            byte[] bytes = File.ReadAllBytes(path);
            PortableProcessEntrypoint.Verify(bytes);
            PortableModuleImage image = PortableModuleFormat.Decode(bytes);
            Console.WriteLine(
                $"Valid Ubytec portable module v{image.MajorVersion}.{image.MinorVersion}: " +
                $"{image.Sections.Count} section(s), {bytes.Length} bytes.");
            return 0;
        }
        catch (Exception error)
        {
            Console.Error.WriteLine(error.Message);
            return 1;
        }
    }

    private static bool NeedsHelp(string[] args) =>
        args.Length == 0 || args.Contains("--help", StringComparer.Ordinal) || args.Contains("-h", StringComparer.Ordinal);

    private static Options Parse(string[] args)
    {
        var options = new Options(args[0]);
        int index = 1;

        while (index < args.Length)
        {
            string option = args[index++];
            if (FlagSetters.TryGetValue(option, out Action<Options>? setFlag))
            {
                setFlag(options);
                continue;
            }

            string value = ReadValue(args, ref index, option);
            SetValueOption(options, option, value);
        }

        options.MetadataPath ??= Path.ChangeExtension(options.OutputPath, ".metadata.json");
        return options;
    }

    private static string ReadValue(string[] args, ref int index, string option)
    {
        if (index >= args.Length)
            throw new ArgumentException($"Missing value for '{option}'.", nameof(option));
        return args[index++];
    }

    private static void SetValueOption(Options options, string option, string value)
    {
        switch (option)
        {
            case "-o": options.OutputPath = value; break;
            case "--grammar": options.GrammarPath = value; break;
            case "--generated-source": options.GeneratedSourcePath = value; break;
            case "--json": options.JsonPath = value; break;
            case "--metadata": SetMetadataPath(options, value); break;
            case "--portable-module": options.PortableModulePath = value; break;
            case "--host-export": options.Exports.Add(value); break;
            default: throw new ArgumentException($"Unknown option '{option}'.", nameof(option));
        }
    }

    private static void SetMetadataPath(Options options, string value)
    {
        options.MetadataPath = value;
        options.EmitMetadata = true;
    }

    private static void ApplyImplications(Options options)
    {
        if (options.PortableX64)
            options.IndexedExecutable = true;

        if (options.HostIo || options.ArenaImports)
        {
            options.Library = true;
            options.ModuleCalls = true;
        }
    }

    private static void Validate(Options options)
    {
        ValidateOutputPaths(options);
        ValidateModeDependencies(options);
        if (options.PortableX64)
            ValidatePortableX64(options);
    }

    private static void ValidateOutputPaths(Options options)
    {
        if (options.GeneratedSourcePath is not null)
            ValidateGeneratedSource(options);
        if (options.PortableModulePath is not null)
            ValidatePortableModulePath(options);
    }

    private static void ValidateModeDependencies(Options options)
    {
        if (options.IndexedExecutable && options.PortableModulePath is null && !options.PortableX64)
            throw new ArgumentException("--indexed-executable requires --portable-module unless --portable-x64 is selected.");
        if (options.ModuleCalls && !options.Library)
            throw new ArgumentException("--module-calls requires --library.");
        if (options.Exports.Count != 0 && !options.Library)
            throw new ArgumentException("--host-export requires --library.");
    }

    private static void ValidatePortableX64(Options options)
    {
        if (options.Exports.Count != 0)
            throw new ArgumentException("--portable-x64 does not yet support --host-export; portable exports must come from the Ubytec module contract.");

        (bool Enabled, string Name)[] legacyNativeFeatures =
        [
            (options.TailCalls, "--tail-calls"),
            (options.StackTransfers, "--stack-transfers"),
            (options.FrameValues, "--frame-values"),
            (options.FrameRegisters, "--frame-registers"),
            (options.LoopReductions, "--loop-reductions"),
            (options.BlockReductions, "--block-reductions"),
            (options.NativeBlockReductions, "--block-reductions-native"),
            (options.RecordReductions, "--record-reductions"),
            (options.LookupReductions, "--lookup-reductions"),
            (options.EffectRegisters, "--effect-registers")
        ];
        string[] unsupported = legacyNativeFeatures
            .Where(feature => feature.Enabled)
            .Select(feature => feature.Name)
            .ToArray();
        if (unsupported.Length != 0)
        {
            throw new ArgumentException(
                "--portable-x64 rejects legacy source-to-x64 optimization flags until they have a binary-backend contract: " +
                string.Join(", ", unsupported) + ".");
        }
    }

    private static void ValidateGeneratedSource(Options options)
    {
        if (!options.ArenaImports)
            throw new ArgumentException("--generated-source requires --arena-imports.");

        StringComparison comparison = OperatingSystem.IsWindows()
            ? StringComparison.OrdinalIgnoreCase
            : StringComparison.Ordinal;
        string generatedPath = Path.GetFullPath(options.GeneratedSourcePath!);
        string[] candidates =
        [
            options.SourcePath,
            options.OutputPath,
            options.JsonPath ?? string.Empty,
            options.EmitMetadata ? options.MetadataPath ?? string.Empty : string.Empty,
            options.PortableModulePath ?? string.Empty
        ];
        bool conflict = candidates
            .Where(path => path.Length != 0)
            .Select(Path.GetFullPath)
            .Any(path => string.Equals(path, generatedPath, comparison));
        if (conflict)
            throw new ArgumentException("Generated source must use a distinct path from input and other outputs.");
    }

    private static void ValidatePortableModulePath(Options options)
    {
        StringComparison comparison = OperatingSystem.IsWindows()
            ? StringComparison.OrdinalIgnoreCase
            : StringComparison.Ordinal;
        string modulePath = Path.GetFullPath(options.PortableModulePath!);
        string[] candidates =
        [
            options.SourcePath,
            options.OutputPath,
            options.JsonPath ?? string.Empty,
            options.EmitMetadata ? options.MetadataPath ?? string.Empty : string.Empty,
            options.GeneratedSourcePath ?? string.Empty
        ];
        bool conflict = candidates
            .Where(path => path.Length != 0)
            .Select(Path.GetFullPath)
            .Any(path => string.Equals(path, modulePath, comparison));
        if (conflict)
            throw new ArgumentException("Portable module must use a distinct path from input and other outputs.");
    }

    private static void Execute(Options options)
    {
        string source = File.ReadAllText(options.SourcePath).ReplaceLineEndings(CanonicalLineEnding);
        if (options.ArenaImports)
            source = ArenaImportGenerator.Generate(source).ReplaceLineEndings(CanonicalLineEnding);

        var utf8NoBom = new UTF8Encoding(false);
        if (options.PortableX64)
            ExecutePortable(source, options, utf8NoBom);
        else
            ExecuteLegacy(source, options, utf8NoBom);
    }

    private static void ExecutePortable(string source, Options options, Encoding encoding)
    {
        PortableSourceX64Result result = PortableSourceX64Pipeline.Compile(
            source,
            options.GrammarPath is null ? null : File.ReadAllText(options.GrammarPath),
            processImage: !options.Library,
            enableModuleCalls: options.ModuleCalls,
            enableHostIO: options.HostIo);

        string finalAssembly = result.NativeCompilation.Assembly.ReplaceLineEndings(CanonicalLineEnding);
        File.WriteAllText(options.OutputPath, finalAssembly, encoding);
        if (options.PortableModulePath is not null)
            File.WriteAllBytes(options.PortableModulePath, result.ModuleBytes);
        WriteOptionalSidecars(result.SemanticModule, source, finalAssembly, options, encoding);
        PrintOutputs(options);
    }

    private static void ExecuteLegacy(string source, Options options, Encoding encoding)
    {
        SourceCompilation compilation = CompileLegacy(source, options);
        string finalAssembly = BuildLegacyAssembly(compilation, options);
        File.WriteAllText(options.OutputPath, finalAssembly, encoding);

        if (options.PortableModulePath is not null)
        {
            byte[] portableModule = PortableModuleFormat.Encode(
                compilation.Module,
                options.IndexedExecutable ? null : compilation.ContractManifest,
                includeIndexedExecutable: options.IndexedExecutable,
                portableContracts: options.IndexedExecutable ? compilation.PortableContracts : null);
            File.WriteAllBytes(options.PortableModulePath, portableModule);
        }

        WriteOptionalSidecars(compilation.Module, source, finalAssembly, options, encoding);
        PrintOutputs(options);
    }

    private static void WriteOptionalSidecars(
        Module module,
        string source,
        string finalAssembly,
        Options options,
        Encoding encoding)
    {
        if (options.GeneratedSourcePath is not null)
            File.WriteAllText(options.GeneratedSourcePath, source, encoding);
        if (options.JsonPath is not null)
            WriteModuleJson(module, options.JsonPath, encoding);
        if (options.EmitMetadata)
            WriteMetadata(module, source, finalAssembly, options, encoding);
    }

    private static void PrintOutputs(Options options)
    {
        Console.WriteLine($"NASM written to {Path.GetFullPath(options.OutputPath)}");
        if (options.PortableModulePath is not null)
            Console.WriteLine($"Portable module written to {Path.GetFullPath(options.PortableModulePath)}");
        if (options.EmitMetadata)
            Console.WriteLine($"Metadata written to {Path.GetFullPath(options.MetadataPath!)}");
    }

    private static SourceCompilation CompileLegacy(string source, Options options) =>
        SourceCompiler.Compile(
            source,
            options.GrammarPath is null ? null : File.ReadAllText(options.GrammarPath),
            emitProcessEntryPoint: !options.Library,
            optimizeTailCalls: options.TailCalls,
            enableModuleCalls: options.ModuleCalls,
            enableHostIO: options.HostIo,
            optimizeStackTransfers: options.StackTransfers,
            optimizeFrameValues: options.FrameValues,
            optimizeFrameRegisters: options.FrameRegisters,
            optimizeLoopReductions: options.LoopReductions,
            optimizeBlockReductions: options.BlockReductions,
            optimizeNativeBlockReductions: options.NativeBlockReductions,
            optimizeRecordReductions: options.RecordReductions,
            optimizeLookupReductions: options.LookupReductions,
            optimizeEffectRegisters: options.EffectRegisters);

    private static string BuildLegacyAssembly(SourceCompilation compilation, Options options)
    {
        var assembly = new StringBuilder(compilation.Assembly);
        var symbols = new HashSet<string>(StringComparer.Ordinal);
        foreach (string export in options.Exports)
        {
            string[] pair = export.Split('=');
            if (pair.Length != 2 || !symbols.Add(pair[1]))
                throw new ArgumentException("Invalid or duplicate host export.");
            assembly.AppendLine(compilation.GetLinuxSystemVAdapter(pair[0], pair[1]));
        }

        if (options.Library)
            assembly.AppendLine("section .note.GNU-stack noalloc noexec nowrite progbits");
        return assembly.ToString().ReplaceLineEndings(CanonicalLineEnding);
    }

    private static void WriteModuleJson(Module module, string path, Encoding encoding)
    {
        string json = JsonSerializer.Serialize(module, global::SerializerOptionsHelper.Options)
            .ReplaceLineEndings(CanonicalLineEnding);
        File.WriteAllText(path, json, encoding);
    }

    private static void WriteMetadata(
        Module module,
        string source,
        string finalAssembly,
        Options options,
        Encoding encoding)
    {
        CompilationMetadata metadata = CompilationMetadata.Create(
            module,
            source,
            finalAssembly,
            GetTargetIsa(options),
            GetFeatures(options));
        string json = JsonSerializer.Serialize(metadata, new JsonSerializerOptions
        {
            WriteIndented = true,
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        }).ReplaceLineEndings(CanonicalLineEnding) + CanonicalLineEnding;
        File.WriteAllText(options.MetadataPath!, json, encoding);
    }

    private static string GetTargetIsa(Options options)
    {
        if (options.PortableX64)
            return "x86-64-baseline";
        if (options.NativeBlockReductions)
            return System.Runtime.Intrinsics.X86.Avx2.IsSupported ? "avx2" : "sse2";
        if (options.BlockReductions)
            return "sse2";
        return "x86-64-baseline";
    }

    private static string[] GetFeatures(Options options)
    {
        (bool Enabled, string Name)[] features =
        [
            (options.Library, "library"),
            (options.PortableX64, "portable-x64-pipeline-v0"),
            (options.PortableX64 && !options.Library, "process-entrypoint-v0"),
            (options.TailCalls, "tail-calls"),
            (options.StackTransfers, "stack-transfers"),
            (options.FrameValues, "frame-values"),
            (options.FrameRegisters, "frame-registers"),
            (options.LoopReductions, "loop-reductions"),
            (options.BlockReductions, "block-reductions"),
            (options.NativeBlockReductions, "block-reductions-native"),
            (options.RecordReductions, "record-reductions"),
            (options.LookupReductions, "lookup-reductions"),
            (options.EffectRegisters, "effect-registers"),
            (options.ModuleCalls, "module-calls"),
            (options.HostIo, "host-io"),
            (options.ArenaImports, "arena-imports"),
            (options.PortableModulePath is not null, "portable-module-v0"),
            (options.IndexedExecutable, "indexed-executable-v0")
        ];
        return features.Where(feature => feature.Enabled).Select(feature => feature.Name).ToArray();
    }

    private static void PrintHelp()
    {
        Console.WriteLine("Usage: ubytec <source.ubc> [-o <output.nasm>] [--portable-x64] [--portable-module <module.ubcm>] [--indexed-executable] [--grammar <grammar.json>] [--json <module.json>] [--metadata <metadata.json>] [--no-metadata] [--library] [--tail-calls] [--stack-transfers] [--frame-values] [--frame-registers] [--loop-reductions] [--block-reductions] [--block-reductions-native] [--record-reductions] [--lookup-reductions] [--effect-registers] [--module-calls] [--host-io] [--arena-imports] [--generated-source <source.ubc>] [--host-export Function=ubytec_host_symbol]");
        Console.WriteLine("       ubytec --verify-module <module.ubcm>");
        Console.WriteLine("       ubytec --format-stdin < input.ubc > output.ubc");
        Console.WriteLine("--portable-x64 routes final NASM through indexed UBCM -> independent verifier -> typed decoder -> x64; legacy source-to-x64 assembly is discarded.");
        Console.WriteLine("--portable-module emits canonical architecture-neutral Portable Module Format v0; with --portable-x64 it is the exact UBCM consumed by native codegen.");
        Console.WriteLine("--indexed-executable adds the verified indexed executable section group to legacy --portable-module output; --portable-x64 implies it.");
        Console.WriteLine("--verify-module validates PMF framing, indexed executable tables/code and optional process-entry metadata without compiling source.");
        Console.WriteLine("--portable-x64 currently rejects legacy backend optimization flags and --host-export rather than silently changing semantics.");
        Console.WriteLine("--format-stdin canonicalizes UBC from standard input to standard output without compiling it.");
        Console.WriteLine("--metadata writes build provenance separately from canonical NASM; by default <output>.metadata.json is written.");
        Console.WriteLine("--no-metadata disables the provenance sidecar.");
        Console.WriteLine("--arena-imports bundles the arena and scoped import wrappers; implies --library --module-calls.");
        Console.WriteLine("--host-io enables supervised resource reads/writes; implies --library --module-calls.");
        Console.WriteLine("--block-reductions-native selects AVX2 on this CPU/OS, otherwise SSE2. Output requires the selected ISA; use --block-reductions for portable legacy x64.");
        Console.WriteLine("Target: Linux x86-64 NASM. Portable modules are target-independent.");
    }

    private sealed class Options(string sourcePath)
    {
        internal string SourcePath { get; } = sourcePath;
        internal string OutputPath { get; set; } = Path.ChangeExtension(sourcePath, ".nasm");
        internal string? GrammarPath { get; set; }
        internal string? JsonPath { get; set; }
        internal string? MetadataPath { get; set; }
        internal string? GeneratedSourcePath { get; set; }
        internal string? PortableModulePath { get; set; }
        internal bool EmitMetadata { get; set; } = true;
        internal bool PortableX64 { get; set; }
        internal bool IndexedExecutable { get; set; }
        internal bool Library { get; set; }
        internal bool TailCalls { get; set; }
        internal bool StackTransfers { get; set; }
        internal bool FrameValues { get; set; }
        internal bool FrameRegisters { get; set; }
        internal bool LoopReductions { get; set; }
        internal bool BlockReductions { get; set; }
        internal bool NativeBlockReductions { get; set; }
        internal bool RecordReductions { get; set; }
        internal bool LookupReductions { get; set; }
        internal bool EffectRegisters { get; set; }
        internal bool ModuleCalls { get; set; }
        internal bool ArenaImports { get; set; }
        internal bool HostIo { get; set; }
        internal List<string> Exports { get; } = [];
    }
}
