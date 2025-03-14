using static ubytec_interpreter.Operations.Primitives;
using static ubytec_interpreter.Operations.StackOperarions;

namespace ubytec_interpreter.Operations
{
    public static class CoreOperations
    {
        private static readonly Dictionary<string, int> PrefixToLabelCounterMap = [];

        // Generate a unique label for jumps
        private static string NextLabel(string prefix)
        {
            PrefixToLabelCounterMap.TryAdd(prefix, 0);
            return $"{prefix}_{PrefixToLabelCounterMap[prefix]++}";
        }

        public readonly record struct TRAP : IOpCode
        {
            public readonly byte OpCode => 0x00;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "ud2   ; TRAP";
        }
        public readonly record struct NOP : IOpCode
        {
            public readonly byte OpCode => 0x01;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "nop   ; NOP";
        }
        public readonly record struct BLOCK(PrimitiveType? BlockType = PrimitiveType.Default, List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x02;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                string blockLabel = NextLabel("block");
                string endLabel = NextLabel("end_block");

                stacks[0].Push(endLabel);   //  Block end label is pushed to the stack
                stacks[1].Push(blockLabel); //  Block start label is pushed to the stack

                // ✅ Ensure RETURN validation works
                if (BlockType == null) stacks[2].Push((byte)PrimitiveType.Void); //  If no type is provided push a void value
                else stacks[2].Push((byte)BlockType);                                  // Else push the specified type to the stack

                return $"{blockLabel}: ; BLOCK start";
            }
        }
        public readonly record struct LOOP(PrimitiveType? BlockType = PrimitiveType.Default, List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x03;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack);

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                string loopStartLabel = NextLabel("loop");
                string loopEndLabel = NextLabel("end_loop");

                stacks[0].Push(loopEndLabel);   //  Loop end label is pushed to the stack
                stacks[1].Push(loopStartLabel); //  Loop start label is pushed to the stack

                // ✅ Ensure RETURN validation works
                if (BlockType == null) stacks[2].Push((byte)PrimitiveType.Void); //  If no type is provided push a void value
                else stacks[2].Push((byte)BlockType);                            // Else push the specified type to the stack

