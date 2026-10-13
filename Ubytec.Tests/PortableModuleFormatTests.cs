using System.Buffers.Binary;
using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableModuleFormatTests
{
    private const string Source = """
        module (name:"portable", version:"0.1", author:"Ubytec") {
        func Main() -> t_int64 {
        push 42
        return
        }
        }
        """;

    [Fact]
    public void EncodingIsDeterministicAndVerifiable()
    {
        var firstCompilation = SourceCompiler.Compile(Source);
        var secondCompilation = SourceCompiler.Compile(Source);

        byte[] first = PortableModuleFormat.Encode(firstCompilation.Module);
        byte[] second = PortableModuleFormat.Encode(secondCompilation.Module);

        Assert.Equal(first, second);
        PortableModuleImage image = PortableModuleFormat.Decode(first);
        Assert.Equal((ushort)0, image.MajorVersion);
        Assert.Equal((ushort)0, image.MinorVersion);
        Assert.Single(image.Sections);
        string ast = Encoding.UTF8.GetString(
            image.GetRequiredSection(PortableModuleSectionKind.SemanticAst).Payload.Span);
        Assert.StartsWith("{", ast);
        Assert.Contains("portable", ast);
        Assert.DoesNotContain("\"guid\"", ast);
        Assert.DoesNotContain("\r", ast);
        Assert.DoesNotContain("\n", ast);
    }

    [Fact]
    public void ContractAndCapabilitiesAreCanonicalSections()
    {
        var compilation = SourceCompiler.Compile(Source);
        byte[] bytes = PortableModuleFormat.Encode(
            compilation.Module,
            "I|1|Read|tools|Read|UInt64:Int64\r\nEND\r\n",
            ["host.random", "host.clock", "host.random"]);

        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        Assert.Equal(3, image.Sections.Count);

        string contract = Encoding.UTF8.GetString(
            image.GetRequiredSection(PortableModuleSectionKind.ContractManifest).Payload.Span);
        Assert.Equal("I|1|Read|tools|Read|UInt64:Int64\nEND\n", contract);

        string capabilities = Encoding.UTF8.GetString(
            image.GetRequiredSection(PortableModuleSectionKind.CapabilityManifest).Payload.Span);
        Assert.Equal("[\"host.clock\",\"host.random\"]", capabilities);
    }

    [Fact]
    public void BadMagicIsRejected()
    {
        byte[] bytes = Encode();
        bytes[0] ^= 0x20;
        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    [Fact]
    public void TrailingBytesAreRejected()
    {
        byte[] bytes = Encode();
        Array.Resize(ref bytes, bytes.Length + 1);
        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    [Fact]
    public void NonCanonicalAstJsonIsRejected()
    {
        byte[] original = Encode();
        ulong astLength = BinaryPrimitives.ReadUInt64LittleEndian(original.AsSpan(16, 8));
        byte[] changed = new byte[original.Length + 1];
        original.AsSpan(0, 24).CopyTo(changed);
        BinaryPrimitives.WriteUInt64LittleEndian(changed.AsSpan(16, 8), astLength + 1);
        changed[24] = (byte)' ';
        original.AsSpan(24).CopyTo(changed.AsSpan(25));

        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(changed));
    }

    [Fact]
    public void UnknownOptionalSectionCanBeSkipped()
    {
        byte[] bytes = AppendUnknownSection(Encode(), critical: false);
        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        Assert.Equal(2, image.Sections.Count);
        Assert.Equal((ushort)0x7000, image.Sections[1].Kind);
    }

    [Fact]
    public void UnknownCriticalSectionIsRejected()
    {
        byte[] bytes = AppendUnknownSection(Encode(), critical: true);
        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    [Fact]
    public void UnsupportedVersionIsRejected()
    {
        byte[] bytes = Encode();
        BinaryPrimitives.WriteUInt16LittleEndian(bytes.AsSpan(4, 2), 1);
        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    private static byte[] Encode()
    {
        var compilation = SourceCompiler.Compile(Source);
        return PortableModuleFormat.Encode(compilation.Module);
    }

    private static byte[] AppendUnknownSection(byte[] original, bool critical)
    {
        byte[] changed = new byte[original.Length + 12];
        original.CopyTo(changed, 0);
        BinaryPrimitives.WriteUInt32LittleEndian(changed.AsSpan(8, 4), 2);
        int offset = original.Length;
        BinaryPrimitives.WriteUInt16LittleEndian(changed.AsSpan(offset, 2), 0x7000);
        BinaryPrimitives.WriteUInt16LittleEndian(
            changed.AsSpan(offset + 2, 2),
            critical ? (ushort)PortableModuleSectionFlags.Critical : (ushort)0);
        BinaryPrimitives.WriteUInt64LittleEndian(changed.AsSpan(offset + 4, 8), 0);
        return changed;
    }
}
