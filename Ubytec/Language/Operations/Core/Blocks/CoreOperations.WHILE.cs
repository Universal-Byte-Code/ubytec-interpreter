using System.Text;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        public readonly record struct WHILE(UType? BlockType = null, SyntaxExpression? Condition = null, int[]? LabelIDxs = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory, IEquatable<WHILE>
        {
            public const byte OP = 0x0C;
            public readonly byte OpCode => OP;
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                if (TryTokenCondition(tokens, out var tokenCondition, out var tokenType)) return new WHILE { Condition = tokenCondition, BlockType = tokenType, Variables = new([.. variables]) };
                if (operands.Length == 0) return new WHILE { Variables = new([.. variables]) };
                if (operands.Length == 4)
                {
                    var left = operands[0]; var opLower = Convert.ToByte(operands[1]); var opUpper = Convert.ToByte(operands[2]); var right = operands[3];
                    string equals = opUpper == 0 ? new string([(char)opLower]) : new string([(char)opLower, (char)opUpper]);
                    return new WHILE { BlockType = new(type: PrimitiveType.Default), Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }), Variables = new([.. variables]) };
                }
                if (operands.Length == 5)
                {
                    var blockType = (PrimitiveType)operands[0]; var left = operands[1]; var opLower = Convert.ToByte(operands[2]); var opUpper = Convert.ToByte(operands[3]); var right = operands[4];
                    string equals = opUpper == 0 ? new string([(char)opLower]) : new string([(char)opLower, (char)opUpper]);
                    return new WHILE { BlockType = new(type: blockType), Condition = new(new ConditionExpressionFragment(left, equals, right) { Tokens = [.. tokens.Skip(1)] }), Variables = new([.. variables]) };
                }
                if (operands.Length == 2 && operands[0] is byte typeByte && operands[1] is byte flagsByte) return new WHILE { BlockType = UType.FromOperands(typeByte, flagsByte), Variables = new([.. variables]) };
                if (operands.Length >= 2 && operands[^1] is byte finalFlags && operands[..^1].All(o => o is byte)) return new WHILE { BlockType = new UType(PrimitiveType.CustomType, (TypeModifiers)finalFlags), Variables = new([.. variables]) };
                if (operands.Length == 1) return new WHILE { BlockType = new(type: (PrimitiveType)operands[0]), Variables = new([.. variables]) };
                throw new SyntaxException(0x0CBADBEEF, $"WHILE opcode received unexpected number of operands: {operands.Length}");
            }

            public string Compile(CompilationScopes scopes) => ((IOpCode)this).Compile(scopes);
            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                if (!ValidateConditionalBlockType(BlockType?.Type == PrimitiveType.Default ? PrimitiveType.Bool : BlockType?.Type ?? PrimitiveType.Bool)) throw new SyntaxStackException(0x0CBAD1CE, $"Invalid WHILE blockType {BlockType}");
                if (LabelIDxs is { Length: > 1 }) throw new SyntaxStackException(0xBAD080, "WHILE accepts at most one label identifier.");
                string whileStartLabel = NextLabel(scopes, "while");
                string whileEndLabel = NextLabel(scopes, "end_while");
                scopes.Push(new ScopeContext { StartLabel = whileStartLabel, EndLabel = whileEndLabel, LabelIndex = LabelIDxs is { Length: 1 } ? LabelIDxs[0] : null, ExpectedReturnType = BlockType, DeclaredByKeyword = "while" });
                var output = new StringBuilder().AppendLine($"{whileStartLabel}: ; WHILE start");
                if (Condition is null) output.AppendLine(GenerateWhileCondition(null, whileEndLabel));
                else foreach (var condition in Condition.Syntaxes.Cast<ConditionExpressionFragment>()) output.AppendLine(EmitCondition(condition, whileEndLabel, scopes, BlockType));
                return output.ToString();
            }
        }
    }
}