                return $"{loopStartLabel}: ; LOOP start";
            }
        }

        public readonly record struct IF(PrimitiveType? BlockType = PrimitiveType.Default, Condition? Condition = null, List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x04;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            private static bool ValidateIfType(PrimitiveType blockType) => IsNumeric(blockType) || IsBool(blockType);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (!ValidateIfType(BlockType == PrimitiveType.Default ?
                    PrimitiveType.Bool : 
                    BlockType ?? PrimitiveType.Bool))
                    throw new Exception($"Invalid IF blockType {BlockType}");

                string ifEndLabel = NextLabel("end_if");
                string ifLabel = NextLabel("if");

                stacks[0].Push(ifEndLabel);   //  If end label is pushed to the stack
                stacks[1].Push(ifLabel);      //  If start label is pushed to the stack

                // ✅ Ensure RETURN validation works
                if (BlockType == null || BlockType == PrimitiveType.Default)
                {
                    stacks[2].Push((byte)PrimitiveType.Bool); //  If no type is provided push a bool value
                    stacks[3].Push((byte)PrimitiveType.Bool); //  If no type is provided push a bool value
                }
                else
                {
                    stacks[2].Push((byte)BlockType); // Else push the specified type to the stack
                    stacks[3].Push((byte)BlockType); // Else push the specified type to the stack
                }

                var raxHandling = "  pop rax; IF condition";
                if (Condition != null)
                {
                    // Se asume que Condition.Value.left y Condition.Value.right se pueden convertir a una representación
                    // adecuada para el ensamblador (por ejemplo, literales, registros o direcciones de memoria).
                    raxHandling = $"  mov rax, {Condition.Value.Left}  ; Evalúa la parte izquierda\n" +
                                  $"  cmp rax, {Condition.Value.Right}  ; Compara con la parte derecha";

                    // Determinamos la instrucción de salto inverso según el operador.
                    // La idea es: si la comparación NO cumple lo esperado, se salta al final del IF.
                    string jumpInstruction = Condition.Value.Operand switch
                    {
                        "==" => "jne",  // Si left != right, la condición es falsa.
                        "!=" => "je",   // Si left == right, la condición es falsa.
                        "<" => "jge",  // Si left >= right, la condición es falsa.
                        "<=" => "jg",   // Si left > right, la condición es falsa.
                        ">" => "jle",  // Si left <= right, la condición es falsa.
                        ">=" => "jl",   // Si left < right, la condición es falsa.
                        _ => "jne"   // Por defecto, usamos "jne"
                    };

                    return $"{ifLabel}: ; IF START\n{raxHandling}\n  {jumpInstruction} {ifEndLabel}   ; Salta si la condición es falsa";
                }

                return $"{ifLabel}: ; IF START\n{raxHandling}\n  cmp rax, 0\n  je {ifEndLabel}   ; Jump if condition == 0";
            }
        }
        public readonly record struct ELSE(List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x05;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0 || stacks[1].Count == 0)
                    throw new Exception("ELSE without matching IF");

                var ifEndLabel = (string)stacks[0].Pop();
                var ifStart = (string)stacks[1].Pop();
                var elseEndLabel = NextLabel("end_else");
                var elseStartLabel = NextLabel("else");

                stacks[0].Push(elseEndLabel);
                stacks[1].Push(elseStartLabel);

                return $"  jmp {elseEndLabel}     ; Jump over ELSE part\n{ifEndLabel}:    ; {ifStart} END\n{elseStartLabel}:  ; Start ELSE block";
            }
        }
        public readonly record struct END : IOpCode
        {
            public readonly byte OpCode => 0x06;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0 || stacks[1].Count == 0 || stacks[2].Count == 0)
                    throw new Exception("END found without matching BLOCK, IF, or LOOP");

                var blockEnd = (string)stacks[0].Pop();
                var blockStart = (string)stacks[1].Pop();
                var expectedType = Convert.ToByte(stacks[2].Pop());
                var actualType = stacks[3].Count > 0 ? Convert.ToByte(stacks[3].Pop()) : (byte)PrimitiveType.Void;

                ValidateCasts(expectedType, actualType);

                var output = string.Empty;

                if (blockStart.StartsWith("while"))
                {
                    // WHILE loops need counter checking before breaking
                    output +=
                        "  pop rax       ; Load loop counter\n" +
                        "  dec rax       ; Decrement counter\n" +
                        "  push rax      ; Store updated counter\n" +
                        "  cmp rax, 0    ; Check if counter is zero\n" +
                        $"  je {blockEnd} ; Exit loop if counter == 0\n" +
                        $"  jmp {blockStart} ; Otherwise, continue loop\n";
                }

                output += $"{blockEnd}: ; END of {blockStart}";

                return output;
            }
        }
        public readonly record struct BREAK(int? LabelIDx) : IOpCode
        {
            public readonly byte OpCode => 0x07;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0 || stacks[1].Count == 0)
                    throw new Exception("BREAK without a valid BLOCK or LOOP to exit");

                var temp1 = new Stack<string>();
                var temp2 = new Stack<string>();

                var output = string.Empty;

                // Traverse upwards until we find a valid loop or block
                while (stacks[0].Count > 0)
                {
                    var blockEnd = (string)stacks[0].Pop();
                    var blockName = (string)stacks[1].Pop();

                    temp1.Push(blockEnd);
                    temp2.Push(blockName);

                    bool isWhileStart = blockName.StartsWith("while");
                    bool isLoopStart = blockName.StartsWith("loop");
                    bool isBranchStart = blockName.StartsWith("branch");

                    if (isWhileStart || isLoopStart || isBranchStart)
                    {
                        string? key = null;

                        if (isWhileStart) key = "whileEnd";
                        if (isLoopStart) key = "loopEnd";

                        if (isBranchStart)
                        {
                            key = "branchEnd";

                            string? switchEndLabel = null;
                            foreach (var item in stacks[0])
                                if (item is string s && s.StartsWith("switchEnd"))
                                {
                                    switchEndLabel = s;
                                    break;
                                }

                            if (!string.IsNullOrEmpty(switchEndLabel)) output += $"jmp {switchEndLabel}   ; Salta al fin del SWITCH\n";
                            if (LabelIDx != null && key != null) output += $"{key}_{LabelIDx}: ; BREAK SWITCH - {blockName}";
                            else output += $"{blockEnd}: ; BREAK SWITCH - {blockName}";
                        }
                        else
                        {
                            if (LabelIDx != null && key != null) output = $"jmp {key}_{LabelIDx} ; BREAK - Exit {blockName}";
                            else output = $"jmp {blockEnd} ; BREAK - Exit {blockName}";
                        }

                        break;
                    }
                }

                foreach (var temp in temp1)
                    stacks[0].Push(temp);
                foreach (var temp in temp2)
                    stacks[1].Push(temp);

                return output;
            }
        }
        public readonly record struct CONTINUE(int? LabelIDx) : IOpCode
        {
            public readonly byte OpCode => 0x08;

            public string Compile(Stack<object> blockStartStack) =>
                ((IOpCode)this).Compile(blockStartStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (stacks[0].Count == 0) throw new Exception("CONTINUE without a valid LOOP to jump to");

                var temp1 = new Stack<string>();

                string? output = null;

                // Traverse upwards until we find a valid loop or block
                while (stacks[0].Count > 0)
                {
                    var blockName = (string)stacks[0].Pop();

                    temp1.Push(blockName);

                    bool isWhileStart = blockName.StartsWith("while");
                    bool isLoopStart = blockName.StartsWith("loop");

                    if (isWhileStart || isLoopStart)
                    {
                        string? key = null;
                        if (isWhileStart) key = "while";
                        if (isLoopStart) key = "loop";

                        if (LabelIDx != null && key != null) output = $"jmp {key}_{LabelIDx} ; CONTINUE {key}_{LabelIDx}";
                        else output = $"jmp {blockName} ; CONTINUE {blockName}";

                        break;
                    }
                }

                foreach (var temp in temp1)
                    stacks[0].Push(temp);

                return output ?? throw new Exception("Invalid CONTINUE instruction...");
            }
        }
        public readonly record struct RETURN(List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x09;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                string? endLabel = (string)stacks[0].Pop();
                string? startLabel = (string)stacks[1].Pop();

                var poppedEnds = new Stack<string>();
                var poppedStarts = new Stack<string>();
                bool foundFunctionBoundary = false;

                var expectedType = Convert.ToByte(stacks[2].Pop());
                var actualType = stacks[3].Count > 0 ? Convert.ToByte(stacks[3].Pop()) : (byte)0x00;

                ValidateCasts(expectedType, actualType);

                // Mecanismo de repush para conservar los bloques exteriores
                // Los bloques internos que pertenecen a la función actual se desapilan y NO se re-push;
                // en cambio, si se encuentra un bloque que indica el límite de la función (por ej., "func_" o "block"),
                // se reintroduce ese elemento para no perder el contexto del bloque externo.
                var tempStart = new Stack<string>();
                var tempEnd = new Stack<string>();

                // Vamos desapilando hasta dar con una subrutina
                while (stacks[0].Count > 0)
                {
                    var tmpEnd = (string)stacks[0].Pop();
                    var tmpStart = (string)stacks[1].Pop();

                    if (tmpStart.StartsWith("block") || tmpStart.StartsWith("func_"))
                    {
                        // Hemos encontrado el límite de la función
                        foundFunctionBoundary = true;

                        endLabel = tmpEnd;
                        startLabel = tmpStart;

                        // Repush
                        poppedEnds.Push(tmpEnd);
                        poppedStarts.Push(tmpStart);

                        break;
                    }
                    else
                    {
                        // Los bloques internos (como if, while, etc.) que se desapilan pertenecen a la función que se termina.
                        // Se guardan en temporales en caso de querer hacer debug o alguna acción extra,
                        // pero no se re-push, ya que se deben descartar al hacer return.
                        tempStart.Push(tmpStart);
                        tempEnd.Push(tmpEnd);
                    }
                }

                if (!foundFunctionBoundary)
                {
                    // No se encontró un bloque de función: error o caso especial
                    throw new Exception("RETURN without a valid function boundary.");
                }


                // Rearmamos la cadena final
                var output = $"pop rax   ; RETURN value\n  ret\n{endLabel}: ; End of function => {startLabel}";

                // Devolvemos el resultado
                return output;
            }
        }
        public readonly record struct BRANCH(object CaseValue, int? LabelIDx, PrimitiveType? BlockType = PrimitiveType.Default, List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x0A;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                // Asumimos el siguiente orden de stacks:
                // stacks[0] => blockEndStack
                // stacks[1] => blockStartStack
                // stacks[2] => blockExpectedTypeStack
                // stacks[3] => blockActualTypeStack

                if (stacks[2].Count == 0 || stacks[3].Count == 0)
                    throw new Exception("BRANCH: El stack de tipos esperados está vacío.");

                var expectedType = ((byte)stacks[2].Peek());
                var actualType = ((byte)stacks[3].Peek());

                ValidateCasts(expectedType, actualType);
                ValidateCasts(expectedType, (byte?)BlockType ?? (byte)PrimitiveType.Void);

                // Si no se proporciona un labelIDx, se genera uno único.
                string branchLabel = LabelIDx == null ? NextLabel("branch") : $"branch_{LabelIDx}";
                string branchEndLabel = LabelIDx == null ? NextLabel("end_branch") : $"end_branch_{LabelIDx}";

                stacks[0].Push(branchEndLabel);
                stacks[1].Push(branchLabel);

                var output =
                   $"{branchLabel}: ; BRANCH: Salida de bloque(s)\n" +
                   $"pop rax\n" +
                   $"cmp rax, {CaseValue}\n" +
                   $"jne {branchEndLabel}   ; Exit branch if condition is not equal";

                // Genera el salto incondicional a la etiqueta destino indicada por labelIDx
                return output;
            }
        }
        public readonly record struct SWITCH(int? TableIDx, PrimitiveType? BlockType = PrimitiveType.Default, List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x0B;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                // Asumimos que stacks[0] es el blockEndStack.
                // Asumimos que stacks[1] es el blockStartStack.
                // Asumimos que stacks[2] es el blockExpectedTypeStack.
                // Asumimos que stacks[3] es el blockActualTypeStack.

                string? switchEndLabel;
                string? switchStartLabel;
                if (TableIDx == null)
                {
                    switchEndLabel = NextLabel("end_switch");
                    switchStartLabel = NextLabel("switch");
                }
                else
                {
                    switchEndLabel = $"end_switch_{TableIDx}";
                    switchStartLabel = $"switch_{TableIDx}";
                }

                stacks[0].Push(switchEndLabel);
                stacks[1].Push(switchStartLabel);

                // Se empuja el blockType para que, más adelante, la validación de RETURN funcione correctamente.
                if (BlockType != null)
                {
                    stacks[2].Push((byte)BlockType);
                    stacks[3].Push((byte)BlockType);
                }
                else
                {
                    stacks[2].Push((byte)PrimitiveType.Void); // Push void
                    stacks[3].Push((byte)PrimitiveType.Void); // Push void
                }

                return $"{switchStartLabel}: ; SWITCH: Salto múltiple\n";
            }
        }
        public readonly record struct WHILE(PrimitiveType? BlockType = PrimitiveType.Default, Condition? Condition = null, int[]? LabelIDxs = null, List<Variable>? Variables = null) : IOpCode
        {
            public readonly byte OpCode => 0x0C;

            public string Compile(Stack<object> blockEndStack, Stack<object> blockStartStack, Stack<object> blockExpectedTypeStack, Stack<object> blockActualTypeStack) =>
                ((IOpCode)this).Compile(blockEndStack, blockStartStack, blockExpectedTypeStack, blockActualTypeStack);
            private static bool ValidateWhileType(PrimitiveType blockType) => IsNumeric(blockType) || IsBool(blockType);
            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                ArgumentNullException.ThrowIfNull(stacks);

                if (!ValidateWhileType(BlockType == PrimitiveType.Default ?
                    PrimitiveType.Bool :
                    BlockType ?? PrimitiveType.Bool))
                    throw new Exception($"Invalid IF blockType {BlockType}");

                string? whileStartLabel;
                string? whileEndLabel;

                // ✅ Ensure RETURN validation works
                if (BlockType == null || BlockType == PrimitiveType.Default)
                {
                    stacks[2].Push((byte)PrimitiveType.Bool); //  If no type is provided push a bool value
                    stacks[3].Push((byte)PrimitiveType.Bool); //  If no type is provided push a bool value
                }
                else
                {
                    stacks[2].Push((byte)BlockType); // Else push the specified type to the stack
                    stacks[3].Push((byte)BlockType); // Else push the specified type to the stack
                }

                if (LabelIDxs is { Length: > 0 })
                {
                    var output = string.Empty;
                    foreach (var labelIDx in LabelIDxs)
                    {
                        whileEndLabel = $"end_while_{labelIDx}";
                        whileStartLabel = $"while_{labelIDx}";

                        output += $"{whileStartLabel}: ; WHILE start\n{GenerateWhileCondition(Condition, whileEndLabel)}";

                        // Push to block stack (ensures proper END handling)
                        stacks[0].Push(whileEndLabel);
                        stacks[1].Push(whileStartLabel);
                    }
                    return output;
                }

                // **Default Structured WHILE (No Operand Given)**
                whileStartLabel = NextLabel("while");
                whileEndLabel = NextLabel("end_while");

                // Push to block stack (ensures proper END handling)
                stacks[0].Push(whileEndLabel);
                stacks[1].Push(whileStartLabel);

                return $"{whileStartLabel}: ; WHILE start\n{GenerateWhileCondition(Condition, whileEndLabel)}";
            }

            /// <summary>
            /// Similar logic to your IF’s condition. If Condition != null,
            /// do “mov rax, left; cmp rax, right; [jumpInstruction] endLabel”.
            /// Otherwise do “pop rax; cmp rax, 0; je endLabel”.
            /// </summary>
            private static string GenerateWhileCondition(Condition? cond, string endLabel)
            {
                if (cond is null)
                    return $"  pop rax ; WHILE Condition\n  cmp rax, 0\n  je {endLabel}   ; Exit loop if condition == 0";

                // Condition-based approach
                // We replicate the logic from your IF
                var left = cond.Value.Left;
                var right = cond.Value.Right;
                var op = cond.Value.Operand;

                // The jump instruction is "inverse" => if condition is *not* satisfied, jump out.
                // The mapping is the same as your IF example:
                string jumpInstruction = op switch
                {
                    "==" => "jne",  // if left != right => exit
                    "!=" => "je",   // if left == right => exit
                    "<" => "jge",  // if left >= right => exit
                    "<=" => "jg",   // if left > right  => exit
                    ">" => "jle",  // if left <= right => exit
                    ">=" => "jl",   // if left < right  => exit
                    _ => "jne"
                };

                return $"  mov rax, {left}    ; Evaluate left\n  cmp rax, {right}   ; Compare with right\n  {jumpInstruction} {endLabel}    ; Jump if condition is false";
            }
        }
        public readonly record struct CLEAR : IOpCode
        {
            public readonly byte OpCode => 0x0D;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "mov rsp, rbp   ; CLEAR - Reset stack pointer to base pointer\n  ; Stack is now empty";
        }
        public readonly record struct DEFAULT : IOpCode
        {
            public readonly byte OpCode => 0x0E;

            public string Compile() => ((IOpCode)this).Compile();
            string IOpCode.Compile(params Stack<object>[]? stacks) => "mov rax, 1  ; DEFAULT non-null placeholder\n  push rax";
        }
        public readonly record struct NULL : IOpCode
        {
            public readonly byte OpCode => 0x0F;

            public string Compile() => ((IOpCode)this).Compile();

            string IOpCode.Compile(params Stack<object>[]? stacks) => "xor rax, rax   ; NULL = 0\n  push rax";
        }

        public readonly record struct VAR(Variable Variable) : IOpCode
        {
            public readonly byte OpCode => 0x10;

            public string Compile() => ((IOpCode)this).Compile();

            string IOpCode.Compile(params Stack<object>[]? stacks) => string.Empty;
        }
    }
}