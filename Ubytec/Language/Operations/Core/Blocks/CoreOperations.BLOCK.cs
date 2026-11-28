using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct BLOCK(UType? BlockType = null, SyntaxExpression? Variables = null,
            UType[]? InputTypes = null, bool Checked = false, int? LabelIDx = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory, IEquatable<BLOCK>
        {
            public const byte OP = 0x02;
            public readonly byte OpCode => OP;

            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (tokens.Skip(1).Any(t => t.Source.Contains('(') ||
                    t.Source.Equals("checked", StringComparison.OrdinalIgnoreCase)))
                    return ParseContract(tokens, variables);

                if (operands.Length == 0)
                    return new BLOCK { Variables = new([.. variables]) };

                if (operands.Length == 1 && operands[0] is PrimitiveType typeByte)
                    return new BLOCK { BlockType = new(type: typeByte), Variables = new([.. variables]) };

                if (operands.Length == 2 && operands[0] is PrimitiveType primitive && operands[1] is TypeModifiers flags)
                {
                    var typeWithFlags = new UType(primitive, flags, Types.FromPrimitive(primitive), primitive.ToString());
                    return new BLOCK { BlockType = typeWithFlags, Variables = new([.. variables]) };
                }

                if (operands.Length >= 2 && operands[^1] is TypeModifiers customFlags && operands[..^1].All(o => o is char))
                {
                    var typeName = new string(operands[..^1].Cast<char>().ToArray());
                    var typeWithFlags = new UType(PrimitiveType.CustomType, customFlags, UType.TypeIDLUT[typeName], typeName);
                    return new BLOCK { BlockType = typeWithFlags, Variables = new([.. variables]) };
                }

                throw new SyntaxException(0x02BADBEEF,
                    $"BLOCK opcode received unrecognized operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            private static BLOCK ParseContract(SyntaxToken[] tokens, VariableExpressionFragment[] variables)
            {
                string source = string.Join(" ", tokens.Select(t => t.Source));
                var match = System.Text.RegularExpressions.Regex.Match(source,
                    @"\Ablock\s+(?:(checked)\s+)?(?:(\d+)\s+)?(?:\(\s*([^()]*)\s*\)\s*-\s*>\s*)?(t_\w+)\s*\z",
                    System.Text.RegularExpressions.RegexOptions.IgnoreCase | System.Text.RegularExpressions.RegexOptions.CultureInvariant);
                if (!match.Success || (!match.Groups[1].Success && !match.Groups[3].Success))
                    throw new SyntaxException(0xBAD091, "BLOCK expects [checked] [label] (input types) -> result type.");
                UType ParseType(string value, bool result)
                {
                    if (!value.StartsWith("t_", StringComparison.OrdinalIgnoreCase) ||
                        !Enum.TryParse<PrimitiveType>(value[2..], true, out var primitive))
                        throw new SyntaxException(0xBAD092, "Invalid BLOCK contract type.");
                    var type = new UType(primitive);
                    if (!(result && primitive == PrimitiveType.Void) && !FunctionCode.IsCellType(type))
                        throw new SyntaxException(0xBAD092, "BLOCK contract types must be scalar; only the result may be void.");
                    return type;
                }
                string inputText = match.Groups[3].Value.Trim();
                UType[] inputs = inputText.Length == 0 ? [] : inputText.Split(',').Select(x => ParseType(x.Trim(), false)).ToArray();
                if (inputs.Length > 1024) throw new SyntaxException(0xBAD093, "Too many BLOCK inputs.");
                int? label = null;
                if (match.Groups[2].Success)
                {
                    if (!int.TryParse(match.Groups[2].Value, out int value))
                        throw new SyntaxException(0xBAD094, "BLOCK label is out of range.");
                    label = value;
                }
                return new BLOCK(ParseType(match.Groups[4].Value, true), new([.. variables]), inputs, match.Groups[1].Success, label);
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                string blockLabel = NextLabel(scopes, "block");
                string endLabel = NextLabel(scopes, "end_block");
                scopes.Push(new() { StartLabel = blockLabel, EndLabel = endLabel, ExpectedReturnType = BlockType,
                    DeclaredByKeyword = "block", IsContractBlock = InputTypes is not null,
                    CheckedBlockResult = Checked, LabelIndex = LabelIDx });
                var output = new System.Text.StringBuilder($"{blockLabel}: ; BLOCK start");
                if (InputTypes is not null)
                {
                    for (int i = 0; i < InputTypes.Length; i++)
                    {
                        int offset = checked((InputTypes.Length - 1 - i) * 8);
                        output.AppendLine().AppendLine($"  mov rax, qword [rsp + {offset}]");
                        output.AppendLine(FunctionCode.CanonicalizeBlockCell(InputTypes[i], Checked, scopes));
                        output.Append($"  mov qword [rsp + {offset}], rax");
                    }
                }
                return output.ToString();
            }
        }
    }
}
