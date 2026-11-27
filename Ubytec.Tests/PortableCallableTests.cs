using System.Buffers.Binary;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableCallableTests
{
    private const uint Root = uint.MaxValue;
    private const string Source = """
        module (name:"callable-fixture", version:"0.1", author:"Ubytec")
        {
            func First() -> t_int64
            {
                push 7
                return
            }
            func Second() -> t_int64
            {
                push 11
                return
            }
            func Main() -> t_int64
            {
                call First
                return
            }
        }
        """;

    private static PortableBinaryModule Fixture()
    {
        // Deliberately construct a binary executable independent of future source grammar.
        PortableBinaryModule ordinary = PortableBinaryCodec.Decode(
            PortableSourceX64Pipeline.Compile(Source, processImage: false).ModuleBytes);
        PortableExecutableModule executable = ordinary.Executable!;
        var functions = executable.Functions.ToArray();
        var sig = new PortableCallableSignature(functions[0].ReturnTypeIndex, functions[0].ArgumentTypeIndices);
        functions[2] = functions[2] with
        {
            Instructions =
            [
                new PortableCallableInstruction(0, 0, 0),
                new PortableCallableInstruction(1, 1, 0),
                new PortableCallableInstruction(2, 0),
                new PortableCallableInstruction(3, 1),
                new PortableCallableInstruction(0, 0, 1),
                new PortableCallableInstruction(3, 0),
                new PortableOperandFreeInstruction(0x20),
                new PortableReturnInstruction(null)
            ]
        };
        return ordinary with
        {
            Executable = executable with
            {
                Functions = functions,
                Contexts = new PortableContextTable(PortableExecutionProfile.CallableLocal, [Root, Root, Root]),
                CallableSlots = new PortableCallableTable([[], [], [sig, sig]])
            }
        };
    }

    private static byte[] Bytes() => PortableBinaryCodec.Encode(Fixture());

    [Theory]
    [InlineData(PortableExecutionProfile.UnsafeCells)]
    [InlineData(PortableExecutionProfile.DirectOnly)]
    public void OrdinaryProfilesDoNotRequireCallableSlotSection(PortableExecutionProfile profile)
    {
        byte[] bytes = PortableSourceX64Pipeline.Compile(Source, processImage: false,
            executionProfile: profile).ModuleBytes;
        PortableBinaryVerifier.Verify(bytes, profile);
        PortableBinaryModule module = PortableBinaryCodec.Decode(bytes);
        Assert.Null(module.Executable!.CallableSlots);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(module));
        Assert.Throws<InvalidDataException>(() =>
            PortableBinaryVerifier.Verify(bytes, PortableExecutionProfile.CallableLocal));
    }

    [Fact]
    public void IndependentVerifierAndTypedCodecAcceptExactCallableProfile()
    {
        byte[] bytes = Bytes();
        PortableBinaryVerifier.Verify(bytes, PortableExecutionProfile.CallableLocal);
        Assert.Equal(bytes, PortableBinaryCodec.Encode(PortableBinaryCodec.Decode(bytes)));
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes, PortableExecutionProfile.DirectOnly));
    }

    [Fact]
    public void NativeDispatchCopyClearAndRebindUsePrivateSlots()
    {
        byte[] bytes = Bytes();
        PortableX64Compilation native = PortableX64Backend.Compile(bytes);
        Assert.Contains("ud2 ; empty or invalid callable selector", native.Assembly);
        Assert.DoesNotContain("call rax", native.Assembly);
        Assert.Contains("call ubytec_binary_f_0", native.Assembly);
        Assert.Contains("call ubytec_binary_f_1", native.Assembly);
        Assert.Equal(18L, Assert.Single(NativeStack.Run(
            "call ubytec_binary_f_2\npush rax", 1, native.Assembly)));
    }

    [Fact]
    public void NativeBackendRejectsTailReuse()
    {
        Assert.Throws<InvalidDataException>(() => PortableX64Backend.Compile(Bytes(), optimizeTailCalls: true));
    }

    [Fact]
    public void RecursiveActivationKeepsOuterSlot()
    {
        PortableBinaryModule module = Fixture();
        PortableExecutableModule executable = module.Executable!;
        // Recur using a scalar argument; base case binds Second, outer activation binds First.
        // Independent raw verifier sees both call paths, and each activation gets a separate bank.
        var functions = executable.Functions.ToArray();
        uint scalar = functions[0].ReturnTypeIndex;
        functions[2] = functions[2] with
        {
            ArgumentTypeIndices = [scalar],
            Instructions =
            [
                new PortableMemoryInstruction(0x50, PortableMemoryAccessMode.Binding, null, 0),
                new PortableOperandFreeInstruction(0x04), // IF
                new PortableCallableInstruction(0, 0, 0),
                new PortablePushInstruction([0]),
                new PortableCallInstruction(PortableCallTargetKind.LocalFunction, 2),
                new PortableOperandFreeInstruction(0x12), // POP recursive result
                new PortableCallableInstruction(3, 0),
                new PortableReturnInstruction(null),
                new PortableOperandFreeInstruction(0x05), // ELSE
                new PortableCallableInstruction(0, 0, 1),
                new PortableCallableInstruction(3, 0),
                new PortableReturnInstruction(null),
                new PortableOperandFreeInstruction(0x06) // END
            ]
        };
        byte[] bytes = PortableBinaryCodec.Encode(module with { Executable = executable with { Functions = functions } });
        PortableBinaryVerifier.Verify(bytes, PortableExecutionProfile.CallableLocal);
        var native = PortableX64Backend.Compile(bytes);
        Assert.Equal(7L, Assert.Single(NativeStack.Run(
            "push 1\ncall ubytec_binary_f_2\nadd rsp, 8\npush rax", 1, native.Assembly)));
    }

    [Theory]
    [InlineData(99u, 0u)]
    [InlineData(0u, 99u)]
    public void RejectsBadSlotAndTargetInRawBytes(uint slot, uint target)
    {
        byte[] bytes = Bytes();
        int at = FirstBind(bytes);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(at + 3, 4), slot);
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(at + 7, 4), target);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void RejectsNestedTargetOutsideCallerContext()
    {
        byte[] bytes = Bytes();
        var (offset, _) = Find(bytes, 0x0018);
        // Function 1 now belongs to 0. Main (2) is a separate root.
        BinaryPrimitives.WriteUInt32LittleEndian(bytes.AsSpan(offset + 16, 4), 0);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void RejectsWrongCallableArity()
    {
        PortableBinaryModule module = Fixture();
        PortableExecutableModule e = module.Executable!;
        var functions = e.Functions.ToArray();
        // The target has no arguments; the slot requires one.
        var mismatch = new PortableCallableSignature(functions[0].ReturnTypeIndex, [functions[0].ReturnTypeIndex]);
        var slots = new PortableCallableTable([[], [], [mismatch, mismatch]]);
        Assert.Throws<InvalidDataException>(() =>
            PortableBinaryCodec.Encode(module with { Executable = e with { CallableSlots = slots } }));
    }

    [Fact]
    public void RejectsProfileDowngradeMissingSectionAndNoncriticalSection()
    {
        byte[] bytes = Bytes();
        var (context, _) = Find(bytes, 0x0018);
        byte[] downgrade = bytes.ToArray();
        BinaryPrimitives.WriteUInt32LittleEndian(downgrade.AsSpan(context + 4, 4), 1);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(downgrade));
        var (offset, length) = Find(bytes, 0x0019);
        byte[] missing = bytes[..(offset - 12)].Concat(bytes[(offset + length)..]).ToArray();
        uint count = BinaryPrimitives.ReadUInt32LittleEndian(missing.AsSpan(8, 4));
        BinaryPrimitives.WriteUInt32LittleEndian(missing.AsSpan(8, 4), count - 1);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(missing));
        BinaryPrimitives.WriteUInt16LittleEndian(bytes.AsSpan(offset - 10, 2), 0);
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void RejectsUnknownOperationAndEscapeDepth()
    {
        byte[] bytes = Bytes();
        int at = FirstBind(bytes);
        byte[] bad = bytes.ToArray();
        bad[at + 2] = 4;
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bad));
        bytes[at + 1] = 0xFF;
        Assert.Throws<NotSupportedException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    [Fact]
    public void CallableCallStackEffectComesFromSignature()
    {
        PortableBinaryModule module = Fixture();
        PortableExecutableModule e = module.Executable!;
        var functions = e.Functions.ToArray();
        uint scalar = functions[0].ReturnTypeIndex;
        // Empty is allowed at verification time (traps at runtime), but a
        // missing scalar argument is still invalid.
        functions[2] = functions[2] with
        {
            Instructions = [new PortableCallableInstruction(3, 0), new PortableReturnInstruction(null)]
        };
        var slots = new PortableCallableTable([[], [], [new PortableCallableSignature(scalar, [scalar])]]);
        byte[] bytes = PortableBinaryCodec.Encode(module with { Executable = e with { Functions = functions, CallableSlots = slots } });
        Assert.Throws<InvalidDataException>(() => PortableBinaryVerifier.Verify(bytes));
    }

    private static int FirstBind(byte[] bytes)
    {
        var (offset, length) = Find(bytes, 0x0016);
        int relative = bytes.AsSpan(offset, length).IndexOf(new byte[] { 0xFF, 0x13, 0 });
        Assert.True(relative >= 0);
        return offset + relative;
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
