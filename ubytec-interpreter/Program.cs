using System.Text.Json;
using ubytec_interpreter;
using static ubytec_interpreter.Operations.StackOperarions;

//var code = @"
//BLOCK 0x7F
//    PUSH 0x7F 0x00     ; First Fibonacci number (fib1 = 0)
//    PUSH 0x7F 0x01     ; Second Fibonacci number (fib2 = 1)
//    PUSH 0x7F 0x0A     ; Push 10 (countdown from 10)
//    WHILE
//        BLOCK 0x7F
//            DUP          ; Duplicate count
//            IF 0x7F
//                OVER     ; Copy fib1
//                OVER     ; Copy fib2
//                ADD      ; fibNext = fib1 + fib2
//                PICK 2   ; Get fib2
//                SWAP     ; Swap fibNext and fib2
//                PICK 4   ; Get fib1
//                ROLL 3   ; Roll fib1 to bottom
//                DEC      ; Decrease counter
//            ELSE
//                BREAK  ; Exit loop if count == 0
//            END
//        END
//    RETURN
//";

//SEGUNDA SENTENCE ES ELSE

var code = @"
block t_void
    if 1 == 1
        if 2 != 2
            nop
        end
    else
        nop
    end
end
";

var (byteCode, opCode, tokens) = Compiler.Parse(code);
var compiled = Compiler.CompileSyntax(opCode, tokens);
var nasm = Compiler.CompileAST(compiled);
//var b = Compiler.ParseOperationsToByteArray(opC0de);
//var compiled = Compiler.CompileToX86(byteCode); 
//var optimized = Optimizer.OptimizePushPop(compiled);
//optimized = Optimizer.OptimizeMiscPatterns(optimized);
//var optimized2 = Compiler.Optimize(optimized);
var options = new JsonSerializerOptions
{
    WriteIndented = true,
    IncludeFields = false
};

options.Converters.Add(new IOpCodeConverter());

string json = JsonSerializer.Serialize(compiled, options);
Console.WriteLine(nasm);

Console.ReadLine();
