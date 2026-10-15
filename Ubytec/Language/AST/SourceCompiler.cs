using System.Globalization;
using System.Runtime.Intrinsics.X86;
using System.Text;
using System.Text.RegularExpressions;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Grammar;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Portable;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;

namespace Ubytec.Language.AST;

/// <summary>A parsed and validated source module with architecture-neutral portable contracts.</summary>
/// <param name="Module">Normalized semantic module.</param>
/// <param name="PortableContracts">Portable import/export identities and signatures.</param>
public sealed record SourceSemanticCompilation(
    Module Module,
    PortableModuleContracts PortableContracts);

/// <summary>A source module and its generated Linux x86-64 NASM assembly.</summary>
/// <param name="Module">Parsed module.</param>
/// <param name="Assembly">Assembly emitted by the legacy source backend.</param>
/// <param name="EntryLabel">Main function's internal entry label, if present.</param>
public sealed record SourceCompilation(Module Module, string Assembly, string? EntryLabel)
{
    /// <summary>Embedded experimental import/export contracts; never an authority grant.</summary>
    public string ContractManifest { get; internal set; } = "";

    /// <summary>
    /// Semantic import/export contracts retained before host handles and adapter symbols are introduced.
    /// Portable lowering uses this view instead of reverse-engineering the legacy textual manifest.
    /// </summary>
    public PortableModuleContracts PortableContracts { get; internal set; } = PortableModuleContracts.Empty;

    /// <summary>Adapts up to six integer scalar arguments from Linux System V to the Ubytec stack ABI.</summary>
    public string GetLinuxSystemVAdapter(string functionName, string exportedName)
    {
        if (!Regex.IsMatch(exportedName, @"\A[A-Za-z_][A-Za-z0-9_]*\z") ||
            !exportedName.StartsWith("ubytec_host_", StringComparison.Ordinal))
            throw new ArgumentException("Host symbols must begin with ubytec_host_ and contain only ASCII identifier characters.", nameof(exportedName));
        var label = GetFunctionLabel(functionName);
        var function = Module.Functions.First(x => x.Name == functionName);
        if (function.Arguments.Length > 6 || function.Arguments.Any(a => !FunctionCode.IsCellType(a.Type)) ||
            (function.ReturnType.Type != Types.PrimitiveType.Void && !FunctionCode.IsCellType(function.ReturnType)))
            throw new ArgumentException("Host adapters support at most six scalar integer arguments and an integer or void result.");
        string[] registers = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"];
        var sb = new StringBuilder();
        sb.AppendLine("section .text").AppendLine($"global {exportedName}").AppendLine($"{exportedName}:");
        sb.AppendLine("push rbp").AppendLine("mov rbp, rsp");
        foreach (var register in new[] { "rbx", "r12", "r13", "r14", "r15" }) sb.AppendLine($"push {register}");
        if (function.Arguments.Length % 2 == 0) sb.AppendLine("sub rsp, 8");
        for (int i = 0; i < function.Arguments.Length; i++) sb.AppendLine($"push {registers[i]}");
        sb.AppendLine($"call {label}").AppendLine("lea rsp, [rbp-40]");
        foreach (var register in new[] { "r15", "r14", "r13", "r12", "rbx", "rbp" }) sb.AppendLine($"pop {register}");
        return sb.AppendLine("ret").ToString().ReplaceLineEndings("\n");
    }

    /// <summary>Resolves a module function's emitted label for an embedding host or test harness.</summary>
    public string GetFunctionLabel(string name)
    {
        var function = Module.Functions.FirstOrDefault(x => x.Name == name);
        if (string.IsNullOrEmpty(function.Name)) throw new ArgumentException($"Unknown module function '{name}'.", nameof(name));
        return FunctionEmitter.Binding(function).Label;
    }
}

/// <summary>
/// Source frontend plus the retained legacy source-to-NASM entry point.
/// Portable backends should consume <see cref="CompileSemantic"/> and cross the UBCM boundary before native code generation.
/// </summary>
public static class SourceCompiler
{
    private static readonly object Gate = new();

