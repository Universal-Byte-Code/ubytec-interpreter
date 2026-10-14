using System.Buffers.Binary;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableSourceX64PipelineTests
{
    private const string ProcessSource = """
        module (name:"portable-process", version:"0.1", author:"Ubytec")
        {
            func Helper() -> t_int64
            {
                push 5
                return
            }

            func Main() -> t_int64
            {
                call Helper
                push 37
                add
                return
            }
        }
        """;

    [Fact]
    public void ProcessPipelineCarriesExplicitFunctionIndexIntoX64Start()
    {
        PortableSourceX64Result result = PortableSourceX64Pipeline.Compile(ProcessSource);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(result.ModuleBytes);
        PortableProcessEntrypointInfo entry = Assert.IsType<PortableProcessEntrypointInfo>(
            PortableProcessEntrypoint.Read(binary));

        uint index = Assert.IsType<uint>(entry.FunctionIndex);
        Assert.Equal(1u, index);
        string label = result.NativeCompilation.GetFunctionLabel(checked((int)index));

        Assert.Contains("global _start", result.NativeCompilation.Assembly);
        Assert.Contains($"call {label}", result.NativeCompilation.Assembly);
        Assert.DoesNotContain("Main", result.NativeCompilation.Assembly);
        Assert.DoesNotContain("Helper", result.NativeCompilation.Assembly);

        long value = Assert.Single(NativeStack.Run($"call {label}\npush rax", 1, result.NativeCompilation.Assembly));
        Assert.Equal(42, value);
    }

    [Fact]
    public void LibraryPipelineHasNoProcessSectionOrStartSymbol()
    {
        PortableSourceX64Result result = PortableSourceX64Pipeline.Compile(ProcessSource, processImage: false);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(result.ModuleBytes);

        Assert.Null(PortableProcessEntrypoint.Read(binary));
        Assert.DoesNotContain("global _start", result.NativeCompilation.Assembly);
    }

    [Fact]
    public void ProcessWithoutMainUsesExplicitNoIndexAndExitsZero()
    {
        const string source = """
            module (name:"portable-empty-process", version:"0.1", author:"Ubytec")
            {
                func Helper() -> t_int64
                {
                    push 7
                    return
                }
            }
            """;

        PortableSourceX64Result result = PortableSourceX64Pipeline.Compile(source);
        PortableProcessEntrypointInfo entry = Assert.IsType<PortableProcessEntrypointInfo>(
            PortableProcessEntrypoint.Read(PortableBinaryCodec.Decode(result.ModuleBytes)));

        Assert.Null(entry.FunctionIndex);
        Assert.Contains("global _start", result.NativeCompilation.Assembly);
        Assert.Contains("xor edi, edi", result.NativeCompilation.Assembly);
        Assert.Contains("mov eax, 60", result.NativeCompilation.Assembly);
        Assert.DoesNotContain("call ubytec_binary_f_", ProcessStub(result.NativeCompilation.Assembly));
    }

    [Fact]
    public void ProcessMainWithArgumentsIsRejectedBeforeNativeGeneration()
    {
        const string source = """
            module (name:"portable-bad-main", version:"0.1", author:"Ubytec")
            {
                func Main(t_int64 value) -> t_int64
                {
                    load @value
                    return
                }
            }
            """;

        Assert.Throws<InvalidDataException>(() => PortableSourceX64Pipeline.Compile(source));
    }

    [Fact]
    public void ProcessEntrypointSurvivesCanonicalBinaryRoundTrip()
    {
        PortableSourceX64Result result = PortableSourceX64Pipeline.Compile(ProcessSource);
        byte[] roundTrip = PortableBinaryCodec.Encode(PortableBinaryCodec.Decode(result.ModuleBytes));

        Assert.Equal(result.ModuleBytes, roundTrip);
        PortableProcessEntrypoint.Verify(roundTrip);
    }

    [Fact]
    public void ProcessVerifierRejectsOutOfRangeFunctionIndex()
    {
        PortableSourceX64Result result = PortableSourceX64Pipeline.Compile(ProcessSource);
        PortableBinaryModule binary = PortableBinaryCodec.Decode(result.ModuleBytes);
        PortableModuleSection entry = Assert.Single(binary.ContainerSections.Where(
            section => section.Kind == PortableProcessEntrypoint.SectionKind));
        byte[] payload = entry.Payload.ToArray();
        BinaryPrimitives.WriteUInt32LittleEndian(payload, 123456u);
        PortableModuleSection replacement = entry with { Payload = payload };
        PortableBinaryModule malformed = binary with
        {
            ContainerSections = binary.ContainerSections
                .Select(section => section.Kind == PortableProcessEntrypoint.SectionKind ? replacement : section)
                .ToArray()
        };
        byte[] bytes = PortableBinaryCodec.Encode(malformed);

        Assert.Throws<InvalidDataException>(() => PortableProcessEntrypoint.Verify(bytes));
        Assert.Throws<InvalidDataException>(() => PortableProcessX64Backend.Compile(bytes));
    }

    private static string ProcessStub(string assembly)
    {
        int start = assembly.LastIndexOf("_start:", StringComparison.Ordinal);
        return start < 0 ? string.Empty : assembly[start..];
    }
}
