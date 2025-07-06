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
using Ubytec.Language.Tools.Serialization;

internal static class SerializerOptionsHelper
{
    public static JsonSerializerOptions Options { get; private set; } = new()
    {
        WriteIndented              = true,
        IncludeFields              = false,
        RespectNullableAnnotations = true,
        Converters = { 
            new IOpCodeConverter(),
            new ISyntaxTreeConverter(),
            new IUbytecExpressionFragmentConverter(),
            new IUbytecEntityConverter() }
    };

}