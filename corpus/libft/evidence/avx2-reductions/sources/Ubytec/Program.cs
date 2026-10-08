using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.Tools;

[assembly: CLSCompliant(true)]
[assembly: System.Runtime.InteropServices.ComVisible(true)]

if (args.Length == 0 || args.Contains("--help") || args.Contains("-h"))
{
    Console.WriteLine("Usage: ubytec <source.ubc> [-o <output.nasm>] [--grammar <grammar.json>] [--json <module.json>] [--library] [--tail-calls] [--stack-transfers] [--frame-values] [--frame-registers] [--loop-reductions] [--block-reductions] [--block-reductions-native] [--module-calls] [--host-io] [--arena-imports] [--generated-source <source.ubc>] [--host-export Function=ubytec_host_symbol]");
    Console.WriteLine("--arena-imports bundles the arena and scoped import wrappers; implies --library --module-calls.");
    Console.WriteLine("--host-io enables supervised resource reads/writes; implies --library --module-calls.");
    Console.WriteLine("--block-reductions-native selects AVX2 on this CPU/OS, otherwise SSE2. Output requires the selected ISA; use --block-reductions for portable x64.");
    Console.WriteLine("Target: Linux x86-64 NASM. The default grammar is bundled locally.");
    return 0;
}

try
{
    string sourcePath = args[0];
    string outputPath = Path.ChangeExtension(sourcePath, ".nasm");
    string? grammarPath = null;
    string? jsonPath = null;
    bool library = false;
    bool tailCalls = false;
    bool stackTransfers = false;
    bool frameValues = false;
    bool frameRegisters = false;
    bool loopReductions = false;
    bool blockReductions = false;
    bool nativeBlockReductions = false;
    bool moduleCalls = false;
    bool arenaImports = false;
    bool hostIO = false;
    string? generatedSourcePath = null;
    var exports = new List<string>();
    for (int i = 1; i < args.Length; i++)
    {
        string option = args[i];
        if (option == "--arena-imports") { arenaImports = true; continue; }
        if (option == "--host-io") { hostIO = true; continue; }
        if (option == "--module-calls") { moduleCalls = true; continue; }
        if (option == "--block-reductions-native") { nativeBlockReductions = true; continue; }
        if (option == "--block-reductions") { blockReductions = true; continue; }
        if (option == "--loop-reductions") { loopReductions = true; continue; }
        if (option == "--frame-registers") { frameRegisters = true; continue; }
        if (option == "--frame-values") { frameValues = true; continue; }
        if (option == "--stack-transfers") { stackTransfers = true; continue; }
        if (option == "--tail-calls") { tailCalls = true; continue; }
        if (option == "--library") { library = true; continue; }
        if (i + 1 >= args.Length) throw new ArgumentException($"Missing value for '{option}'.");
        string value = args[++i];
        switch (option)
        {
            case "-o": outputPath = value; break;
            case "--grammar": grammarPath = value; break;
            case "--generated-source": generatedSourcePath = value; break;
            case "--json": jsonPath = value; break;
            case "--host-export": exports.Add(value); break;
            default: throw new ArgumentException($"Unknown option '{option}'.");
        }
    }
    if (hostIO) { library = true; moduleCalls = true; }
    if (arenaImports) { library = true; moduleCalls = true; }
    if (generatedSourcePath is not null)
    {
        if (!arenaImports) throw new ArgumentException("--generated-source requires --arena-imports.");
        var comparison = OperatingSystem.IsWindows() ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal;
        foreach (var path in new[] { sourcePath, outputPath, jsonPath }.OfType<string>())
            if (string.Equals(Path.GetFullPath(path), Path.GetFullPath(generatedSourcePath), comparison))
                throw new ArgumentException("Generated source must use a distinct path from input and other outputs.");
    }
    if (moduleCalls && !library) throw new ArgumentException("--module-calls requires --library.");
    if (exports.Count != 0 && !library) throw new ArgumentException("--host-export requires --library.");
    string source = File.ReadAllText(sourcePath);
    if (arenaImports) source = ArenaImportGenerator.Generate(source);
    var compilation = SourceCompiler.Compile(source,
        grammarPath is null ? null : File.ReadAllText(grammarPath), emitProcessEntryPoint: !library, optimizeTailCalls: tailCalls, enableModuleCalls: moduleCalls, enableHostIO: hostIO, optimizeStackTransfers: stackTransfers, optimizeFrameValues: frameValues, optimizeFrameRegisters: frameRegisters, optimizeLoopReductions: loopReductions, optimizeBlockReductions: blockReductions, optimizeNativeBlockReductions: nativeBlockReductions);
    var assembly = new System.Text.StringBuilder(compilation.Assembly);
    var symbols = new HashSet<string>(StringComparer.Ordinal);
    foreach (var export in exports)
    {
        var pair = export.Split('=');
        if (pair.Length != 2 || !symbols.Add(pair[1])) throw new ArgumentException("Invalid or duplicate host export.");
        assembly.AppendLine(compilation.GetLinuxSystemVAdapter(pair[0], pair[1]));
    }
    if (library) assembly.AppendLine("section .note.GNU-stack noalloc noexec nowrite progbits");
    File.WriteAllText(outputPath, assembly.ToString());
    if (generatedSourcePath is not null) File.WriteAllText(generatedSourcePath, source);
    if (jsonPath is not null)
        File.WriteAllText(jsonPath, JsonSerializer.Serialize(compilation.Module, SerializerOptionsHelper.Options));
    Console.WriteLine($"NASM written to {Path.GetFullPath(outputPath)}");
    return 0;
}
catch (Exception error)
{
    Console.Error.WriteLine(error.Message);
    return 1;
}
