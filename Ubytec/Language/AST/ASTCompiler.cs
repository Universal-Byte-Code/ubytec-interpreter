using NJsonSchema;
using System.Text;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Operations.ArithmeticOperations;
using static Ubytec.Language.Operations.BitwiseOperations;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Operations.StackOperarions;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.AST
{
    public static class ASTCompiler
    {
        private static readonly Dictionary<string, byte> OpcodeMap = new()
        {
            // Control Flow
            { nameof(TRAP), 0x00 },
            { nameof(NOP), 0x01 },
            { nameof(BLOCK), 0x02 },
            { nameof(LOOP), 0x03 },
            { nameof(IF), 0x04 },
            { nameof(ELSE), 0x05 },
            { nameof(END), 0x06 },
            { nameof(BREAK), 0x07 },
            { nameof(CONTINUE), 0x08 },
            { nameof(RETURN), 0x09 },
            { nameof(BRANCH), 0x0A },
            { nameof(SWITCH), 0x0B },
            { nameof(WHILE), 0x0C },
            { nameof(CLEAR), 0x0D },
            { nameof(DEFAULT), 0x0E },
            { nameof(NULL), 0x0F },

            // Inline var
            { nameof(VAR), 0x10 },
        
            // Stack Manipulation
            { nameof(PUSH), 0x11 },
            { nameof(POP), 0x12 },
            { nameof(DUP), 0x13 },
            { nameof(SWAP), 0x14 },
            { nameof(ROT), 0x15 },
            { nameof(OVER), 0x16 },
            { nameof(NIP), 0x17 },
            { nameof(DROP), 0x18 },
            { nameof(TwoDUP), 0x19 },
            { nameof(TwoSWAP), 0x1A },
            { nameof(TwoROT), 0x1B },
            { nameof(TwoOVER), 0x1C },
            { nameof(PICK), 0x1D },
            { nameof(ROLL), 0x1E },
        
            // Arithmetic Operations
            { nameof(ADD), 0x20 },
            { nameof(SUB), 0x21 },
            { nameof(MUL), 0x22 },
            { nameof(DIV), 0x23 },
            { nameof(MOD), 0x24 },
            { nameof(INC), 0x25 },
            { nameof(DEC), 0x26 },
            { nameof(NEG), 0x27 },
            { nameof(ABS), 0x28 },
        
            // Logical Operations
            { nameof(AND), 0x30 },
            { nameof(OR), 0x31 },
            { nameof(XOR), 0x32 },
            { nameof(NOT), 0x33 },
            { nameof(SHL), 0x34 },
            { nameof(SHR), 0x35 },
        
            // Comparisons
            { "EQ", 0x40 },
            { "NEQ", 0x41 },
            { "LT", 0x42 },
            { "LE", 0x43 },
            { "GT", 0x44 },
            { "GE", 0x45 },
        
            // Memory Operations (Optional)
            { "LOAD", 0x50 },
            { "STORE", 0x51 }
        };

        /// <summary>
        /// Parses the source code line by line, tokenizes each line, builds opCodes,
        /// and handles opening/closing of blocks (BLOCK, IF, ELSE, LOOP, WHILE, etc.)
        /// using a stack-based approach.
        /// </summary>
        /// <param name="code">A string representing the source code to parse.</param>
        /// <returns>
        /// A tuple containing an array of generated opCodes and an array of SyntaxToken 
        /// representing the tokens for each instruction.
        /// </returns>
        public static IOpCode[] Parse(SyntaxToken[] code)
        {
            List<IOpCode> opCodes = [];

            // Holds the currently 'open' blocks or conditional structures
            Stack<IBlockOpCode> blockStack = new();

            for (int y = 0; y < code.Length; y++)
            {
                var currToken = code[y];
                IBlockOpCode? currentBlock = blockStack.Count > 0 ? blockStack.Peek() : null;

                if (string.IsNullOrWhiteSpace(currToken.Source) || currToken.Scopes.Length == 0 || currToken.Scopes.Length == 1 && currToken.Scopes[0] == "source.ubytec") continue;

                var currLineIndex = currToken.Line;
                var currLine = new List<SyntaxToken>();

                for (int i = y; i < code.Length && code[i].Line == currLineIndex; i++)
                {
                    if (!string.IsNullOrWhiteSpace(code[i].Source) || code[i].Scopes.Length == 0)
                        currLine.Add(code[i]);

                    if (i != y && currLine.Count > 0) y++;
                }

                if (currToken.Scopes.FirstOrDefault(x => x.StartsWith("storage.type.")) is string typeScope)
                {
                    var labelToken = currLine[1];
                    var valueToken = currLine[2];

                    var typeModifiers = TypeModifiers.None;

                    // Determinar si es array y/o nullable según scope
                    if (typeScope.Contains("nullable-both"))
                        typeModifiers |= TypeModifiers.Nullable | TypeModifiers.IsArray;
                    else if (typeScope.Contains("nullable-array"))
                        typeModifiers |= TypeModifiers.IsArray | TypeModifiers.Nullable;
                    else if (typeScope.Contains("nullable-items"))
                        typeModifiers |= TypeModifiers.IsArray;
                    else if (typeScope.Contains("single.nullable"))
                        typeModifiers |= TypeModifiers.Nullable;
                    else if (typeScope.Contains("array"))
                        typeModifiers |= TypeModifiers.IsArray;

                    // Determinar modificadores adicionales desde scopes
                    foreach (var scope in currLine.SelectMany(t => t.Scopes))
                    {
                        if (!scope.StartsWith("storage.modifier.")) continue;
                        var keyword = currLine.First(t => t.Scopes.Contains(scope)).Source.ToLowerInvariant();

                        typeModifiers |= keyword switch
                        {
                            "public" => TypeModifiers.Public,
                            "private" => TypeModifiers.Private,
                            "protected" => TypeModifiers.Protected,
                            "internal" => TypeModifiers.Internal,
                            "const" => TypeModifiers.Const,
                            "abstract" => TypeModifiers.Abstract,
                            "virtual" => TypeModifiers.Virtual,
                            "override" => TypeModifiers.Override,
                            "sealed" => TypeModifiers.Sealed,
                            "readonly" => TypeModifiers.ReadOnly,
                            "local" => TypeModifiers.Local,
                            "global" => TypeModifiers.Global,
                            "secret" => TypeModifiers.Secret,
                            _ => TypeModifiers.None
                        };
                    }

                    // Obtener tipo base
                    var targetType = Enum.Parse<PrimitiveType>(currToken.Source.Remove(0, 2), ignoreCase: true);

                    var ubytecType = new UbytecType(
                        targetType,
                        typeModifiers,
                        targetType == PrimitiveType.CustomType ? Guid.NewGuid() : null,
                        targetType == PrimitiveType.CustomType ? labelToken.Source : targetType.ToString()
                    );

                    var variableFragment = new VariableExpressionFragment(ubytecType, labelToken.Source, valueToken.Source)
                    {
                        Tokens = [currToken, labelToken, valueToken]
                    };

                    var varOp = new VAR(variableFragment);

                    if (currentBlock is not null)
                        MergeVariables(currentBlock, varOp);

                    opCodes.Add(varOp);
                    continue;
                }

                if (!OpcodeMap.TryGetValue(currToken.Source.ToUpper(), out byte byteCode))
                    throw new Exception($"Unknown instruction: {currToken}");
                else
                {
                    var instructionAndOperands = new Queue<ValueType>();
                    instructionAndOperands.Enqueue(byteCode);

                    // Process operands (assumes operands are hex or decimal values)
                    for (int i = 1; i < currLine.Count; i++)
                    {
                        var currLineToken = currLine[i];
                        if (string.IsNullOrWhiteSpace(currLineToken.Source) || currLineToken.Scopes.Length == 0 || currLineToken.Scopes.Length == 1 && currLineToken.Scopes[0] == "source.ubytec") continue;


                        ///if (currLineToken.Source.StartsWith("@", StringComparison.OrdinalIgnoreCase))
                        ///{
                        ///    var trimmed = currLineToken.Source.Remove(0, 1);
                        ///    foreach (VAR variableOp in opCodes.Where(t => t.OpCode == OpcodeMap[nameof(VAR)]).Select(v => (VAR)v))
                        ///        if (variableOp.Variable.Name == trimmed)
                        ///            ProcessOperand(
                        ///                new SyntaxToken(variableOp.Variable.Value?.ToString() ?? string.Empty, currLineToken.Line, currLineToken.StartColumn + 1, currLineToken.EndColumn, [.. currLineToken.Scopes, "entity.name.var.reference.ubytec"]),
                        ///                instructionAndOperands);
                        ///}
                        ///else
                        ///

                        try
                        {
                            ProcessOperand(currLineToken, instructionAndOperands);
                        }
                        catch(Exception e)
                        {
                            throw new SyntaxException(0xD7D2BB3DFE8411EA, e.Message);
                        }
                    }

                    var dequedByteCode = instructionAndOperands.Dequeue();

                    // Actually create the IOpCode
                    IOpCode op = OpcodeFactory.Create((byte)dequedByteCode, [], [.. currLine], [.. instructionAndOperands]);
                    // Now handle special constructs:
                    switch (op)
                    {
                        case BLOCK:
                        case IF:
                        case LOOP:
                        case WHILE:
                        case SWITCH:
                            {
                                InheritVariables(currentBlock, (IOpInheritance)op);
                                blockStack.Push((IBlockOpCode)op);
                                break;
                            }
                        case ELSE:
                            {
                                if (blockStack.Count > 0 && blockStack.Peek() is IF ifOp)
                                {
                                    blockStack.Pop();
                                    currentBlock = blockStack.Count > 0 ? blockStack.Peek() : null;
                                }

                                InheritVariables(currentBlock, (IOpInheritance)op);
                                blockStack.Push((IBlockOpCode)op);
                                break;
                            }
                        case END:
                            {
                                if (blockStack.Count > 0)
                                    blockStack.Pop();
                                break;
                            }

                        // Opcodes con efecto de control de flujo o salidas:
                        case BREAK:
                        case CONTINUE:
                        case RETURN:
                            {
                                // Estos podrían validar si hay contexto válido o tipo de retorno esperado.
                                // Por ahora no hacemos nada extra con ellos.
                                break;
                            }

                        // Operaciones neutras o constantes:
                        case TRAP:
                        case NOP:
                        case CLEAR:
                        case DEFAULT:
                        case NULL:
                            {
                                // Estas instrucciones se ejecutan tal cual sin manipular el stack de bloques.
                                break;
                            }

                        // Casos especiales con saltos condicionados
                        case BRANCH:
                            {
                                InheritVariables(currentBlock, (IOpInheritance)op);
                                blockStack.Push((IBlockOpCode)op);
                                break;
                            }

                        default:
                            {
                                throw new InvalidOperationException($"Unhandled opcode in switch: {op.GetType().Name}");
                            }
                    }

                    opCodes.Add(op);
                }
            }

            return [.. opCodes];
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="currLineToken"></param>
        /// <param name="instructionAndOperands"></param>
        /// <exception cref="Exception"></exception>
        private static void ProcessOperand(SyntaxToken currLineToken, Queue<ValueType> instructionAndOperands)
        {
            // Storage Types
            var isArrayNullableBoth = currLineToken.Scopes.Contains("storage.type.array.nullable-both.ubytec");
            var isArrayNullableArray = currLineToken.Scopes.Contains("storage.type.array.nullable-array.ubytec");
            var isArrayNullableItems = currLineToken.Scopes.Contains("storage.type.array.nullable-items.ubytec");
            var isSingleNullable = currLineToken.Scopes.Contains("storage.type.single.nullable.ubytec");
            var isSingle = currLineToken.Scopes.Contains("storage.type.single.ubytec");
            var isArray = currLineToken.Scopes.Contains("storage.type.array.ubytec");

            // Comments
            var isCommentLineDoubleSlash = currLineToken.Scopes.Contains("comment.line.double-slash.ubytec");
            var isCommentBlock = currLineToken.Scopes.Contains("comment.block.ubytec");

            // Modifiers
            var isModifier = currLineToken.Scopes.Contains("storage.modifier.ubytec");

            // Constants
            var isBooleanConstant = currLineToken.Scopes.Contains("constant.boolean.ubytec");
            var isNumericFloat = currLineToken.Scopes.Contains("constant.numeric.float.ubytec");
            var isNumericDouble = currLineToken.Scopes.Contains("constant.numeric.double.ubytec");
            var isNumericInt = currLineToken.Scopes.Contains("constant.numeric.int.ubytec");
            var isNumericHex = currLineToken.Scopes.Contains("constant.numeric.hex.ubytec");
            var isNumericBinary = currLineToken.Scopes.Contains("constant.numeric.binary.ubytec");

            // Code Structures
            var isArrayStructure = currLineToken.Scopes.Contains("meta.array.ubytec");
            var isGroupingStructure = currLineToken.Scopes.Contains("meta.grouping.ubytec");
            var isBlockStructure = currLineToken.Scopes.Contains("meta.block.ubytec");
            var isAngleGrouping = currLineToken.Scopes.Contains("meta.angle.grouping.ubytec");

            // Strings
            var isDoubleQuotedString = currLineToken.Scopes.Contains("string.quoted.double.ubytec");
            var isSingleQuotedString = currLineToken.Scopes.Contains("string.quoted.single.ubytec");

            // Keywords
            var isDeclarationKeyword = currLineToken.Scopes.Contains("keyword.control.declaration.ubytec");
            var isControlKeyword = currLineToken.Scopes.Contains("keyword.control.ubytec");
            var isFlowKeyword = currLineToken.Scopes.Contains("keyword.control.flow.ubytec");
            var isVarKeyword = currLineToken.Scopes.Contains("keyword.storage.var.ubytec");
            var isStackKeyword = currLineToken.Scopes.Contains("keyword.stack.ubytec");
            var isArithmeticKeyword = currLineToken.Scopes.Contains("keyword.operator.arithmetic.ubytec");
            var isBitwiseKeyword = currLineToken.Scopes.Contains("keyword.operator.bitwise.ubytec");
            var isComparisonKeyword = currLineToken.Scopes.Contains("keyword.operator.comparison.ubytec");
            var isMemoryKeyword = currLineToken.Scopes.Contains("keyword.memory.ubytec");
            var isJumpKeyword = currLineToken.Scopes.Contains("keyword.control.jump.ubytec");
            var isFuncCallKeyword = currLineToken.Scopes.Contains("keyword.function.call.ubytec");
            var isSyscallKeyword = currLineToken.Scopes.Contains("keyword.syscall.ubytec");
            var isThreadingKeyword = currLineToken.Scopes.Contains("keyword.threading.ubytec");
            var isSecurityKeyword = currLineToken.Scopes.Contains("keyword.security.ubytec");
            var isExceptionKeyword = currLineToken.Scopes.Contains("keyword.exception.ubytec");
            var isVectorKeyword = currLineToken.Scopes.Contains("keyword.vector.ubytec");
            var isAudioKeyword = currLineToken.Scopes.Contains("keyword.audio.ubytec");
            var isSystemKeyword = currLineToken.Scopes.Contains("keyword.system.ubytec");
            var isMLKeyword = currLineToken.Scopes.Contains("keyword.ml.ubytec");
            var isPowerKeyword = currLineToken.Scopes.Contains("keyword.power.ubytec");
            var isQuantumKeyword = currLineToken.Scopes.Contains("keyword.quantum.ubytec");

            // Operators
            var isEqualityOperator = currLineToken.Scopes.Contains("operator.equality.ubytec");
            var isInequalityOperator = currLineToken.Scopes.Contains("operator.inequality.ubytec");
            var isLessThanEqualsOperator = currLineToken.Scopes.Contains("operator.less-than-equals.ubytec");
            var isGreaterThanEqualsOperator = currLineToken.Scopes.Contains("operator.greater-than-equals.ubytec");
            var isLessThanOperator = currLineToken.Scopes.Contains("operator.less-than.ubytec");
            var isGreaterThanOperator = currLineToken.Scopes.Contains("operator.greater-than.ubytec");
            var isNegationOperator = currLineToken.Scopes.Contains("operator.negation.ubytec");
            var isUnsignedRightShift = currLineToken.Scopes.Contains("operator.unsigned-right-shift.ubytec");
            var isUnsignedLeftShift = currLineToken.Scopes.Contains("operator.unsigned-left-shift.ubytec");
            var isLeftShift = currLineToken.Scopes.Contains("operator.left-shift.ubytec");
            var isRightShift = currLineToken.Scopes.Contains("operator.right-shift.ubytec");
            var isAdditionOperator = currLineToken.Scopes.Contains("operator.addition.ubytec");
            var isSubtractionOperator = currLineToken.Scopes.Contains("operator.subtraction.ubytec");
            var isDivisionOperator = currLineToken.Scopes.Contains("operator.division.ubytec");
            var isMultiplicationOperator = currLineToken.Scopes.Contains("operator.multiplication.ubytec");
            var isExponentiationOperator = currLineToken.Scopes.Contains("operator.exponentiation.ubytec");
            var isModuloOperator = currLineToken.Scopes.Contains("operator.modulo.ubytec");
            var isBitwiseAndOperator = currLineToken.Scopes.Contains("operator.bitwise-and.ubytec");
            var isHashOperator = currLineToken.Scopes.Contains("operator.hash.ubytec");
            var isIncrementOperator = currLineToken.Scopes.Contains("operator.increment.ubytec");
            var isDecrementOperator = currLineToken.Scopes.Contains("operator.decrement.ubytec");
            var isLogicalAndOperator = currLineToken.Scopes.Contains("operator.logical-and.ubytec");
            var isLogicalOrOperator = currLineToken.Scopes.Contains("operator.logical-or.ubytec");
            var isOptionalChaining = currLineToken.Scopes.Contains("operator.optional-chaining.ubytec");
            var isPipeOperator = currLineToken.Scopes.Contains("operator.pipe.ubytec");
            var isPipeInOperator = currLineToken.Scopes.Contains("operator.pipe-in.ubytec");
            var isPipeOutOperator = currLineToken.Scopes.Contains("operator.pipe-out.ubytec");
            var isNullableCoalescence = currLineToken.Scopes.Contains("operator.nullable-coalescence.ubytec");
            var isSpreadOperator = currLineToken.Scopes.Contains("operator.spread.ubytec");
            var isSchematizeOperator = currLineToken.Scopes.Contains("operator.schematize.ubytec");
            var isAssignOperator = currLineToken.Scopes.Contains("operator.assign.ubytec");

            // Punctuation
            var isComma = currLineToken.Scopes.Contains("punctuation.comma.ubytec");
            var isKeyValueSeparator = currLineToken.Scopes.Contains("punctuation.separator.key-value.ubytec");
            var isScopeSeparator = currLineToken.Scopes.Contains("punctuation.scope.ubytec");
            var isParentChildSeparator = currLineToken.Scopes.Contains("punctuation.separator.parent-child.ubytec");
            var isSemicolon = currLineToken.Scopes.Contains("punctuation.semicolon.ubytec");
            var isArrow = currLineToken.Scopes.Contains("punctuation.arrow.ubytec");

            // Arguments
            var isArgumentName = currLineToken.Scopes.Contains("entity.name.argument.ubytec");

            // Labels
            var isClassLabel = currLineToken.Scopes.Contains("entity.name.type.class.ubytec");
            var isRecordLabel = currLineToken.Scopes.Contains("entity.name.type.record.ubytec");
            var isStructLabel = currLineToken.Scopes.Contains("entity.name.type.struct.ubytec");
            var isEnumLabel = currLineToken.Scopes.Contains("entity.name.type.enum.ubytec");
            var isInterfaceLabel = currLineToken.Scopes.Contains("entity.name.type.interface.ubytec");
            var isActionLabel = currLineToken.Scopes.Contains("entity.name.type.action.ubytec");
            var isFuncLabel = currLineToken.Scopes.Contains("entity.name.type.func.ubytec");
            var isImplicitVarLabel = currLineToken.Scopes.Contains("entity.name.var.implicit.ubytec");
            var isFieldLabel = currLineToken.Scopes.Contains("entity.name.field.ubytec");
            var isExplicitVarLabel = currLineToken.Scopes.Contains("entity.name.var.explicit.ubytec");

            // Invalid tokens
            var isInvalid = currLineToken.Scopes.Contains("invalid.illegal.ubytec");

            if (isInvalid) throw new IlegalTokenException(0x484834053EA2B37C, $"Invalid token used as operand: {currLineToken.Source}");
            if (isComma) return;
            if (isSemicolon) return;

            // Process numeric, type, comment, and operator tokens using boolean checks
            else if (isNumericBinary)
            {
                // Hexadecimal literal detected (e.g. 0x1A3F)
                var a = Convert.ToInt32(currLineToken.Source, 2);
                instructionAndOperands.Enqueue(a);
            }
            else if (isNumericHex)
            {
                // Hexadecimal literal detected (e.g. 0x1A3F)
                var a = Convert.ToInt32(currLineToken.Source, 16);
                instructionAndOperands.Enqueue(a);
            }
            else if (isNumericFloat || isNumericDouble)
            {
                // Floating-point literal (with a decimal point) detected
                var a = Convert.ToSingle(currLineToken.Source);
                instructionAndOperands.Enqueue(a);
            }
            else if (currLineToken.Source.StartsWith("t_", StringComparison.OrdinalIgnoreCase))
            {
                // Removemos el prefijo "t_" para obtener el nombre del tipo.
                string typeToken = currLineToken.Source[2..];

                // Usamos las flags definidas en el token para determinar si es nullable y/o array.
                // Las condiciones se basan en los scopes ya asignados:
                //   - isSingleNullable, isArrayNullableBoth, isArrayNullableItems indican nullabilidad.
                //   - isArray, isArrayNullableBoth, isArrayNullableArray, isArrayNullableItems indican un array.
                bool isNullable = isSingleNullable || isArrayNullableBoth || isArrayNullableItems;
                bool isArrayType = isArray || isArrayNullableBoth || isArrayNullableArray || isArrayNullableItems;

                // Si por alguna razón el token termina con '?' (y no lo refleja el scope), lo eliminamos.
                if (typeToken.EndsWith('?'))
                    throw new IlegalTokenException(0x6A9283F9FB0248A1,
                        "There was an error processing the type a '?' token was detected, and it does not correspond to a nullable. Did you misspell something?");

                // Intentamos convertir el tipo a un enum de PrimitiveType.
                if (Enum.TryParse(typeToken, true, out PrimitiveType parsedType))
                {
                    // Codificamos la nullabilidad y la condición array en un byte (primer bit para nullable, segundo para array).
                    byte flags = 0;
                    if (isNullable) flags |= 0x01;
                    if (isArrayType) flags |= 0x02;

                    instructionAndOperands.Enqueue((byte)parsedType);
                    instructionAndOperands.Enqueue(flags);
                }
                else
                {
                    // Para tipos personalizados, convertimos cada carácter en un byte.
                    foreach (char c in typeToken)
                        instructionAndOperands.Enqueue((byte)c);

                    // Añadimos el byte de flags al final.
                    byte flags = 0;
                    if (isNullable) flags |= 0x01;
                    if (isArrayType) flags |= 0x02;
                    instructionAndOperands.Enqueue(flags);
                }
            }
            else if (isNumericInt)
            {
                // Integer literal detected
                if (int.TryParse(currLineToken.Source, out int intValue))
                    instructionAndOperands.Enqueue(intValue);
                else if (byte.TryParse(currLineToken.Source, out byte byteValue))
                    instructionAndOperands.Enqueue(byteValue);
                else
                    throw new IlegalTokenException(0xA47A4945647CBC9D, $"Invalid integer constant: {currLineToken.Source}");
            }
            else if (isCommentLineDoubleSlash || isCommentBlock)
            {
                // Skip comments
                return;
            }
            else if (isEqualityOperator || isInequalityOperator ||
                     isLessThanEqualsOperator || isGreaterThanEqualsOperator ||
                     isLessThanOperator || isGreaterThanOperator ||
                     isAdditionOperator || isSubtractionOperator ||
                     isDivisionOperator || isMultiplicationOperator ||
                     isExponentiationOperator || isModuloOperator ||
                     isBitwiseAndOperator || isHashOperator ||
                     isIncrementOperator || isDecrementOperator ||
                     isLogicalAndOperator || isLogicalOrOperator ||
                     isOptionalChaining || isPipeOperator ||
                     isPipeInOperator || isPipeOutOperator ||
                     isNullableCoalescence || isSpreadOperator ||
                     isSchematizeOperator || isAssignOperator)
            {
                // Here we process all other operators.
                // If the operator token is a single character, we enqueue it and pad with 0.
                // If it’s two characters long, we enqueue both characters.
                // For longer operators (if any emerge in the future), we iterate through each character.
                if (currLineToken.Source.Length == 1)
                {
                    instructionAndOperands.Enqueue((byte)currLineToken.Source[0]);
                    instructionAndOperands.Enqueue(0); // Padding for expected two-byte format
                }
                else if (currLineToken.Source.Length == 2)
                {
                    instructionAndOperands.Enqueue((byte)currLineToken.Source[0]);
                    instructionAndOperands.Enqueue((byte)currLineToken.Source[1]);
                }
                else
                {
                    foreach (char c in currLineToken.Source)
                    {
                        instructionAndOperands.Enqueue((byte)c);
                    }
                }
            }
            else
            {
                throw new IlegalTokenException(0xFDDEFC54BA8E0600, $"Invalid operand: {currLineToken}");
            }

        }

        /// <summary>
        /// Inherits variables from a parent opCode (e.g., a block or IF) 
        /// into the child opCode so that they share the same variable context.
        /// </summary>
        /// <param name="parent">The parent opCode holding the variable list.</param>
        /// <param name="child">The child opCode to which the variables will be added.</param>
        private static void InheritVariables(IBlockOpCode? parent, IOpInheritance child)
        {
            if (parent is null || parent!.Variables is null) return;

            // Each block-like opcode has a `List<Variable> Variables` property
            child.Variables?.Syntaxes.AddRange(parent.Variables?.Syntaxes ?? []);
        }
        /// <summary>
        /// Merges the declared variable (from a VAR instruction) into the 
        /// variable list of the current block-like opCode (BLOCK, IF, LOOP, etc.).
        /// Ensures each block maintains a record of variables declared in its scope.
        /// </summary>
        /// <param name="block">The block opCode (e.g., BLOCK, IF, LOOP).</param>
        /// <param name="varOp">The VAR instruction that contains the newly declared variable.</param>
        private static void MergeVariables(IBlockOpCode block, VAR varOp)
        {
            if (block!.Variables is null) return;

            if (block.Variables == null) return;

            block.Variables?.Syntaxes.Add(varOp.Variable);
        }

        /// <summary>
        /// Builds a SyntaxTree from the provided opCodes and tokens. 
        /// Assumes each row of tokens corresponds to one instruction, 
        /// inserting nodes into the tree based on the structure of blocks (BLOCK, IF, ELSE, LOOP, WHILE, etc.).
        /// </summary>
        /// <param name="opCodes">An array of IOpCode objects representing program logic.</param>
        /// <param name="tokens">
        /// An array of SyntaxToken objects containing lexical info (operands, symbols, etc.).
        /// May have more tokens than opCodes due to additional operands.
        /// </param>
        /// <returns>A SyntaxTree that represents the hierarchical arrangement of statements and nodes.</returns>
        public static (SyntaxTree tree, List<CompileSyntaxError> errors) CompileSyntax(IOpCode[] opCodes, SyntaxToken[] tokens)
        {
            // Se crea el árbol raíz con una oración inicial.
            var lastRoot = new SyntaxTree(new SyntaxSentence());
            var errors = new List<CompileSyntaxError>();

            var validTokens = new List<SyntaxToken>();

            foreach (var token in tokens)
            {
                if (string.IsNullOrWhiteSpace(token.Source) || token.Scopes.Length == 0 || token.Scopes.Length == 1 && token.Scopes[0] == "source.ubytec") continue;
                validTokens.Add(token);
            }

            // Agrupamos los tokens por la propiedad "Line" (suponiendo que cada grupo corresponde a una instrucción o línea).
            var group = validTokens
                .GroupBy(t => t.Line);
            var tokensByRow = group
                .OrderBy(g => g.Key)
                .ToDictionary(g => g.Key, g => g.ToList());

            var currentRow = 1;

            foreach (var opCode in opCodes)
            {
                try
                {
                    // Si se encontraron tokens para la fila actual, se usan; si no, se pasa una lista vacía.
                    BuildSyntaxTree(lastRoot, opCode, tokensByRow.TryGetValue(currentRow, out var rowTokens) ? rowTokens : []);
                }
                catch (Exception e)
                {
                    errors.Add(new(currentRow, opCode, "", e));
                }

                currentRow++;
            }

            return (lastRoot, errors);
        }

        public record class CompileSyntaxError
        {
            public int Row { get; init; }
            public IOpCode OpCode { get; init; }
            public string Message { get; init; }
            public Exception? InnerException { get; init; }

            public CompileSyntaxError(int row, IOpCode opCode, string message, Exception? innerException = null)
            {
                Row = row;
                OpCode = opCode;
                Message = message;
                InnerException = innerException;
            }

            public override string ToString()
            {
                return $"[CompileSyntaxError] Row: {Row}, OpCode: {OpCode}, Message: {Message}" +
                       (InnerException != null ? $", InnerException: {InnerException.Message}" : "");
            }
        }


        /// <summary>
        /// Adds a node (opCode) and its associated tokens to the SyntaxTree under construction.
        /// Handles the creation of new sentences (SyntaxSentence) for scopes like BLOCK or IF, 
        /// and places closing nodes (END, RETURN) accordingly.
        /// </summary>
        /// <param name="tree">The SyntaxTree under construction.</param>
        /// <param name="opCode">The current IOpCode instruction to insert.</param>
        /// <param name="tokens">The list of tokens associated with this instruction (usually by row).</param>
        static void BuildSyntaxTree(SyntaxTree tree, IOpCode opCode, List<SyntaxToken> tokens)
        {
            // Se asegura que haya una oración activa.
            if (tree.TreeSentenceStack.Count == 0)
                throw new Exception("The syntax tree has no active sentence.");

            SyntaxSentence currentSentence = tree.TreeSentenceStack.Peek();

            switch (opCode)
            {
                // Para opCodes que abren un nuevo scope, se crea una nueva oración y un nodo contenedor.
                case BLOCK or LOOP or IF or SWITCH or WHILE:
                    {
                        // Se crea un nuevo nodo para el opCode y se asignan todos los tokens correspondientes.
                        var newNode = new SyntaxNode(opCode)
                        {
                            Children = [],
                            Tokens = tokens,
                        };

                        // Se crea una nueva oración para contener los nodos dentro de este scope.
                        var newSentence = new SyntaxSentence()
                        {
                            Nodes = new(),
                            Sentences = [],
                        };

                        string sentenceType = opCode switch
                        {
                            BLOCK => nameof(BLOCK).ToLower(),
                            LOOP => nameof(LOOP).ToLower(),
                            IF => nameof(IF).ToLower(),
                            SWITCH => nameof(SWITCH).ToLower(),
                            WHILE => nameof(WHILE).ToLower(),
                            _ => throw new NotImplementedException(),
                        };
                        newSentence.Metadata.Add("type", sentenceType);

                        // Se agrega la nueva oración como hija de la oración actual.
                        currentSentence.Sentences.Add(newSentence);
                        // En la nueva oración se empuja el nuevo nodo contenedor.
                        newSentence.Nodes.Push(newNode);
                        // Y se empuja la nueva oración a la pila del árbol.
                        tree.TreeSentenceStack.Push(newSentence);
                        break;
                    }
                // Para opCodes que abren un nuevo scope, se crea una nueva oración y un nodo contenedor.
                case ELSE:
                    {
                        SyntaxSentence closedSentence = tree.TreeSentenceStack.Pop();
                        SyntaxSentence parentSentence = tree.TreeSentenceStack.Peek();

                        if (closedSentence.Nodes.Count > 1)
                            closedSentence.Nodes.Pop();

                        var newElseNode = new SyntaxNode(opCode)
                        {
                            Children = [],
                            Tokens = tokens,
                        };

                        // Se crea una nueva oración para contener los nodos dentro de este scope.
                        var newSentence = new SyntaxSentence()
                        {
                            Nodes = new(),
                            Sentences = [],
                        };
                        newSentence.Metadata.Add("type", nameof(ELSE).ToLower());

                        parentSentence.Sentences.Add(newSentence);
                        newSentence.Nodes.Push(newElseNode);
                        tree.TreeSentenceStack.Push(newSentence);
                        break;
                    }
                case BRANCH:
                    {
                        if (tree.TreeSentenceStack.Count < 1)
                            throw new Exception("Unexpected BRANCH without parent SWITCH.");

                        SyntaxSentence branchParent = tree.TreeSentenceStack.Peek();

                        if (!branchParent.Metadata.TryGetValue("type", out var parentType) || parentType?.ToString() != "switch")
                        {
                            throw new Exception("BRANCH must be inside a SWITCH block.");
                        }

                        // No hagas Pop si no es necesario, solo anida correctamente
                        var newBranchNode = new SyntaxNode(opCode)
                        {
                            Children = [],
                            Tokens = tokens,
                        };

                        SyntaxSentence newBranchSentence = new()
                        {
                            Nodes = new(),
                            Sentences = [],
                        };
                        newBranchSentence.Metadata.Add("type", nameof(BRANCH).ToLower());

                        branchParent.Sentences.Add(newBranchSentence);
                        newBranchSentence.Nodes.Push(newBranchNode);
                        tree.TreeSentenceStack.Push(newBranchSentence);

                        break;
                    }
                // Para opCodes que cierran un scope (como END, BREAK o RETURN), se crea un nodo de cierre y se extrae la oración.
                case END or BREAK or RETURN:
                    {
                        SyntaxSentence closedSentence = tree.TreeSentenceStack.Pop();
                        var endNode = new SyntaxNode(opCode)
                        {
                            Tokens = tokens,
                        };

                        // Si el stack de nodos tiene más de un nodo, se descarta el tope para volver al contenedor.
                        if (closedSentence.Nodes.Count > 1)
                            closedSentence.Nodes.Pop();

                        closedSentence.Nodes.Peek().Children?.Add(endNode);
                        break;
                    }
                // Para cualquier otro opCode, se crea un nodo simple y se agrega como hijo del nodo activo.
                default:
                    {
                        var newNode = new SyntaxNode(opCode)
                        {
                            Tokens = tokens,
                        };

                        currentSentence.Nodes.Peek().Children?.Add(newNode);
                        break;
                    }
            }
        }

        /// <summary>
        /// Compiles a SyntaxTree into NASM assembly code. 
        /// Starts by processing the root sentence and recurses through all nested nodes.
        /// </summary>
        /// <param name="tree">The full SyntaxTree to compile.</param>
        /// <returns>A string containing the generated NASM assembly code.</returns>
        public static string CompileAST(SyntaxTree tree) => CompileSentence(tree.RootSentence.Sentences.First(), new CompilationScopes());
        /// <summary>
        /// Compiles a specific SyntaxSentence into NASM assembly, 
        /// handling nested statements recursively.
        /// </summary>
        /// <param name="sentence">The SyntaxSentence to compile.</param>
        /// <param name="stacks">Auxiliary stacks used for scope control or type checking, if applicable.</param>
        /// <returns>A string fragment with the NASM code for that sentence.</returns>
        private static string CompileSentence(SyntaxSentence sentence, CompilationScopes scopes)
        {
            var output = new StringBuilder();

            // Si hay nodos, asumimos que el primero representa la estructura (apertura + cierre)
            if (sentence.Nodes != null && sentence.Nodes.Count > 0)
            {
                // Usamos Peek() para no alterar la pila
                var node = sentence.Nodes.Peek();
                output.Append(CompileBlockNode(sentence, node, scopes));
            }
            // Si no hay nodos, simplemente compilamos las oraciones anidadas (si las hubiera)
            else if (sentence.Sentences != null)
            {
                foreach (var childSentence in sentence.Sentences)
                    output.Append(CompileSentence(childSentence, scopes));
            }

            // Filtramos las líneas vacías o con solo espacios/tabs
            var cleaned = string.Join(
                Environment.NewLine,
                output.ToString()
                      .Split(["\r\n", "\r", "\n"], StringSplitOptions.None)
                      .Where(line => !string.IsNullOrWhiteSpace(line))
            );

            return cleaned;

        }
        /// <summary>
        /// Compiles a block node (e.g., IF with an END, a BLOCK with its END) and 
        /// its children into NASM format, respecting indentation and any generated labels.
        /// </summary>
        /// <param name="sentence">The SyntaxSentence containing this node.</param>
        /// <param name="node">The SyntaxNode holding the operation (BLOCK, IF, ELSE, etc.).</param>
        /// <param name="stacks">Environment stacks used for scope control or validation.</param>
        /// <returns>The resulting NASM code for opening, populating, and closing this block.</returns>
        private static string CompileBlockNode(SyntaxSentence sentence, SyntaxNode node, CompilationScopes scopes)
        {
            var code = new StringBuilder();

            var initialDepth = GetDepth();
            node.Metadata.Add("initialDepth", initialDepth);
            var depth = node.Operation is ELSE ? GetDepth(-1) : initialDepth;
            node.Metadata.Add("depth", depth);

            // Compilamos la operación de apertura
            if (node.Operation != null)
            {
                var compiled = node.Operation.Compile(scopes);
                code.AppendLine(FormatCompiledLines(compiled, depth));
            }

            // Compilamos el cuerpo del bloque: las sentencias anidadas se insertan justo aquí
            if (sentence.Sentences != null)
                foreach (var childSentence in sentence.Sentences)
                {
                    var compiled = CompileSentence(childSentence, scopes);
                    code.Append(FormatCompiledLines(compiled, string.Empty));
                }


            if (node.Children == null || node.Children.Count == 0)
                return code.ToString();

            // Seleccionamos el nodo de cierre y lo eliminamos de los hijos
            var closingNode = node.Children.Last();
            var nodeActions = node.Children.GetRange(0, node.Children.Count - 1);

            foreach (var n in nodeActions)
                if (n.Operation != null)
                {
                    var compiled = n.Operation.Compile(scopes);
                    code.AppendLine(FormatCompiledLines(compiled, GetDepth()));
                }


            // Finalmente, compilamos la operación de cierre, que asumimos es el último hijo del nodo
            if (closingNode.Operation != null)
            {
                var compiled = closingNode.Operation.Compile(scopes);
                code.AppendLine(FormatCompiledLines(compiled, GetDepth()));
            }

            return code.ToString();

            string GetDepth(int basis = 0)
            {
                var output = string.Empty;
                var depth = scopes.Count + basis;
                for (int i = 0; i < depth; i++)
                    output += "  ";
                return output;
            }

            string FormatCompiledLines(string? lines, string depth)
            {
                var f_0x00 = string.Empty;
                foreach (var l_0x00 in lines?.Split('\n', StringSplitOptions.RemoveEmptyEntries) ?? [])
                    f_0x00 += depth + l_0x00 + '\n';
                return f_0x00;
            }
        }
    }
}
