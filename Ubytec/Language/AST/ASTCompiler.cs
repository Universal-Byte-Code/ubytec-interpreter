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
        private static readonly Dictionary<string, byte> OpcodeMap = new(StringComparer.OrdinalIgnoreCase)
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
        
            { "UDIV", 0x29 },
            { "UMOD", 0x2A },
            { "LSHR", 0x36 },
            { "ULT", 0x46 },
            { "ULE", 0x47 },
            { "UGT", 0x48 },
            { "UGE", 0x49 },

            // Memory Operations (Optional)
            { "LOAD",          0x50 },
            { "STORE",         0x51 },
            { "PUSH16",        0xFF },
            { "DROP16",        0xFF },
            { "PICK16",        0xFF },
            { "ROLL16",        0xFF },
            { "CALL",          FunctionOperations.CALL.OP },
            { "FNADDR",        FunctionOperations.FNADDR.OP },
            { "CALLI",         FunctionOperations.CALLI.OP },
            { "2DUP",          TwoDUP.OP },
            { "2SWAP",         TwoSWAP.OP },
            { "2ROT",          TwoROT.OP },
            { "2OVER",         TwoOVER.OP }
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

                if (string.IsNullOrWhiteSpace(currToken.Source) || currToken.Scopes.DataSource.Any(s => s.StartsWith("comment.")) || currToken.Source == ";") continue;

                var currLineIndex = currToken.Line;
                var currLine = new List<SyntaxToken>();

                int lineEnd = y;
                while (lineEnd < code.Length && code[lineEnd].Line == currLineIndex)
                {
                    var token = code[lineEnd++];
                    if (!string.IsNullOrWhiteSpace(token.Source) && token.Source != ";" &&
                        !token.Scopes.DataSource.Any(s => s.StartsWith("comment.")))
                        currLine.Add(token);
                }
                y = lineEnd - 1;
                // TextMate separates unary signs from decimal literals.
                for (int i = 1; i + 1 < currLine.Count; i++)
                {
                    if (currLine[i].Source is not ("-" or "+") || !currLine[i + 1].Scopes.Helper.IsNumericInt) continue;
                    var sign = currLine[i];
                    var number = currLine[i + 1];
                    currLine[i] = new SyntaxToken(sign.Source + number.Source, sign.Line,
                        sign.StartColumn, number.EndColumn, [.. number.Scopes.DataSource]);
                    currLine.RemoveAt(i + 1);
                }

                if (currToken.Scopes.Helper.IsStorageType)
                {
                    var labelToken = currLine[1];
                    if (currLine.Count is < 2 or > 3)
                        throw new SyntaxException(0xBAD06A, "Variable declaration expects a type, name, and optional initializer.");
                    var valueToken = currLine.Count == 3 ? currLine[2] : null;

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

                    var variableFragment = new VariableExpressionFragment(ubytecType, labelToken.Source, valueToken?.Source)
                    {
                        Tokens = [.. currLine]
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
                    if (byteCode == 0xFF)
                    {
                        instructionAndOperands.Enqueue((byte)0x10);
                        instructionAndOperands.Enqueue(currToken.Source.ToUpperInvariant() switch
                        {
                            "PUSH16" => (byte)0x11,
                            "DROP16" => (byte)0x18,
                            "PICK16" => (byte)0x1D,
                            "ROLL16" => (byte)0x1E,
                            _ => throw new InvalidOperationException("Unknown extended instruction.")
                        });
                    }

                    bool namedInstruction = ((byteCode == IF.OP || byteCode == WHILE.OP) && currLine.Any(t => t.Source is "==" or "!=" or "<" or "<=" or ">" or ">=")) || byteCode == FunctionOperations.CALL.OP || byteCode == FunctionOperations.FNADDR.OP ||
                        ((byteCode == MemoryOperations.LOAD.OP || byteCode == MemoryOperations.STORE.OP) &&
                            currLine.Count > 1 && !currLine[1].Source.StartsWith("t_", StringComparison.OrdinalIgnoreCase) && !currLine[1].Scopes.DataSource.Any(s => s.StartsWith("constant.")));

                    // Symbolic instructions keep their names in tokens; numeric instructions use operands.
                    for (int i = 1; !namedInstruction && i < currLine.Count; i++)
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
                                // Data operations do not change the structured block stack.
                                break;
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

        /// <summary>Builds an ordered tree without moving statements ahead of nested blocks.</summary>
        public static (SyntaxTree tree, List<CompileSyntaxError> errors) CompileSyntax(IOpCode[] opCodes, SyntaxToken[] tokens)
        {
            var root = new SyntaxSentence();
            var container = new SyntaxNode((IOpCode?)null) { Children = [] };
            root.Nodes.Push(container);
            var tree = new SyntaxTree(root);
            var active = new Stack<SyntaxNode>();
            active.Push(container);
            var elseSeen = new HashSet<SyntaxNode>();
            var errors = new List<CompileSyntaxError>();
            var rows = tokens.Where(t => !string.IsNullOrWhiteSpace(t.Source) &&
                    !t.Scopes.DataSource.Any(s => s.StartsWith("comment.")))
                .GroupBy(t => t.Line).OrderBy(x => x.Key).ToArray();

            for (int i = 0; i < opCodes.Length; i++)
            {
                var op = opCodes[i];
                int row = i < rows.Length ? rows[i].Key : i + 1;
                var node = new SyntaxNode(op) { Children = [], Tokens = i < rows.Length ? rows[i].ToList() : [] };
                if (op is END)
                {
                    if (active.Count == 1)
                    {
                        errors.Add(new(row, op, "END has no matching block."));
                        continue;
                    }
                    active.Peek().Children!.Add(node);
                    active.Pop();
                    continue;
                }
                if (op is ELSE)
                {
                    if (active.Peek().Entity is not IF || !elseSeen.Add(active.Peek()))
                    {
                        errors.Add(new(row, op, "ELSE requires an open IF without another ELSE."));
                        continue;
                    }
                }
                active.Peek().Children!.Add(node);
                if (op is IBlockOpCode && op is not ELSE)
                    active.Push(node);
            }
            while (active.Count > 1)
            {
                var unclosed = active.Pop();
                errors.Add(new(unclosed.Tokens?.FirstOrDefault()?.Line ?? 0,
                    (IOpCode)unclosed.Entity!, "Block has no matching END."));
            }
            return (tree, errors);
        }

        /// <summary>Compiles every statement in the tree using a fresh scope context.</summary>
        public static string CompileAST(SyntaxTree tree) => CompileAST(tree, new CompilationScopes());

        /// <summary>Compiles an ordered tree in the caller's function and module context.</summary>
        public static string CompileAST(SyntaxTree tree, CompilationScopes scopes)
        {
            var output = new StringBuilder();
            void Node(SyntaxNode node)
            {
                if (node.Entity is not null)
                {
                    output.AppendLine(node.Entity.Compile(scopes));
                    if (node.Entity is IOpCode op && Ubytec.Language.Tools.Optimization.FunctionValueIR.InvalidatesFrameCopies(op) &&
                        scopes.All.FirstOrDefault(s => s.DeclaredByKeyword is "func" or "action") is { ReloadRegistersAfterEffects: true } frame)
                    {
                        // MOV does not change flags, return values, RSP or residual cells.
                        // Executed only after the complete original operation returns/succeeds.
                        output.AppendLine("; effect-registers: reload after " + op.GetType().Name);
                        foreach (var binding in frame.Symbols.Values.Where(b => b.Register is not null))
                            output.AppendLine($"mov {binding.Register}, qword {binding.Address}");
                    }
                }
                Nodes(node.Children ?? []);
            }
            void Nodes(IEnumerable<SyntaxNode> sequence)
            {
                var nodes = sequence.ToArray();
                for (int i = 0; i < nodes.Length; i++)
                {
                    if (nodes[i].Entity is FunctionOperations.CALL call && (nodes[i].Children?.Count ?? 0) == 0 &&
                        i + 1 < nodes.Length && nodes[i+1].Entity is RETURN ret && (nodes[i+1].Children?.Count ?? 0) == 0 &&
                        call.CompileTail(scopes) is string tail)
                    {
                        // Validate explicit RETURN types and mark enclosing scopes exactly as for a normal return.
                        _ = ret.Compile(scopes);
                        output.AppendLine(tail);
                        i++;
                    }
                    else Node(nodes[i]);
                }
            }
            void Sentence(SyntaxSentence sentence)
            {
                Nodes(sentence.Nodes.Reverse());
                foreach (var child in sentence.Sentences) Sentence(child);
            }
            Sentence(tree.RootSentence);
            return output.ToString();
        }
    }
}
