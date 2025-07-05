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
        /// <summary>
        /// Represents a <c>BLOCK</c> operation—an isolated lexical scope that may
        /// declare variables and optionally specify an explicit result type. When
        /// compiled, the operation pushes a new <see cref="ScopeContext"/>
        /// onto the compilation stack and emits paired entry- and exit-labels
        /// (<c>block</c> / <c>end_block</c>) to anchor branch targets and ensure
        /// structurally balanced control flow.
        /// </summary>
        /// <param name="BlockType">
        /// The static type expected to be produced by the block. Specify
        /// <see langword="null"/> to indicate an untyped block whose result is
        /// inferred from its contents.
        /// </param>
        /// <param name="Variables">
        /// The collection of variables that become local to the block. Pass
        /// <see langword="null"/> if the block declares no variables.
        /// </param>
        public readonly record struct BLOCK(UType? BlockType = null, SyntaxExpression? Variables = null) : IBlockOpCode, IOpVariableScope, IOpCodeFactory
        {
            /// <summary>
            /// Represents the opcode for the BLOCK operation.
            /// </summary>
            public const byte OP = 0x02;

            /// <inheritdoc/>
            public readonly byte OpCode => OP;

            /// <inheritdoc/>
            public static IOpCode CreateInstruction(VariableExpressionFragment[] variables, SyntaxToken[] tokens, params ValueType[] operands)
            {
                // Sin tipo explícito
                if (operands.Length == 0)
                {
                    return new BLOCK
                    {
                        Variables = new([.. variables])
                    };
                }

                // BLOCK con tipo de bloque explícito
                if (operands.Length == 1)
                {
                    if (operands[0] is PrimitiveType typeByte)
                    {
                        return new BLOCK
                        {
                            BlockType = new(type: typeByte),
                            Variables = new([.. variables])
                        };
                    }
                }

                // t_<tipo>: tipo primitivo codificado como byte + flags
                if (operands.Length == 2)
                { 
                    if (operands[0] is PrimitiveType typeByte &&
                    operands[1] is TypeModifiers flags)
                    {
                        var typeWithFlags = new UType(typeByte, flags, Types.FromPrimitive(typeByte), typeByte.ToString());
                        return new BLOCK
                        {
                            BlockType = typeWithFlags,
                            Variables = new([.. variables])
                        };
                    }
                }

                // Tipos personalizados: secuencia de bytes y el último es el flags
                if (operands.Length >= 2)
                {
                    if (operands[^1] is TypeModifiers flags &&
                    operands[..^1].All(o => o is char))
                    {
                        var typeName = new string(operands[..^1].Cast<char>().ToArray());
                        var typeWithFlags = new UType(PrimitiveType.CustomType, flags, UType.TypeIDLUT[typeName], typeName);

                        return new BLOCK
                        {
                            BlockType = typeWithFlags,
                            Variables = new([.. variables])
                        };
                    }
                }

                throw new SyntaxException(0x02BADBEEF,
                    $"BLOCK opcode received unrecognized operands: {string.Join(", ", operands.Select(o => o?.ToString() ?? "null"))}");
            }

            /// <summary>
            /// Compiles this entity, emitting its code into the current compilation scopes.
            /// </summary>
            /// <param name="scopes">
            /// The <see cref="CompilationScopes"/> used to track nested blocks,
            /// finalizers, and control-flow during compilation.
            /// </param>
            /// <returns>
            /// A string containing the compiled representation of this entity
            /// (e.g., opcode mnemonics, labels, directives).
            /// </returns>
            public string Compile(CompilationScopes scopes) =>
                ((IOpCode)this).Compile(scopes);

            /// <inheritdoc />
            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                string blockLabel = NextLabel("block");
                string endLabel = NextLabel("end_block");

                scopes.Push(new()
                {
                    StartLabel = blockLabel,
                    EndLabel = endLabel,
                    ExpectedReturnType = BlockType,
                    DeclaredByKeyword = "block"
                });

                return $"{blockLabel}: ; BLOCK start";
            }

        }
    }
}
