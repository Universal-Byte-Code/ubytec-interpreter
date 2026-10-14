using System.Buffers.Binary;
using Ubytec.Language.AST;
using Ubytec.Language.Operations;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableBinaryVerifierTests
{
    private const string BoundarySource = """
        import Remote from math.Twice (t_int64) -> t_int64
        export Main as Execute (t_int64) -> t_int64
        module (name:"binary-verifier", version:"0.1", author:"Ubytec")
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
    public void IndependentVerifierAcceptsAstOnlyAndIndexedModules()
    {
        const string astOnlySource = """
            module (name:"ast-only-verifier", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 42
                    return
                }
            }
            """;
        SourceCompilation astOnly = SourceCompiler.Compile(astOnlySource, emitProcessEntryPoint: false);
        PortableBinaryVerifier.Verify(PortableModuleFormat.Encode(astOnly.Module));

        PortableBinaryVerifier.Verify(BuildIndexed());
    }

    [Fact]
    public void IndependentVerifierRejectsContainerCorruption()
    {
        byte[] bytes = BuildIndexed();
        byte[] badMagic = bytes.ToArray();
        badMagic[0] ^= 0x20;
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(badMagic));

        byte[] truncated = bytes[..11];
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(truncated));
    }

    [Fact]
    public void IndependentVerifierRejectsReservedTypeModifierBits()
    {
        byte[] bytes = BuildIndexed();
        var (offset, _) = FindSection(bytes, PortableModuleSectionKind.IndexedTypeTable);
        int firstEntry = offset + 4;
        uint modifiers = BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(firstEntry + 1, 4));
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(firstEntry + 1, 4), modifiers | 0x80000000u);

        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void IndependentVerifierRejectsZeroCellScalarExtent()
    {
        byte[] bytes = BuildIndexed();
        var (offset, _) = FindSection(bytes, PortableModuleSectionKind.IndexedTypeTable);
        int firstEntry = offset + 4;
        BinaryPrimitives.WriteUInt64LittleEndian(bytes.AsSpan(firstEntry + 5, 8), 0);

        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void IndependentVerifierRejectsReservedCallTargetKind()
    {
        byte[] bytes = BuildIndexed();
        var (offset, length) = FindSection(bytes, PortableModuleSectionKind.IndexedCode);
        Span<byte> code = bytes.AsSpan(offset, length);
        int call = -1;
        for (int index = 0; index + 5 < code.Length; index++)
        {
            if (code[index] == FunctionOperations.CALL.OP && code[index + 1] <= 1)
            {
                call = index;
                break;
            }
        }
        Assert.True(call >= 0, "Expected at least one portable CALL instruction.");
        code[call + 1] = 0x7F;

        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    private static byte[] BuildIndexed()
    {
        SourceCompilation compilation = SourceCompiler.Compile(
            BoundarySource,
            emitProcessEntryPoint: false,
            enableModuleCalls: true);
        return PortableModuleFormat.Encode(
            compilation.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: compilation.PortableContracts);
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
