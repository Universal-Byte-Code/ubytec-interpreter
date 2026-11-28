using Ubytec.Language.AST;
using Xunit;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Tests;

public class LexicalParserContractTests
{
    [Fact]
    public void MalformedDeclarationFailsAtFirstRequiredToken()
    {
        const string source = """
module (name:"strict-consume", version:"0.1", author:"Ubytec")
{
    func
    {
    }
}
""";

        var error = Assert.Throws<FormatException>(() =>
            SourceCompiler.CompileSemantic(source, processImage: false));

        Assert.Contains("Expected", error.Message, StringComparison.Ordinal);
        Assert.Contains("found '{'", error.Message, StringComparison.Ordinal);
    }

    [Fact]
    public void FieldNamesAreRecognizedAfterEverySupportedNullableArrayShape()
    {
        const string source = """
module (name:"typed-names", version:"0.1", author:"Ubytec")
{
    field t_int32 Scalar
    field t_int32? NullableScalar
    field [t_int32] Array
    field [t_int32]? NullableArray
    field [t_int32?] NullableItems
    field [t_int32?]? NullableArrayAndItems
}
""";

        var module = SourceCompiler.CompileSemantic(source, processImage: false).Module;

        Assert.Equal(
            ["Scalar", "NullableScalar", "Array", "NullableArray", "NullableItems", "NullableArrayAndItems"],
            module.Fields.Select(field => field.Name).ToArray());
    }

    [Fact]
    public void GlobalContextAndGlobalModifierRemainDistinctProductions()
    {
        const string source = """
module (name:"global-dispatch", version:"0.1", author:"Ubytec")
{
    global func Flagged()
    {
        return
    }

    global
    {
        func Contextual()
        {
            return
        }
    }
}
""";

        var module = SourceCompiler.CompileSemantic(source, processImage: false).Module;

        var flagged = Assert.Single(module.Functions);
        Assert.Equal("Flagged", flagged.Name);
        Assert.True((flagged.Modifiers & TypeModifiers.Global) != 0);

        var globalContext = Assert.IsType<Ubytec.Language.HighLevel.GlobalContext>(module.GlobalContext);
        Assert.Equal("Contextual", Assert.Single(globalContext.Functions).Name);
    }
}
