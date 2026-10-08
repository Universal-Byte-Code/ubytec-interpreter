using System.Numerics;
using System.Runtime.InteropServices;
using Ubytec.Language;
using Ubytec.Language.AST;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Extended;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Xunit;

namespace Ubytec.Tests;

public class OpcodeTests
{
    private static IOpCode Op(byte code, params ValueType[] operands) => OpcodeFactory.Create(code, [], [], operands);
    private static IOpCode Ext(byte code, params ValueType[] operands) =>
        OpcodeFactory.Create((byte)0xFF, [], [], new ValueType[] { (byte)0x10, code }.Concat(operands).ToArray());
    private static string Emit(params IOpCode[] ops) => string.Join("\n", ops.Select(x => x.Compile(new CompilationScopes())));
    private static IOpCode Push(long value) => Op(0x11, value);
    private static long[] Execute(long[] input, IOpCode op, int cells) =>
        NativeStack.Run(Emit(input.Select(Push).Append(op).ToArray()), cells);

    public static IEnumerable<object[]> ArithmeticCases()
    {
        yield return new object[] { (byte)0x20, new long[] { 10, 3 }, 13L };
        yield return new object[] { (byte)0x20, new long[] { long.MaxValue, 1 }, long.MinValue };
        yield return new object[] { (byte)0x21, new long[] { 10, 3 }, 7L };
        yield return new object[] { (byte)0x21, new long[] { 3, 10 }, -7L };
        yield return new object[] { (byte)0x22, new long[] { -10, 3 }, -30L };
        yield return new object[] { (byte)0x22, new long[] { long.MinValue, 2 }, 0L };
        yield return new object[] { (byte)0x23, new long[] { -10, 3 }, -3L };
        yield return new object[] { (byte)0x23, new long[] { 10, -3 }, -3L };
        yield return new object[] { (byte)0x23, new long[] { long.MinValue, 1 }, long.MinValue };
        yield return new object[] { (byte)0x24, new long[] { -10, 3 }, -1L };
        yield return new object[] { (byte)0x24, new long[] { 10, -3 }, 1L };
        yield return new object[] { (byte)0x25, new long[] { long.MaxValue }, long.MinValue };
        yield return new object[] { (byte)0x26, new long[] { long.MinValue }, long.MaxValue };
        yield return new object[] { (byte)0x27, new long[] { -3 }, 3L };
        yield return new object[] { (byte)0x27, new long[] { long.MinValue }, long.MinValue };
        yield return new object[] { (byte)0x28, new long[] { -3 }, 3L };
        yield return new object[] { (byte)0x28, new long[] { 3 }, 3L };
        yield return new object[] { (byte)0x28, new long[] { 0 }, 0L };
        yield return new object[] { (byte)0x28, new long[] { long.MinValue }, long.MinValue };
    }

    [Theory, MemberData(nameof(ArithmeticCases))]
    public void ArithmeticExecutes(byte code, long[] input, long expected) =>
        Assert.Equal(new[] { expected }, Execute(input, Op(code), 1));

    [Theory]
    [InlineData(0x30, 12L, 10L, 8L)]
    [InlineData(0x31, 12L, 10L, 14L)]
    [InlineData(0x32, 12L, 10L, 6L)]
    [InlineData(0x34, 3L, 2L, 12L)]
    [InlineData(0x34, 3L, 64L, 3L)]
    [InlineData(0x34, 1L, -1L, long.MinValue)]
    [InlineData(0x35, -8L, 2L, -2L)]
    [InlineData(0x35, 8L, 2L, 2L)]
    [InlineData(0x35, -8L, 64L, -8L)]
    public void BitsExecute(int code, long left, long right, long expected) =>
        Assert.Equal(new[] { expected }, Execute([left, right], Op((byte)code), 1));

    [Fact]
    public void NotExecutes() => Assert.Equal(new[] { ~12L }, Execute([12], Op(0x33), 1));

    [Theory]
    [InlineData(-1L, 1L)]
    [InlineData(1L, -1L)]
    [InlineData(1L, 1L)]
    [InlineData(long.MinValue, long.MaxValue)]
    public void ComparisonsProduceCanonicalBooleans(long left, long right)
    {
        bool[] expected = [left == right, left != right, left < right, left <= right, left > right, left >= right];
        for (int i = 0; i < expected.Length; i++)
            Assert.Equal(new[] { expected[i] ? 1L : 0L }, Execute([left, right], Op((byte)(0x40 + i)), 1));
    }

