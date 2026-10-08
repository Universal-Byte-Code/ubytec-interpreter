using System.Runtime.InteropServices;
using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class LibftStringTests
{
    private static readonly Lazy<SourceCompilation> Compilation = new(() =>
    {
        string Body(string name) { string text = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, name)); return text[(text.IndexOf('{') + 1)..text.LastIndexOf('}')]; }
        return SourceCompiler.Compile("module (name:\"libft_strings_test\",version:\"0.1\",author:\"Ubytec\") {\n" + Body("libft-strings.ubc") + Body("libft-arena.ubc") + Body("libft-arena-strings.ubc") + "\n}");
    });
    private static ulong A(nint p) => unchecked((ulong)p);
    private static long Run(string name, params ulong[] args)
    {
        var compiled = Compilation.Value;
        string body = string.Concat(args.Select(x => $"mov rax, 0x{x:X16}\n push rax\n"));
        body += $"call {compiled.GetFunctionLabel(name)}\n add rsp, {args.Length * 8}\n push rax";
        return Assert.Single(NativeStack.Run(body, 1, compiled.Assembly));
    }
    private sealed class Buffer : IDisposable
    {
        internal nint Pointer { get; }
        private readonly int length;
        internal Buffer(byte[] bytes) { length = bytes.Length; Pointer = Marshal.AllocHGlobal(length); Marshal.Copy(bytes, 0, Pointer, length); }
        internal byte[] Read() { var bytes = new byte[length]; Marshal.Copy(Pointer, bytes, 0, length); return bytes; }
        public void Dispose() => Marshal.FreeHGlobal(Pointer);
    }
    private sealed class Reference : IDisposable
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)] internal delegate nint Search(nint text, int value);
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)] internal delegate nint MemorySearch(nint text, int value, nuint count);
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)] internal delegate int Compare(nint a, nint b, nuint n);
        private readonly nint library = NativeLibrary.Load(OperatingSystem.IsWindows() ? "ucrtbase.dll" : "libc.so.6");
        internal T Export<T>(string name) where T : Delegate => Marshal.GetDelegateForFunctionPointer<T>(NativeLibrary.GetExport(library, name));
        public void Dispose() => NativeLibrary.Free(library);
    }
    [Theory]
    [InlineData("ft_strchr")]
    [InlineData("ft_strrchr")]
    public void CharacterSearchMatchesCAndStopsAtGuard(string name)
    {
        // UCRT strrchr expects the argument already narrowed to signed char.
        // Both hosts are compared using the corpus low-eight-bit contract.
        using var reference = new Reference(); var search = reference.Export<Reference.Search>(name[3..]);
        foreach (byte[] bytes in new byte[][] { [0], [65, 66, 65, 0], [255, 128, 1, 255, 0], [65, 0, 66, 0] })
        {
            using var text = new GuardedCString(bytes);
            foreach (int c in new[] { 0, 1, 65, 66, 127, 128, 255, 256, 321, -1, -128, -257 })
                Assert.Equal((long)search(text.Pointer, unchecked((sbyte)c)), Run(name, A(text.Pointer), unchecked((ulong)c)));
            Assert.Equal(bytes, Enumerable.Range(0, bytes.Length).Select(i => Marshal.ReadByte(text.Pointer, i)).ToArray());
        }
    }
    [Fact]
    public void MemorySearchAndBoundedLengthNeverReadPastCount()
    {
        using var reference = new Reference(); var search = reference.Export<Reference.MemorySearch>("memchr");
        foreach (int n in new[] { 0, 1, 7, 31, 256 })
        {
            byte[] bytes = Enumerable.Range(0, n).Select(i => (byte)(1 + i % 255)).ToArray();
            using var text = new GuardedCString(bytes, requireTerminator: false);
            Assert.Equal(n, Run("ft_strnlen", A(text.Pointer), (ulong)n));
            foreach (int c in new[] { 0, 1, 31, 128, 255, 257, -1 })
                Assert.Equal((long)search(text.Pointer, unchecked((byte)c), (nuint)n), Run("ft_memchr", A(text.Pointer), unchecked((ulong)c), (ulong)n));
        }
        Assert.Equal(0, Run("ft_memchr", 0, 65, 0)); Assert.Equal(0, Run("ft_strnlen", 0, 0));
        using var nul = new GuardedCString([65, 0]);
        Assert.Equal(1, Run("ft_strnlen", A(nul.Pointer), ulong.MaxValue));
        Assert.Equal((long)nul.Pointer, Run("ft_memchr", A(nul.Pointer), 65, ulong.MaxValue));
    }
    [Fact]
    public void StrncmpMatchesCWithUnsignedBytesAndFullWidthLimits()
    {
        using var reference = new Reference(); var compare = reference.Export<Reference.Compare>("strncmp");
        byte[][] texts = [[0], [65, 0], [65, 66, 0], [65, 255, 0], [65, 128, 0], [65, 0, 255, 0]];
        foreach (byte[] a in texts) foreach (byte[] b in texts)
        {
            using var left = new GuardedCString(a); using var right = new GuardedCString(b);
            foreach (ulong n in new[] { 0UL, 1UL, 2UL, 3UL, 16UL, 1UL << 63, ulong.MaxValue })
                Assert.Equal(Math.Sign(compare(left.Pointer, right.Pointer, (nuint)n)), Math.Sign(Run("ft_strncmp", A(left.Pointer), A(right.Pointer), n)));
        }
        Assert.Equal(0, Run("ft_strncmp", 0, 0, 0));
        using var prefix = new GuardedCString([65, 255], requireTerminator: false);
        Assert.Equal(0, Run("ft_strncmp", A(prefix.Pointer), A(prefix.Pointer), 2));
    }
    [Fact]
    public void LimitedCopyPreservesNeighborsAndWritesAtGuard()
    {
        foreach (byte[] source in new byte[][] { [0], [65, 0], [65, 255, 128, 66, 0], [65, 0, 66, 0] })
        foreach (int cap in new[] { 0, 1, 2, 4, 8, 16 })
        {
            using var input = new GuardedCString(source);
            byte[] initial = Enumerable.Repeat((byte)0xA5, cap + 8).ToArray(); using var output = new Buffer(initial);
            int length = Array.IndexOf(source, (byte)0); byte[] expected = (byte[])initial.Clone();
            if (cap > 0) { int n = Math.Min(length, cap - 1); Array.Copy(source, 0, expected, 3, n); expected[3 + n] = 0; }
            Assert.Equal(length, Run("ft_strlcpy", A(output.Pointer + 3), A(input.Pointer), (ulong)cap)); Assert.Equal(expected, output.Read());
            if (cap > 0) { using var guarded = new GuardedCString(new byte[cap], requireTerminator: false); Assert.Equal(length, Run("ft_strlcpy", A(guarded.Pointer), A(input.Pointer), (ulong)cap)); }
        }
        using var empty = new GuardedCString([0]); Assert.Equal(0, Run("ft_strlcpy", 0, A(empty.Pointer), 0));
    }
    [Fact]
    public void LimitedConcatenationHandlesUnterminatedDestinationAndGuards()
    {
        foreach (int cap in new[] { 0, 1, 2, 4, 8 }) foreach (int used in new[] { 0, 1, 3, 8 })
        {
            byte[] prefix = Enumerable.Repeat((byte)65, cap).ToArray(); if (used < cap) prefix[used] = 0;
            using var source = new GuardedCString([66, 255, 67, 0]);
            using var destination = new GuardedCString(prefix, requireTerminator: false);
            int bounded = Math.Min(used, cap), n = bounded == cap ? 0 : Math.Min(3, cap - bounded - 1);
            byte[] expected = (byte[])prefix.Clone(); if (bounded < cap) { Array.Copy(new byte[] { 66, 255, 67 }, 0, expected, bounded, n); expected[bounded + n] = 0; }
            Assert.Equal(bounded + 3, Run("ft_strlcat", A(destination.Pointer), A(source.Pointer), (ulong)cap));
            Assert.Equal(expected, Enumerable.Range(0, cap).Select(i => Marshal.ReadByte(destination.Pointer, i)).ToArray());
        }
    }
    [Fact]
    public void BoundedSubstringSearchHandlesPrefixesNulAndHighLimits()
    {
        byte[][] haystacks = [[0], [65, 66, 65, 66, 67, 0], [255, 128, 255, 0], [65, 0, 66, 0]];
        byte[][] needles = [[0], [65, 0], [65, 66, 67, 0], [66, 67, 0], [255, 0], [128, 255, 0], [65, 66, 65, 66, 67, 68, 0]];
        foreach (byte[] h in haystacks) foreach (byte[] n in needles) foreach (ulong count in new[] { 0UL, 1UL, 2UL, 4UL, 6UL, 1UL << 63, ulong.MaxValue })
        {
            using var hay = new GuardedCString(h); using var needle = new GuardedCString(n);
            int hn = Array.IndexOf(h, (byte)0), nn = Array.IndexOf(n, (byte)0), found = nn == 0 ? 0 : -1;
            for (int i = 0; nn > 0 && i + nn <= hn && (ulong)(i + nn) <= count; i++) if (h.AsSpan(i, nn).SequenceEqual(n.AsSpan(0, nn))) { found = i; break; }
            Assert.Equal(found < 0 ? 0 : (long)hay.Pointer + found, Run("ft_strnstr", A(hay.Pointer), A(needle.Pointer), count));
        }
        using var prefix = new GuardedCString([65, 66, 67], requireTerminator: false); using var two = new GuardedCString([66, 67, 0]);
        Assert.Equal((long)prefix.Pointer + 1, Run("ft_strnstr", A(prefix.Pointer), A(two.Pointer), 3));
    }
    [Fact]
    public void AllocatedStringsComposeRecoverAfterOomAndPreserveInputs()
    {
        using var storage = new Buffer(Enumerable.Repeat((byte)0xA5, 16 + 1024 + 16).ToArray()); ulong arena = A(storage.Pointer);
        Assert.Equal(1, Run("ArenaInit", arena, 1024));
        byte[] a = [65, 255, 66, 0], b = [128, 67, 0]; using var left = new GuardedCString(a); using var right = new GuardedCString(b);
        var cases = new (string Name, ulong[] Args, byte[] Expected)[]
        {
            ("ft_strdup_arena", [arena,A(left.Pointer)], a),
            ("ft_substr_arena", [arena,A(left.Pointer),1,ulong.MaxValue], [255,66,0]),
            ("ft_substr_arena", [arena,A(left.Pointer),ulong.MaxValue,16], [0]),
            ("ft_substr_arena", [arena,A(left.Pointer),0,0], [0]),
            ("ft_strjoin_arena", [arena,A(left.Pointer),A(right.Pointer)], [65,255,66,128,67,0])
        };
        foreach (var item in cases)
        {
            nint result = (nint)Run(item.Name, item.Args); Assert.NotEqual(0, result);
            Assert.Equal(item.Expected, Enumerable.Range(0, item.Expected.Length).Select(i => Marshal.ReadByte(result, i)).ToArray()); Assert.Equal(1, Run("ArenaFree", arena, A(result))); Assert.Equal(0, Marshal.ReadInt64(storage.Pointer, 8));
        }
        // Exhaust with a pinned live allocation, then recover on the same arena.
        ulong pin = unchecked((ulong)Run("ArenaAlloc", arena, 960)); Assert.NotEqual(0UL, pin); Assert.Equal(1, Run("ArenaPin", arena, pin));
        byte[] before = storage.Read(); Assert.Equal(0, Run("ft_strdup_arena", arena, A(left.Pointer))); Assert.Equal(before, storage.Read()); Assert.Equal(1, Run("ArenaUnpin", arena, pin)); Assert.Equal(1, Run("ArenaFree", arena, pin));
        nint recovered = (nint)Run("ft_strjoin_arena", arena, A(left.Pointer), A(right.Pointer)); Assert.NotEqual(0, recovered); Assert.Equal(1, Run("ArenaFree", arena, A(recovered)));
        Assert.Equal(a, Enumerable.Range(0, a.Length).Select(i => Marshal.ReadByte(left.Pointer, i)).ToArray()); Assert.Equal(b, Enumerable.Range(0, b.Length).Select(i => Marshal.ReadByte(right.Pointer, i)).ToArray());
        Assert.All(storage.Read()[1040..], x => Assert.Equal(0xA5, x));
    }
    [Fact]
    public void ExactArenaCapacityAndLargeLengthFailuresPreserveMemory()
    {
        using var storage = new Buffer(Enumerable.Repeat((byte)0xA5, 16 + 65536 + 16).ToArray()); ulong arena = A(storage.Pointer);
        Assert.Equal(1, Run("ArenaInit", arena, 65536));
        byte[] exact = Enumerable.Repeat((byte)65, 65503).Append((byte)0).ToArray(); using var source = new Buffer(exact);
        nint result = (nint)Run("ft_strdup_arena", arena, A(source.Pointer)); Assert.NotEqual(0, result);
        Assert.Equal(exact, Enumerable.Range(0, exact.Length).Select(i => Marshal.ReadByte(result, i)).ToArray()); Assert.Equal(65536, Marshal.ReadInt64(storage.Pointer, 8));
        Assert.Equal(1, Run("ArenaFree", arena, A(result)));
        ulong owner = unchecked((ulong)Run("ArenaAlloc", arena, 8)); Assert.Equal(1, Run("ArenaPin", arena, owner));
        byte[] tooLarge = Enumerable.Repeat((byte)66, 65536).Append((byte)0).ToArray(); using var large = new Buffer(tooLarge);
        using var empty = new GuardedCString([0]); byte[] snapshot = storage.Read();
        Assert.Equal(0, Run("ft_strdup_arena", arena, A(large.Pointer)));
        Assert.Equal(0, Run("ft_substr_arena", arena, A(large.Pointer), 0, ulong.MaxValue));
        Assert.Equal(0, Run("ft_strjoin_arena", arena, A(large.Pointer), A(empty.Pointer)));
        Assert.Equal(snapshot, storage.Read());
        Assert.Equal(1, Run("ArenaUnpin", arena, owner)); Assert.Equal(1, Run("ArenaFree", arena, owner)); Assert.Equal(0, Marshal.ReadInt64(storage.Pointer, 8));
        Assert.All(storage.Read()[65552..], x => Assert.Equal(0xA5, x));
    }

}
