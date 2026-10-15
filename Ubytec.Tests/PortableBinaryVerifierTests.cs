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
    public void IndependentVerifierRejectsUnsupportedVersion()
    {
        byte[] bytes = BuildIndexed();
        BinaryPrimitives.WriteUInt16LittleEndian(bytes.AsSpan(4, 2), 1);

        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
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

    [Fact]
    public void IndependentVerifierRejectsMutatedAluUnderflowWithoutFrontend()
    {
        const string source = """
            module (name:"binary-underflow", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 1
                    dup
                    add
                    return
                }
            }
            """;
        byte[] bytes = BuildIndexed(source);
        Span<byte> code = Code(bytes);
        int duplicate = FindOpcode(code, StackOperations.DUP.OP);
        code[duplicate] = ArithmeticOperations.ADD.OP;

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("evaluation stack cell", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public void IndependentVerifierUsesLocalFunctionArityForCallStackEffects()
    {
        const string source = """
            module (name:"binary-local-call", version:"0.1", author:"Ubytec")
            {
                func Pair(t_int64 left, t_int64 right) -> t_int64
                {
                    load @left
                    load @right
                    add
                    return
                }

                func Main() -> t_int64
                {
                    push 1
                    dup
                    call Pair
                    return
                }
            }
            """;
        byte[] bytes = BuildIndexed(source);
        Span<byte> code = Code(bytes);
        int duplicate = FindOpcode(code, StackOperations.DUP.OP);
        code[duplicate] = CoreOperations.NOP.OP;

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("evaluation stack cell", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public void IndependentVerifierUsesImportLoanCellCountForCallStackEffects()
    {
        const string source = """
            import Remote from math.Read (t_uint64) -> t_int64
            module (name:"binary-import-call", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 4096
                    push 1000
                    push 16384
                    call Remote
                    return
                }
            }
            """;
        byte[] bytes = BuildIndexed(source, enableModuleCalls: true);
        var (importsOffset, _) = FindSection(bytes, PortableModuleSectionKind.IndexedImportTable);
        int firstArgumentMode = importsOffset + 4 + 16;
        Assert.Equal((byte)PortablePassingMode.Value, bytes[firstArgumentMode]);
        bytes[firstArgumentMode] = (byte)PortablePassingMode.LoanRead;

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("evaluation stack cell", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public void IndependentVerifierRejectsStoreToReadonlyBindingFromMutatedBytes()
    {
        const string source = """
            module (name:"binary-readonly", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    local
                    {
                        readonly t_int64 value 1
                    }
                    push 2
                    load @value
                    add
                    return
                }
            }
            """;
        byte[] bytes = BuildIndexed(source);
        Span<byte> code = Code(bytes);
        int load = FindSequence(code, new byte[] { MemoryOperations.LOAD.OP, 2 });
        code[load] = MemoryOperations.STORE.OP;

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("readonly/const", error.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void IndependentVerifierRejectsNonVoidReachableFallthroughFromMutatedBytes()
    {
        const string source = """
            module (name:"binary-fallthrough", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 42
                    return
                }
            }
            """;
        byte[] bytes = BuildIndexed(source);
        Span<byte> code = Code(bytes);
        int ret = FindSequence(code, new byte[] { CoreOperations.RETURN.OP, 0 });
        code[ret] = CoreOperations.NOP.OP;
        code[ret + 1] = CoreOperations.NOP.OP;

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("reachable path without RETURN", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public void IndependentVerifierRejectsReturnUnderflowAfterSignatureMutation()
    {
        const string source = """
            module (name:"binary-return", version:"0.1", author:"Ubytec")
            {
                func Anchor() -> t_int64
                {
                    push 1
                    return
                }

                action Stop()
                {
                    return
                }
            }
            """;
        byte[] bytes = BuildIndexed(source);
        FunctionRow[] functions = ReadFunctionRows(bytes);
        Assert.Equal(2, functions.Length);
        BinaryPrimitives.WriteUInt32LittleEndian(
            bytes.AsSpan(functions[1].Offset, 4),
            functions[0].ReturnType);

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("evaluation stack cell", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public void IndependentVerifierRejectsNonCellBindingTypeFromMutatedFunctionTable()
    {
        const string source = """
            module (name:"binary-binding-type", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    local
                    {
                        t_int64 value 1
                    }
                    load @value
                    return
                }

                action Marker()
                {
                    return
                }
            }
            """;
        byte[] bytes = BuildIndexed(source);
        FunctionRow[] functions = ReadFunctionRows(bytes);
        Assert.Equal(2, functions.Length);
        uint voidType = functions[1].ReturnType;
        BinaryPrimitives.WriteUInt32LittleEndian(
            bytes.AsSpan(functions[0].BindingTypesOffset, 4),
            voidType);

        InvalidDataException error = Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes));

        Assert.Contains("scalar cell type", error.Message, StringComparison.Ordinal);
    }

    private static byte[] BuildIndexed() => BuildIndexed(BoundarySource, enableModuleCalls: true);

    private static byte[] BuildIndexed(string source, bool enableModuleCalls = false)
    {
        SourceSemanticCompilation compilation = SourceCompiler.CompileSemantic(
            source,
            processImage: false,
            enableModuleCalls: enableModuleCalls);
        return PortableModuleFormat.Encode(
            compilation.Module,
            contractManifest: null,
            includeIndexedExecutable: true,
            portableContracts: compilation.PortableContracts);
    }

    private static Span<byte> Code(byte[] bytes)
    {
        var (offset, length) = FindSection(bytes, PortableModuleSectionKind.IndexedCode);
        return bytes.AsSpan(offset, length);
    }

    private static int FindOpcode(ReadOnlySpan<byte> code, byte opcode)
    {
        int index = code.IndexOf(opcode);
        Assert.True(index >= 0, $"Expected opcode 0x{opcode:X2} in portable code.");
        return index;
    }

    private static int FindSequence(ReadOnlySpan<byte> code, ReadOnlySpan<byte> sequence)
    {
        int index = code.IndexOf(sequence);
        Assert.True(index >= 0, "Expected instruction byte sequence in portable code.");
        return index;
    }

    private static FunctionRow[] ReadFunctionRows(byte[] bytes)
    {
        var (offset, length) = FindSection(bytes, PortableModuleSectionKind.IndexedFunctionTable);
        ReadOnlySpan<byte> table = bytes.AsSpan(offset, length);
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(table[..4]);
        var result = new FunctionRow[checked((int)count)];
        int cursor = 4;
        for (int index = 0; index < result.Length; index++)
        {
            int rowOffset = offset + cursor;
            uint returnType = BinaryPrimitives.ReadUInt32LittleEndian(table.Slice(cursor, 4));
            uint argumentCount = BinaryPrimitives.ReadUInt32LittleEndian(table.Slice(cursor + 4, 4));
            uint localCount = BinaryPrimitives.ReadUInt32LittleEndian(table.Slice(cursor + 8, 4));
            cursor += 24;
            int bindingTypesOffset = offset + cursor;
            cursor = checked(cursor + (int)(argumentCount + localCount) * 4);
            result[index] = new FunctionRow(rowOffset, returnType, bindingTypesOffset);
        }
        Assert.Equal(table.Length, cursor);
        return result;
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

    private readonly record struct FunctionRow(
        int Offset,
        uint ReturnType,
        int BindingTypesOffset);
}
