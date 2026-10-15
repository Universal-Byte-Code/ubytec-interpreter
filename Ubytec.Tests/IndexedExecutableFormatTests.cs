using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class IndexedExecutableFormatTests
{
    private const string Source = """
        module (name:"indexed", version:"0.1", author:"Ubytec")
        {
            func Twice(t_int64 value) -> t_int64
            {
                load @value
                push 2
                mul
                return
            }

            func Main() -> t_int64
            {
                local
                {
                    t_int64 counter 20
                }
                load @counter
                push 1
                add
                store @counter
                load @counter
                call Twice
                return
            }
        }
        """;

    [Fact]
    public void IndexedEncodingIsDeterministicAndVerifiable()
    {
        var firstCompilation = SourceCompiler.Compile(Source);
        var secondCompilation = SourceCompiler.Compile(Source);

        byte[] first = PortableModuleFormat.Encode(
            firstCompilation.Module,
            includeIndexedExecutable: true);
        byte[] second = PortableModuleFormat.Encode(
            secondCompilation.Module,
            includeIndexedExecutable: true);

        Assert.Equal(first, second);

        PortableModuleImage image = PortableModuleFormat.Decode(first);
        Assert.True(IndexedExecutableFormat.IsPresent(image));
        Assert.Equal(8, image.Sections.Count);
        Assert.NotNull(image.GetSection(PortableModuleSectionKind.IndexedStringTable));
        Assert.NotNull(image.GetSection(PortableModuleSectionKind.IndexedTypeTable));
        Assert.NotNull(image.GetSection(PortableModuleSectionKind.IndexedFunctionTable));
        Assert.NotNull(image.GetSection(PortableModuleSectionKind.IndexedCode));
    }

    [Fact]
    public void CodeSectionUsesIndicesInsteadOfLocalNames()
    {
        var compilation = SourceCompiler.Compile(Source);
        byte[] bytes = PortableModuleFormat.Encode(
            compilation.Module,
            includeIndexedExecutable: true);

        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        byte[] code = image.GetRequiredSection(PortableModuleSectionKind.IndexedCode).Payload.ToArray();
        string lossyAscii = Encoding.ASCII.GetString(code);

        Assert.DoesNotContain("Twice", lossyAscii, StringComparison.Ordinal);
        Assert.DoesNotContain("counter", lossyAscii, StringComparison.Ordinal);
        Assert.True(Contains(code, [0x60, 0x00, 0x00, 0x00, 0x00]));
        Assert.True(Contains(code, [0x50, 0x02, 0x00, 0x00, 0x00, 0x00]));
        Assert.True(Contains(code, [0x51, 0x02, 0x00, 0x00, 0x00, 0x00]));
    }

    [Fact]
    public void InvalidFunctionIndexIsRejected()
    {
        var compilation = SourceCompiler.Compile(Source);
        byte[] bytes = PortableModuleFormat.Encode(
            compilation.Module,
            includeIndexedExecutable: true);

        int codeOffset = FindSectionPayloadOffset(bytes, PortableModuleSectionKind.IndexedCode, out int codeLength);
        Span<byte> code = bytes.AsSpan(codeOffset, codeLength);
        int call = Find(code, [0x60, 0x00, 0x00, 0x00, 0x00]);
        Assert.True(call >= 0);
        code.Slice(call + 1, 4).Fill(0xFF);

        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    [Fact]
    public void PartialIndexedProfileIsRejected()
    {
        var compilation = SourceCompiler.Compile(Source);
        byte[] bytes = PortableModuleFormat.Encode(
            compilation.Module,
            includeIndexedExecutable: true);
        PortableModuleImage complete = PortableModuleFormat.Decode(bytes);

        PortableModuleSection[] partial = complete.Sections
            .Where(section => section.Kind != (ushort)PortableModuleSectionKind.IndexedConstantTable)
            .ToArray();
        var image = new PortableModuleImage(complete.MajorVersion, complete.MinorVersion, partial);

        Assert.Throws<InvalidDataException>(() => IndexedExecutableFormat.Verify(image));
    }

    [Fact]
    public void BasePmfRemainsValidWithoutIndexedProfile()
    {
        var compilation = SourceCompiler.Compile(Source);
        byte[] bytes = PortableModuleFormat.Encode(compilation.Module);

        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        Assert.False(IndexedExecutableFormat.IsPresent(image));
        Assert.Single(image.Sections);
    }

    private static bool Contains(ReadOnlySpan<byte> haystack, ReadOnlySpan<byte> needle) =>
        Find(haystack, needle) >= 0;

    private static int Find(ReadOnlySpan<byte> haystack, ReadOnlySpan<byte> needle)
    {
        if (needle.Length == 0) return 0;
        for (int index = 0; index <= haystack.Length - needle.Length; index++)
            if (haystack.Slice(index, needle.Length).SequenceEqual(needle))
                return index;
        return -1;
    }

    private static int FindSectionPayloadOffset(
        ReadOnlySpan<byte> module,
        PortableModuleSectionKind target,
        out int payloadLength)
    {
        uint count = System.Buffers.Binary.BinaryPrimitives.ReadUInt32LittleEndian(module.Slice(8, 4));
        int offset = 12;
        for (uint index = 0; index < count; index++)
        {
            ushort kind = System.Buffers.Binary.BinaryPrimitives.ReadUInt16LittleEndian(module.Slice(offset, 2));
            ulong rawLength = System.Buffers.Binary.BinaryPrimitives.ReadUInt64LittleEndian(module.Slice(offset + 4, 8));
            int length = checked((int)rawLength);
            int payload = offset + 12;
            if (kind == (ushort)target)
            {
                payloadLength = length;
                return payload;
            }
            offset = checked(payload + length);
        }

        throw new InvalidDataException($"Section {target} was not found.");
    }
}
