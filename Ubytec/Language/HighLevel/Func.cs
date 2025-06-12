using System.Numerics;
using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Func : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public UType ReturnType { get; }
        public Argument[] Arguments { get; }
        public LocalContext? Locals { get; }
        public SyntaxSentence? Definition { get; }

        public Func(string name, UType returnType, Guid id, Argument[]? arguments = null, LocalContext? locals = null, TypeModifiers modifiers = TypeModifiers.None, SyntaxSentence? definitionSentence = null)
        {
            Name= name;
            ID= id;
            Modifiers= modifiers;
            ReturnType= returnType;
            Arguments= arguments ?? [];
            Locals= locals;
            Definition= definitionSentence;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Function name cannot be null or empty.");

            if ((Modifiers & (TypeModifiers.Const | TypeModifiers.Sealed)) != 0)
                throw new Exception($"Function '{Name}' cannot have modifiers: const or sealed.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Function '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Global | TypeModifiers.Local)).CountSetBits() > 1)
                throw new Exception($"Function '{Name}' cannot be both global and local.");

            if (Modifiers.HasFlag(TypeModifiers.Abstract) && Definition is not null)
                throw new Exception($"Function '{Name}' is abstract and should not have a body.");

            if (!Modifiers.HasFlag(TypeModifiers.Abstract) && Definition is null)
                throw new Exception($"Function '{Name}' must have a definition unless it is abstract.");

            var argumentNames = new HashSet<string>();
            foreach (var arg in Arguments)
            {
                if (!argumentNames.Add(arg.Name))
                    throw new Exception($"Duplicate argument name '{arg.Name}' in function '{Name}'.");
                arg.Validate();
            }

            Locals?.Validate();
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel         = $"func_{Name}_{ID}_start",
                EndLabel           = $"func_{Name}_{ID}_end",
                DeclaredByKeyword  = "func"
            });

            try
            {
                Validate();
                var sb = new StringBuilder();

                // etiqueta de entrada sin indent
                sb.AppendLine($"{scopes.Peek().StartLabel}:");

                // comentario de función al nivel 0
                sb.Append(FormatCompiledLines($"; Function: {Name} (ID: {ID}), ReturnType: {ReturnType}", string.Empty));

                if (Arguments.Length > 0)
                    sb.Append(FormatCompiledLines(
                        $"; Arguments: {string.Join(", ", Arguments.Select(a => $"{a.Name}:{a.Type}"))}",
                        string.Empty
                    ));

                // cálculo de tamaño total de argumentos
                var totalArgSize = 0;
                foreach (var arg in Arguments)
                {
                    var size = arg.Type.Type switch
                    {
                        PrimitiveType.Bool or PrimitiveType.Char8 or PrimitiveType.SByte or PrimitiveType.Byte => 1,
                        PrimitiveType.Int16 or PrimitiveType.UInt16 => 2,
                        PrimitiveType.Int32 or PrimitiveType.UInt32 or PrimitiveType.Float32 => 4,
                        PrimitiveType.Int64 or PrimitiveType.UInt64 or PrimitiveType.Float64 => 8,
                        PrimitiveType.Int128 or PrimitiveType.UInt128 or PrimitiveType.Float128 => 16,
                        _ => 8
                    };
                    totalArgSize += size;
                }

                // reserva de stack y compilación de cada argumento
                if (totalArgSize > 0)
                {
                    sb.Append(FormatCompiledLines(
                        $"sub rsp, {totalArgSize}  ; reserve {totalArgSize} bytes for all arguments",
                        GetDepth()
                    ));

                    foreach (var arg in Arguments)
                        sb.Append(FormatCompiledLines(arg.Compile(scopes), GetDepth()));
                }

                // variables locales (si existen)
                if (Locals != null)
                    sb.Append(FormatCompiledLines(Locals.Value.Compile(scopes), GetDepth()));

                // cuerpo de la función
                if (Definition != null)
                {
                    sb.Append(FormatCompiledLines("; Function body begin", GetDepth()));
                    sb.Append(FormatCompiledLines(
                        ASTCompiler.CompileAST(new SyntaxTree(Definition)),
                        GetDepth()
                    ));
                    sb.Append(FormatCompiledLines("; Function body end", GetDepth()));
                }

                // instrucción de retorno
                sb.Append(FormatCompiledLines("ret", GetDepth()));

                // etiqueta de salida sin indent
                sb.AppendLine($"{scopes.Peek().EndLabel}:");

                return sb.ToString();
            }
            finally
            {
                scopes.Pop();
            }

            string GetDepth(int basis = 0)
            {
                var output = string.Empty;
                var depth = scopes.Count + basis;
                for (int i = 0; i < depth; i++)
                    output += "  ";
                return output;
            }

            string FormatCompiledLines(string? lines, string depth)
            {
                var final = string.Empty;
                foreach (var line in lines?.Split('\n', StringSplitOptions.RemoveEmptyEntries) ?? [])
                    final += depth + line + '\n';
                return final;
            }
        }
    }
}