    public static IEnumerable<object[]> StackCases()
    {
        yield return new object[] { (byte)0x12, new long[] { 1, 2 }, new long[] { 1 } };
        yield return new object[] { (byte)0x13, new long[] { 1, 2 }, new long[] { 1, 2, 2 } };
        yield return new object[] { (byte)0x14, new long[] { 1, 2 }, new long[] { 2, 1 } };
        yield return new object[] { (byte)0x15, new long[] { 1, 2, 3 }, new long[] { 2, 3, 1 } };
        yield return new object[] { (byte)0x16, new long[] { 1, 2 }, new long[] { 1, 2, 1 } };
        yield return new object[] { (byte)0x17, new long[] { 1, 2 }, new long[] { 2 } };
        yield return new object[] { (byte)0x19, new long[] { 1, 2 }, new long[] { 1, 2, 1, 2 } };
        yield return new object[] { (byte)0x1A, new long[] { 1, 2, 3, 4 }, new long[] { 3, 4, 1, 2 } };
        yield return new object[] { (byte)0x1B, new long[] { 1, 2, 3, 4, 5, 6 }, new long[] { 3, 4, 5, 6, 1, 2 } };
        yield return new object[] { (byte)0x1C, new long[] { 1, 2, 3, 4 }, new long[] { 1, 2, 3, 4, 1, 2 } };
    }

    [Theory, MemberData(nameof(StackCases))]
    public void StackPermutationsExecute(byte code, long[] input, long[] expected)
    {
        // A sentinel below the working values must also survive.
        Assert.Equal(new long[] { 99 }.Concat(expected), Execute(new long[] { 99 }.Concat(input).ToArray(), Op(code), expected.Length + 1));
    }

    [Theory]
    [InlineData(0)]
    [InlineData(1)]
    [InlineData(2)]
    [InlineData(255)]
    [InlineData(300)]
    public void IndexedOperationsExecute(int index)
    {
        long[] input = Enumerable.Range(0, index + 3).Select(x => (long)x).ToArray();
        int selected = input.Length - 1 - index;
        foreach (byte code in new byte[] { 0x18, 0x1D, 0x1E })
        {
            long[] expected = code switch
            {
                0x18 => input.Where((_, i) => i != selected).ToArray(),
                0x1D => input.Append(input[selected]).ToArray(),
                _ => input.Where((_, i) => i != selected).Append(input[selected]).ToArray()
            };
            Assert.Equal(expected, Execute(input, Ext(code, (ushort)index), expected.Length));
            if (index <= 255)
                Assert.Equal(expected, Execute(input, Op(code, index), expected.Length));
        }
    }

    [Fact]
    public void RepeatedIndexedOperationsHaveDistinctAssemblyLabels()
    {
        Assert.Equal(new long[] { 2, 1 }, NativeStack.Run(Emit(Push(1), Push(2), Push(3), Op(0x1E, 2), Op(0x18, 1)), 2));
    }

    [Fact]
    public void PushPreservesFullWidthAndWireByteOrder()
    {
        foreach (long value in new[] { 0L, -1L, long.MinValue, long.MaxValue, 0x0000000080000000L })
            Assert.Equal(new[] { value }, NativeStack.Run(Emit(Push(value)), 1));
        Assert.Equal(new[] { -1L }, NativeStack.Run(Emit(Op(0x11, ulong.MaxValue)), 1));
        Assert.Equal(new[] { 0x1234L }, NativeStack.Run(Emit(Op(0x11, (byte)0x34, (byte)0x12)), 1));
        Assert.Equal(new[] { 255L }, NativeStack.Run(new StackOperations.PUSH([255]).Compile(new CompilationScopes()), 1));
    }

    [Fact]
    public void Push16ReadsWordAtByteOffsetAndZeroExtends()
    {
        Assert.Equal(new long[] { 0xFEDCBA987654321, 0x8765 },
            NativeStack.Run(Emit(Push(0xFEDCBA987654321), Ext(0x11, (ushort)2)), 2));
    }

    [Fact]
    public void MemoryRoundTripUsesAddressThenValueAndConsumesStoreOperands()
    {
        nint address = Marshal.AllocHGlobal(8);
        try
        {
            long value = long.MinValue + 123;
            string body = Emit(Push(99), Push((long)address), Push(value), Op(0x51), Push((long)address), Op(0x50));
            Assert.Equal(new[] { 99L, value }, NativeStack.Run(body, 2));
            Assert.Equal(value, Marshal.ReadInt64(address));
        }
        finally { Marshal.FreeHGlobal(address); }
    }

    [Fact]
    public void ExtendedWireEncodingAndMaximumIndexAreAccepted()
    {
        foreach (byte code in new byte[] { 0x11, 0x18, 0x1D, 0x1E })
        {
            string reference = Emit(Ext(code, (ushort)0x1234));
            Assert.Equal(reference, Normalize(Emit(Ext(code, (byte)0x34, (byte)0x12)), reference));
            Assert.False(string.IsNullOrWhiteSpace(Emit(Ext(code, ushort.MaxValue))));
        }
    }

    // DROP/ROLL use unique global labels. Compare instructions independently of label IDs.
    private static string Normalize(string value, string reference)
    {
        var pattern = "stack_shift_[0-9a-f]{32}";
        var match = System.Text.RegularExpressions.Regex.Match(reference, pattern);
        return match.Success ? System.Text.RegularExpressions.Regex.Replace(value, pattern, match.Value) : value;
    }