    /// <summary>
    /// Tokenizes, parses and validates one source module without invoking any native backend.
    /// <paramref name="processImage"/> selects process-vs-library source contract rules only; no `_start` or NASM is emitted.
    /// </summary>
    public static SourceSemanticCompilation CompileSemantic(
        string source,
        string? grammarJson = null,
        bool processImage = true,
        bool enableModuleCalls = false,
        bool enableHostIO = false)
    {
        ValidateCompilationMode(processImage, enableModuleCalls, enableHostIO);
        return InInvariantContext(() =>
        {
            ParsedSource parsed = ParseSource(
                source,
                grammarJson,
                processImage,
                enableModuleCalls,
                enableHostIO);
            ValidateSemanticModule(parsed, enableModuleCalls, enableHostIO);
            return new SourceSemanticCompilation(parsed.Module, parsed.PortableContracts);
        });
    }

    /// <summary>Tokenizes, parses, validates and compiles one source module through the legacy x64 NASM backend.</summary>
    /// <param name="source">Ubytec module source.</param>
    /// <param name="grammarJson">Optional explicit TextMate grammar JSON.</param>
    /// <param name="emitProcessEntryPoint">False emits a library without _start.</param>
    /// <param name="optimizeTailCalls">Reuse compatible tail frames; unsafe programs must not retain their addresses.</param>
    /// <param name="enableModuleCalls">Enable the experimental supervised ModuleInvoke bridge.</param>
    /// <param name="enableHostIO">Enable experimental supervisor-mediated resource I/O imports.</param>
    /// <param name="optimizeStackTransfers">Fold adjacent x64 register push/pop transfers, retaining stack writes.</param>
    /// <param name="optimizeFrameValues">Reuse ordinary frame-cell values within conservative straight-line spans.</param>
    /// <param name="optimizeFrameRegisters">Keep write-through frame copies across loops in eligible leaf functions.</param>
    /// <param name="optimizeLoopReductions">Specialize proven scalar byte reductions while retaining observable stack bytes.</param>
    /// <param name="optimizeBlockReductions">Use guarded page-bounded SSE2 reductions over stable ordinary RAM.</param>
    /// <param name="optimizeNativeBlockReductions">Select AVX2 for this compilation host when CPU/OS support it, otherwise SSE2. The artifact requires the selected ISA.</param>
    /// <param name="optimizeRecordReductions">Specialize scalar UInt64 field reductions with constant stride and exact stack/fault state.</param>
    /// <param name="optimizeLookupReductions">Specialize closed record lookups with scalar nested comparisons and exact observable state.</param>
    /// <param name="optimizeEffectRegisters">Keep write-through frame copies through branches and loops, reloading after raw stores and calls.</param>
    public static SourceCompilation Compile(string source, string? grammarJson = null, bool emitProcessEntryPoint = true, bool optimizeTailCalls = false, bool enableModuleCalls = false, bool enableHostIO = false, bool optimizeStackTransfers = false, bool optimizeFrameValues = false, bool optimizeFrameRegisters = false, bool optimizeLoopReductions = false, bool optimizeBlockReductions = false, bool optimizeNativeBlockReductions = false, bool optimizeRecordReductions = false, bool optimizeLookupReductions = false, bool optimizeEffectRegisters = false)
    {
        ValidateCompilationMode(emitProcessEntryPoint, enableModuleCalls, enableHostIO);
        return InInvariantContext(() =>
        {
            ParsedSource parsed = ParseSource(
                source,
                grammarJson,
                emitProcessEntryPoint,
                enableModuleCalls,
                enableHostIO);
            return CompileNative(
                parsed,
                emitProcessEntryPoint,
                optimizeTailCalls,
                enableModuleCalls,
                enableHostIO,
                optimizeStackTransfers,
                optimizeFrameValues,
                optimizeFrameRegisters,
                optimizeLoopReductions,
                optimizeBlockReductions,
                optimizeNativeBlockReductions,
                optimizeRecordReductions,
                optimizeLookupReductions,
                optimizeEffectRegisters);
        });
    }

    private static void ValidateCompilationMode(bool processImage, bool enableModuleCalls, bool enableHostIO)
    {
        if (enableModuleCalls && processImage)
            throw new ArgumentException("Module calls require library compilation.");
        if (enableHostIO && (!enableModuleCalls || processImage))
            throw new ArgumentException("Host I/O requires library compilation and module calls.");
    }

    private static T InInvariantContext<T>(Func<T> action)
    {
        lock (Gate)
        {
            CultureInfo previousCulture = CultureInfo.CurrentCulture;
            CultureInfo previousUiCulture = CultureInfo.CurrentUICulture;
            CultureInfo.CurrentCulture = CultureInfo.InvariantCulture;
            CultureInfo.CurrentUICulture = CultureInfo.InvariantCulture;

            try
            {
                return action();
            }
            finally
            {
                CultureInfo.CurrentCulture = previousCulture;
                CultureInfo.CurrentUICulture = previousUiCulture;
            }
        }
    }

