using System.Runtime.InteropServices;
using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class LibftMemoryTests
{
    private static readonly Lazy<SourceCompilation> Compilation = new(() =>
        SourceCompiler.Compile(File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "libft-memory.ubc"))));

    private static long Run(string name, params ulong[] args)
    {
        var compiled = Compilation.Value;
        string body = string.Concat(args.Select(x => $"mov rax, 0x{x:X16}\n push rax\n"));
        body += $"call {compiled.GetFunctionLabel(name)}\n add rsp, {args.Length * 8}\n push rax";
        return Assert.Single(NativeStack.Run(body, 1, compiled.Assembly));
    }

    private static ulong Address(nint pointer) => unchecked((ulong)pointer);

    private sealed class Buffer : IDisposable
    {
        internal nint Pointer { get; }
        internal int Length { get; }
        internal Buffer(byte[] bytes)
        {
            Length = bytes.Length;
            Pointer = Marshal.AllocHGlobal(Length);
            Marshal.Copy(bytes, 0, Pointer, Length);
        }
        internal byte[] Read()
        {
            var bytes = new byte[Length];
            Marshal.Copy(Pointer, bytes, 0, Length);
            return bytes;
        }
        public void Dispose() => Marshal.FreeHGlobal(Pointer);
    }

    private sealed class Reference : IDisposable
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)] internal delegate nuint LengthCall(nint text);
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)] internal delegate int CompareCall(nint left, nint right, nuint count);
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)] internal delegate nint FillCall(nint destination, int value, nuint count);
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)] internal delegate nint CopyCall(nint destination, nint source, nuint count);
        private readonly nint library = NativeLibrary.Load(OperatingSystem.IsWindows() ? "ucrtbase.dll" : "libc.so.6");
        internal T Export<T>(string name) where T : Delegate =>
            Marshal.GetDelegateForFunctionPointer<T>(NativeLibrary.GetExport(library, name));
        public void Dispose() => NativeLibrary.Free(library);
    }

    [Theory]
    [InlineData(0)]
    [InlineData(1)]
    [InlineData(7)]
    [InlineData(8)]
    [InlineData(15)]
    [InlineData(16)]
    [InlineData(31)]
    [InlineData(256)]
    [InlineData(1023)]
    public void StrlenMatchesCAtGuardPage(int length)
    {
        byte[] bytes = Enumerable.Range(0, length).Select(i => (byte)(1 + i % 255)).Append((byte)0).ToArray();
        using var buffer = new GuardedCString(bytes);
        using var reference = new Reference();
        Assert.Equal((long)reference.Export<Reference.LengthCall>("strlen")(buffer.Pointer),
            Run("ft_strlen", Address(buffer.Pointer)));
        Assert.Equal(bytes, Enumerable.Range(0, bytes.Length).Select(i => Marshal.ReadByte(buffer.Pointer, i)).ToArray());
    }

    [Fact]
    public void StrlenStopsAtEmbeddedNul()
    {
        using var buffer = new Buffer([65, 255, 0, 66, 0]);
        Assert.Equal(2, Run("ft_strlen", Address(buffer.Pointer)));
    }

    [Theory]
    [InlineData(0)]
    [InlineData(1)]
    [InlineData(7)]
    [InlineData(8)]
    [InlineData(16)]
    [InlineData(63)]
    [InlineData(256)]
    public void MemcmpMatchesCIncludingEveryMismatchPosition(int count)
    {
        byte[] bytes = Enumerable.Range(0, count).Select(i => (byte)(i * 73)).Append((byte)0).ToArray();
        using var left = new GuardedCString(bytes);
        using var reference = new Reference();
        var compare = reference.Export<Reference.CompareCall>("memcmp");
        // Equal, then differences at each position in both directions, including bytes >= 128.
        foreach (int position in Enumerable.Range(-1, count + 1))
        foreach (int difference in new[] { 1, -1 })
        {
            byte[] other = (byte[])bytes.Clone();
            if (position >= 0) other[position] = unchecked((byte)(other[position] + difference));
            using var right = new GuardedCString(other);
            Assert.Equal(Math.Sign(compare(left.Pointer, right.Pointer, (nuint)count)),
                Math.Sign(Run("ft_memcmp", Address(left.Pointer), Address(right.Pointer), (ulong)count)));
        }
    }

    public static IEnumerable<object[]> FillCases()
    {
        foreach (int count in new[] { 0, 1, 7, 8, 17, 63, 256 })
        foreach (int value in new[] { -257, -1, 0, 127, 128, 255, 256, 511 })
            yield return [count, value];
    }

    [Theory]
    [MemberData(nameof(FillCases))]
    public void MemsetMatchesCAndPreservesNeighbors(int count, int value)
    {
        byte[] initial = Enumerable.Repeat((byte)0xA5, count + 11).ToArray();
        using var actual = new Buffer(initial);
        using var expected = new Buffer(initial);
        using var reference = new Reference();
        nint destination = actual.Pointer + 3;
        Assert.Equal(expected.Pointer + 3, reference.Export<Reference.FillCall>("memset")(expected.Pointer + 3, value, (nuint)count));
        Assert.Equal(unchecked((long)destination), Run("ft_memset", Address(destination), unchecked((ulong)value), (ulong)count));
        Assert.Equal(expected.Read(), actual.Read());
    }

    [Theory]
    [InlineData("ft_memcpy")]
    [InlineData("ft_memmove")]
    public void CopyMatchesCForLengthsAndUnalignedOffsets(string name)
    {
        var random = new Random(420);
        using var reference = new Reference();
        var copy = reference.Export<Reference.CopyCall>(name[3..]);
        foreach (int count in new[] { 0, 1, 2, 7, 8, 15, 16, 17, 31, 63, 256, 1024 })
        foreach (int offset in new[] { 0, 1, 3, 7 })
        {
            var input = new byte[count + 16];
            random.NextBytes(input);
            using var source = new Buffer(input);
            byte[] sentinel = Enumerable.Repeat((byte)0xA5, count + 16).ToArray();
            using var actual = new Buffer(sentinel);
            using var expected = new Buffer(sentinel);
            copy(expected.Pointer + offset, source.Pointer + 1, (nuint)count);
            Assert.Equal(unchecked((long)(actual.Pointer + offset)),
                Run(name, Address(actual.Pointer + offset), Address(source.Pointer + 1), (ulong)count));
            Assert.Equal(expected.Read(), actual.Read());
            Assert.Equal(input, source.Read());
        }
    }

    [Fact]
    public void MemmoveMatchesCForOverlappingRangesInBothDirections()
    {
        using var reference = new Reference();
        var move = reference.Export<Reference.CopyCall>("memmove");
        foreach (int count in new[] { 0, 1, 2, 7, 8, 16, 31, 64 })
        foreach (int shift in new[] { -17, -8, -1, 0, 1, 8, 17 })
        {
            byte[] bytes = Enumerable.Range(0, 128).Select(i => (byte)(i * 73)).ToArray();
            using var actual = new Buffer(bytes);
            using var expected = new Buffer(bytes);
            int source = 32, destination = source + shift;
            move(expected.Pointer + destination, expected.Pointer + source, (nuint)count);
            Assert.Equal(unchecked((long)(actual.Pointer + destination)),
                Run("ft_memmove", Address(actual.Pointer + destination), Address(actual.Pointer + source), (ulong)count));
            Assert.Equal(expected.Read(), actual.Read());
        }
    }

    [Theory]
    [InlineData("ft_memcpy")]
    [InlineData("ft_memmove")]
    public void CopyDoesNotAccessBeyondRequestedBytesAtGuardPage(string name)
    {
        byte[] bytes = Enumerable.Range(0, 256).Select(i => (byte)i).Append((byte)0).ToArray();
        using var source = new GuardedCString(bytes);
        using var destination = new GuardedCString(new byte[bytes.Length]);
        Assert.Equal(unchecked((long)destination.Pointer),
            Run(name, Address(destination.Pointer), Address(source.Pointer), (ulong)bytes.Length));
        Assert.Equal(bytes, Enumerable.Range(0, bytes.Length).Select(i => Marshal.ReadByte(destination.Pointer, i)).ToArray());
    }

    [Fact]
    public void MemsetDoesNotWritePastRequestedBytesAtGuardPage()
    {
        using var destination = new GuardedCString(new byte[257]);
        Assert.Equal(unchecked((long)destination.Pointer),
            Run("ft_memset", Address(destination.Pointer), 255, 257));
        Assert.All(Enumerable.Range(0, 257), i => Assert.Equal((byte)255, Marshal.ReadByte(destination.Pointer, i)));
    }

    [Fact]
    public void MemcmpCanCompareThroughLastAccessibleByte()
    {
        using var left = new GuardedCString([255, 128, 1, 0]);
        using var right = new GuardedCString([255, 128, 1, 0]);
        Assert.Equal(0, Run("ft_memcmp", Address(left.Pointer), Address(right.Pointer), 4));
    }

    [Fact]
    public void ZeroCountOperationsDoNotDereferenceRawAddresses()
    {
        // Ubytec-only contract: do not ask C to dereference or validate null pointers.
        Assert.Equal(0, Run("ft_memcmp", 0, 0, 0));
        Assert.Equal(0, Run("ft_memset", 0, 255, 0));
        Assert.Equal(0, Run("ft_memcpy", 0, 0, 0));
        Assert.Equal(0, Run("ft_memmove", 0, 0, 0));
    }

    [Fact]
    public void CorpusExportsAllFiveFunctions()
    {
        Assert.Equal(5, Compilation.Value.Module.Functions.Length);
        foreach (string name in new[] { "ft_strlen", "ft_memcmp", "ft_memset", "ft_memcpy", "ft_memmove" })
            Assert.NotEmpty(Compilation.Value.GetFunctionLabel(name));
    }

    [Fact]
    public void HighLevelCallCanReturnToRawMemoryAccess()
    {
        string source = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "libft-memory.ubc"));
        int close = source.LastIndexOf('}');
        source = source.Insert(close, """
            func ft_patch(t_uint64 destination) -> t_uint64
            {
                load @destination
                push 65
                push 3
                call ft_memset
                push 1
                add
                push 255
                store t_byte
                load @destination
                return
            }
            """);
        var compiled = SourceCompiler.Compile(source);
        using var buffer = new Buffer([0, 0, 0, 99]);
        string body = $"mov rax, 0x{Address(buffer.Pointer):X16}\n push rax\n call {compiled.GetFunctionLabel("ft_patch")}\n add rsp, 8\n push rax";
        Assert.Equal(unchecked((long)buffer.Pointer), Assert.Single(NativeStack.Run(body, 1, compiled.Assembly)));
        Assert.Equal(new byte[] { 65, 255, 65, 99 }, buffer.Read());
    }
}
