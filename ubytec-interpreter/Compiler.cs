using System.Text;
using System.Text.RegularExpressions;
using ubytec_interpreter.Operations;
using static ubytec_interpreter.Operations.CoreOperations;
using static ubytec_interpreter.Operations.Primitives;

namespace ubytec_interpreter
{
    internal static partial class Compiler
    {
        private static readonly Dictionary<string, byte> OpcodeMap = new()
        {
            // Control Flow
            { "TRAP", 0x00 },
            { "NOP", 0x01 },
            { "BLOCK", 0x02 },
            { "LOOP", 0x03 },
            { "IF", 0x04 },
            { "ELSE", 0x05 },
            { "END", 0x06 },
            { "BREAK", 0x07 },
            { "CONTINUE", 0x08 },
            { "RETURN", 0x09 },
            { "BRANCH", 0x0A },
            { "SWITCH", 0x0B },
            { "WHILE", 0x0C },
            { "CLEAR", 0x0D },
            { "DEFAULT", 0x0E },
            { "NULL", 0x0F },
        
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

        //public static byte[] ParseOperationsToByteArray(params IOpCode[] opCodes)
        //{
        //    var l = new List<byte>();
        //    foreach (var opCode in opCodes)
        //    {
        //        l.Add(opCode.OpCode);
        //        if (opCode.Operands != null)
        //            foreach (var operand in opCode.Operands)
        //                l.Add(operand);
        //    }
        //    return [.. l];
        //}
        public static string CompileToX86(byte[] bytecode)
        {
            var asm = new List<string>
            {
                "bits 64",
                "default rel",
                "section .text",
                "global _start",
                "",
                "_start:",
                "  sub rsp, 128  ; or some safe big value",
                "  call main      ; call on main",
                "  pop rbx        ; get return value",
                "  add rsp, 128",
                // Normally, you'd want an exit if we reach end of bytecode:
                "  mov rax, 60    ; sys_exit",
                "  mov rdi, 0     ; status = 0",
                "  syscall",
                "",
                "_main:"
            };

            Dictionary<string, int> PrefixToLabelCounterMap = [];

            // We'll keep a naive stack on the CPU stack itself:
            //   push / pop registers for data manipulation.
            // For BLOCK / IF / LOOP, we generate labels.
            // Each time we see a structured opcode, we'll create a label or jump.
            Stack<object> blockEndStack = new Stack<object>();
            Stack<object> blockStartStack = new Stack<object>();
            Stack<object> blockExpectedTypeStack = new Stack<object>();
            Stack<object> blockActualTypeStack = new Stack<object>();

            int codeCounter = 0;
            while (codeCounter < bytecode.Length)
            {
                byte opcode = bytecode[codeCounter];
                int lastCount = codeCounter;
                if (opcode >= 0x00 && opcode <= 0x0F)
                    _ = 1;
                //HandleControlFlowOpCodes(opcode);
                else if (opcode >= 0x10 && opcode <= 0x1F)
                    HandleStackOpCodes(opcode);
                else if (opcode >= 0x20 && opcode <= 0x2F)
                    HandleArithmeticOpCodes(opcode);
                else
                {
                    throw new Exception($"Unknown opcode 0x{opcode:X2}");
                }
                if (lastCount == codeCounter) codeCounter++;
            }

            return string.Join('\n', asm);

            void HandleStackOpCodes(byte opcode)
            {
                switch (opcode)
                {
                    case 0x11: // PUSH <type> <value>
                        {
                            if (codeCounter + 1 >= bytecode.Length)
                                throw new Exception("PUSH missing type and value operand");

                            byte valueType = bytecode[codeCounter++];  // Read type (DO NOT increment pc yet)
                            int valueSize = GetTypeSize(valueType);
                            if (valueSize == 0)
                            {
                                valueType = 0x7F;
                                valueSize = GetTypeSize(valueType);
                            }

                            //throw new Exception($"PUSH with unsupported type 0x{valueType:X2}");

                            if (codeCounter + 1 + valueSize > bytecode.Length)
                                throw new Exception($"PUSH {GetTypeName(valueType)} missing value");

                            byte[] valueBytes = bytecode[codeCounter..(codeCounter + valueSize)];
                            codeCounter += valueSize;  // Increment pc AFTER slicing valueBytes

                            string asmPushInstruction = GeneratePushInstruction(valueType, valueBytes);
                            asm.Add(GetDepth()+asmPushInstruction);
                            blockActualTypeStack.Push(valueType);  // Track pushed type
                            break;
                        }

                    case 0x12: // POP
                        {
                            asm.Add(GetDepth()+"  pop rax   ; POP - Remove top stack value");
                            blockActualTypeStack.Pop(); // Remove top stack type
                            break;
                        }

                    case 0x13: // DUP
                        {
                            asm.Add(GetDepth()+"  pop rax   ; DUP - Duplicate top stack value");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rax");
                            blockActualTypeStack.Push(blockActualTypeStack.Peek()); // Duplicate type
                            break;
                        }

                    case 0x14: // SWAP
                        {
                            asm.Add(GetDepth()+"  pop rax   ; SWAP - Swap top two values");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rbx");

                            // Swap types
                            var topType = blockActualTypeStack.Pop();
                            var secondType = blockActualTypeStack.Pop();
                            blockActualTypeStack.Push(topType);
                            blockActualTypeStack.Push(secondType);
                            break;
                        }

                    case 0x15: // ROT (A, B, C → C, A, B)
                        {
                            asm.Add(GetDepth()+"  pop rax   ; ROT - Rotate top three values");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  pop rcx");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rcx");
                            asm.Add(GetDepth()+"  push rbx");

                            // Rotate types
                            var top = blockActualTypeStack.Pop();
                            var second = blockActualTypeStack.Pop();
                            var third = blockActualTypeStack.Pop();
                            blockActualTypeStack.Push(top);
                            blockActualTypeStack.Push(third);
                            blockActualTypeStack.Push(second);
                            break;
                        }

                    case 0x16: // OVER (A, B → A, B, B)
                        {
                            asm.Add(GetDepth()+"  pop rax   ; OVER - Duplicate second value");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  push rbx");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rbx");

                            // Duplicate second type
                            var top = blockActualTypeStack.Pop();
                            var second = blockActualTypeStack.Pop();
                            blockActualTypeStack.Push(second);
                            blockActualTypeStack.Push(top);
                            blockActualTypeStack.Push(second);
                            break;
                        }

                    case 0x17: // NIP (A, B → B)
                        {
                            asm.Add(GetDepth()+"  pop rax   ; NIP - Remove second value");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  push rax");

                            // Remove second type
                            blockActualTypeStack.Pop();
                            break;
                        }

                    case 0x18: // DROP <stackIndex>
                        {
                            if (codeCounter >= bytecode.Length)
                                throw new Exception("DROP missing operand");

                            byte stackIndex = bytecode[codeCounter++];
                            asm.Add(GetDepth()+$"  ; DROP {stackIndex} - Remove item at depth {stackIndex}");

                            if (stackIndex == 0)
                            {
                                asm.Add(GetDepth()+"  pop rax   ; DROP - Remove top stack value");
                            }
                            else
                            {
                                asm.Add(GetDepth()+$"  mov rbx, rsp");
                                asm.Add(GetDepth()+$"  add rbx, {stackIndex * 8}   ; Move to target stack index");
                                asm.Add(GetDepth()+"  mov rax, [rbx]   ; Load the value");
                                asm.Add(GetDepth()+"  add rsp, 8       ; Remove the top");
                                asm.Add(GetDepth()+"  push rax         ; Push back the adjusted stack");
                            }
                            blockActualTypeStack.Pop(); // Remove from type tracking
                            break;
                        }

                    case 0x19: // 2DUP (Duplicate top two elements)
                        {
                            asm.Add(GetDepth()+"  pop rax   ; 2DUP - Duplicate top two");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  push rbx");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rbx");
                            asm.Add(GetDepth()+"  push rax");

                            // Duplicate top two types
                            var first = blockActualTypeStack.Pop();
                            var second = blockActualTypeStack.Pop();
                            blockActualTypeStack.Push(second);
                            blockActualTypeStack.Push(first);
                            blockActualTypeStack.Push(second);
                            blockActualTypeStack.Push(first);
                            break;
                        }

                    case 0x1A: // 2SWAP (Swap top two pairs)
                        {
                            asm.Add(GetDepth()+"  pop rax   ; 2SWAP - Swap top two pairs");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  pop rcx");
                            asm.Add(GetDepth()+"  pop rdx");
                            asm.Add(GetDepth()+"  push rbx");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rdx");
                            asm.Add(GetDepth()+"  push rcx");

                            var first = blockActualTypeStack.Pop();
                            var second = blockActualTypeStack.Pop();
                            var third = blockActualTypeStack.Pop();
                            var fourth = blockActualTypeStack.Pop();
                            blockActualTypeStack.Push(second);
                            blockActualTypeStack.Push(first);
                            blockActualTypeStack.Push(fourth);
                            blockActualTypeStack.Push(third);
                            break;
                        }

                    case 0x1B: // 2ROT (Rotate top six items in pairs)
                        {
                            asm.Add(GetDepth()+"  pop rax   ; 2ROT - Rotate top six items");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  pop rcx");
                            asm.Add(GetDepth()+"  pop rdx");
                            asm.Add(GetDepth()+"  pop rsi");
                            asm.Add(GetDepth()+"  pop rdi");
                            asm.Add(GetDepth()+"  push rbx");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rdx");
                            asm.Add(GetDepth()+"  push rcx");
                            asm.Add(GetDepth()+"  push rdi");
                            asm.Add(GetDepth()+"  push rsi");

                            var first = blockActualTypeStack.Pop();
                            var second = blockActualTypeStack.Pop();
                            var third = blockActualTypeStack.Pop();
                            var fourth = blockActualTypeStack.Pop();
                            var fifth = blockActualTypeStack.Pop();
                            var sixth = blockActualTypeStack.Pop();
                            blockActualTypeStack.Push(second);
                            blockActualTypeStack.Push(first);
                            blockActualTypeStack.Push(fourth);
                            blockActualTypeStack.Push(third);
                            blockActualTypeStack.Push(sixth);
                            blockActualTypeStack.Push(fifth);
                            break;
                        }

                    case 0x1C: // 2OVER (Duplicate second pair)
                        {
                            asm.Add(GetDepth()+"  pop rax   ; 2OVER - Copy second pair");
                            asm.Add(GetDepth()+"  pop rbx");
                            asm.Add(GetDepth()+"  pop rcx");
                            asm.Add(GetDepth()+"  pop rdx");
                            asm.Add(GetDepth()+"  push rdx");
                            asm.Add(GetDepth()+"  push rcx");
                            asm.Add(GetDepth()+"  push rbx");
                            asm.Add(GetDepth()+"  push rax");
                            asm.Add(GetDepth()+"  push rdx");
                            asm.Add(GetDepth()+"  push rcx");

                            var first = blockActualTypeStack.Pop();
                            var second = blockActualTypeStack.Pop();
                            var third = blockActualTypeStack.Pop();
                            var fourth = blockActualTypeStack.Pop();
                            blockActualTypeStack.Push(fourth);
                            blockActualTypeStack.Push(third);
                            blockActualTypeStack.Push(second);
                            blockActualTypeStack.Push(first);
                            blockActualTypeStack.Push(fourth);
                            blockActualTypeStack.Push(third);
                            break;
                        }

                    case 0x1D: // PICK <index>
                        {
                            if (codeCounter >= bytecode.Length)
                                throw new Exception("PICK missing operand");

                            codeCounter++;
                            byte index = bytecode[codeCounter++];
                            asm.Add(GetDepth()+$"  ; PICK {index} - Duplicate value at index {index}");

                            // Load the value from the stack at the given index (counting from the top)
                            asm.Add(GetDepth()+$"  mov rax, [rsp + {index * 8}]   ; Load value from index {index}");
                            asm.Add(GetDepth()+"  push rax                       ; Push the value back on top");

                            // Fix type tracking: Properly extract type at "index" from the top of the stack
                            var tempTypeStack = blockActualTypeStack.ToArray();  // Convert stack to array for indexed access
                            blockActualTypeStack.Push(tempTypeStack[index]);     // Push the correct type onto the stack

                            break;
                        }

                    case 0x1E: // ROLL <index>
                        {
                            if (codeCounter >= bytecode.Length)
                                throw new Exception("ROLL missing operand");

                            codeCounter++;
                            byte index = bytecode[codeCounter++];
                            asm.Add(GetDepth()+$"  ; ROLL {index} - Move value at index {index} to the top");

                            if (index == 0)
                            {
                                // If index == 0, nothing needs to be done
                                break;
                            }

                            // Load the target element (without popping yet)
                            asm.Add(GetDepth()+$"  mov rax, [rsp + {index * 8}]   ; Load value at index {index}");

                            // Shift down all elements above the target
                            for (int i = index; i > 0; i--)
                            {
                                asm.Add(GetDepth()+$"  mov rbx, [rsp + {(i - 1) * 8}]  ; Load element above");
                                asm.Add(GetDepth()+$"  mov [rsp + {i * 8}], rbx       ; Shift it down");
                            }

                            // Move the extracted value to the top
                            asm.Add(GetDepth()+"  mov [rsp], rax   ; Place the rolled value at the top");

                            // Adjust type tracking:
                            var tempTypeStack = new Stack<byte>();
                            for (int i = 0; i < index; i++)
                            {
                                tempTypeStack.Push(Convert.ToByte(blockActualTypeStack.Pop()));
                            }
                            byte movedType = Convert.ToByte(blockActualTypeStack.Pop());
                            while (tempTypeStack.Count > 0)
                            {
                                blockActualTypeStack.Push(tempTypeStack.Pop());
                            }
                            blockActualTypeStack.Push(movedType);
                            break;
                        }


                    default:
                        throw new Exception($"Unknown opcode 0x{opcode:X2}");
                }
            }
            void HandleArithmeticOpCodes(byte opcode)
            {
                switch (opcode)
                {
                    // -------------------------
                    // In-Place 64-bit arithmetic
                    // -------------------------

                    case 0x20: // ADD
                               // Instead of popping two values, we do:
                               //   mov rax, [rsp]        ; top-of-stack
                               //   add [rsp+8], rax      ; second-top += top
                               //   add rsp, 8            ; effectively pop top
                        asm.Add(GetDepth() + "  ; In-place ADD [rsp+8] += [rsp]");
                        asm.Add(GetDepth() + "  mov rax, [rsp]");
                        asm.Add(GetDepth() + "  add [rsp+8], rax");
                        asm.Add(GetDepth() + "  add rsp, 8   ; remove old top");
                        break;

                    case 0x21: // SUB
                               // second = [rsp+8], top = [rsp]
                               // => second -= top
                        asm.Add(GetDepth() + "  ; In-place SUB [rsp+8] -= [rsp]");
                        asm.Add(GetDepth() + "  mov rax, [rsp]");
                        asm.Add(GetDepth() + "  sub [rsp+8], rax");
                        asm.Add(GetDepth() + "  add rsp, 8");
                        break;

                    case 0x22: // MUL (Signed)
                               // second = [rsp+8], top = [rsp]
                               // => second = second * top
                               // Because x86 does not allow mem * mem, we do:
                               //   mov rax, [rsp+8]
                               //   imul qword [rsp]
                               //   mov [rsp+8], rax
                               //   add rsp, 8
                        asm.Add(GetDepth() + "  ; In-place IMUL [rsp+8] *= [rsp]");
                        asm.Add(GetDepth() + "  mov rax, [rsp+8]");
                        asm.Add(GetDepth() + "  imul qword [rsp]");
                        asm.Add(GetDepth() + "  mov [rsp+8], rax");
                        asm.Add(GetDepth() + "  add rsp, 8");
                        break;

                    case 0x23: // DIV (Signed)
                               // second = [rsp+8], top = [rsp]
                               // => second /= top, with remainder in rdx
                               // typical steps:
                               //   mov rax, [rsp+8]
                               //   cqo
                               //   idiv qword [rsp]
                               //   mov [rsp+8], rax
                               //   add rsp, 8
                        asm.Add(GetDepth() + "  ; In-place IDIV [rsp+8] / [rsp]");
                        asm.Add(GetDepth() + "  mov rax, [rsp+8]");
                        asm.Add(GetDepth() + "  cqo");
                        asm.Add(GetDepth() + "  idiv qword [rsp]");
                        asm.Add(GetDepth() + "  mov [rsp+8], rax");
                        asm.Add(GetDepth() + "  add rsp, 8");
                        break;

                    // -------------
                    // Remaining ops
                    // -------------

                    case 0x24: // MOD (Remainder)
                               // For remainder, we cannot do an in-place approach quite as easily
                               // because we want the remainder from RDX. We'll do the old approach:
                        asm.Add(GetDepth() + "  pop rbx      ; Load divisor");
                        asm.Add(GetDepth() + "  pop rax      ; Load dividend");
                        asm.Add(GetDepth() + "  cqo          ; Sign extend RAX -> RDX:RAX");
                        asm.Add(GetDepth() + "  idiv rbx     ; quotient in RAX, remainder in RDX");
                        asm.Add(GetDepth() + "  push rdx     ; push remainder");
                        break;

                    case 0x25: // INC (Increment)
                               // For unary ops, we can still do a normal pop/push
                        asm.Add(GetDepth() + "  pop rax      ; Load value");
                        asm.Add(GetDepth() + "  inc rax      ; Increment value");
                        asm.Add(GetDepth() + "  push rax     ; Push result back");
                        break;

                    case 0x26: // DEC (Decrement)
                        asm.Add(GetDepth() + "  pop rax      ; Load value");
                        asm.Add(GetDepth() + "  dec rax      ; Decrement value");
                        asm.Add(GetDepth() + "  push rax     ; Push result");
                        break;

                    case 0x27: // NEG (Negate)
                        asm.Add(GetDepth() + "  pop rax      ; Load value");
                        asm.Add(GetDepth() + "  neg rax      ; Negate value");
                        asm.Add(GetDepth() + "  push rax     ; Push result");
                        break;

                    case 0x28: // ABS (Absolute value)
                               // Standard approach: test => js => neg => done
                        asm.Add(GetDepth() + "  pop rax        ; Load value");
                        asm.Add(GetDepth() + "  test rax, rax  ; Check if negative");
                        string labelNeg = NextLabel("abs_neg");
                        string labelDone = NextLabel("abs_done");
                        asm.Add(GetDepth() + $"  js {labelNeg}   ; If sign is negative, jump");
                        asm.Add(GetDepth() + $"  jmp {labelDone} ; else skip neg");
                        asm.Add(GetDepth() + $"{labelNeg}:");
                        asm.Add(GetDepth() + "  neg rax        ; if negative => neg rax");
                        asm.Add(GetDepth() + $"{labelDone}:");
                        asm.Add(GetDepth() + "  push rax       ; push absolute value");
                        break;

                    default:
                        throw new Exception($"Unknown arithmetic opcode 0x{opcode:X2}");
                }
            }

