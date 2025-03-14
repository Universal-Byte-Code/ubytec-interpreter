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
    t_bool thisIsFromTheBlock true
    loop t_void
        t_bool hello false
        if 1 == 1
            if 2 != 2
            t_half theHalf 0.8
                nop
            end
        else
            t_int32 uwu 17
            nop
        end
    end
    while 666 t_bool 2 != 2 
        t_void dearGoffyGod false
        nop
    end
end
";

var (opCode, tokens) = ASTCompiler.Parse(code);
var compiled = ASTCompiler.CompileSyntax(opCode, tokens);
var nasm = ASTCompiler.CompileAST(compiled);
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

using (var file1 = File.CreateText(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop),"ubc-compiled.ubc.nasm")))
{
    file1.WriteLine(nasm);
}
using (var file2 = File.CreateText(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "ubc-compiled.ubc.ast.json")))
{
    file2.WriteLine(json);
}