    private static ParsedSource ParseSource(
        string source,
        string? grammarJson,
        bool processImage,
        bool enableModuleCalls,
        bool enableHostIO)
    {
        source = source.ReplaceLineEndings("\n");
        grammarJson = grammarJson?.ReplaceLineEndings("\n");

        var contracts = new ModuleContracts();
        source = contracts.Read(source).ReplaceLineEndings("\n");
        if (contracts.Imports.Count != 0 && !enableModuleCalls)
            throw new ArgumentException("Imports require --module-calls.");
        if (contracts.Exports.Count != 0 && processImage)
            throw new ArgumentException("Exports require library compilation.");

        LexicalAnalyst.InitializeGrammar(grammarJson);
        var tokens = LexicalAnalyst.Tokenize(source);
        var (module, errors) = HighLevelParser.ParseModule([.. tokens]);
        if (errors.Length != 0)
        {
            throw new SyntaxException(0xBAD076, string.Join("\n",
                errors.Select(e => $"line {e.Line + 1}: {e.Where}: {e.Message}")));
        }

        module = SemanticIdentity.Normalize(module);
        ValidateReservedNames(module, contracts, enableModuleCalls, enableHostIO);
        PortableModuleContracts portableContracts = PortableModuleContracts.From(contracts, module);
        return new ParsedSource(module, contracts, portableContracts);
    }

    private static void ValidateReservedNames(
        Module module,
        ModuleContracts contracts,
        bool enableModuleCalls,
        bool enableHostIO)
    {
        if (!enableModuleCalls)
            return;

        if (module.Functions.Any(f => f.Name == "ModuleInvoke" || contracts.Imports.Any(i => i.Alias == f.Name)) ||
            module.Actions.Any(a => a.Name == "ModuleInvoke" || contracts.Imports.Any(i => i.Alias == a.Name)))
            throw new ArgumentException("ModuleInvoke is reserved when module calls are enabled.");

        if (!enableHostIO)
            return;

        foreach (string name in new[] { "HostRead", "HostWrite" })
        {
            if (module.Functions.Any(f => f.Name == name) ||
                module.Actions.Any(a => a.Name == name) ||
                contracts.Imports.Any(i => i.Alias == name))
                throw new ArgumentException(name + " is reserved when host I/O is enabled.");
        }
    }

    private static void ValidateSemanticModule(
        ParsedSource parsed,
        bool enableModuleCalls,
        bool enableHostIO)
    {
        Module module = parsed.Module;
        module.Validate();

        var scopes = new CompilationScopes { EmitProcessEntryPoint = false };
        if (enableModuleCalls)
            scopes.Push(CreateHostImportScope(parsed.Contracts, enableHostIO));

        var moduleScope = new ScopeContext
        {
            StartLabel = FunctionCode.Label("module", module.Name, module.ID, "start"),
            EndLabel = FunctionCode.Label("module", module.Name, module.ID, "end"),
            DeclaredByKeyword = "module"
        };
        foreach (var function in module.Functions)
            moduleScope.Callables.Add(function.Name, FunctionEmitter.Binding(function));
        foreach (var action in module.Actions)
            moduleScope.Callables.Add(action.Name, FunctionEmitter.Binding(action));

        int originalCount = scopes.Count;
        scopes.Push(moduleScope);
        try
        {
            foreach (var function in module.Functions)
            {
                FunctionEmitter.Validate(
                    function.Name,
                    function.ID,
                    "func",
                    function.Arguments,
                    function.Locals,
                    function.Definition,
                    function.ReturnType,
                    scopes);
            }
            foreach (var action in module.Actions)
            {
                FunctionEmitter.Validate(
                    action.Name,
                    action.ID,
                    "action",
                    action.Arguments,
                    action.Locals,
                    action.Definition,
                    new Types.UType(Types.PrimitiveType.Void),
                    scopes);
            }
        }
        finally
        {
            while (scopes.Count > originalCount) scopes.Pop();
        }
    }

