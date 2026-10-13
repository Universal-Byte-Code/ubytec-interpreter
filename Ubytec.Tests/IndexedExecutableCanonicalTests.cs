using System.Buffers.Binary;
using System.Text;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class IndexedExecutableCanonicalTests
{
    [Fact]
    public void UnsortedStringTableIsRejected()
    {
        byte[] strings = StringTable("zeta", "alpha");
        byte[] emptyTable = new byte[4];

        var image = new PortableModuleImage(
            PortableModuleFormat.CurrentMajorVersion,
            PortableModuleFormat.CurrentMinorVersion,
            [
                Section(PortableModuleSectionKind.IndexedStringTable, strings),
                Section(PortableModuleSectionKind.IndexedTypeTable, emptyTable),
                Section(PortableModuleSectionKind.IndexedFunctionTable, emptyTable),
                Section(PortableModuleSectionKind.IndexedImportTable, emptyTable),
                Section(PortableModuleSectionKind.IndexedExportTable, emptyTable),
                Section(PortableModuleSectionKind.IndexedConstantTable, emptyTable),
                Section(PortableModuleSectionKind.IndexedCode, [])
            ]);

        Assert.Throws<InvalidDataException>(() => IndexedExecutableFormat.Verify(image));
    }

    private static PortableModuleSection Section(
        PortableModuleSectionKind kind,
        byte[] payload) =>
        new((ushort)kind, PortableModuleSectionFlags.Critical, payload);

    private static byte[] StringTable(params string[] values)
    {
        using var stream = new MemoryStream();
        Span<byte> word = stackalloc byte[4];
        BinaryPrimitives.WriteUInt32LittleEndian(word, checked((uint)values.Length));
        stream.Write(word);

        foreach (string value in values)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(value);
            BinaryPrimitives.WriteUInt32LittleEndian(word, checked((uint)bytes.Length));
            stream.Write(word);
            stream.Write(bytes);
        }

        return stream.ToArray();
    }
}
