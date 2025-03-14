using System.Text;
using System.Text.RegularExpressions;
using ubytec_interpreter.Operations;
using static ubytec_interpreter.Operations.CoreOperations;
using static ubytec_interpreter.Operations.Primitives;

namespace ubytec_interpreter
{
    public static partial class ASTCompiler
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
            { "VAR", 0x10 },
        
            // Stack Manipulation
            { "PUSH", 0x11 },
            { "POP", 0x12 },
            { "DUP", 0x13 },
            { "SWAP", 0x14 },
            { "ROT", 0x15 },
            { "OVER", 0x16 },
            { "NIP", 0x17 },
            { "DROP", 0x18 },
            { "2DUP", 0x19 },
            { "2SWAP", 0x1A },
            { "2ROT", 0x1B },
            { "2OVER", 0x1C },
            { "PICK", 0x1D },
            { "ROLL", 0x1E },
        
            // Arithmetic Operations
            { "ADD", 0x20 },
            { "SUB", 0x21 },
            { "MUL", 0x22 },
            { "DIV", 0x23 },
            { "MOD", 0x24 },
            { "INC", 0x25 },
            { "DEC", 0x26 },
            { "NEG", 0x27 },
            { "ABS", 0x28 },
        
            // Logical Operations
            { "AND", 0x30 },
            { "OR", 0x31 },
            { "XOR", 0x32 },
            { "NOT", 0x33 },
            { "SHL", 0x34 },
            { "SHR", 0x35 },
        
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
        public static (IOpCode[], SyntaxToken[]) Parse(string code)
        {
            List<IOpCode> opCodes = [];
            List<SyntaxToken> syntaxTokens = [];

            // Holds the currently 'open' blocks or conditional structures
            Stack<IOpCode> blockStack = new();

            var lines = code.Split('\n', ';')
                            .Select(line => line.Trim())
                            .Where(line => !string.IsNullOrWhiteSpace(line) && !line.StartsWith("//"))
                            .ToArray();

            for (int y = 0; y < lines.Length; y++)
            {
                var line = lines[y];
                var tokens = CodeRegex().Split(line).Where(t => !string.IsNullOrWhiteSpace(t)).ToArray();
                if (tokens.Length == 0) continue;

                string instruction = tokens[0].ToUpper().TrimEnd(';');

                if (instruction.StartsWith("T_"))
                {
                    SyntaxToken[] tempTokens = [
                        new(tokens[0], line, y, 0),
                        new(tokens[1], line, y, 1),
                        new(tokens[2], line, y, 2)];

                    var targetType = Enum.Parse<PrimitiveType>(instruction.Remove(0, 2), true);
                    var variable = new Variable(targetType, instruction.EndsWith('?'), tokens[1], tokens[2], tempTokens);
                    var varOp = new VAR(variable);

                    // Attach it to the current block (if any)
                    IOpCode? currentBlock = blockStack.Count > 0 ? blockStack.Peek() : null;
                    if (currentBlock is not null)
                        // Merge block's variables, or do something similar
                        MergeVariables(currentBlock, varOp);

                    opCodes.Add(varOp);

                    continue;
                }

                if (!OpcodeMap.TryGetValue(instruction, out byte byteCode))
                    throw new Exception($"Unknown instruction: {instruction}");

                var instructionAndOperands = new Queue<ValueType>();
                instructionAndOperands.Enqueue(byteCode);

                syntaxTokens.Add(new SyntaxToken(instruction, line, y, 0)); // Add instruction

                // Process operands (assumes operands are hex or decimal values)
                for (int i = 1; i < tokens.Length; i++)
                {
                    var currentToken = tokens[i];
                    syntaxTokens.Add(new SyntaxToken(currentToken, line, y, i)); // Add operands

                    if (currentToken.StartsWith("0x", StringComparison.OrdinalIgnoreCase))
                    {
                        var a = Convert.ToInt32(currentToken, 16);
                        instructionAndOperands.Enqueue(a);
                    }
                    else if (currentToken.Contains('.', StringComparison.OrdinalIgnoreCase))
                    {
                        var a = Convert.ToSingle(currentToken);
                        instructionAndOperands.Enqueue(a);
                    }
                    else if (currentToken.StartsWith("t_", StringComparison.OrdinalIgnoreCase))
                    {
                        var trimmed = currentToken.Remove(0, 2);
                        var a = Enum.Parse<PrimitiveType>(trimmed, true);
                        instructionAndOperands.Enqueue(a);
                    }
                    else if (byte.TryParse(currentToken, out byte byteValue))
                    {
                        instructionAndOperands.Enqueue(byteValue);
                    }
                    else if (int.TryParse(currentToken, out int intValue))
                    {
                        instructionAndOperands.Enqueue(intValue);
                    }
                    else if (currentToken.StartsWith(';')) break;
                    else if (currentToken == "==" || currentToken == "!=" || currentToken == ">=" || currentToken == "<=")
                    {
                        instructionAndOperands.Enqueue((byte)(currentToken.First() & 0xFF));  // Lower byte 
                        instructionAndOperands.Enqueue((byte)(currentToken.Last() & 0xFF)); //Upper byte
                    }
                    else if (currentToken == ">" || currentToken == "<")
                    {
                        // Para un operador de un solo carácter, usamos solo su valor ASCII.
                        byte lowerByte = (byte)currentToken[0];
                        // Si la lógica de IF espera dos bytes, podemos añadir un 0 como byte superior.
                        byte upperByte = 0;

                        instructionAndOperands.Enqueue(lowerByte);
                        instructionAndOperands.Enqueue(upperByte);
                    }
                    else throw new Exception($"Invalid operand: {currentToken}");
                }

                var dequedByteCode = instructionAndOperands.Dequeue();
                // Actually create the IOpCode
                IOpCode op = CreateInstruction((byte)dequedByteCode, new(), [.. instructionAndOperands]);

                // *** Attach it to the correct parent if needed ***
                IOpCode? parent = blockStack.Count > 0 ? blockStack.Peek() : null;

                // Now handle special constructs:
                switch (instruction)
                {
                    case "BLOCK":
                    case "IF":
                    case "LOOP":
                    case "WHILE":
                    case "SWITCH":
                        {
                            // If you want the new block to “inherit” the parent’s variables:
                            InheritVariables(parent, op);

                            // After creation, push it so subsequent instructions are inside it
                            blockStack.Push(op);
                            break;
                        }
                    case "ELSE":
                        {
                            // Typically, ELSE pairs with an IF
                            // So pop the top if it is IF
                            if (blockStack.Count > 0 && blockStack.Peek() is IF ifOp)
                            {
                                // We might want to do something with ifOp.Variables
                                blockStack.Pop();
                            }

                            // Inherit parent variables if you want same scope
                            InheritVariables(parent, op);

                            // Then push the ELSE as the 'current' block
                            blockStack.Push(op);
                            break;
                        }
                    case "END":
                        {
                            // End typically closes the last open block
                            if (blockStack.Count > 0)
                            {
                                blockStack.Pop();
                            }
                            break;
                        }
                    default:
                        {
                            // e.g. NOP or other instructions that don't open/close blocks
                            // Just attach them to the top of the stack if needed
                            // if (parent is not null)
                            // {
                            //     InheritVariables(parent, op);
                            // }
                            break;
                        }
                }

                opCodes.Add(op);
            }

            return ([.. opCodes], [.. syntaxTokens]);
        }
        /// <summary>
        /// Creates an appropriate IOpCode instance (e.g., IF, WHILE, LOOP) based on the 
        /// given opcode byte and additional operands. Also delegates to specialized 
        /// constructors like ProcessIf() and ProcessWhile() when needed.
        /// </summary>
        /// <param name="opcode">The opcode (byte) identifying which instruction to create.</param>
        /// <param name="variables">A stack of variables in the current context.</param>
        /// <param name="operands">A list of ValueType operands extracted from the line of code.</param>
        /// <returns>An IOpCode object ready to be added to the instruction flow.</returns>
        private static IOpCode CreateInstruction(byte opcode, Stack<Variable> variables, params ValueType[] operands)
        {
            return opcode switch
            {
                // Core Control Instructions
                0x00 => new TRAP(),
                0x01 => new NOP(),
                0x02 => new BLOCK(operands.Length > 0 ? (PrimitiveType)operands[0] : PrimitiveType.Void,
                    [.. variables]),
                0x03 => new LOOP(operands.Length > 0 ? (PrimitiveType)operands[0] : PrimitiveType.Default,
                    [.. variables]),
                0x04 => ProcessIf(),
                0x05 => new ELSE(
                    [.. variables]),
                0x06 => new END(),
                0x07 => new BREAK(operands.Length > 0 ? Convert.ToInt32(operands[0]) : null),
                0x08 => new CONTINUE(operands.Length > 0 ? Convert.ToInt32(operands[0]) : null),
                0x09 => new RETURN(
                    [.. variables]),
                0x0A => new BRANCH(
                    operands.Length > 0 ? operands[0] : default!,
                    operands.Length > 1 ? Convert.ToInt32(operands[1]) : null,
                    operands.Length > 2 ? (PrimitiveType)operands[2] : PrimitiveType.Default,
                    [.. variables]),
                0x0B => new SWITCH(
                    operands.Length > 0 ? Convert.ToInt32(operands[0]) : null,
                    operands.Length > 1 ? (PrimitiveType)operands[1] : PrimitiveType.Default,
                    [.. variables]),
                0x0C => ProcessWhile(),
                0x0D => new CLEAR(),
                0x0E => new DEFAULT(),
                0x0F => new NULL(),

                // Stack Manipulation Instructions
                //0x11 => new PUSH(operands),  // Accepts multiple bytes for type + value
                //0x12 => new POP(),
                //0x13 => new DUP(),
                //0x14 => new SWAP(),
                //0x15 => new ROT(),
                //0x16 => new OVER(),
                //0x17 => new NIP(),
                //0x18 => new DROP(operands.Length > 0 ? operands[0] : throw new Exception("DROP requires a stack index.")),
                //0x19 => new TwoDUP(),
                //0x1A => new TwoSWAP(),
                //0x1B => new TwoROT(),
                //0x1C => new TwoOVER(),
                //0x1D => new PICK(operands.Length > 0 ? operands[0] : throw new Exception("PICK requires an index.")),
                //0x1E => new ROLL(operands.Length > 0 ? operands[0] : throw new Exception("ROLL requires an index.")),
                //
                //// Arithmetic Instructions (Placeholders for now)
                //0x20 => new ADD(),
                //0x21 => new SUB(),
                //0x22 => new MUL(),
                //0x23 => new DIV(),
                //0x24 => new MOD(),
                //0x25 => new INC(),
                //0x26 => new DEC(),
                //0x27 => new NEG(),
                //0x28 => new ABS(),
                //
                ////Bitwise Instructions
                //0x30 => new AND(),
                //0x31 => new OR(),
                //0x32 => new XOR(),
                //0x33 => new NOT(),
                //0x34 => new SHL(),
                //0x35 => new SHR(),

                _ => throw new Exception($"Unknown opcode: 0x{opcode:X4}")
            };

            IF ProcessIf()
            {
                // IF sin condición explícita.
                if (operands.Length == 0)
                {
                    return new IF(Variables: [.. variables]);
                }
                // Caso: IF left [op] right
                // Se esperan 4 operandos: left, equalsLower, equalsUpper, right.
                else if (operands.Length == 4) // Caso sin bloque tipo: left, opLower, opUpper, right
                {
                    var left = operands[0];
                    var opLower = Convert.ToByte(operands[1]);
                    var opUpper = Convert.ToByte(operands[2]);
                    // Para operadores de un solo carácter, opUpper será 0.
                    string equals = opUpper == 0 ? new string([(char)opLower]) : new string([(char)opLower, (char)opUpper]);
                    var right = operands[3];
                    return new IF(PrimitiveType.Default, Condition: new(left, equals, right), [.. variables]);
                }

                // Caso: IF t_<tipo> left [op] right
                // Se esperan 5 operandos: blockType, left, equalsLower, equalsUpper, right.
                else if (operands.Length == 5)
                {
                    var blockType = (PrimitiveType)operands[0];
                    var left = operands[1];
                    var equalsLower = Convert.ToByte(operands[2]);
                    var equalsUpper = Convert.ToByte(operands[3]);
                    string equals = equalsUpper == 0 ? new string([(char)equalsLower]) : new string([(char)equalsLower, (char)equalsUpper]);
                    var right = operands[4];
                    return new IF(blockType, Condition: new(left, equals, right), [.. variables]);
                }
                // Fallback: Si se proporciona solo el bloque tipo.
                else
                {
                    var blockType = (PrimitiveType)operands[0];
                    return new IF(blockType, Variables: [.. variables]);
                }
            }
            WHILE ProcessWhile()
            {
                // 1) Gather leading integer operands as label IDs
                List<int> allLabelIds = new();
                int index = 0;
                while (index < operands.Length && operands[index] is int intVal)
                {
                    allLabelIds.Add(intVal);
                    index++;
                }
                // We'll unify them into either zero or one label ID
                // (If you truly want multiple loops from one line, you'd have to return multiple WHILE objects.)
                int[]? singleLabelIdArray = null;
                if (allLabelIds.Count == 1) singleLabelIdArray = [allLabelIds[0]];
                else if (allLabelIds.Count > 1)
                {
                    Console.WriteLine($"[WARNING] Multiple label IDs detected: {string.Join(", ", allLabelIds)}. Using only the first.");
                    singleLabelIdArray = [allLabelIds[0]];
                }

                // 2) Now figure out how many operands remain after label IDs
                int remaining = operands.Length - index;

                // ---------------------------------------------------------------------------------
                // A) No more operands => either structured loop or single-label jump
                // ---------------------------------------------------------------------------------
                if (remaining == 0)
                {
                    // If we have at least one label ID => "pop rax; cmp rax,0; jne while_<label>"
                    if (singleLabelIdArray is not null)
                        return new WHILE(
                            // We treat it as a "stack-check jump" loop
                            // meaning the compile method can do: pop rax, cmp rax, 0, jne while_label
                            LabelIDxs: singleLabelIdArray,
                            // No condition => you’ll handle in the WHILE compile to jump if nonzero
                            Variables: [.. variables]
                        );
                    else
                        // No label IDs, no operands => structured loop
                        //   while_x:
                        //     pop rax
                        //     cmp rax, 0
                        //     je end_while_x
                        //   ...
                        //   jmp while_x
                        return new WHILE(
                            Variables: [.. variables]
                        );
                }

                // ---------------------------------------------------------------------------------
                // B) 4 operands => typical "left, opLower, opUpper, right"
                // ---------------------------------------------------------------------------------
                else if (remaining == 4)
                {
                    var left = operands[index + 0];
                    var opLower = Convert.ToByte(operands[index + 1]);
                    var opUpper = Convert.ToByte(operands[index + 2]);
                    var right = operands[index + 3];

                    // For single-char operators, opUpper == 0
                    string @operator = (opUpper == 0)
                        ? new string((char)opLower, 1)
                        : new string([(char)opLower, (char)opUpper]);

                    // Condition-based while, no explicit block type
                    return new WHILE(
                        BlockType: PrimitiveType.Default,
                        Condition: new Condition(left, @operator, right),
                        LabelIDxs: singleLabelIdArray, // if present, we keep it
                        Variables: [.. variables]
                    );
                }

                // ---------------------------------------------------------------------------------
                // C) 5 operands => "blockType, left, opLower, opUpper, right"
                // ---------------------------------------------------------------------------------
                else if (remaining == 5)
                {
                    var blockType = (PrimitiveType)operands[index + 0];
                    var left = operands[index + 1];
                    var opLower = Convert.ToByte(operands[index + 2]);
                    var opUpper = Convert.ToByte(operands[index + 3]);
                    var right = operands[index + 4];

                    string @operator = (opUpper == 0)
                        ? new string((char)opLower, 1)
                        : new string([(char)opLower, (char)opUpper]);

                    return new WHILE(
                        BlockType: blockType,
                        Condition: new Condition(left, @operator, right),
                        LabelIDxs: singleLabelIdArray,
                        Variables: [.. variables]
                    );
                }

                // ---------------------------------------------------------------------------------
                // D) 1 operand left => interpret as blockType (no condition)
                // ---------------------------------------------------------------------------------
                else if (remaining == 1)
                {
                    var blockType = (PrimitiveType)operands[index];
                    // This means "while t_int32" for instance, no explicit condition
                    // The compile method can do structured logic with that type, or
                    // pop rax if you want. Up to you.
                    return new WHILE(
                        BlockType: blockType,
                        LabelIDxs: singleLabelIdArray,
                        Variables: [.. variables]
                    );
                }

                // ---------------------------------------------------------------------------------
                // E) Otherwise => unknown pattern
                // ---------------------------------------------------------------------------------
                else
                {
                    throw new Exception($"Invalid WHILE operand pattern. Found {operands.Length} total operands.");
                }
            }
        }
        /// <summary>
        /// Inherits variables from a parent opCode (e.g., a block or IF) 
        /// into the child opCode so that they share the same variable context.
        /// </summary>
        /// <param name="parent">The parent opCode holding the variable list.</param>
        /// <param name="child">The child opCode to which the variables will be added.</param>
        private static void InheritVariables(IOpCode? parent, IOpCode child)
        {
            if (parent is null) return;

            dynamic dynParent = parent;
            dynamic dynChild = child;

            // Each block-like opcode has a `List<Variable> Variables` property
            dynChild.Variables.AddRange(dynParent.Variables);
        }
        /// <summary>
        /// Merges the declared variable (from a VAR instruction) into the 
        /// variable list of the current block-like opCode (BLOCK, IF, LOOP, etc.).
        /// Ensures each block maintains a record of variables declared in its scope.
        /// </summary>
        /// <param name="block">The block opCode (e.g., BLOCK, IF, LOOP).</param>
        /// <param name="varOp">The VAR instruction that contains the newly declared variable.</param>
        private static void MergeVariables(IOpCode block, IOpCode varOp)
        {
            // add the declared variable to the block's variable list
            dynamic dynBlock = block;
            dynamic dynVarOp = varOp;

            if (dynVarOp is VAR { Variable: Variable v })
            {
                dynBlock.Variables.Add(v);
            }
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
        public static SyntaxTree CompileSyntax(IOpCode[] opCodes, SyntaxToken[] tokens)
        {
            // Se crea el árbol raíz con una oración inicial.
            var lastRoot = new SyntaxTree(new SyntaxSentence());

            // Agrupamos los tokens por la propiedad "Row" (suponiendo que cada grupo corresponde a una instrucción o línea).
            var tokensByRow = tokens
                .GroupBy(t => t.Row)
                .OrderBy(g => g.Key)
                .ToDictionary(g => g.Key, g => g.ToList());

            var currentRow = 0;

            foreach (var opCode in opCodes)
            {
                try
                {
                    // Si se encontraron tokens para la fila actual, se usan; si no, se pasa una lista vacía.
                    if (tokensByRow.TryGetValue(currentRow, out var rowTokens))
                        BuildSyntaxTree(lastRoot, opCode, rowTokens);
                    else
                        BuildSyntaxTree(lastRoot, opCode, []);
                }
                catch (Exception e)
                {
                    throw new Exception($"Error at row {currentRow} on opcode {opCode}", e);
                }

                currentRow++;
            }

            return lastRoot;
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
            if (tree.Sentences.Count == 0)
                throw new Exception("The syntax tree has no active sentence.");

            SyntaxSentence currentSentence = tree.Sentences.Peek();

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
                        SyntaxSentence newSentence = new SyntaxSentence()
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
                        tree.Sentences.Push(newSentence);
                        break;
                    }
                // Para opCodes que abren un nuevo scope, se crea una nueva oración y un nodo contenedor.
                case ELSE:
                    {
                        SyntaxSentence closedSentence = tree.Sentences.Pop();
                        SyntaxSentence parentSentence = tree.Sentences.Peek();

                        if (closedSentence.Nodes.Count > 1)
                            closedSentence.Nodes.Pop();

                        var newElseNode = new SyntaxNode(opCode)
                        {
                            Children = [],
                            Tokens = tokens,
                        };

                        // Se crea una nueva oración para contener los nodos dentro de este scope.
                        SyntaxSentence newSentence = new SyntaxSentence()
                        {
                            Nodes = new(),
                            Sentences = [],
                        };
                        newSentence.Metadata.Add("type", nameof(ELSE).ToLower());

                        parentSentence.Sentences.Add(newSentence);
                        newSentence.Nodes.Push(newElseNode);
                        tree.Sentences.Push(newSentence);
                        break;
                    }
                // Para opCodes que cierran un scope (como END, BREAK o RETURN), se crea un nodo de cierre y se extrae la oración.
                case END or BREAK or RETURN:
                    {
                        SyntaxSentence closedSentence = tree.Sentences.Pop();
                        SyntaxNode endNode = new SyntaxNode(opCode)
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
                        SyntaxNode newNode = new SyntaxNode(opCode)
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
        public static string CompileAST(SyntaxTree tree) => CompileSentence(tree.RootSentence.Sentences.First(), new(), new(), new(), new());
        /// <summary>
        /// Compiles a specific SyntaxSentence into NASM assembly, 
        /// handling nested statements recursively.
        /// </summary>
        /// <param name="sentence">The SyntaxSentence to compile.</param>
        /// <param name="stacks">Auxiliary stacks used for scope control or type checking, if applicable.</param>
        /// <returns>A string fragment with the NASM code for that sentence.</returns>
        private static string CompileSentence(SyntaxSentence sentence, params Stack<object>[] stacks)
        {
            StringBuilder output = new StringBuilder();

            // Si hay nodos, asumimos que el primero representa la estructura (apertura + cierre)
            if (sentence.Nodes != null && sentence.Nodes.Count > 0)
            {
                // Usamos Peek() para no alterar la pila
                var node = sentence.Nodes.Peek();
                output.Append(CompileBlockNode(sentence, node, stacks));
            }
            // Si no hay nodos, simplemente compilamos las oraciones anidadas (si las hubiera)
            else if (sentence.Sentences != null)
            {
                foreach (var childSentence in sentence.Sentences)
                    output.Append(CompileSentence(childSentence, stacks));
            }

            return output.ToString();
        }
        /// <summary>
        /// Compiles a block node (e.g., IF with an END, a BLOCK with its END) and 
        /// its children into NASM format, respecting indentation and any generated labels.
        /// </summary>
        /// <param name="sentence">The SyntaxSentence containing this node.</param>
        /// <param name="node">The SyntaxNode holding the operation (BLOCK, IF, ELSE, etc.).</param>
        /// <param name="stacks">Environment stacks used for scope control or validation.</param>
        /// <returns>The resulting NASM code for opening, populating, and closing this block.</returns>
        private static string CompileBlockNode(SyntaxSentence sentence, SyntaxNode node, params Stack<object>[] stacks)
        {
            StringBuilder code = new StringBuilder();

            var initialDepth = GetDepth();

            var depth = node.Operation is ELSE ? GetDepth(-1) : initialDepth;

            // Compilamos la operación de apertura
            if (node.Operation != null)
            {
                var compiled = node.Operation.Compile(stacks);

                if (!node.Metadata.TryAdd("nasm", compiled))
                    node.Metadata["nasm"] += compiled;

                code.AppendLine(FormatCompiledLines(compiled, depth));
            }

            // Compilamos el cuerpo del bloque: las sentencias anidadas se insertan justo aquí
            if (sentence.Sentences != null)
                foreach (var childSentence in sentence.Sentences)
                {
                    var compiled = CompileSentence(childSentence, stacks);

                    if (!node.Metadata.TryAdd("nasm", compiled))
                        node.Metadata["nasm"] += compiled;

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
                    var compiled = n.Operation.Compile(stacks);

                    if (!node.Metadata.TryAdd("nasm", compiled))
                        node.Metadata["nasm"] += compiled;

                    code.AppendLine(FormatCompiledLines(compiled, GetDepth()));
                }


            // Finalmente, compilamos la operación de cierre, que asumimos es el último hijo del nodo
            if (closingNode.Operation != null)
            {
                var compiled = closingNode.Operation.Compile(stacks);

                if (!node.Metadata.TryAdd("nasm", compiled))
                    node.Metadata["nasm"] += compiled;

                code.AppendLine(FormatCompiledLines(compiled, GetDepth()));
            }

            return code.ToString();

            string GetDepth(int basis = 0)
            {
                var output = string.Empty;
                var depth = stacks[0].Count + basis;
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

        [GeneratedRegex(@"\s+")]
        private static partial Regex CodeRegex();
    }
}
