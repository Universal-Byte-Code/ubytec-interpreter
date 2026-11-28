using Ubytec.Language.AST;
using Xunit;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Tests;

public class HighLevelParserDeclarationDispatchTests
{
    [Fact]
    public void FuncAndActionDeclarationsParseAcrossScopes()
    {
        const string source = """
module (name:"parser-entry", version:"0.1", author:"Ubytec")
{
    func ModuleFunc()
    {
        return
    }

    action ModuleAction()
    {
        return
    }

    global
    {
        func GlobalFunc()
        {
            return
        }

        action GlobalAction()
        {
            return
        }
    }

    local
    {
        func LocalFunc()
        {
            return
        }

        action LocalAction()
        {
            return
        }
    }

    class Holder
    {
        func ClassFunc()
        {
            return
        }

        action ClassAction()
        {
            return
        }
    }
}
""";

        var module = SourceCompiler.CompileSemantic(source, processImage: false).Module;

        Assert.Equal("ModuleFunc", Assert.Single(module.Functions).Name);
        Assert.Equal("ModuleAction", Assert.Single(module.Actions).Name);

        Assert.True(module.GlobalContext.HasValue);
        Assert.Equal("GlobalFunc", Assert.Single(module.GlobalContext.Value.Functions).Name);
        Assert.Equal("GlobalAction", Assert.Single(module.GlobalContext.Value.Actions).Name);

        Assert.True(module.LocalContext.HasValue);
        Assert.Equal("LocalFunc", Assert.Single(module.LocalContext.Value.Functions).Name);
        Assert.Equal("LocalAction", Assert.Single(module.LocalContext.Value.Actions).Name);

        var holder = Assert.Single(module.Classes);
        Assert.Equal("Holder", holder.Name);
        Assert.Equal("ClassFunc", Assert.Single(holder.Functions).Name);
        Assert.Equal("ClassAction", Assert.Single(holder.Actions).Name);
    }

    [Fact]
    public void DispatcherConsumesKeywordsAndPreservesModifiers()
    {
        const string source = """
module (name:"parser-modifiers", version:"0.1", author:"Ubytec")
{
    public func Visible()
    {
        return
    }

    private action Hidden()
    {
        return
    }

    public class Holder
    {
        protected func Member()
        {
            return
        }
    }
}
""";

        var module = SourceCompiler.CompileSemantic(source, processImage: false).Module;

        var visible = Assert.Single(module.Functions);
        Assert.Equal("Visible", visible.Name);
        Assert.True(visible.Modifiers.HasFlag(TypeModifiers.Public));

        var hidden = Assert.Single(module.Actions);
        Assert.Equal("Hidden", hidden.Name);
        Assert.True(hidden.Modifiers.HasFlag(TypeModifiers.Private));

        var holder = Assert.Single(module.Classes);
        Assert.True(holder.Modifiers.HasFlag(TypeModifiers.Public));
        var member = Assert.Single(holder.Functions);
        Assert.True(member.Modifiers.HasFlag(TypeModifiers.Protected));
    }

    [Fact]
    public void RecordFunctionUsesDeclarationKeywordRatherThanCallKeyword()
    {
        const string source = """
module (name:"parser-record", version:"0.1", author:"Ubytec")
{
    record Packet
    {
        func Decode()
        {
            return
        }

        action Mark()
        {
            return
        }
    }
}
""";

        var module = SourceCompiler.CompileSemantic(source, processImage: false).Module;

        var record = Assert.Single(module.Records);
        Assert.Equal("Packet", record.Name);
        Assert.Equal("Decode", Assert.Single(record.Functions).Name);
        Assert.Equal("Mark", Assert.Single(record.Actions).Name);
    }

    [Fact]
    public void KeywordDispatchParsesFieldStructEnumAndNestedTypeDeclarations()
    {
        const string source = """
module (name:"parser-declarations", version:"0.1", author:"Ubytec")
{
    field t_uint64 Counter

    struct Pair
    {
        field t_uint64 Left
        field t_uint64 Right

        func Touch()
        {
            return
        }
    }

    enum State
    {
        Idle,
        Ready
    }

    class Outer
    {
        class Inner
        {
            func Run()
            {
                return
            }
        }
    }
}
""";

        var module = SourceCompiler.CompileSemantic(source, processImage: false).Module;

        Assert.Equal("Counter", Assert.Single(module.Fields).Name);

        var pair = Assert.Single(module.Structs);
        Assert.Equal("Pair", pair.Name);
        Assert.Equal(2, pair.Fields.Length);
        Assert.Equal("Touch", Assert.Single(pair.Functions).Name);

        var state = Assert.Single(module.Enums);
        Assert.Equal("State", state.Name);

        var outer = Assert.Single(module.Classes);
        var inner = Assert.Single(outer.Classes);
        Assert.Equal("Inner", inner.Name);
        Assert.Equal("Run", Assert.Single(inner.Functions).Name);
    }
}
