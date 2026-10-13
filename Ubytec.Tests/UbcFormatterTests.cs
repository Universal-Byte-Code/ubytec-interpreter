using Ubytec.Language.Tools;
using Xunit;

namespace Ubytec.Tests;

public class UbcFormatterTests
{
    [Fact]
    public void FormatsBracesAndStructuredBlocks()
    {
        const string source = "module (name:\"format\",version:\"0.1\",author:\"Ubytec\") {\nfunc Main() -> t_int64 {\nlocal { t_int64 value 0 }\nif @value == 0\npush 1\nelse\npush 2\nend\npush 2\nswitch\nbranch 1\npush 10\nend\ndefault\npush 20\nend\nreturn\n}\n}\n";
        const string expected = "module (name:\"format\",version:\"0.1\",author:\"Ubytec\")\n{\n    func Main() -> t_int64\n    {\n        local\n        {\n            t_int64 value 0\n        }\n        if @value == 0\n            push 1\n        else\n            push 2\n        end\n        push 2\n        switch\n            branch 1\n                push 10\n            end\n            default\n                push 20\n        end\n        return\n    }\n}\n";

        Assert.Equal(expected, UbcFormatter.Format(source));
        Assert.Equal(expected, UbcFormatter.Format(expected));
    }

    [Fact]
    public void IgnoresBracesInsideStringsAndComments()
    {
        const string source = "module (name:\"{format}\",version:\"0.1\",author:\"Ubytec\") {\n// { ignored }\n/* { also ignored\n   } still ignored */\nfunc Main() -> t_int64 {\npush 0 // } ignored\nreturn\n}\n}\n";
        const string expected = "module (name:\"{format}\",version:\"0.1\",author:\"Ubytec\")\n{\n    // { ignored }\n    /* { also ignored\n    } still ignored */\n    func Main() -> t_int64\n    {\n        push 0 // } ignored\n        return\n    }\n}\n";

        Assert.Equal(expected, UbcFormatter.Format(source));
    }

    [Fact]
    public void DefaultOutsideSwitchDoesNotCreateIndentation()
    {
        const string source = "module (name:\"format\",version:\"0.1\",author:\"Ubytec\") {\nfunc Main() -> t_int64 {\ndefault\nreturn\n}\n}\n";
        const string expected = "module (name:\"format\",version:\"0.1\",author:\"Ubytec\")\n{\n    func Main() -> t_int64\n    {\n        default\n        return\n    }\n}\n";

        Assert.Equal(expected, UbcFormatter.Format(source));
    }
}
