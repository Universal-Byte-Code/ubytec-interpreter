using System.Buffers.Binary;
using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableBinaryVerifierFrameAttackTests
{
    [Fact]
    public void IndependentVerifierRejectsVarRetargetedFromLocalToArgument()
    {
        const string source = """
            module (name:"binary-var-attack", version:"0.1", author:"Ubytec")
            {
                func Main(t_int64 value) -> t_int64
                {
                    local
                    {
                        t_int64 scratch 0
                    }
                    load @value
                    return
                }
            }
            """;

        SourceSemanticCompilation compilation = SourceCompiler.CompileSemantic(
            source,
            processImage: false);
        byte[] bytes = PortableModuleFormat.Encode(
            compilation.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: compilation.PortableContracts);

        var (codeOffset, codeLength) = FindSection(bytes, PortableModuleSectionKind.IndexedCode);
        Span<byte> code = bytes.AsSpan(codeOffset, codeLength);

        Assert.True(code.Length >= 13, "Expected canonical local VAR initialization.");
        Assert.Equal(0x10, code[0]);
        Assert.Equal(1u, BinaryPrimitives.ReadUInt32LittleEndian(code.Slice(1, 4)));

        // Retarget the canonical local initialization to BindingIndex 0, which is the argument.
        // The source frontend never produced this program; only the raw UBCM bytes are malicious.
        BinaryPrimitives.WriteUInt32LittleEndian(code.Slice(1, 4), 0);

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("VAR cannot initialize an argument", error.Message, StringComparison.Ordinal);
    }

    private static (int Offset, int Length) FindSection(
        byte[] bytes,
        PortableModuleSectionKind target)
    {
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(8, 4));
        int cursor = 12;
        for (uint index = 0; index < count; index++)
        {
            ushort kind = BinaryPrimitives.ReadUInt16LittleEndian(bytes.AsSpan(cursor, 2));
            ulong rawLength = BinaryPrimitives.ReadUInt64LittleEndian(bytes.AsSpan(cursor + 4, 8));
            cursor += 12;
            int length = checked((int)rawLength);
            if (kind == (ushort)target)
                return (cursor, length);
            cursor += length;
        }

        throw new InvalidOperationException($"Section {target} was not found.");
    }
}
