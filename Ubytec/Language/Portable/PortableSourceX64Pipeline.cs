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
    /// The returned semantic module is exposed only for diagnostics and sidecars; native code generation
    /// depends exclusively on <see cref="PortableSourceX64Result.ModuleBytes"/>.
    /// </summary>
    public static PortableSourceX64Result Compile(
        string source,
        string? grammarJson = null,
        bool processImage = true,
        bool enableModuleCalls = false,
        bool enableHostIO = false)
    {
        SourceSemanticCompilation frontend = SourceCompiler.CompileSemantic(
            source,
            grammarJson,
            processImage: processImage,
            enableModuleCalls: enableModuleCalls,
            enableHostIO: enableHostIO);

        byte[] moduleBytes = PortableModuleFormat.Encode(
            frontend.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: frontend.PortableContracts);

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
