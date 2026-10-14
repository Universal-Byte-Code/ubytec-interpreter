using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableBinaryCodecTests
{
    private const string BoundarySource = """
        import Remote from math.Twice (t_int64) -> t_int64
        export Main as Execute (t_int64) -> t_int64
        module (name:"binary-codec", version:"0.1", author:"Ubytec")
        {
            func Local(t_int64 value) -> t_int64
            {
                load @value
                push 1
                add
                return
            }

            func Main(t_int64 value) -> t_int64
            {
                load @value
                call Local
                push 1000
                push 16384
                call Remote
                return
            }
        }
        """;

    [Fact]
    public void IndexedExecutableRoundTripsByteForByte()
    {
        SourceCompilation compilation = SourceCompiler.Compile(
            BoundarySource,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);
        byte[] original = PortableModuleFormat.Encode(
            compilation.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: compilation.PortableContracts);

        PortableBinaryModule decoded = PortableBinaryCodec.Decode(original);
        byte[] reencoded = PortableBinaryCodec.Encode(decoded);

        Assert.Equal(original, reencoded);
        Assert.NotNull(decoded.Executable);
        Assert.Single(decoded.Executable!.Imports);
        Assert.Single(decoded.Executable.Exports);
        Assert.Contains(
            decoded.Executable.Functions.SelectMany(function => function.Instructions),
            instruction => instruction is PortableCallInstruction
            {
                TargetKind: PortableCallTargetKind.Import
            });
    }

    [Fact]
    public void AstOnlyPortableModuleRoundTripsByteForByte()
    {
        const string source = """
            module (name:"ast-only", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 42
                    return
                }
            }
            """;
        SourceCompilation compilation = SourceCompiler.Compile(source, emitProcessEntryPoint: false);
        byte[] original = PortableModuleFormat.Encode(compilation.Module);

        PortableBinaryModule decoded = PortableBinaryCodec.Decode(original);
        byte[] reencoded = PortableBinaryCodec.Encode(decoded);

        Assert.Null(decoded.Executable);
        Assert.Equal(original, reencoded);
    }

    [Fact]
    public void DecoderExposesTypedCodeInsteadOfAstOperands()
    {
        SourceCompilation compilation = SourceCompiler.Compile(
            BoundarySource,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);
        byte[] bytes = PortableModuleFormat.Encode(
            compilation.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: compilation.PortableContracts);

        PortableExecutableModule executable = PortableBinaryCodec.Decode(bytes).Executable!;
        PortableCallInstruction[] calls = executable.Functions
            .SelectMany(function => function.Instructions)
            .OfType<PortableCallInstruction>()
            .ToArray();

        Assert.Contains(calls, call => call.TargetKind == PortableCallTargetKind.LocalFunction);
        Assert.Contains(calls, call => call.TargetKind == PortableCallTargetKind.Import);
        Assert.All(calls, call => Assert.True(call.TargetIndex < uint.MaxValue));
    }
}