    private static ScopeContext CreateHostImportScope(ModuleContracts contracts, bool enableHostIO)
    {
        var imports = new ScopeContext { DeclaredByKeyword = "host-imports" };
        imports.Callables.Add("ModuleInvoke", new("ModuleInvoke", "ubytec_module_invoke", 6,
            new Types.UType(Types.PrimitiveType.Int64)));
        foreach (var import in contracts.Imports)
        {
            imports.Callables.Add(import.Alias, new(import.Alias, "ubytec_import_" + import.Alias, import.CallArguments,
                new Types.UType(Types.PrimitiveType.Int64)));
        }

        if (enableHostIO)
        {
            foreach (string name in new[] { "HostRead", "HostWrite" })
            {
                imports.Callables.Add(name, new(name, "ubytec_hostio_" + name, 5,
                    new Types.UType(Types.PrimitiveType.Int64)));
            }
        }
        return imports;
    }

    private static SourceCompilation CompileNative(
        ParsedSource parsed,
        bool emitProcessEntryPoint,
        bool optimizeTailCalls,
        bool enableModuleCalls,
        bool enableHostIO,
        bool optimizeStackTransfers,
        bool optimizeFrameValues,
        bool optimizeFrameRegisters,
        bool optimizeLoopReductions,
        bool optimizeBlockReductions,
        bool optimizeNativeBlockReductions,
        bool optimizeRecordReductions,
        bool optimizeLookupReductions,
        bool optimizeEffectRegisters)
    {
        Module module = parsed.Module;
        ModuleContracts contracts = parsed.Contracts;
        var scopes = new CompilationScopes
        {
            EmitProcessEntryPoint = emitProcessEntryPoint,
            OptimizeTailCalls = optimizeTailCalls,
            OptimizeFrameRegisters = optimizeFrameRegisters,
            OptimizeLoopReductions = optimizeLoopReductions,
            OptimizeBlockReductions = optimizeBlockReductions || optimizeNativeBlockReductions,
            UseAvx2BlockReductions = optimizeNativeBlockReductions && Avx2.IsSupported,
            OptimizeRecordReductions = optimizeRecordReductions,
            OptimizeLookupReductions = optimizeLookupReductions,
            OptimizeEffectRegisters = optimizeEffectRegisters
        };

        if (enableModuleCalls)
            scopes.Push(CreateHostImportScope(contracts, enableHostIO));

        string assembly = module.Compile(scopes).ReplaceLineEndings("\n");

        if (enableModuleCalls) assembly += """

            section .text
            extern ubytec_bridge_call
            ubytec_module_invoke:
                push rbp
                mov rbp, rsp
                mov rdi, [rbp+56]
                mov rsi, [rbp+48]
                mov rdx, [rbp+40]
                mov rcx, [rbp+32]
                mov r8, [rbp+24]
                mov r9, [rbp+16]
                and rsp, -16
                call ubytec_bridge_call
                mov rsp, rbp
                pop rbp
                ret

            """;

        if (enableHostIO)
        {
            foreach (string name in new[] { "HostRead", "HostWrite" })
            {
                string bridge = name == "HostRead" ? "ubytec_bridge_read" : "ubytec_bridge_write";
                assembly += $"\nsection .text\nextern {bridge}\nubytec_hostio_{name}:\n" +
                    "push rbp\nmov rbp, rsp\nmov rdi, [rbp+48]\nmov rsi, [rbp+40]\n" +
                    "mov rdx, [rbp+32]\nmov rcx, [rbp+24]\nmov r8, [rbp+16]\n" +
                    $"and rsp, -16\ncall {bridge}\nmov rsp, rbp\npop rbp\nret\n";
            }
        }

        if (optimizeStackTransfers)
            assembly = Ubytec.Language.Tools.Optimization.StackTransferOptimizer.Optimize(assembly);
        if (optimizeFrameValues)
            assembly = Ubytec.Language.Tools.Optimization.FrameValueOptimizer.Optimize(assembly);

        assembly = assembly.ReplaceLineEndings("\n");

        var main = module.Functions.FirstOrDefault(x => x.Name == "Main");
        var result = new SourceCompilation(
            module,
            assembly,
            string.IsNullOrEmpty(main.Name) ? null : FunctionEmitter.Binding(main).Label);

        if (contracts.Imports.Count != 0 || contracts.Exports.Count != 0)
        {
            string extra = contracts.Emit(result);
            result = result with { Assembly = (assembly + extra).ReplaceLineEndings("\n") };
        }

        result.PortableContracts = parsed.PortableContracts;
        return result;
    }

    private sealed record ParsedSource(
        Module Module,
        ModuleContracts Contracts,
        PortableModuleContracts PortableContracts);
}
