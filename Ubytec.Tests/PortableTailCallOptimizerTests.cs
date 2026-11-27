using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public class PortableTailCallOptimizerTests
{
    private const string TailSource = """
        module (name:"portable-tails", version:"0.1", author:"Ubytec")
        {
            func Sum(t_int64 n, t_int64 acc) -> t_int64
            {
                local
                {
                    t_int64 step 7
                }
                if @n == 0
                    load @acc
                    return
                end
                load @n
                dec
                load @acc
                load @step
                add
                call Sum
                return
            }
        }
        """;

    [Fact]
    public void ExplicitPortableTailCallsReuseVerifiedIndexedFrame()
    {
        PortableSourceX64Result compilation = PortableSourceX64Pipeline.Compile(
            TailSource,
            processImage: false,
            optimizeTailCalls: true);

        PortableProcessEntrypoint.Verify(compilation.ModuleBytes);
        string assembly = compilation.NativeCompilation.Assembly.ReplaceLineEndings("\n");
        Assert.Contains("; tail call: reuse incoming argument cells", assembly);
        Assert.Contains("jmp ubytec_binary_f_0", assembly);
        Assert.DoesNotContain("call ubytec_binary_f_0\n", assembly);
        Assert.DoesNotContain("\r", compilation.NativeCompilation.Assembly);

        PortableSourceX64Result ordinary = PortableSourceX64Pipeline.Compile(
            TailSource, processImage: false);
        Assert.Equal(ordinary.ModuleBytes, compilation.ModuleBytes);
        string body = "push 3\npush 10\ncall ubytec_binary_f_0\nadd rsp, 16\npush rax";
        Assert.Equal(31L, Assert.Single(NativeStack.Run(body, 1, ordinary.NativeCompilation.Assembly)));
        Assert.Equal(31L, Assert.Single(NativeStack.Run(body, 1, compilation.NativeCompilation.Assembly)));
    }

    [Fact]
    public void PortableTailCallsRemainOptIn()
    {
        PortableSourceX64Result compilation = PortableSourceX64Pipeline.Compile(
            TailSource,
            processImage: false);

        Assert.DoesNotContain("; tail call: reuse incoming argument cells", compilation.NativeCompilation.Assembly);
        Assert.Contains("call ubytec_binary_f_0", compilation.NativeCompilation.Assembly);
    }
}
