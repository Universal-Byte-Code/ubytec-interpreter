using Ubytec.Language.Syntax.Scopes.Contexts;
using Xunit;

namespace Ubytec.Tests;

public class ScopeContextTests
{
    [Theory]
    [InlineData("loop")]
    [InlineData("while")]
    public void LoopClassificationUsesDeclaredKeywordWithDeterministicLabels(string keyword)
    {
        var context = new ScopeContext
        {
            DeclaredByKeyword = keyword,
            StartLabel = "func_0123456789abcdef__control_0"
        };

        Assert.True(context.IsLoop);
    }

    [Fact]
    public void BranchClassificationUsesDeclaredKeywordWithDeterministicLabels()
    {
        var context = new ScopeContext
        {
            DeclaredByKeyword = "branch",
            StartLabel = "func_0123456789abcdef__control_1"
        };

        Assert.True(context.IsBranch);
    }

    [Fact]
    public void ExplicitKeywordOverridesLegacyLabelPrefix()
    {
        var context = new ScopeContext
        {
            DeclaredByKeyword = "if",
            StartLabel = "loop_legacy"
        };

        Assert.False(context.IsLoop);
        Assert.False(context.IsBranch);
    }

    [Fact]
    public void LegacyLabelPrefixesRemainSupportedWithoutDeclaredKeyword()
    {
        Assert.True(new ScopeContext { StartLabel = "loop_legacy" }.IsLoop);
        Assert.True(new ScopeContext { StartLabel = "while_legacy" }.IsLoop);
        Assert.True(new ScopeContext { StartLabel = "branch_legacy" }.IsBranch);
    }
}
