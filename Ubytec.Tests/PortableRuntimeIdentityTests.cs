using Ubytec.Language.AST;
using Ubytec.Language.Portable;
using Xunit;

namespace Ubytec.Tests;

public sealed class PortableRuntimeIdentityTests
{
    private static byte[] Image()
    {
        var source = SourceCompiler.Compile("""
            module (name:"event-identity", version:"0.1", author:"Ubytec")
            {
                func Main() -> t_int64
                {
                    push 1
                    return
                }
            }
            """, emitProcessEntryPoint: false);
        return PortableModuleFormat.Encode(source.Module, contractManifest: null,
            includeIndexedExecutable: true, portableContracts: source.PortableContracts,
            executionProfile: PortableExecutionProfile.DirectOnly);
    }

    [Fact]
    public void RepeatedOccurrencesAndRecursionHaveDistinctEvents()
    {
        var runtime = new PortableRuntimeIdentity();
        var module = runtime.Load(Image(), PortableExecutionProfile.DirectOnly);
        var context = runtime.CreateContext();
        var outer = runtime.Enter(context, module, 0);
        var a = runtime.Record(outer, 0);
        var b = runtime.Record(outer, 0);
        var inner = runtime.Enter(context, module, 0);
        var c = runtime.Record(inner, 0);
        Assert.Equal(a.Occurrence, c.Occurrence);
        Assert.Equal(a.Activation, b.Activation);
        Assert.NotEqual(a.Activation, c.Activation);
        Assert.Equal(new ulong[] { 1, 2, 3 }, new[] { a.Id.Sequence, b.Id.Sequence, c.Id.Sequence });
        Assert.Throws<InvalidOperationException>(() => runtime.Record(outer, 0));
        Assert.Throws<InvalidOperationException>(() => runtime.Leave(outer));
        Assert.Throws<InvalidOperationException>(() => runtime.Unload(module));
        runtime.Leave(inner);
        Assert.Equal(4UL, runtime.Record(outer, 0).Id.Sequence);
        runtime.Leave(outer);
        runtime.RetireContext(context);
        runtime.Unload(module);
    }

    [Fact]
    public void IdenticalImagesAndFreshSessionsDoNotCollapse()
    {
        byte[] bytes = Image();
        var runtime = new PortableRuntimeIdentity();
        var left = runtime.Load(bytes, PortableExecutionProfile.DirectOnly);
        var right = runtime.Load(bytes, PortableExecutionProfile.DirectOnly);
        var c = runtime.CreateContext();
        var a = runtime.Enter(c, left, 0);
        var e = runtime.Record(a, 0);
        runtime.Leave(a);
        var b = runtime.Enter(c, right, 0);
        var f = runtime.Record(b, 0);
        Assert.Equal(e.Occurrence, f.Occurrence);
        Assert.NotEqual(e.Instance, f.Instance);
        Assert.NotEqual(e.Id, f.Id);
        var fresh = new PortableRuntimeIdentity();
        Assert.NotEqual(runtime.Session, fresh.Session);
        Assert.Throws<InvalidOperationException>(() => fresh.Enter(c, left, 0));
    }

    [Fact]
    public void InvalidSitesAndStaleHandlesDoNotConsumeOrReuseEventIdentity()
    {
        byte[] bytes = Image();
        var runtime = new PortableRuntimeIdentity();
        var loaded = runtime.Load(bytes, PortableExecutionProfile.DirectOnly);
        Array.Clear(bytes);
        var c = runtime.CreateContext();
        var a = runtime.Enter(c, loaded, 0);
        Assert.Throws<InvalidDataException>(() => runtime.Record(a, 1));
        Assert.Equal(1UL, runtime.Record(a, 0).Id.Sequence);
        runtime.Leave(a);
        Assert.Throws<InvalidOperationException>(() => runtime.Record(a, 0));
        runtime.Unload(loaded);
        Assert.Throws<InvalidOperationException>(() => runtime.Enter(c, loaded, 0));
        var newInstance = runtime.Load(Image(), PortableExecutionProfile.DirectOnly);
        Assert.True(newInstance.Ordinal > loaded.Ordinal);
        runtime.RetireContext(c);
        Assert.Throws<InvalidOperationException>(() => runtime.Enter(c, newInstance, 0));
        Assert.True(runtime.CreateContext().Ordinal > c.Ordinal);
    }
}
