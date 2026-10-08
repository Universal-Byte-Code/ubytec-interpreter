using static Ubytec.Language.Syntax.TypeSystem.Types;
using System.Globalization;
using System.Text;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;

namespace Ubytec.Language.Operations;

public static partial class CoreOperations
{
    private static bool TryTokenCondition(Ubytec.Language.Syntax.Model.SyntaxToken[] tokens,
        out Ubytec.Language.Syntax.Model.SyntaxExpression? expression,
        out Ubytec.Language.Syntax.TypeSystem.Types.UType? type)
    {
        expression = null; type = null;
        string source = string.Join(" ", tokens.Skip(1).Select(x => x.Source));
        var match = System.Text.RegularExpressions.Regex.Match(source,
            @"\A\s*(?:(t_\w+)\s+)?(@\s*[A-Za-z_]\w*|-?(?:0[xX][0-9a-fA-F]+|0[bB][01]+|\d+)|true|false)\s*(==|!=|<=|>=|<|>)\s*(@\s*[A-Za-z_]\w*|-?(?:0[xX][0-9a-fA-F]+|0[bB][01]+|\d+)|true|false)\s*\z");
        if (!match.Success) { if (tokens.Any(x => x.Source is "==" or "!=" or "<" or ">" or "<=" or ">=")) throw new SyntaxException(0xBAD08C, "Malformed conditional operands."); return false; }
        object Side(int index) => match.Groups[index].Value.Replace(" ", "");
        if (match.Groups[1].Success)
            type = new(Enum.Parse<Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType>(match.Groups[1].Value[2..], true));
        expression = new(new ConditionExpressionFragment(Side(2), match.Groups[3].Value, Side(4)) { Tokens = tokens.Skip(1).ToArray() });
        return true;
    }

    private static string EmitCondition(ConditionExpressionFragment condition, string endLabel, CompilationScopes scopes, Ubytec.Language.Syntax.TypeSystem.Types.UType? type = null)
    {
        string Load(object? value, string register)
        {
            var source = Convert.ToString(value, CultureInfo.InvariantCulture) ?? "";
            if (source.StartsWith('@'))
                return FunctionCode.Load(scopes.ResolveSymbol(FunctionCode.Identifier(source))) +
                    (register == "rax" ? "" : "\n  mov " + register + ", rax");
            long literal = FunctionCode.InitialValue(new(Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Int64), value);
            return $"mov {register}, {literal}";
        }
        if (type?.Type == PrimitiveType.Default) type = null;
        bool unsigned = type?.Type.IsUnsigned() ?? false;
        var symbolTypes = new[] { condition.Left, condition.Right }
            .Select(x => Convert.ToString(x, CultureInfo.InvariantCulture) ?? "")
            .Where(x => x.StartsWith('@'))
            .Select(x => scopes.ResolveSymbol(FunctionCode.Identifier(x)).Type.Type)
            .Where(x => x.IsNumeric()).ToArray();
        if (type is null && symbolTypes.Length != 0)
        {
            if (symbolTypes.Select(x => x.IsUnsigned()).Distinct().Count() > 1)
                throw new SyntaxException(0xBAD08F, "Mixed signed/unsigned named conditions need an explicit comparison type.");
            unsigned = symbolTypes[0].IsUnsigned();
        }
        if (type is { } explicitType && !FunctionCode.IsCellType(explicitType))
            throw new SyntaxException(0xBAD090, "Conditional type is not supported by the scalar cell backend.");
        string jump = condition.Operand switch
        {
            "==" => "jne", "!=" => "je", "<" => unsigned ? "jae" : "jge", "<=" => unsigned ? "ja" : "jg", ">" => unsigned ? "jbe" : "jle", ">=" => unsigned ? "jb" : "jl",
            _ => throw new SyntaxException(0xBAD081, $"Invalid condition operator '{condition.Operand}'.")
        };
        // Load the right side first: named loads use RAX, so preserve it in RCX.
        return Load(condition.Right, "rcx") + "\n  " + Load(condition.Left, "rax") +
            $"\n  cmp rax, rcx\n  {jump} {endLabel}";
    }

    private static ScopeContext TransferTarget(CompilationScopes scopes, int? label, bool continuing)
    {
        foreach (var scope in scopes.All)
        {
            if (scope.DeclaredByKeyword is "func" or "action") break;
            bool valid = continuing ? scope.IsLoop : scope.IsLoop || scope.DeclaredByKeyword is "switch" or "branch";
            if (valid && (label is null || scope.LabelIndex == label))
            {
                if (scope.DeclaredByKeyword == "branch") return scopes.All.SkipWhile(x => x != scope).Skip(1).First(x => x.DeclaredByKeyword == "switch");
                return scope;
            }
        }
        throw new SyntaxStackException(0xBAD082,
            $"{(continuing ? "CONTINUE" : "BREAK")} has no enclosing target{(label is null ? "" : $" with label {label}")}.");
    }
}