    [Theory]
    [InlineData(0x18)]
    [InlineData(0x1D)]
    [InlineData(0x1E)]
    public void InvalidIndicesAreRejected(int code)
    {
        foreach (ValueType value in new ValueType[] { -1, 256, 1.5, true })
            Assert.Throws<SyntaxException>(() => Op((byte)code, value));
        foreach (ValueType value in new ValueType[] { -1, 65536, 1.5, true })
            Assert.Throws<SyntaxException>(() => Ext((byte)code, value));
        Assert.Throws<SyntaxException>(() => Op((byte)code));
        Assert.Throws<SyntaxException>(() => Ext((byte)code, (byte)1, (byte)2, (byte)3));
    }

    [Fact]
    public void InvalidPushOperandsAreRejected()
    {
        Assert.Throws<SyntaxException>(() => Op(0x11));
        Assert.Throws<SyntaxException>(() => Op(0x11, 1.5));
        Assert.Throws<SyntaxException>(() => Op(0x11, BigInteger.One << 64));
        Assert.Throws<SyntaxException>(() => Op(0x11, 1, 2));
        Assert.Throws<SyntaxException>(() => new StackOperations.PUSH([]).Compile(new CompilationScopes()));
        Assert.Throws<SyntaxException>(() => new StackOperations.PUSH(new byte[9]).Compile(new CompilationScopes()));
    }

    [Theory]
    [InlineData(0x12)] [InlineData(0x13)] [InlineData(0x14)] [InlineData(0x15)]
    [InlineData(0x16)] [InlineData(0x17)] [InlineData(0x19)] [InlineData(0x1A)]
    [InlineData(0x1B)] [InlineData(0x1C)]
    [InlineData(0x20)] [InlineData(0x21)] [InlineData(0x22)] [InlineData(0x23)]
    [InlineData(0x24)] [InlineData(0x25)] [InlineData(0x26)] [InlineData(0x27)] [InlineData(0x28)]
    [InlineData(0x30)] [InlineData(0x31)] [InlineData(0x32)] [InlineData(0x33)] [InlineData(0x34)] [InlineData(0x35)]
    [InlineData(0x40)] [InlineData(0x41)] [InlineData(0x42)] [InlineData(0x43)] [InlineData(0x44)] [InlineData(0x45)]
    [InlineData(0x50)] [InlineData(0x51)]
    public void OperandlessInstructionsRejectExtraOperands(int code) =>
        Assert.Throws<SyntaxException>(() => Op((byte)code, 1));

    private static SyntaxToken Token(string source, int line, string scope) =>
        new(source, line, 0, source.Length, ["source.ubytec", scope]);

    [Fact]
    public void ParserAcceptsEveryDataInstructionAndMixedCaseNames()
    {
        Type[] groups = [typeof(StackOperations), typeof(ArithmeticOperations), typeof(BitwiseOperations),
            typeof(ComparisonOperations), typeof(MemoryOperations), typeof(ExtendedStackOperations)];
        foreach (Type instruction in groups.SelectMany(x => x.GetNestedTypes()))
        {
            var tokens = new List<SyntaxToken> { Token(instruction.Name.ToLowerInvariant(), 1, "keyword.stack.ubytec") };
            if (instruction.Name is "PUSH" or "DROP" or "PICK" or "ROLL" or "PUSH16" or "DROP16" or "PICK16" or "ROLL16")
                tokens.Add(Token("2", 1, "constant.numeric.int.ubytec"));
            IOpCode parsed = Assert.Single(ASTCompiler.Parse(tokens.ToArray()));
            Assert.Equal(instruction, parsed.GetType());
            var (tree, errors) = ASTCompiler.CompileSyntax([Op(0x02, Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Void), parsed, Op(0x06)], tokens.ToArray());
            Assert.Empty(errors);
            Assert.False(string.IsNullOrWhiteSpace(ASTCompiler.CompileAST(tree)));
        }
    }

    [Fact]
    public void ParserToNativeAssemblyPreservesInstructionOrder()
    {
        SyntaxToken[] tokens =
        [
            Token("push", 1, "keyword.stack.ubytec"), Token("20", 1, "constant.numeric.int.ubytec"),
            Token("push", 2, "keyword.stack.ubytec"), Token("3", 2, "constant.numeric.int.ubytec"),
            Token("sub", 3, "keyword.operator.arithmetic.ubytec")
        ];
        var (tree, errors) = ASTCompiler.CompileSyntax(new[] { Op(0x02, Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Void) }.Concat(ASTCompiler.Parse(tokens)).Append(Op(0x06)).ToArray(), tokens);
        Assert.Empty(errors);
        Assert.Equal(new[] { 17L }, NativeStack.Run(ASTCompiler.CompileAST(tree), 1));
    }
}
