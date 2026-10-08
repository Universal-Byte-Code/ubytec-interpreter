using System.Text;
using System.Runtime.Intrinsics.X86;
using System.Text.RegularExpressions;
using Ubytec.Language.Syntax.TypeSystem;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Grammar;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.AST;

/// <summary>A source module and its generated Linux x86-64 NASM assembly.</summary>
/// <param name="Module">Parsed module.</param>
/// <param name="Assembly">Assembly emitted by the module compiler.</param>
/// <param name="EntryLabel">Main function's internal entry label, if present.</param>
public sealed record SourceCompilation(Module Module, string Assembly, string? EntryLabel)
{
    /// <summary>Embedded experimental import/export contracts; never an authority grant.</summary>
    public string ContractManifest { get; internal set; } = "";

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
        // Align the host call without inserting padding between Ubytec arguments.
        if (function.Arguments.Length % 2 == 0) sb.AppendLine("sub rsp, 8");
        for (int i = 0; i < function.Arguments.Length; i++) sb.AppendLine($"push {registers[i]}");
        sb.AppendLine($"call {label}").AppendLine("lea rsp, [rbp-40]");
        foreach (var register in new[] { "r15", "r14", "r13", "r12", "rbx", "rbp" }) sb.AppendLine($"pop {register}");
        return sb.AppendLine("ret").ToString();
    }

    /// <summary>Resolves a module function's emitted label for an embedding host or test harness.</summary>
    public string GetFunctionLabel(string name)
    {
        var function = Module.Functions.FirstOrDefault(x => x.Name == name);
        if (string.IsNullOrEmpty(function.Name)) throw new ArgumentException($"Unknown module function '{name}'.", nameof(name));
        return FunctionEmitter.Binding(function).Label;
    }
}

/// <summary>Complete source-to-assembly entry point using the bundled grammar.</summary>
public static class SourceCompiler
{
    private static readonly object Gate = new();

    /// <summary>Tokenizes, parses, validates and compiles one source module.</summary>
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
        if (enableModuleCalls && emitProcessEntryPoint)
            throw new ArgumentException("Module calls require library compilation.");
        if (enableHostIO && (!enableModuleCalls || emitProcessEntryPoint))
            throw new ArgumentException("Host I/O requires library compilation and module calls.");
        // The existing lexer and high-level parser hold shared state.
        lock (Gate)
        {
            var contracts=new ModuleContracts();
            source=contracts.Read(source);
            if (contracts.Imports.Count!=0 && !enableModuleCalls)
                throw new ArgumentException("Imports require --module-calls.");
            if (contracts.Exports.Count!=0 && emitProcessEntryPoint)
                throw new ArgumentException("Exports require library compilation.");
            LexicalAnalyst.InitializeGrammar(grammarJson);
            var tokens = LexicalAnalyst.Tokenize(source);
            var (module, errors) = HighLevelParser.ParseModule([.. tokens]);
            if (errors.Length != 0)
                throw new SyntaxException(0xBAD076, string.Join(Environment.NewLine,
                    errors.Select(e => $"line {e.Line + 1}: {e.Where}: {e.Message}")));
            var scopes = new CompilationScopes { EmitProcessEntryPoint = emitProcessEntryPoint, OptimizeTailCalls = optimizeTailCalls, OptimizeFrameRegisters = optimizeFrameRegisters, OptimizeLoopReductions = optimizeLoopReductions, OptimizeBlockReductions = optimizeBlockReductions || optimizeNativeBlockReductions, UseAvx2BlockReductions = optimizeNativeBlockReductions && Avx2.IsSupported, OptimizeRecordReductions = optimizeRecordReductions, OptimizeLookupReductions = optimizeLookupReductions, OptimizeEffectRegisters = optimizeEffectRegisters };
            if (enableModuleCalls)
            {
                if (module.Functions.Any(f => f.Name == "ModuleInvoke" || contracts.Imports.Any(i=>i.Alias==f.Name)) ||
                    module.Actions.Any(a=>a.Name=="ModuleInvoke" || contracts.Imports.Any(i=>i.Alias==a.Name)))
                    throw new ArgumentException("ModuleInvoke is reserved when module calls are enabled.");
                var imports = new Ubytec.Language.Syntax.Scopes.Contexts.ScopeContext { DeclaredByKeyword = "host-imports" };
                imports.Callables.Add("ModuleInvoke", new("ModuleInvoke", "ubytec_module_invoke", 6,
                    new Types.UType(Types.PrimitiveType.Int64)));
                foreach(var import in contracts.Imports)
                    imports.Callables.Add(import.Alias,new(import.Alias,"ubytec_import_"+import.Alias,import.CallArguments,
                        new Types.UType(Types.PrimitiveType.Int64)));
                if (enableHostIO)
                {
                    foreach (string name in new[] { "HostRead", "HostWrite" })
                    {
                        if (module.Functions.Any(f => f.Name == name) || module.Actions.Any(a => a.Name == name) || contracts.Imports.Any(i => i.Alias == name))
                            throw new ArgumentException(name + " is reserved when host I/O is enabled.");
                        imports.Callables.Add(name, new(name, "ubytec_hostio_" + name, 5,
                            new Types.UType(Types.PrimitiveType.Int64)));
                    }
                }
                scopes.Push(imports);
            }
            string assembly = module.Compile(scopes);
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
            if (optimizeStackTransfers) assembly = Ubytec.Language.Tools.Optimization.StackTransferOptimizer.Optimize(assembly);
            if (optimizeFrameValues) assembly = Ubytec.Language.Tools.Optimization.FrameValueOptimizer.Optimize(assembly);
            var main = module.Functions.FirstOrDefault(x => x.Name == "Main");
            var result=new SourceCompilation(module,assembly,string.IsNullOrEmpty(main.Name)?null:FunctionEmitter.Binding(main).Label);
            if(contracts.Imports.Count!=0 || contracts.Exports.Count!=0)
            {
                string extra=contracts.Emit(result);
                result=result with { Assembly=assembly+extra };
            }
            return result;
        }
    }
}
