using System.Runtime.InteropServices;
using System.Text;
using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class LibftCorpusTests
{
    private static readonly Lazy<SourceCompilation> Compilation = new(() =>
        SourceCompiler.Compile(File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "libft-scalar.ubc"))));

    [Theory]
    [InlineData("ft_isalpha")]
    [InlineData("ft_isdigit")]
    [InlineData("ft_isalnum")]
    [InlineData("ft_isascii")]
    [InlineData("ft_isprint")]
    [InlineData("ft_toupper")]
    [InlineData("ft_tolower")]
    public void AllCharacterValuesAndEofMatchC(string function)
    {
        var compiled = Compilation.Value;
        string label = compiled.GetFunctionLabel(function);
        var body = new StringBuilder();
        for (int input = -1; input <= 255; input++)
            body.AppendLine($"push {input}\n  call {label}\n  add rsp, 8\n  push rax");
        var results = NativeStack.Run(body.ToString(), 257, compiled.Assembly);
        using var reference = new CReference();
        for (int input = -1; input <= 255; input++)
            Assert.True(reference.EvaluateCharacter(function, input) == results[input + 1],
                $"{function}({input}): C={reference.EvaluateCharacter(function, input)}, Ubytec={results[input + 1]}");
    }

    public static IEnumerable<object[]> DecimalInputs()
    {
        foreach (string input in new[]
        {
            "", "0", "-0", "+0", "42", "-42", "+42", "00042",
            "2147483647", "-2147483648", "2147483646", "-2147483647",
            "  42", "\t\n\v\f\r  -42suffix", "   ", "+", "-", "++42",
            "--42", "+-42", "-+42", "+ 42", "- 42", "42 99", "123abc",
            "abc123", "0x10", "01", "00000000000000000000000000000000000042",
            "\u008042", "42\u00ff", "\0ignored", "42\0ignored", "\t-2147483648junk"
        }) yield return [input];
        var random = new Random(42);
        for (int i = 0; i < 128; i++)
        {
            int value = (int)random.NextInt64(int.MinValue, (long)int.MaxValue + 1);
            string signAndDigits = value.ToString(System.Globalization.CultureInfo.InvariantCulture);
            if (value >= 0 && i % 2 == 0) signAndDigits = "+" + signAndDigits;
            yield return [(i % 3 == 0 ? "\t " : "") + signAndDigits + (i % 5 == 0 ? "trailing" : "")];
        }
    }

    [Theory]
    [MemberData(nameof(DecimalInputs))]
    public void AtoiMatchesCOnDefinedIntDomain(string input)
    {
        byte[] bytes = Encoding.Latin1.GetBytes(input + "\0");
        nint buffer = Marshal.AllocHGlobal(bytes.Length);
        try
        {
            Marshal.Copy(bytes, 0, buffer, bytes.Length);
            var compiled = Compilation.Value;
            string body = $"mov rax, 0x{unchecked((ulong)buffer):X16}\n push rax\n call {compiled.GetFunctionLabel("ft_atoi")}\n add rsp, 8\n push rax";
            long actual = Assert.Single(NativeStack.Run(body, 1, compiled.Assembly));
            using var reference = new CReference();
            Assert.Equal(reference.EvaluateAtoi(buffer), actual);
            Assert.Equal(bytes, Enumerable.Range(0, bytes.Length).Select(i => Marshal.ReadByte(buffer, i)).ToArray());
        }
        finally { Marshal.FreeHGlobal(buffer); }
    }

    [Theory]
    [InlineData("")]
    [InlineData("42")]
    [InlineData("-2147483648")]
    [InlineData("\t\r +2147483647")]
    public void AtoiDoesNotReadBeyondNulAtPageBoundary(string input)
    {
        using var buffer = new GuardedCString(Encoding.Latin1.GetBytes(input + "\0"));
        var compiled = Compilation.Value;
        string body = $"mov rax, 0x{unchecked((ulong)buffer.Pointer):X16}\n push rax\n call {compiled.GetFunctionLabel("ft_atoi")}\n add rsp, 8\n push rax";
        long actual = Assert.Single(NativeStack.Run(body, 1, compiled.Assembly));
        using var reference = new CReference();
        Assert.Equal(reference.EvaluateAtoi(buffer.Pointer), actual);
    }

    [Fact]
    public void CorpusExportsAllNineFunctions()
    {
        Assert.Equal(9, Compilation.Value.Module.Functions.Length);
        foreach (var name in new[] { "ft_isalpha", "ft_isdigit", "ft_isalnum", "ft_isascii", "ft_isprint", "ft_toupper", "ft_tolower", "ft_isspace", "ft_atoi" })
            Assert.NotEmpty(Compilation.Value.GetFunctionLabel(name));
    }
}