            // Generate a unique label for jumps
            string NextLabel(string prefix)
            {
                PrefixToLabelCounterMap.TryAdd(prefix, 0);
                return $"{prefix}_{PrefixToLabelCounterMap[prefix]++}";
            }

            string GetDepth(int basis = 0)
            {
                var output = string.Empty;
                var depth = blockEndStack.Count + basis;
                for (int i = 0; i < depth; i++)
                    output += "  ";
                return output;
            }
        }

        private static int GetTypeSize(byte valueType)
        {
            return valueType switch
            {
                0x7F => 1,  // i32 (1 byte)
                0x7E => 8,  // i64 (8 bytes)
                0x7D => 4,  // f64 (4 bytes)
                0x01 => 1,  // BOOL (1 byte)
                0x7C => 2,  // i16 (2 bytes)
                0x7B => 4,  // f32 (4 bytes)
                0x7A => 8,  // custom 64-bit struct
                _ => 0      // Unsupported type
            };
        }
        private static string GeneratePushInstruction(byte valueType, byte[] valueBytes)
        {
            return valueType switch
            {
                0x7F => $"  push qword {valueBytes[0]}   ; PUSH {valueBytes[0]} (i32)",
                0x7E => $"  push qword {BitConverter.ToInt64(valueBytes, 0)}   ; PUSH {BitConverter.ToInt64(valueBytes, 0)} (i64)",
                0x7D => $"  push qword {BitConverter.ToSingle(valueBytes, 0)}   ; PUSH {BitConverter.ToSingle(valueBytes, 0)} (f64)",
                0x01 => $"  push qword {valueBytes[0]}   ; PUSH {(valueBytes[0] != 0 ? "true" : "false")} (BOOL)",
                0x7C => $"  push qword {BitConverter.ToInt16(valueBytes, 0)}   ; PUSH {BitConverter.ToInt16(valueBytes, 0)} (i16)",
                0x7B => $"  push qword {BitConverter.ToSingle(valueBytes, 0)}   ; PUSH {BitConverter.ToSingle(valueBytes, 0)} (f32)",
                _ => throw new Exception($"Unsupported PUSH type 0x{valueType:X2}")
            };
        }
        private static string GetTypeName(byte valueType)
        {
            return valueType switch
            {
                0x7F => "i32",
                0x7E => "i64",
                0x7D => "f64",
                0x01 => "bool",
                0x7C => "i16",
                0x7B => "f32",
                _ => $"UnknownType(0x{valueType:X2})"
            };
        }

        public static (ValueType[], IOpCode[], SyntaxToken[]) Parse(string code)
        {
            List<ValueType> bytecode = [];
            List<IOpCode> opCode = [];
            List<SyntaxToken> syntaxTokens = [];
            Stack<Variable> variables = new();

            var lines = code.Split('\n')
                            .Select(line => line.Trim())
                            .Where(line => !string.IsNullOrWhiteSpace(line) && !line.StartsWith("//"))
                            .ToArray();

            for (int y = 0; y < lines.Length; y++)
            {
                var line = lines[y];
                var tokens = CodeRegex().Split(line).Where(t => !string.IsNullOrWhiteSpace(t)).ToArray();
                if (tokens.Length == 0) continue;

                string instruction = tokens[0].ToUpper().TrimEnd(';');
                syntaxTokens.Add(new SyntaxToken(instruction, line, y, 0));

                if (instruction.StartsWith("T_"))
                {
                    var trimmed = instruction.Remove(0, 2);
                    var a = Enum.Parse<PrimitiveType>(trimmed, true);
                    syntaxTokens.Add(new SyntaxToken(tokens[1], line, y, 1));
                    syntaxTokens.Add(new SyntaxToken(tokens[2], line, y, 2));
                    var variable = new Variable(a, instruction.EndsWith('?'), tokens[1], tokens[2]);
                    variables.Push(variable);
                    continue;
                }

                if (!OpcodeMap.TryGetValue(instruction, out byte opcode))
                    throw new Exception($"Unknown instruction: {instruction}");

                var temp = new Queue<ValueType>();
                bytecode.Add(opcode);
                temp.Enqueue(opcode);

                // Process operands (assumes operands are hex or decimal values)
                for (int i = 1; i < tokens.Length; i++)
                {
                    var currentToken = tokens[i];
                    syntaxTokens.Add(new SyntaxToken(currentToken, line, y, i));

                    if (currentToken.StartsWith("0x", StringComparison.OrdinalIgnoreCase))
                    {
                        var a = Convert.ToInt32(currentToken, 16);
                        bytecode.Add(a);
                        temp.Enqueue(a);
                    }
                    else if (currentToken.Contains('.', StringComparison.OrdinalIgnoreCase))
                    {
                        var a = Convert.ToSingle(currentToken);
                        bytecode.Add(a);
                        temp.Enqueue(a);
                    }
                    else if (currentToken.StartsWith("t_", StringComparison.OrdinalIgnoreCase))
                    {
                        var trimmed = currentToken.Remove(0, 2);
                        var a = Enum.Parse<PrimitiveType>(trimmed, true);
                        bytecode.Add(a);
                        temp.Enqueue(a);
                    }
                    else if (byte.TryParse(currentToken, out byte byteValue))
                    {
                        bytecode.Add(byteValue);
                        temp.Enqueue(byteValue);
                    }
                    else if (int.TryParse(currentToken, out int intValue))
                    {
                        bytecode.Add(intValue);
                        temp.Enqueue(intValue);
                    }
                    else if (currentToken.StartsWith(';')) break;
                    else if (currentToken == "==" || currentToken == "!=" || currentToken == ">=" || currentToken == "<=")
                    {
                        bytecode.Add((byte)(currentToken.First() & 0xFF));  // Lower byte 
                        bytecode.Add((byte)(currentToken.Last() & 0xFF)); //Upper byte

                        temp.Enqueue((byte)(currentToken.First() & 0xFF));  // Lower byte 
                        temp.Enqueue((byte)(currentToken.Last() & 0xFF)); //Upper byte
                    }
                    else if (currentToken == ">" || currentToken == "<")
                    {
                        // Para un operador de un solo carácter, usamos solo su valor ASCII.
                        byte lowerByte = (byte)currentToken[0];
                        // Si la lógica de IF espera dos bytes, podemos añadir un 0 como byte superior.
                        byte upperByte = 0;

                        bytecode.Add(lowerByte);
                        bytecode.Add(upperByte);

                        temp.Enqueue(lowerByte);
                        temp.Enqueue(upperByte);
                    }
                    else throw new Exception($"Invalid operand: {currentToken}");
                }

                var dequed = temp.Dequeue();
                var last = opCode.LastOrDefault();
                IOpCode? op;

                if (last != null && last is BLOCK or LOOP or IF or ELSE or BRANCH or SWITCH or WHILE)
                {
                    List<Variable>? variab = ((dynamic)last).Variables;
                    variab.AddRange(variables.ToArray());
                    op = CreateInstruction((byte)dequed, new((List<Variable>)((dynamic)last).Variables), [.. temp]);
                    variables.Clear();
                }
                else
                    op = CreateInstruction((byte)dequed, new(), [.. temp]);

                opCode.Add(op);

            }

            return ([.. bytecode], [.. opCode], [.. syntaxTokens]);
        }
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
                0x0C => new WHILE(operands.Length > 0 ? operands.Cast<int>().ToArray() : [],
                    [.. variables]),
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
        }

        /// <summary>
        /// Compila un AST a partir de los opCodes y tokens proporcionados.
        /// </summary>
        /// <param name="opCodes">Array de opCodes.</param>
        /// <param name="tokens">Array de tokens (pueden ser más tokens que opCodes, pues incluyen operandos, operadores, etc.).</param>
        /// <returns>El árbol sintáctico compilado.</returns>
        public static SyntaxTree? CompileSyntax(IOpCode[] opCodes, SyntaxToken[] tokens)
        {
            // Se crea el árbol raíz con una oración inicial.
            SyntaxTree lastRoot = new SyntaxTree(new SyntaxSentence());

            // Agrupamos los tokens por la propiedad "Row" (suponiendo que cada grupo corresponde a una instrucción o línea).
            var tokensByRow = tokens
                .GroupBy(t => t.Row)
                .OrderBy(g => g.Key)
                .ToDictionary(g => g.Key, g => g.ToList());

            int currentRow = 0;
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
        /// Construye (o modifica) el árbol sintáctico agregando un nodo con el opCode dado y los tokens asociados.
        /// </summary>
        /// <param name="tree">El árbol sintáctico en construcción.</param>
        /// <param name="opCode">El opCode actual.</param>
        /// <param name="tokens">La lista de tokens correspondientes a esta instrucción.</param>
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
        /// Recursively compiles a SyntaxTree into NASM code.
        /// </summary>
        /// <param name="tree">The AST to compile.</param>
        /// <returns>A string with the generated NASM code.</returns>
        public static string CompileAST(SyntaxTree tree) => CompileSentence(tree.RootSentence.Sentences.First(), new(), new(), new(), new());

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

        private static string CompileBlockNode(SyntaxSentence sentence, SyntaxNode node, params Stack<object>[] stacks)
        {
            StringBuilder code = new StringBuilder();

            var initialDepth = GetDepth();

            if (node.Operation is ELSE)
            {
                // Compilamos la operación de apertura
                if (node.Operation != null)
                    code.AppendLine(FormatCompiledLines(node.Operation.Compile(stacks), GetDepth(-1)));
            }
            else
                // Compilamos la operación de apertura
                if (node.Operation != null)
                code.AppendLine(FormatCompiledLines(node.Operation.Compile(stacks), initialDepth));


            // Compilamos el cuerpo del bloque: las sentencias anidadas se insertan justo aquí
            if (sentence.Sentences != null)
                foreach (var childSentence in sentence.Sentences)
                    code.Append(FormatCompiledLines(CompileSentence(childSentence, stacks), string.Empty));

            if (node.Children == null || node.Children.Count == 0)
                return code.ToString();

            // Seleccionamos el nodo de cierre y lo eliminamos de los hijos
            var closingNode = node.Children.Last();
            var nodeActions = node.Children.GetRange(0, node.Children.Count - 1);

            foreach (var n in nodeActions)
                if (n.Operation != null)
                    code.AppendLine(FormatCompiledLines(n.Operation.Compile(stacks), GetDepth()));

            // Finalmente, compilamos la operación de cierre, que asumimos es el último hijo del nodo
            if (closingNode.Operation != null)
                code.AppendLine(FormatCompiledLines(closingNode.Operation.Compile(stacks), GetDepth()));

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
