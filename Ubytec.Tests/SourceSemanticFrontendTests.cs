using Ubytec.Language.AST;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class SourceSemanticFrontendTests
{
    private const string ContractSource = """
        import Remote from math.Twice (t_int64) -> t_int64
        export Main as Execute (t_int64) -> t_int64
        module (name:"semantic-front", version:"0.1", author:"Ubytec")
        {
            func Main(t_int64 value) -> t_int64
            {
                load @value
                push 1000
                push 16384
                call Remote
                return
            }
        }
        """;

    [Fact]
    public void SemanticFrontendProducesTheSameCanonicalPortableProgramAsLegacyCompilation()
    {
        SourceSemanticCompilation semantic = SourceCompiler.CompileSemantic(
            ContractSource,
            processImage: false,
            enableModuleCalls: true);
        SourceCompilation legacy = SourceCompiler.Compile(
            ContractSource,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);

        byte[] semanticBytes = PortableModuleFormat.Encode(
            semantic.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: semantic.PortableContracts);
        byte[] legacyBytes = PortableModuleFormat.Encode(
            legacy.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: legacy.PortableContracts);

        Assert.Equal(legacyBytes, semanticBytes);
    }

    [Fact]
    public void SemanticCompilationExposesNoNativeArtifactSurface()
    {
        Type resultType = typeof(SourceSemanticCompilation);

        Assert.Null(resultType.GetProperty("Assembly"));
        Assert.Null(resultType.GetProperty("EntryLabel"));
        Assert.Equal(
            ["Module", "PortableContracts"],
            resultType.GetProperties()
                .Select(property => property.Name)
                .OrderBy(name => name, StringComparer.Ordinal)
                .ToArray());
    }

    [Fact]
    public void SemanticFrontendDoesNotInvokeLegacyProcessEntrypointEmitter()
    {
        const string source = """
            module (name:"semantic-no-native", version:"0.1", author:"Ubytec")
            {
                func Main(t_int64 value) -> t_int64
                {
                    load @value
                    return
                }
            }
            """;

        SourceSemanticCompilation semantic = SourceCompiler.CompileSemantic(source, processImage: true);

        Assert.Equal("semantic-no-native", semantic.Module.Name);
        Assert.Throws<SyntaxException>(() => SourceCompiler.Compile(source, emitProcessEntryPoint: true));
    }

    [Fact]
    public void SemanticFrontendStillRejectsEvaluationStackUnderflow()
    {
        const string source = """
            module (name:"semantic-underflow", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    add
                    return
                }
            }
            """;

        SyntaxException error = Assert.Throws<SyntaxException>(() =>
            SourceCompiler.CompileSemantic(source));

        Assert.Contains("needs 2 stack cell", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public void SemanticFrontendStillRejectsStoreToReadonlyFrameBinding()
    {
        const string source = """
            module (name:"semantic-readonly", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    local
                    {
                        readonly t_int64 value 1
                    }
                    push 2
                    store @value
                    load @value
                    return
                }
            }
            """;

        SyntaxException error = Assert.Throws<SyntaxException>(() =>
            SourceCompiler.CompileSemantic(source));

        Assert.Contains("readonly symbol", error.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void PortableProcessPipelineUsesProcessContractRulesWithoutLegacyCodegen()
    {
        const string exportedProcess = """
            export Main as Execute () -> t_int64
            module (name:"portable-process-contract", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 42
                    return
                }
            }
            """;

        Assert.Throws<ArgumentException>(() => PortableSourceX64Pipeline.Compile(exportedProcess));

        PortableSourceX64Result library = PortableSourceX64Pipeline.Compile(
            exportedProcess,
            processImage: false);
        Assert.Null(PortableProcessEntrypoint.Read(PortableBinaryCodec.Decode(library.ModuleBytes)));
    }
}
