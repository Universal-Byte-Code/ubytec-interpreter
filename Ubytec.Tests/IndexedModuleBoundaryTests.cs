using System.Buffers.Binary;
using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class IndexedModuleBoundaryTests
{
    private const string BoundarySource = """
        import Remote from math.Twice (t_int64) -> t_int64
        export Main as Execute (t_int64) -> t_int64
        module (name:"boundary", version:"0.1", author:"Ubytec")
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

    private const string LoanSource = """
        import Copy from memory.Copy (t_loan_rw,t_loan_ro,t_uint64) -> t_int64
        module (name:"loans", version:"0.1", author:"Ubytec")
        {
            func Main() -> t_int64
            {
                push 4096
                push 16
                push 8192
                push 16
                push 16
                push 1000
                push 16384
                call Copy
                return
            }
        }
        """;

    [Fact]
    public void ImportsExportsAndCallsUsePortableIndices()
    {
        SourceCompilation compilation = Compile(BoundarySource);
        byte[] bytes = Encode(compilation);
        PortableModuleImage image = PortableModuleFormat.Decode(bytes);

        string[] strings = ReadStringTable(
            image.GetRequiredSection(PortableModuleSectionKind.IndexedStringTable).Payload.Span);
        Assert.Contains("math", strings);
        Assert.Contains("Twice", strings);
        Assert.Contains("Execute", strings);
        Assert.DoesNotContain("Remote", strings);
        Assert.False(strings.Any(value => value.StartsWith("ubytec_host_contract_", StringComparison.Ordinal)));

        ReadOnlySpan<byte> imports = image
            .GetRequiredSection(PortableModuleSectionKind.IndexedImportTable)
            .Payload.Span;
        ReadOnlySpan<byte> exports = image
            .GetRequiredSection(PortableModuleSectionKind.IndexedExportTable)
            .Payload.Span;
        Assert.Equal(1u, BinaryPrimitives.ReadUInt32LittleEndian(imports[..4]));
        Assert.Equal(1u, BinaryPrimitives.ReadUInt32LittleEndian(exports[..4]));

        ReadOnlySpan<byte> code = image
            .GetRequiredSection(PortableModuleSectionKind.IndexedCode)
            .Payload.Span;
        Assert.True(Find(code, [0x60, 0x00, 0x00, 0x00, 0x00, 0x00]) >= 0);
        Assert.True(Find(code, [0x60, 0x01, 0x00, 0x00, 0x00, 0x00]) >= 0);
    }

    [Fact]
    public void IndexedImageOmitsLegacyNativeContractManifest()
    {
        SourceCompilation compilation = Compile(BoundarySource);
        Assert.Contains("ubytec_host_contract_Execute", compilation.ContractManifest);

        PortableModuleImage image = PortableModuleFormat.Decode(Encode(compilation));

        Assert.Null(image.GetSection(PortableModuleSectionKind.ContractManifest));
        Assert.NotNull(image.GetSection(PortableModuleSectionKind.IndexedImportTable));
        Assert.NotNull(image.GetSection(PortableModuleSectionKind.IndexedExportTable));
    }

    [Fact]
    public void ReservedCallTargetKindIsRejected()
    {
        SourceCompilation compilation = Compile(BoundarySource);
        byte[] bytes = Encode(compilation);
        int codeOffset = FindSectionPayloadOffset(
            bytes,
            PortableModuleSectionKind.IndexedCode,
            out int codeLength);
        Span<byte> code = bytes.AsSpan(codeOffset, codeLength);
        int call = Find(code, [0x60, 0x01, 0x00, 0x00, 0x00, 0x00]);
        Assert.True(call >= 0);
        code[call + 1] = 0x02;

        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    [Fact]
    public void InvalidImportIndexIsRejected()
    {
        SourceCompilation compilation = Compile(BoundarySource);
        byte[] bytes = Encode(compilation);
        int codeOffset = FindSectionPayloadOffset(
            bytes,
            PortableModuleSectionKind.IndexedCode,
            out int codeLength);
        Span<byte> code = bytes.AsSpan(codeOffset, codeLength);
        int call = Find(code, [0x60, 0x01, 0x00, 0x00, 0x00, 0x00]);
        Assert.True(call >= 0);
        code.Slice(call + 2, 4).Fill(0xFF);

        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    [Fact]
    public void LoanSemanticsArePassingModesNotTypes()
    {
        SourceCompilation compilation = Compile(LoanSource);
        byte[] bytes = Encode(compilation);
        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        ReadOnlySpan<byte> imports = image
            .GetRequiredSection(PortableModuleSectionKind.IndexedImportTable)
            .Payload.Span;

        Assert.Equal(1u, BinaryPrimitives.ReadUInt32LittleEndian(imports[..4]));
        Assert.Equal(3u, BinaryPrimitives.ReadUInt32LittleEndian(imports.Slice(16, 4)));
        Assert.Equal((byte)PortablePassingMode.LoanWrite, imports[20]);
        Assert.Equal((byte)PortablePassingMode.LoanRead, imports[25]);
        Assert.Equal((byte)PortablePassingMode.Value, imports[30]);
    }

    [Fact]
    public void IdenticalPortableImportsRemainDistinctAuthoritySlots()
    {
        const string source = """
            import First from math.Twice (t_int64) -> t_int64
            import Second from math.Twice (t_int64) -> t_int64
            module (name:"authority-slots", version:"0.1", author:"Ubytec")
            {
                func Main(t_int64 value) -> t_int64
                {
                    load @value
                    push 1000
                    push 16384
                    call First
                    drop 0
                    load @value
                    push 1000
                    push 16384
                    call Second
                    return
                }
            }
            """;

        SourceCompilation compilation = Compile(source);
        byte[] bytes = Encode(compilation);
        PortableModuleImage image = PortableModuleFormat.Decode(bytes);
        ReadOnlySpan<byte> imports = image
            .GetRequiredSection(PortableModuleSectionKind.IndexedImportTable)
            .Payload.Span;
        ReadOnlySpan<byte> code = image
            .GetRequiredSection(PortableModuleSectionKind.IndexedCode)
            .Payload.Span;

        Assert.Equal(2u, BinaryPrimitives.ReadUInt32LittleEndian(imports[..4]));
        Assert.Equal(1, Count(code, [0x60, 0x01, 0x00, 0x00, 0x00, 0x00]));
        Assert.Equal(1, Count(code, [0x60, 0x01, 0x01, 0x00, 0x00, 0x00]));
    }

    private static SourceCompilation Compile(string source) =>
        SourceCompiler.Compile(
            source,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);

    private static byte[] Encode(SourceCompilation compilation) =>
        PortableModuleFormat.Encode(
            compilation.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: compilation.PortableContracts);

    private static string[] ReadStringTable(ReadOnlySpan<byte> payload)
    {
        int offset = 0;
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(payload.Slice(offset, 4));
        offset += 4;
        var result = new string[checked((int)count)];
        for (int index = 0; index < result.Length; index++)
        {
            int length = checked((int)BinaryPrimitives.ReadUInt32LittleEndian(payload.Slice(offset, 4)));
            offset += 4;
            result[index] = Encoding.UTF8.GetString(payload.Slice(offset, length));
            offset += length;
        }
        Assert.Equal(payload.Length, offset);
        return result;
    }

    private static int Count(ReadOnlySpan<byte> haystack, ReadOnlySpan<byte> needle)
    {
        int count = 0;
        int offset = 0;
        while (offset <= haystack.Length - needle.Length)
        {
            int found = Find(haystack[offset..], needle);
            if (found < 0) break;
            count++;
            offset += found + needle.Length;
        }
        return count;
    }

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
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(module.Slice(8, 4));
        int offset = 12;
        for (uint index = 0; index < count; index++)
        {
            ushort kind = BinaryPrimitives.ReadUInt16LittleEndian(module.Slice(offset, 2));
            int length = checked((int)BinaryPrimitives.ReadUInt64LittleEndian(module.Slice(offset + 4, 8)));
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
