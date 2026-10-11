/*
 * <Your-Product-Name>
 * Copyright (c) <Year-From>-<Year-To> <Your-Company-Name>
 *
 * Please configure this header in your SonarCloud/SonarQube quality profile.
 * You can also set it in SonarLint.xml additional file for SonarLint or standalone NuGet analyzer.
 */
// Program.cs
//
// * end-to-end* driver for the whole Ubytec tool-chain.
//
// ────────────────────────────────────────────────────────────────
//  1.  LexicalAnalyst  →  SyntaxToken[]
//  2.  HighLevelParser →  Module  (+ collected ParseErrors)
//  3.  `module.Compile(scopes)`  →  NASM
//  4.  JSON  +  UTF-64 dumps
// ────────────────────────────────────────────────────────────────

using System.Text;
using System.Text.Json;
using Ubytec.Language.AST;

[assembly: System.CLSCompliant(true)]
[assembly: System.Runtime.InteropServices.ComVisible(true)]

namespace Ubytec;

internal static class Program
{
    private static int Main(string[] args) => CommandLine.Run(args);

    private static class CommandLine
    {
        private static readonly string CanonicalLineEnding = ((char)10).ToString();

        private static readonly IReadOnlyDictionary<string, Action<Options>> FlagSetters =
            new Dictionary<string, Action<Options>>(StringComparer.Ordinal)
            {
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
            if (options.HostIo || options.ArenaImports)
            {
                options.Library = true;
                options.ModuleCalls = true;
            }
        }

        private static void Validate(Options options)
        {
            if (options.GeneratedSourcePath is not null)
                ValidateGeneratedSource(options);
            if (options.ModuleCalls && !options.Library)
                throw new ArgumentException("--module-calls requires --library.");
            if (options.Exports.Count != 0 && !options.Library)
                throw new ArgumentException("--host-export requires --library.");
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
                options.EmitMetadata ? options.MetadataPath ?? string.Empty : string.Empty
            ];
            bool conflict = candidates
                .Where(path => path.Length != 0)
                .Select(Path.GetFullPath)
                .Any(path => string.Equals(path, generatedPath, comparison));
            if (conflict)
                throw new ArgumentException("Generated source must use a distinct path from input and other outputs.");
        }

        private static void Execute(Options options)
        {
            string source = File.ReadAllText(options.SourcePath).ReplaceLineEndings(CanonicalLineEnding);
            if (options.ArenaImports)
                source = ArenaImportGenerator.Generate(source).ReplaceLineEndings(CanonicalLineEnding);

            SourceCompilation compilation = Compile(source, options);
            string finalAssembly = BuildAssembly(compilation, options);
            var utf8NoBom = new UTF8Encoding(false);
            File.WriteAllText(options.OutputPath, finalAssembly, utf8NoBom);

            if (options.GeneratedSourcePath is not null)
                File.WriteAllText(options.GeneratedSourcePath, source, utf8NoBom);
            if (options.JsonPath is not null)
                WriteModuleJson(compilation, options.JsonPath, utf8NoBom);
            if (options.EmitMetadata)
                WriteMetadata(compilation, source, finalAssembly, options, utf8NoBom);

            Console.WriteLine($"NASM written to {Path.GetFullPath(options.OutputPath)}");
            if (options.EmitMetadata)
                Console.WriteLine($"Metadata written to {Path.GetFullPath(options.MetadataPath!)}");
        }

        private static SourceCompilation Compile(string source, Options options) =>
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

        private static string BuildAssembly(SourceCompilation compilation, Options options)
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

        private static void WriteModuleJson(SourceCompilation compilation, string path, Encoding encoding)
        {
            string json = JsonSerializer.Serialize(compilation.Module, global::SerializerOptionsHelper.Options)
                .ReplaceLineEndings(CanonicalLineEnding);
            File.WriteAllText(path, json, encoding);
        }

        private static void WriteMetadata(
            SourceCompilation compilation,
            string source,
            string finalAssembly,
            Options options,
            Encoding encoding)
        {
            CompilationMetadata metadata = CompilationMetadata.Create(
                compilation.Module,
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
                (options.ArenaImports, "arena-imports")
            ];
            return features.Where(feature => feature.Enabled).Select(feature => feature.Name).ToArray();
        }

        private static void PrintHelp()
        {
            Console.WriteLine("Usage: ubytec <source.ubc> [-o <output.nasm>] [--grammar <grammar.json>] [--json <module.json>] [--metadata <metadata.json>] [--no-metadata] [--library] [--tail-calls] [--stack-transfers] [--frame-values] [--frame-registers] [--loop-reductions] [--block-reductions] [--block-reductions-native] [--record-reductions] [--lookup-reductions] [--effect-registers] [--module-calls] [--host-io] [--arena-imports] [--generated-source <source.ubc>] [--host-export Function=ubytec_host_symbol]");
            Console.WriteLine("--metadata writes build provenance separately from canonical NASM; by default <output>.metadata.json is written.");
            Console.WriteLine("--no-metadata disables the provenance sidecar.");
            Console.WriteLine("--arena-imports bundles the arena and scoped import wrappers; implies --library --module-calls.");
            Console.WriteLine("--host-io enables supervised resource reads/writes; implies --library --module-calls.");
            Console.WriteLine("--block-reductions-native selects AVX2 on this CPU/OS, otherwise SSE2. Output requires the selected ISA; use --block-reductions for portable x64.");
            Console.WriteLine("Target: Linux x86-64 NASM. The default grammar is bundled locally.");
        }

        private sealed class Options(string sourcePath)
        {
            internal string SourcePath { get; } = sourcePath;
            internal string OutputPath { get; set; } = Path.ChangeExtension(sourcePath, ".nasm");
            internal string? GrammarPath { get; set; }
            internal string? JsonPath { get; set; }
            internal string? MetadataPath { get; set; }
            internal string? GeneratedSourcePath { get; set; }
            internal bool EmitMetadata { get; set; } = true;
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
}
