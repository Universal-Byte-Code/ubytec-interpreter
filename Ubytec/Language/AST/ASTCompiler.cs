using NJsonSchema;
using System.Numerics;
using System.Text;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Operations.ArithmeticOperations;
using static Ubytec.Language.Operations.BitwiseOperations;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Operations.StackOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.AST
{
    /// <summary>
    /// Provides methods to parse Ubytec source tokens into low-level opcodes,
    /// build a hierarchical abstract syntax tree (<see cref="SyntaxTree"/>),
    /// and emit NASM assembly code from that tree.
    /// </summary>
    /// <remarks>
    /// The <see cref="ASTCompiler"/> is split across partial definitions:
    /// - Parsing and opcode generation (<see cref="Parse"/>).
    /// - Syntax tree construction (<see cref="CompileSyntax"/> and <see cref="BuildSyntaxTree"/>).
    /// - Assembly code emission (<see cref="CompileAST"/>, <see cref="CompileSentence"/>, <see cref="CompileBlockNode"/>).
    /// Errors encountered during tree construction are captured in <see cref="CompileSyntaxError"/> records.
    /// </remarks>
    public static partial class ASTCompiler
    {
        /// <summary>
        /// Maps each opcode name to its corresponding byte value for instruction encoding.
        /// </summary>
        /// <remarks>
        /// The keys are the string names of the operations (e.g., <c>nameof(TRAP)</c>, <c>"EQ"</c>),
        /// and the values are the byte codes used in the Ubytec instruction set.
        /// </remarks>
        private static readonly Dictionary<string, byte> OpcodeMap = new()
        {
            // Control Flow
            { nameof(TRAP),    TRAP.OP },
            { nameof(NOP),     NOP.OP },
            { nameof(BLOCK),   BLOCK.OP },
            { nameof(LOOP),    LOOP.OP },
            { nameof(IF),      IF.OP },
            { nameof(ELSE),    ELSE.OP },
            { nameof(END),     END.OP },
            { nameof(BREAK),   BREAK.OP },
            { nameof(CONTINUE),CONTINUE.OP },
            { nameof(RETURN),  RETURN.OP },
            { nameof(BRANCH),  BRANCH.OP },
            { nameof(SWITCH),  SWITCH.OP },
            { nameof(WHILE),   WHILE.OP },
            { nameof(CLEAR),   CLEAR.OP },
            { nameof(DEFAULT), DEFAULT.OP },
            { nameof(NULL),    NULL.OP },
        
            // Inline var
            { nameof(VAR),     0x10 },
        
            // Stack Manipulation
            { nameof(PUSH),    0x11 },
            { nameof(POP),     0x12 },
            { nameof(DUP),     0x13 },
            { nameof(SWAP),    0x14 },
            { nameof(ROT),     0x15 },
            { nameof(OVER),    0x16 },
            { nameof(NIP),     0x17 },
            { nameof(DROP),    0x18 },
            { nameof(TwoDUP),  0x19 },
            { nameof(TwoSWAP), 0x1A },
            { nameof(TwoROT),  0x1B },
            { nameof(TwoOVER), 0x1C },
            { nameof(PICK),    0x1D },
            { nameof(ROLL),    0x1E },
        
            // Arithmetic Operations
            { nameof(ADD),     0x20 },
            { nameof(SUB),     0x21 },
            { nameof(MUL),     0x22 },
            { nameof(DIV),     0x23 },
            { nameof(MOD),     0x24 },
            { nameof(INC),     0x25 },
            { nameof(DEC),     0x26 },
            { nameof(NEG),     0x27 },
            { nameof(ABS),     0x28 },
        
            // Logical Operations
            { nameof(AND),     0x30 },
            { nameof(OR),      0x31 },
            { nameof(XOR),     0x32 },
            { nameof(NOT),     0x33 },
            { nameof(SHL),     0x34 },
            { nameof(SHR),     0x35 },
        
            // Comparisons
            { "EQ",            0x40 },
            { "NEQ",           0x41 },
            { "LT",            0x42 },
            { "LE",            0x43 },
            { "GT",            0x44 },
            { "GE",            0x45 },
        
            // Memory Operations (Optional)
            { "LOAD",          0x50 },
            { "STORE",         0x51 }
        };

        /// <summary>
        /// Parses a sequence of <see cref="SyntaxToken"/> instances into low-level <see cref="IOpCode"/> instructions.
        /// <para>Tokenizes each source line, builds opcodes, and manages nested block structures
        /// (e.g., BLOCK, IF, ELSE, LOOP, WHILE, SWITCH) using a stack-based approach.</para>
        /// </summary>
        /// <param name="code">
        /// An array of <see cref="SyntaxToken"/> objects containing the lexical tokens for each source line.
        /// </param>
        /// <returns>
        /// An array of <see cref="IOpCode"/> representing the parsed instructions,
        /// with block contexts correctly nested.
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

                if (string.IsNullOrWhiteSpace(currToken.Source) || currToken.Scopes.Length == 0 || currToken.Scopes.Length == 1 && currToken.Scopes.Helper.IsSource) continue;

                var currLineIndex = currToken.Line;
                var currLine = new List<SyntaxToken>();

                for (int i = y; i < code.Length && code[i].Line == currLineIndex; i++)
                {
                    if (!string.IsNullOrWhiteSpace(code[i].Source) || code[i].Scopes.Length == 0)
                        currLine.Add(code[i]);

                    if (i != y && currLine.Count > 0) y++;
                }

                if (currToken.Scopes.Helper.IsStorageType)
                {
                    var labelToken = currLine[1];
                    var valueToken = currLine[2];

                    var typeModifiers = TypeModifiers.None;

                    // Determinar si es array y/o nullable según scope
                    if (currToken.Scopes.Helper.IsArrayNullableBoth)
                        typeModifiers |= TypeModifiers.Nullable | TypeModifiers.IsArray | TypeModifiers.NullableItems | TypeModifiers.NullableArray;
                    else if (currToken.Scopes.Helper.IsArrayNullableArray)
                        typeModifiers |= TypeModifiers.IsArray | TypeModifiers.NullableArray;
                    else if (currToken.Scopes.Helper.IsArrayNullableItems)
                        typeModifiers |= TypeModifiers.IsArray | TypeModifiers.NullableItems;
                    else if (currToken.Scopes.Helper.IsSingleNullable)
                        typeModifiers |= TypeModifiers.Nullable;
                    else if (currToken.Scopes.Helper.IsArray)
                        typeModifiers |= TypeModifiers.IsArray;

                    // Determinar modificadores adicionales desde scopes
                    foreach (var scope in currLine.SelectMany(t => t.Scopes.DataSource))
                    {
                        if (!scope.StartsWith("storage.modifier.")) continue;
                        var keyword = currLine.First(t => t.Scopes.DataSource.Contains(scope)).Source.ToLowerInvariant();

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

                    var ubytecType = new UType(
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
                        if (string.IsNullOrWhiteSpace(currLineToken.Source) || currLineToken.Scopes.Length == 0 || currLineToken.Scopes.Length == 1 && currLineToken.Scopes.Helper.IsSource) continue;

                        //if (currLineToken.Source.StartsWith("@", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    var trimmed = currLineToken.Source.Remove(0, 1);
                        //    foreach (VAR variableOp in opCodes.Where(t => t.OpCode == OpcodeMap[nameof(VAR)]).Select(v => (VAR)v))
                        //        if (variableOp.Variable.Name == trimmed)
                        //            ProcessOperand(
                        //                new SyntaxToken(variableOp.Variable.Value?.ToString() ?? string.Empty, currLineToken.Line, currLineToken.StartColumn + 1, currLineToken.EndColumn, [.. currLineToken.Scopes, "entity.name.var.reference.ubytec"]),
                        //                instructionAndOperands);
                        //}
                        //else

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
                    IOpCode op = OpcodeFactory.Create(dequedByteCode, [], [.. currLine], [.. instructionAndOperands]);
                    // Now handle special constructs:
                    switch (op)
                    {
                        case BLOCK:
                        case IF:
                        case LOOP:
                        case WHILE:
                        case SWITCH:
                            {
                                var blockOp = (IBlockOpCode)op;
                                InheritVariables(currentBlock, blockOp);
                                blockStack.Push(blockOp);
                                break;
                            }
                        case ELSE:
                            {
                                if (blockStack.Count > 0 && blockStack.Peek() is IF ifOp)
                                {
                                    blockStack.Pop();
                                    currentBlock = blockStack.Count > 0 ? blockStack.Peek() : null;
                                }

                                var elseOp = (ELSE)op;
                                InheritVariables(currentBlock, elseOp);
                                blockStack.Push(elseOp);
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
                                var branchOp = (BRANCH)op;
                                InheritVariables(currentBlock, branchOp);
                                blockStack.Push(branchOp);
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
        /// Processes a single operand token, classifying it (numeric literal, type token, operator, etc.)
        /// and enqueues the corresponding value(s) into the instruction operand queue.
        /// </summary>
        /// <param name="token">
        /// The <see cref="SyntaxToken"/> representing the operand to process
        /// (with source text and scope metadata).
        /// </param>
        /// <param name="instructionAndOperands">
        /// A <see cref="Queue{ValueType}"/> into which parsed operand values are enqueued
        /// for subsequent opcode creation.
        /// </param>
        /// <exception cref="IlegalTokenException">
        /// Thrown if the token is recognized as an illegal or invalid operand (e.g., unsupported symbol).
        /// </exception>
        /// <exception cref="SyntaxException">
        /// Thrown if an error occurs during parsing of a valid token scope (e.g., invalid numeric format).
        /// </exception>
        private static void ProcessOperand(SyntaxToken token, Queue<ValueType> instructionAndOperands)
        {
            if (token.Scopes.Helper.IsInvalid) throw new IlegalTokenException(0x484834053EA2B37C, $"Invalid token used as operand: {token.Source}");
            if (token.Scopes.Helper.IsComma || token.Scopes.Helper.IsArrow || token.Scopes.Helper.IsSemicolon || token.Scopes.Helper.IsParentChildSeparator || token.Scopes.Helper.IsScopeSeparator || token.Scopes.Helper.IsKeyValueSeparator) return;
            if (token.Scopes.Helper.IsModifier) return;
            if (token.Scopes.Helper.IsClassLabel || token.Scopes.Helper.IsRecordLabel || token.Scopes.Helper.IsStructLabel || token.Scopes.Helper.IsEnumLabel || token.Scopes.Helper.IsInterfaceLabel || token.Scopes.Helper.IsActionLabel || token.Scopes.Helper.IsFuncLabel || token.Scopes.Helper.IsImplicitVarLabel || token.Scopes.Helper.IsFieldLabel || token.Scopes.Helper.IsExplicitVarLabel) return;
            if (token.Scopes.Helper.IsCommentLineDoubleSlash || token.Scopes.Helper.IsCommentBlock) return;

            else if (token.Scopes.Helper.IsDoubleQuotedString)
            {
                // Doble comilla → cadena normal.
                string rawValue = token.Source;

                // Quita comillas si las incluye el token
                if (rawValue.StartsWith('\"') && rawValue.EndsWith('\"'))
                    rawValue = rawValue[1..^1];

                byte[] stringBytes = Encoding.UTF8.GetBytes(rawValue);

                // Encola longitud como un byte (útil para lectura posterior)
                instructionAndOperands.Enqueue((byte)stringBytes.Length);

                // Encola cada byte del contenido de la cadena
                foreach (var b in stringBytes)
                    instructionAndOperands.Enqueue(b);

                Console.WriteLine($"Double-quoted string processed: \"{rawValue}\" → {stringBytes.Length} bytes");
            }
            else if (token.Scopes.Helper.IsSingleQuotedString)
            {
                // Comilla simple → un solo carácter.
                string rawValue = token.Source;

                if (rawValue.StartsWith('\'') && rawValue.EndsWith('\''))
                    rawValue = rawValue[1..^1];

                if (rawValue.Length != 1)
                    throw new IlegalTokenException(0xA13C42D9FF10A93D,
                        $"Single-quoted literal should contain exactly one character, got \"{rawValue}\"");

                // Convertimos el único carácter a byte UTF-8
                byte charByte = Encoding.UTF8.GetBytes(rawValue)[0];
                instructionAndOperands.Enqueue(charByte);

                Console.WriteLine($"Single-quoted char processed: '{rawValue}' → 0x{charByte:X2}");
            }
            else if (token.Scopes.Helper.IsBooleanConstant)
            {
                byte boolByte = 0;

                boolByte |= token.Source.Equals("true", StringComparison.OrdinalIgnoreCase) ? (byte)1 : (byte)0;

                // Boolean literal detected (true/false)
                instructionAndOperands.Enqueue(boolByte);
            }
            // Process numeric, type, comment, and operator tokens using boolean checks
            else if (token.Scopes.Helper.IsNumericBinary)
            {
                // Hexadecimal literal detected (e.g. 0x1A3F)
                var a = Convert.ToByte(token.Source, 2);
                instructionAndOperands.Enqueue(a);
            }
            else if (token.Scopes.Helper.IsNumericHex)
            {
                // Hexadecimal literal detected (e.g. 0x1A3F)
                var a = Convert.ToInt32(token.Source, 16);
                instructionAndOperands.Enqueue(a);
            }
            else if (token.Scopes.Helper.IsNumericFloat)
            {
                // Floating-point literal (with a decimal point) detected
                var a = Convert.ToSingle(token.Source);
                instructionAndOperands.Enqueue(a);
            }
            else if (token.Scopes.Helper.IsNumericDouble)
            {
                var a = Convert.ToDouble(token.Source);
                instructionAndOperands.Enqueue(a);
            }
            else if (token.Scopes.Helper.IsNumericInt)
            {
                if (short.TryParse(token.Source, out short shortValue))
                {
                    instructionAndOperands.Enqueue(shortValue);
                }
                else if (int.TryParse(token.Source, out int intValue))
                {
                    instructionAndOperands.Enqueue(intValue);
                }
                else if (long.TryParse(token.Source, out long longValue))
                {
                    instructionAndOperands.Enqueue(longValue);
                }
                else if (BigInteger.TryParse(token.Source, out BigInteger bigIntValue))
                {
                    instructionAndOperands.Enqueue(bigIntValue);
                }
                else
                {
                    throw new SyntaxException(0xD7D2BB3DFE8411EA, $"Invalid integer format: {token.Source}");
                }
            }
            else if (token.Source.StartsWith("t_", StringComparison.OrdinalIgnoreCase))
            {
                // Removemos el prefijo "t_" para obtener el nombre del tipo.
                string typeToken = token.Source[2..];

                // Si por alguna razón el token termina con '?' (y no lo refleja el scope)
                if (typeToken.EndsWith('?'))
                    throw new IlegalTokenException(0x6A9283F9FB0248A1,
                        "There was an error processing the type a '?' token was detected, and it does not correspond to a nullable. Did you misspell something?");

                TypeModifiers flags = TypeModifiers.None;

                // Bit 0 (0x0001): nullable simple  (int?)
                if (token.Scopes.Helper.IsSingleNullable) flags |= TypeModifiers.Nullable;       // 00000001

                // Bit 1 (0x0002) + Bit 2 (0x0004): array nullable completo ( [T]? )
                if (token.Scopes.Helper.IsArrayNullableBoth) flags |= TypeModifiers.NullableArray | TypeModifiers.NullableItems;    // 00000010

                // Bit 2 (0x0004): array nullable ( [T]? )
                if (token.Scopes.Helper.IsArrayNullableArray) flags |= TypeModifiers.NullableArray;   // 00000100

                // Bit 3 (0x0008): ítems nullables ( [T?] )
                if (token.Scopes.Helper.IsArrayNullableItems) flags |= TypeModifiers.NullableItems;   // 00001000

                // Bit 1 (0x0002) *solo* para “es array” sin nullabilidad adicional
                if (token.Scopes.Helper.IsArray) flags |= TypeModifiers.IsArray;                // 00010000

                if (token.Scopes.Helper.IsModifier)
                {
                    switch (token.Source.ToLowerInvariant())
                    {
                        // Access
                        case "public": flags |= TypeModifiers.Public; break;
                        case "private": flags |= TypeModifiers.Private; break; // Bit 5  (0x0020)
                        case "protected": flags |= TypeModifiers.Protected; break; // Bit 6  (0x0040)
                        case "internal": flags |= TypeModifiers.Internal; break; // Bit 7  (0x0080)
                        case "secret": flags |= TypeModifiers.Secret; break; // Bit 8  (0x0100)

                        // Mutabilidad
                        case "const": flags |= TypeModifiers.Const; break; // Bit 9  (0x0200)
                        case "readonly": flags |= TypeModifiers.ReadOnly; break; // Bit 10 (0x0400)

                        // Comportamiento
                        case "abstract": flags |= TypeModifiers.Abstract; break; // Bit 11 (0x0800)
                        case "virtual": flags |= TypeModifiers.Virtual; break; // Bit 12 (0x1000)
                        case "override": flags |= TypeModifiers.Override; break; // Bit 13 (0x2000)
                        case "sealed": flags |= TypeModifiers.Sealed; break; // Bit 14 (0x4000)

                        // Ámbito
                        case "local": flags |= TypeModifiers.Local; break; // Bit 15 (0x8000)
                        case "global": flags |= TypeModifiers.Global; break; // Bit 16 (0x10000)
                    }
                }

                // Intentamos convertir el tipo a un enum de PrimitiveType.
                if (Enum.TryParse(typeToken, true, out PrimitiveType parsedType))
                    instructionAndOperands.Enqueue(parsedType);
                else // Para tipos personalizados, convertimos cada carácter en un byte.
                    foreach (char c in typeToken)
                        instructionAndOperands.Enqueue(c);
                instructionAndOperands.Enqueue(flags);
            }
            else if (token.Scopes.Helper.IsEqualityOperator || token.Scopes.Helper.IsInequalityOperator ||
                     token.Scopes.Helper.IsLessThanEqualsOperator || token.Scopes.Helper.IsGreaterThanEqualsOperator ||
                     token.Scopes.Helper.IsLessThanOperator || token.Scopes.Helper.IsGreaterThanOperator ||
                     token.Scopes.Helper.IsAdditionOperator || token.Scopes.Helper.IsSubtractionOperator ||
                     token.Scopes.Helper.IsDivisionOperator || token.Scopes.Helper.IsMultiplicationOperator ||
                     token.Scopes.Helper.IsExponentiationOperator || token.Scopes.Helper.IsModuloOperator ||
                     token.Scopes.Helper.IsBitwiseAndOperator || token.Scopes.Helper.IsHashOperator ||
                     token.Scopes.Helper.IsIncrementOperator || token.Scopes.Helper.IsDecrementOperator ||
                     token.Scopes.Helper.IsLogicalAndOperator || token.Scopes.Helper.IsLogicalOrOperator ||
                     token.Scopes.Helper.IsOptionalChaining || token.Scopes.Helper.IsPipeOperator ||
                     token.Scopes.Helper.IsPipeInOperator || token.Scopes.Helper.IsPipeOutOperator ||
                     token.Scopes.Helper.IsNullableCoalescence || token.Scopes.Helper.IsSpreadOperator ||
                     token.Scopes.Helper.IsSchematizeOperator || token.Scopes.Helper.IsAssignOperator)
            {
                // Here we process all other operators.
                // If the operator token is a single character, we enqueue it and pad with 0.
                // If it’s two characters long, we enqueue both characters.
                // For longer operators (if any emerge in the future), we iterate through each character.
                if (token.Source.Length == 1)
                {
                    instructionAndOperands.Enqueue(token.Source[0]);
                    instructionAndOperands.Enqueue(0); // Padding for expected two-byte format
                }
                else if (token.Source.Length == 2)
                {
                    instructionAndOperands.Enqueue(token.Source[0]);
                    instructionAndOperands.Enqueue(token.Source[1]);
                }
                else
                {
                    foreach (char c in token.Source)
                        instructionAndOperands.Enqueue(c);
                }
            }
            else
            {
                throw new IlegalTokenException(0xFDDEFC54BA8E0600, $"Invalid operand: {token}");
            }

        }

        /// <summary>
        /// Inherits variables from a parent opCode (e.g., a block or IF) 
        /// into the child opCode so that they share the same variable context.
        /// </summary>
        /// <param name="parent">The parent opCode holding the variable list.</param>
        /// <param name="child">The child opCode to which the variables will be added.</param>
        private static void InheritVariables(IOpVariableScope? parent, IOpVariableScope child)
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
        /// Builds a <see cref="SyntaxTree"/> from the provided opCodes and tokens.
        /// <para>Assumes each row of tokens corresponds to one instruction and groups tokens by their line number.</para>
        /// <para>Inserts nodes into the tree based on the structure of block-level opCodes
        /// (e.g., BLOCK, IF, ELSE, LOOP, WHILE, SWITCH).</para>
        /// </summary>
        /// <param name="opCodes">
        /// An array of <see cref="IOpCode"/> instances representing the parsed instructions.
        /// </param>
        /// <param name="tokens">
        /// An array of <see cref="SyntaxToken"/> objects containing lexical details
        /// (operands, symbols, etc.). May include more tokens than opCodes due to extra operands.
        /// </param>
        /// <returns>
        /// A tuple of:
        /// - <see cref="SyntaxTree"/>: the root of the constructed abstract syntax tree.
        /// - <see cref="List{CompileSyntaxError}"/>: a list of errors encountered during tree building.
        /// </returns>
        public static (SyntaxTree tree, List<CompileSyntaxError> errors) CompileSyntax(IOpCode[] opCodes, SyntaxToken[] tokens)
        {
            // Se crea el árbol raíz con una oración inicial.
            var lastRoot = new SyntaxTree(new SyntaxSentence());
            var errors = new List<CompileSyntaxError>();

            var validTokens = new List<SyntaxToken>();

            foreach (var token in tokens)
            {
                if (string.IsNullOrWhiteSpace(token.Source) || token.Scopes.Length == 0 || token.Scopes.Length == 1 && token.Scopes.Helper.IsSource) continue;
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

        /// <summary>
        /// Adds a node for the given <paramref name="opCode"/> and its associated <paramref name="tokens"/>
        /// to the <see cref="SyntaxTree"/> under construction.
        /// <para>Handles entering new block scopes (BLOCK, IF, ELSE, LOOP, WHILE, SWITCH) by creating
        /// new <see cref="SyntaxSentence"/> instances, and closes scopes (END, BREAK, RETURN) by
        /// popping sentences and attaching end nodes.</para>
        /// </summary>
        /// <param name="tree">
        /// The <see cref="SyntaxTree"/> currently being built; its <see cref="SyntaxTree.TreeSentenceStack"/>
        /// must contain at least one active <see cref="SyntaxSentence"/>.
        /// </param>
        /// <param name="opCode">
        /// The <see cref="IOpCode"/> instruction to insert into the tree.
        /// May open a new scope, close an existing scope, or be added as a child of the current node.
        /// </param>
        /// <param name="tokens">
        /// The list of <see cref="SyntaxToken"/> instances associated with this instruction,
        /// typically grouped by their source-line number.
        /// </param>
        /// <exception cref="Exception">
        /// Thrown if <paramref name="tree"/> has no active sentence to attach to,
        /// or if a BRANCH appears without a surrounding SWITCH, or if an unsupported scope type is encountered.
        /// </exception>
        /// <exception cref="NotImplementedException">
        /// Thrown if a scope-opening <paramref name="opCode"/> other than BLOCK, LOOP, IF, SWITCH, or WHILE
        /// is encountered when determining the sentence type.
        /// </exception>
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
        /// Compiles the given <see cref="SyntaxTree"/> into NASM assembly code.
        /// <para>Begins with the first sentence under the root and recursively processes
        /// all nested sentences and nodes.</para>
        /// </summary>
        /// <param name="tree">
        /// The fully constructed <see cref="SyntaxTree"/> whose root sentence will be compiled.
        /// </param>
        /// <returns>
        /// A <see cref="string"/> containing the resulting NASM assembly code.
        /// </returns>
        public static string CompileAST(SyntaxTree tree) => CompileSentence(tree.RootSentence.Sentences.First(), new CompilationScopes());

        /// <summary>
        /// Recursively compiles a <see cref="SyntaxSentence"/> into NASM assembly code,
        /// processing any nested sentences and nodes within it.
        /// </summary>
        /// <param name="sentence">
        /// The <see cref="SyntaxSentence"/> to compile.
        /// </param>
        /// <param name="scopes">
        /// The <see cref="CompilationScopes"/> used to manage indentation and control-flow context.
        /// </param>
        /// <returns>
        /// A <see cref="string"/> fragment containing the NASM assembly code for the given sentence.
        /// </returns>
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
        /// Compiles a block-level <see cref="SyntaxNode"/> (e.g., BLOCK, IF, ELSE, LOOP, WHILE)
        /// along with its opening, nested sentences, and closing operations into NASM assembly,
        /// applying proper indentation and handling generated labels.
        /// </summary>
        /// <param name="sentence">
        /// The <see cref="SyntaxSentence"/> containing the block’s child sentences to compile.
        /// </param>
        /// <param name="node">
        /// The <see cref="SyntaxNode"/> representing the block opcode to compile
        /// (including its metadata and any pre-collected children nodes).
        /// </param>
        /// <param name="scopes">
        /// The <see cref="CompilationScopes"/> instance used to manage indentation levels
        /// and control-flow context during code generation.
        /// </param>
        /// <returns>
        /// A <see cref="string"/> containing the NASM assembly code for the block’s opening opcode,
        /// its nested content, and the closing opcode.
        /// </returns>
        private static string CompileBlockNode(SyntaxSentence sentence, SyntaxNode node, CompilationScopes scopes)
        {
            var code = new StringBuilder();

            var initialDepth = GetDepth();
            node.Metadata.Add("initialDepth", initialDepth);
            var depth = node.Entity is ELSE ? GetDepth(-1) : initialDepth;
            node.Metadata.Add("depth", depth);

            // Compilamos la operación de apertura
            if (node.Entity != null)
            {
                var compiled = node.Entity.Compile(scopes);
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
                if (n.Entity != null)
                {
                    var compiled = n.Entity.Compile(scopes);
                    code.AppendLine(FormatCompiledLines(compiled, GetDepth()));
                }


            // Finalmente, compilamos la operación de cierre, que asumimos es el último hijo del nodo
            if (closingNode.Entity != null)
            {
                var compiled = closingNode.Entity.Compile(scopes);
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
