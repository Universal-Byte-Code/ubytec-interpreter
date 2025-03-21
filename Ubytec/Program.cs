using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.Lexical;
using Ubytec.Language.Tools;
using Ubytec.Language.Tools.Serialization;
using Ubytec.Tools.AST;

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
        t_int32 i 0
        while 2 != 10
            if 2 == 9
                nop
            else
                nop
            end
        end
    return
";


LexicalAnalyst.InitializeGrammar();
var tmTokens = LexicalAnalyst.Tokenize(code);

var opCode = ASTCompiler.Parse([..tmTokens]);
Console.WriteLine("Correctly parsed the ubytec source code!");

var (compiled, errors0) = ASTCompiler.CompileSyntax(opCode, [..tmTokens]);
foreach (var error in errors0) Console.WriteLine(error);
if (errors0.Count == 0) Console.WriteLine("Correctly compiled the AST!");

var errors1 = SyntaxTreeValidator.CheckSyntaxTreeSchema(compiled);
foreach (var error in errors1) Console.WriteLine(error);
if (errors1.Count == 0) Console.WriteLine("Correctly validated the AST!");

var nasm = ASTCompiler.CompileAST(compiled);
Console.WriteLine("Correctly compiled to nasm!");
//var b = Compiler.ParseOperationsToByteArray(opC0de);
//var compiled = Compiler.CompileToX86(byteCode); 
//var optimized = Optimizer.OptimizePushPop(compiled);
//optimized = Optimizer.OptimizeMiscPatterns(optimized);
//var optimized2 = Compiler.Optimize(optimized);
var options = new JsonSerializerOptions
{
    WriteIndented = false,
    IncludeFields = false,
    RespectNullableAnnotations = true
};

options.Converters.Add(new IOpCodeConverter());
options.Converters.Add(new ISyntaxTreeConverter());

string json = JsonSerializer.Serialize(compiled, options);
string codecJson = Utf64Codec.Encode(json);

using (var file1 = File.CreateText(Path.Combine(Directory.GetParent(Environment.CurrentDirectory).Parent.Parent.Parent.FullName, "ubc-compiled.ubc.nasm")))
{
    file1.Write(nasm);
}
using (var file2 = File.CreateText(Path.Combine(Directory.GetParent(Environment.CurrentDirectory).Parent.Parent.Parent.FullName, "ubc-compiled.ubc.ast.json")))
{
    file2.Write(json);
}
using (var file3 = File.CreateText(Path.Combine(Directory.GetParent(Environment.CurrentDirectory).Parent.Parent.Parent.FullName, "ubc-compiled.ubc.ast.json.utf64")))
{
    file3.Write(codecJson);
}
