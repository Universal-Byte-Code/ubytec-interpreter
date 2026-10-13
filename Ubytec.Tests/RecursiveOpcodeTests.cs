using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Xunit;

namespace Ubytec.Tests;

public class RecursiveOpcodeTests
{
    private static IOpCode Ext(int escapeDepth, byte group, byte code, params ValueType[] operands)
    {
        var encodedTail = Enumerable.Repeat<ValueType>((byte)0xFF, escapeDepth - 1)
            .Concat(new ValueType[] { group, code })
            .Concat(operands)
            .ToArray();
        return OpcodeFactory.Create((byte)0xFF, [], [], encodedTail);
    }

    [Fact]
    public void ExistingDepthOneEncodingRemainsCompatible()
    {
        var op = Assert.IsType<ExtendedStackOperations.PUSH16>(Ext(1, 0x10, 0x11, (ushort)2));
        Assert.Equal(1, op.EscapeDepth);
        Assert.Equal(new byte[] { 0xFF, 0x10, 0x11 }, op.OpcodeId.Encode());
    }

    [Fact]
    public void EscapeDepthIsPartOfOpcodeIdentity()
    {
        const byte group = 0x7E;
        const byte code = 0x01;

        ExtendedOpcodeFactory.Register(2, group, code, (_, _, _) => new CoreOperations.NOP());
        ExtendedOpcodeFactory.Register(3, group, code, (_, _, _) => new CoreOperations.TRAP());

        Assert.IsType<CoreOperations.NOP>(Ext(2, group, code));
        Assert.IsType<CoreOperations.TRAP>(Ext(3, group, code));
        Assert.Throws<NotSupportedException>(() => Ext(1, group, code));
    }

    [Theory]
    [InlineData(1, new byte[] { 0xFF, 0x20, 0x01 })]
    [InlineData(2, new byte[] { 0xFF, 0xFF, 0x20, 0x01 })]
    [InlineData(3, new byte[] { 0xFF, 0xFF, 0xFF, 0x20, 0x01 })]
    public void OpcodeIdProducesCanonicalWirePrefix(int escapeDepth, byte[] expected)
    {
        var id = new OpcodeId(escapeDepth, 0x20, 0x01);
        Assert.Equal(expected, id.Encode());
    }

    [Fact]
    public void IncompleteEscapePrefixesAreRejected()
    {
        Assert.Throws<NotSupportedException>(() => OpcodeFactory.Create((byte)0xFF, [], []));
        Assert.Throws<NotSupportedException>(() => OpcodeFactory.Create((byte)0xFF, [], [], (byte)0x10));
        Assert.Throws<NotSupportedException>(() => OpcodeFactory.Create((byte)0xFF, [], [], (byte)0xFF));
        Assert.Throws<NotSupportedException>(() => OpcodeFactory.Create((byte)0xFF, [], [], (byte)0xFF, (byte)0x10));
    }

    [Fact]
    public void EscapeByteCannotBeAllocatedAsGroupOrOpcode()
    {
        Assert.Throws<ArgumentOutOfRangeException>(() => new OpcodeId(1, 0xFF, 0x01));
        Assert.Throws<ArgumentOutOfRangeException>(() => new OpcodeId(1, 0x10, 0xFF));
        Assert.Throws<ArgumentOutOfRangeException>(() => new OpcodeId(0, 0x10, 0x01));
        Assert.Throws<NotSupportedException>(() =>
            OpcodeFactory.Create((byte)0xFF, [], [], (byte)0x10, (byte)0xFF));
    }

    [Fact]
    public void RuntimeRejectsEscapeDepthBeyondDefensiveLimit()
    {
        ValueType[] excessivePrefix = Enumerable
            .Repeat<ValueType>((byte)0xFF, ExtendedOpcodeFactory.MAX_SUPPORTED_ESCAPE_DEPTH)
            .ToArray();

        Assert.Throws<NotSupportedException>(() =>
            OpcodeFactory.Create((byte)0xFF, [], [], excessivePrefix));
    }
}
