namespace Ubytec.Language.Tools
{
    internal static partial class DeprecatedCompiler
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
            var blockEndStack = new Stack<object>();
            var blockStartStack = new Stack<object>();
            var blockExpectedTypeStack = new Stack<object>();
            var blockActualTypeStack = new Stack<object>();

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
                                asm.Add(GetDepth()+"  pop rax   ; DROP - Remove top stack value");
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
                                // If index == 0, nothing needs to be done
                                break;

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
    }
}
