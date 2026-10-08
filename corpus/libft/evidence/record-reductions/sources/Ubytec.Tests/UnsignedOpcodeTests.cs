using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Tools.Serialization;
using Xunit;

namespace Ubytec.Tests;

public class UnsignedOpcodeTests
{
    public static IEnumerable<object[]> Instructions()
    {
        yield return ["udiv", (byte)0x29]; yield return ["umod", (byte)0x2A];
        yield return ["lshr", (byte)0x36]; yield return ["ult", (byte)0x46];
        yield return ["ule", (byte)0x47]; yield return ["ugt", (byte)0x48]; yield return ["uge", (byte)0x49];
    }

    [Theory, MemberData(nameof(Instructions))]
    public void FullWidthNativeResultsPreserveLowerCells(string name, byte code)
    {
        ulong[] edges = [0, 1, 2, 63, 64, 65, (1UL << 63) - 1, 1UL << 63, ulong.MaxValue - 1, ulong.MaxValue];
        var pairs = edges.SelectMany(a => edges.Select(b => (a, b))).ToList();
        var random = new Random(42046);
        for (int i = 0; i < 64; i++)
        {
            byte[] bytes = new byte[16]; random.NextBytes(bytes);
            pairs.Add((BitConverter.ToUInt64(bytes, 0), BitConverter.ToUInt64(bytes, 8)));
        }
        var expected = new List<long> { 1234567 }; var asm = new System.Text.StringBuilder("push 1234567\n");
        foreach (var (a, b) in pairs)
        {
            if ((name is "udiv" or "umod") && b == 0) continue;
            ulong value = name switch
            {
                "udiv" => a / b, "umod" => a % b, "lshr" => a >> (int)(b & 63),
                "ult" => a < b ? 1UL : 0, "ule" => a <= b ? 1UL : 0,
                "ugt" => a > b ? 1UL : 0, _ => a >= b ? 1UL : 0
            };
            expected.Add(unchecked((long)value));
            asm.Append($"mov rax, 0x{a:X16}\n push rax\n mov rax, 0x{b:X16}\n push rax\n");
            asm.AppendLine(OpcodeFactory.Create(code, [], []).Compile(new CompilationScopes()));
        }
        Assert.Equal(expected, NativeStack.Run(asm.ToString(), expected.Count));
    }

    [Theory, MemberData(nameof(Instructions))]
    public void SourceGrammarStackValidationAndJsonAgree(string name, byte code)
    {
        string Source(string body) => "module (name:\"unsigned\",version:\"0.1\",author:\"Ubytec\") { func Run() -> t_uint64 {\n" + body + "\nreturn\n} }";
        var compiled = SourceCompiler.Compile(Source("push 18446744073709551615\npush 2\n" + name.ToUpperInvariant()));
        ulong expected = name switch { "udiv" => ulong.MaxValue / 2, "umod" => 1, "lshr" => ulong.MaxValue >> 2, "ult" or "ule" => 0, _ => 1 };
        Assert.Equal(unchecked((long)expected), Assert.Single(NativeStack.Run($"call {compiled.GetFunctionLabel("Run")}\npush rax", 1, compiled.Assembly)));
        Assert.Throws<SyntaxException>(() => SourceCompiler.Compile(Source("push 1\n" + name)));
        Assert.Throws<SyntaxException>(() => OpcodeFactory.Create(code, [], [], 1));
        var op = OpcodeFactory.Create(code, [], []); var options = new JsonSerializerOptions(); options.Converters.Add(new IOpCodeConverter());
        Assert.Equal(op, JsonSerializer.Deserialize<IOpCode>(JsonSerializer.Serialize(op, options), options));
    }
}
