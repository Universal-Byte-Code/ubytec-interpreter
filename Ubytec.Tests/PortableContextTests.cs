using System.Buffers.Binary;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableContextTests
{
    private const uint Root = uint.MaxValue;

    private const string Source = """
        export Owner as portable_owner
        module (name:"context", version:"0.1", author:"Ubytec")
        {
            func Owner() -> t_int64
            {
                local
                {
                    func Hidden() -> t_int64
                    {
                        push 7
                        return
                    }
                }
                call Hidden
                return
            }

            func Other() -> t_int64
            {
                call Owner
                return
            }
        }
        """;

    private static byte[] Build(PortableExecutionProfile profile = PortableExecutionProfile.UnsafeCells,
        string? source = null) =>
        PortableSourceX64Pipeline.Compile(source ?? Source, processImage: false,
            executionProfile: profile).ModuleBytes;

    [Fact]
    public void PreservesNestedDeclarationAndRoundTrips()
    {
        byte[] bytes = Build(PortableExecutionProfile.DirectOnly);
        PortableBinaryVerifier.Verify(bytes, requireDirectOnly: true);
        PortableBinaryModule decoded = PortableBinaryCodec.Decode(bytes);
        PortableExecutableModule executable = decoded.Executable!;
        Assert.Equal(new uint[] { Root, 0, Root }, executable.Contexts.ParentFunctionIndices.ToArray());
        Assert.Equal(PortableExecutionProfile.DirectOnly, executable.Contexts.Profile);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(decoded));
        PortableX64Compilation native = PortableX64Backend.Compile(bytes);
        Assert.Equal(7L, Assert.Single(NativeStack.Run(
            $"call {native.GetFunctionLabel(2)}\npush rax", 1, native.Assembly)));
    }

    [Fact]
    public void VisibilityIncludesOwningContextDescendantsAndSiblingsNotUnrelatedRoots()
    {
        // 0 owns 1 and 3; 1 owns 2; 4 is unrelated.
        var table = new PortableContextTable(PortableExecutionProfile.UnsafeCells,
            [Root, 0, 1, 0, Root]);
        table.RequireVisible(0, 1);
        table.RequireVisible(2, 3);
        table.RequireVisible(3, 1);
        table.RequireVisible(2, 2);
        table.RequireVisible(4, 0);
        Assert.Throws<InvalidDataException>(() => table.RequireVisible(4, 1));
        Assert.Throws<InvalidDataException>(() => table.RequireVisible(0, 2));
        Assert.Throws<InvalidDataException>(() => table.RequireVisible(3, 2));
    }

    [Fact]
    public void IndependentVerifierRejectsOutOfContextCall()
    {
        byte[] bytes = Build();
        Span<byte> body = Body(bytes, 2);
        Assert.Equal(0x60, body[0]); // CALL FunctionIndex=0
        BinaryPrimitives.WriteUInt32LittleEndian(body.Slice(2, 4), 1);
        var error = Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
        Assert.Contains("lexical context", error.Message);
        Assert.Throws<InvalidDataException>(() => PortableModuleFormat.Verify(bytes));
    }

    [Fact]
    public void IndependentVerifierRejectsOutOfContextFunctionAddress()
    {
        string source = Source.Replace("call Owner\n        return", "fnaddr Owner\n        calli 0 t_int64\n        return", StringComparison.Ordinal);
        Assert.NotEqual(Source, source);
        byte[] bytes = Build(source: source);
        Span<byte> body = Body(bytes, 2);
        Assert.Equal(Ubytec.Language.Operations.FunctionOperations.FNADDR.OP, body[0]);
        BinaryPrimitives.WriteUInt32LittleEndian(body.Slice(1, 4), 1);
        var error = Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
        Assert.Contains("lexical context", error.Message);
    }

    [Theory]
    [InlineData(1u, 1u)]
    [InlineData(1u, 2u)]
    [InlineData(1u, 99u)]
    public void RejectsMalformedParentGraph(uint index, uint parent)
    {
        byte[] bytes = Build();
        var (offset, _) = Find(bytes, (ushort)PortableModuleSectionKind.IndexedFunctionContexts);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(offset + 12 + (int)index * 4, 4), parent);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void RejectsReopenedSubtree()
    {
        Assert.Throws<InvalidDataException>(() => new PortableContextTable(
            PortableExecutionProfile.UnsafeCells, [Root, 0, Root, 0]));
    }

    [Fact]
    public void RejectsNestedExportAndProcessEntrypoint()
    {
        byte[] bytes = Build();
        var (offset, _) = Find(bytes, (ushort)PortableModuleSectionKind.IndexedExportTable);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(offset + 8, 4), 1);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));

        byte[] valid = Build();
        Assert.Throws<InvalidDataException>(() => PortableProcessEntrypoint.Attach(valid, 1));
        byte[] process = PortableProcessEntrypoint.Attach(valid, 0);
        var (entryOffset, _) = Find(process, 0x0017);
        BinaryPrimitives.WriteUInt32LittleEndian(process.AsSpan(entryOffset, 4), 1);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(process));
    }

    [Fact]
    public void RejectsMissingOrNoncriticalContextSection()
    {
        byte[] bytes = Build();
        var (offset, length) = Find(bytes, (ushort)PortableModuleSectionKind.IndexedFunctionContexts);
        byte[] missing = bytes[..(offset - 12)].Concat(bytes[(offset + length)..]).ToArray();
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(missing.AsSpan(8, 4));
        BinaryPrimitives.WriteUInt32LittleEndian(missing.AsSpan(8, 4), count - 1);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(missing));

        BinaryPrimitives.WriteUInt16LittleEndian(bytes.AsSpan(offset - 10, 2), 0);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void AdmissionPolicyRejectsUnsafeProfileAndUnknownProfile()
    {
        byte[] bytes = Build();
        PortableBinaryVerifier.Verify(bytes);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes, requireDirectOnly: true));
        var (offset, _) = Find(bytes, (ushort)PortableModuleSectionKind.IndexedFunctionContexts);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(offset + 4, 4), 99);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Theory]
    [InlineData("push 1\ncalli 0 t_int64\nreturn", "FNADDR and CALLI")]
    [InlineData("push 1\nload\nreturn", "raw memory")]
    public void DirectOnlyRejectsUnsafeInstructionsEvenWhenWireIsOtherwiseValid(string body, string message)
    {
        string source = $$"""
            module (name:"unsafe-cells", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    {{body}}
                }
            }
            """;
        byte[] bytes = Build(source: source);
        PortableBinaryVerifier.Verify(bytes);
        var (offset, _) = Find(bytes, (ushort)PortableModuleSectionKind.IndexedFunctionContexts);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(offset + 4, 4), (uint)PortableExecutionProfile.DirectOnly);
        var error = Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
        Assert.Contains(message, error.Message);
    }

    [Fact]
    public void DirectOnlyRejectsFrameReusingTailCalls()
    {
        byte[] bytes = Build(PortableExecutionProfile.DirectOnly);
        Assert.Throws<InvalidDataException>(() => PortableX64Backend.Compile(bytes, optimizeTailCalls: true));
    }

    private static Span<byte> Body(byte[] bytes, int functionIndex)
    {
        var (tableOffset, _) = Find(bytes, (ushort)PortableModuleSectionKind.IndexedFunctionTable);
        var (codeOffset, _) = Find(bytes, (ushort)PortableModuleSectionKind.IndexedCode);
        int cursor = tableOffset + 4;
        for (int index = 0; index < functionIndex; index++)
        {
            uint args = BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(cursor + 4, 4));
            uint locals = BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(cursor + 8, 4));
            cursor = checked(cursor + 24 + 4 * (int)(args + locals));
        }
        int start = checked((int)BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(cursor + 12, 4)));
        int length = checked((int)BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(cursor + 16, 4)));
        return bytes.AsSpan(codeOffset + start, length);
    }

    private static (int Offset, int Length) Find(byte[] bytes, ushort kind)
    {
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(bytes.AsSpan(8, 4));
        int cursor = 12;
        for (uint i = 0; i < count; i++)
        {
            ushort current = BinaryPrimitives.ReadUInt16LittleEndian(bytes.AsSpan(cursor, 2));
            int length = checked((int)BinaryPrimitives.ReadUInt64LittleEndian(bytes.AsSpan(cursor + 4, 8)));
            cursor += 12;
            if (current == kind) return (cursor, length);
            cursor += length;
        }
        throw new InvalidOperationException($"Missing section 0x{kind:X4}.");
    }
}
