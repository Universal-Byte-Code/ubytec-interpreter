// Program.cs
//
// * end-to-end* driver for the whole Ubytec tool-chain.
//
// ────────────────────────────────────────────────────────────────
//  1.  LexicalAnalyst  →  SyntaxToken[]
//  2.  HighLevelParser →  Module  (+ collected ParseErrors)
//  3.  `module.Compile(scopes)`  →  NASM
//  4.  JSON  +  UTF-64 dumps
// ────────────────────────────────────────────────────────────────

using System.Text.Json;
using Ubytec.Language.AST;
using Ubytec.Language.Grammar;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Tools;
using Ubytec.Language.Tools.Serialization;

[assembly: CLSCompliant(false)]
[assembly: System.Runtime.InteropServices.ComVisible(false)]

var source = """
module (name:"demo", version:"0.1", author:"papifuckingshushi")
{
    func Main() -> t_void
    {
        local
        {
            t_int32 counter 0
        }

        block t_void
            t_bool thisIsFromTheBlock true
            loop t_void
                t_bool hello false
                if 2 != 2
                    t_half theHalf 0.8
                    nop
                    if 3 == 3
                        nop
                    end
                else
                    t_int32 uwu 17
                    nop
                end
            end
        end
    }
}
""";

// 1.  lexical analysis -------------------------------------------------------
LexicalAnalyst.InitializeGrammar();
var tokens = LexicalAnalyst.Tokenize(source);

// 2.  high-level parse (with graceful error collection) ----------------------..
var (rootModule, parseErrors) = HighLevelParser.ParseModule([.. tokens]);

if (parseErrors.Length > 0)
{
    Console.ForegroundColor = ConsoleColor.Yellow;
    Console.WriteLine("High-level parse completed with warnings/errors:");
    foreach (var e in parseErrors)
        Console.WriteLine($"[line {e.Line}] {e.Where}: {e.Message}");
    Console.ResetColor();
}
else
{
    Console.WriteLine("High-level parse succeeded (0 errors).");
}

// 3.  compile the *root module* directly -------------------------------------
var scopes = new CompilationScopes();          // empty stack
var nasm = rootModule.Compile(scopes);       // every nested entity compiles itself!

File.WriteAllText("output.ubc.nasm", nasm);
Console.WriteLine($"✓ NASM written to  {Path.GetFullPath("output.ubc.nasm")}");

// 4.  JSON + UTF-64 serialisation -------------------------------------------
var opts = new JsonSerializerOptions
{
    WriteIndented              = true,
    IncludeFields              = false,
    RespectNullableAnnotations = true
};

opts.Converters.Add(new IOpCodeConverter());
opts.Converters.Add(new ISyntaxTreeConverter());
opts.Converters.Add(new IUbytecExpressionFragmentConverter());
opts.Converters.Add(new IUbytecEntityConverter());

var json = JsonSerializer.Serialize(rootModule, opts);
var utf64 = Utf64Codec.Encode(json);

File.WriteAllText("output.module.ubc.json", json);
File.WriteAllText("output.module.ubc.json.utf64", utf64);

Console.WriteLine("✓ JSON and UTF-64 artefacts written.");
