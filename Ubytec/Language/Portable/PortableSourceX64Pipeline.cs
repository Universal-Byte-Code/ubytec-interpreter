using Ubytec.Language.AST;
using Ubytec.Language.HighLevel;

namespace Ubytec.Language.Portable;

/// <summary>Artifacts produced by the source -> indexed UBCM -> verified x64 pipeline.</summary>
public sealed record PortableSourceX64Result(
    byte[] ModuleBytes,
    PortableX64Compilation NativeCompilation,
    Module SemanticModule);

/// <summary>
/// Canonical source -> portable binary -> x64 pipeline. The source phase is semantic only:
/// no legacy NASM is generated before the verified UBCM boundary is crossed.
/// </summary>
public static class PortableSourceX64Pipeline
{
    /// <summary>
    /// Compiles source semantically to indexed PMF and then generates x64 only from the resulting verified binary.
    /// Requested host exports, source loader contracts and reserved supervisor imports are serialized before the
    /// verifier boundary. Tail-call optimization, runtime bindings and native ABI projections run only afterward
    /// and are driven by the verified UBCM representation rather than source or AST identity.
    /// </summary>
    public static PortableSourceX64Result Compile(
        string source,
        string? grammarJson = null,
        bool processImage = true,
        bool enableModuleCalls = false,
        bool enableHostIO = false,
        bool optimizeTailCalls = false,
        IReadOnlyList<PortableRequestedExport>? requestedExports = null)
    {
        SourceSemanticCompilation frontend = SourceCompiler.CompileSemantic(
            source,
            grammarJson,
            processImage: processImage,
            enableModuleCalls: enableModuleCalls,
            enableHostIO: enableHostIO);
        PortableModuleContracts portableContracts =
            PortableSystemVLibraryAbi.AddRequestedExports(frontend, requestedExports);
        portableContracts = PortableX64RuntimeImports.AddContracts(
            portableContracts,
            enableModuleCalls,
            enableHostIO);

        // The source contract parser is deterministic and is reused here only before serialization.
        // Its loader-facing alias/slot names are embedded in the critical UBCM ContractManifest;
        // no source contract state is consulted after the verifier boundary.
        var sourceContracts = new ModuleContracts();
        _ = sourceContracts.Read(source);
        string contractManifest = sourceContracts.BuildManifest(frontend.Module);

        byte[] moduleBytes = PortableModuleFormat.Encode(
            frontend.Module,
            contractManifest: string.IsNullOrEmpty(contractManifest) ? null : contractManifest,
            includeIndexedExecutable: true,
            portableContracts: portableContracts);

        if (processImage)
        {
            uint? entrypoint = ResolveMainFunctionIndex(frontend.Module);
            if (entrypoint is uint index)
            {
                Ubytec.Language.HighLevel.Func main = frontend.Module.Functions
                    .First(function => string.Equals(function.Name, "Main", StringComparison.Ordinal));
                if (main.Arguments.Length != 0)
                    throw new InvalidDataException("Portable process Main must have zero arguments.");
                moduleBytes = PortableProcessEntrypoint.Attach(moduleBytes, index);
            }
            else
            {
                moduleBytes = PortableProcessEntrypoint.Attach(moduleBytes, null);
            }
        }

        PortableProcessEntrypoint.Verify(moduleBytes);
        PortableX64Compilation native = PortableProcessX64Backend.Compile(moduleBytes);
        if (optimizeTailCalls)
            native = PortableX64TailCallOptimizer.Apply(moduleBytes, native);
        native = PortableX64RuntimeImports.Attach(moduleBytes, native);
        if (!processImage)
        {
            native = PortableX64ModuleContractAbi.Attach(moduleBytes, native);
            native = native with
            {
                Assembly = PortableSystemVLibraryAbi.Attach(moduleBytes, native)
            };
        }
        return new PortableSourceX64Result(moduleBytes, native, frontend.Module);
    }

    private static uint? ResolveMainFunctionIndex(Module module)
    {
        uint index = 0;
        foreach (Ubytec.Language.HighLevel.Func function in module.Functions)
        {
            if (string.Equals(function.Name, "Main", StringComparison.Ordinal))
                return index;
            index = checked(index + Count(function));
        }
        return null;
    }

    private static uint Count(Ubytec.Language.HighLevel.Func function)
    {
        uint count = 1;
        foreach (Ubytec.Language.HighLevel.Func nested in function.Locals?.Functions ?? [])
            count = checked(count + Count(nested));
        foreach (Ubytec.Language.HighLevel.Action nested in function.Locals?.Actions ?? [])
            count = checked(count + Count(nested));
        return count;
    }

    private static uint Count(Ubytec.Language.HighLevel.Action action)
    {
        uint count = 1;
        foreach (Ubytec.Language.HighLevel.Func nested in action.Locals?.Functions ?? [])
            count = checked(count + Count(nested));
        foreach (Ubytec.Language.HighLevel.Action nested in action.Locals?.Actions ?? [])
            count = checked(count + Count(nested));
        return count;
    }
}
