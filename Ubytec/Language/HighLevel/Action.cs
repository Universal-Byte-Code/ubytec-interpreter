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
    public readonly struct Action : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public Argument[] Arguments { get; }
        public LocalContext? Locals { get; }
        public SyntaxSentence? Definition { get; }

        public Action(string name, Guid id, Argument[]? arguments = null, LocalContext? locals = null,TypeModifiers modifiers = TypeModifiers.None, SyntaxSentence? definitionSentence = null)
        {
            Name= name;
            ID= id;
            Modifiers= modifiers;
            Arguments= arguments ?? [];
            Locals= locals;
            Definition= definitionSentence;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Action name cannot be null or empty.");

            if ((Modifiers & (TypeModifiers.Const | TypeModifiers.Sealed)) != 0)
                throw new Exception($"Action '{Name}' cannot have modifiers: const or sealed.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Action '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Global | TypeModifiers.Local)).CountSetBits() > 1)
                throw new Exception($"Action '{Name}' cannot be both global and local.");

            if (Modifiers.HasFlag(TypeModifiers.Abstract) && Definition is not null)
                throw new Exception($"Action '{Name}' is abstract and should not have a body.");

            if (!Modifiers.HasFlag(TypeModifiers.Abstract) && Definition is null)
                throw new Exception($"Action '{Name}' must have a definition unless it is abstract.");

            var argumentNames = new HashSet<string>();
            foreach (var arg in Arguments)
            {
                if (!argumentNames.Add(arg.Name))
                    throw new Exception($"Duplicate argument name '{arg.Name}' in action '{Name}'.");
                arg.Validate();
            }

            Locals?.Validate();
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel = $"action_{Name}_{ID}_start",
                EndLabel   = $"action_{Name}_{ID}_end",
                DeclaredByKeyword = "action"
            });
            try
            {
                Validate();
                var sb = new StringBuilder();

                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; Action: {Name} (ID: {ID})");
                if (Arguments.Length > 0)
                    sb.AppendLine($"; Arguments: {string.Join(", ", Arguments.Select(a => $"{a.Name}:{a.Type}"))}");

                sb.Append(Locals?.Compile(scopes));

                if (Definition != null)
                {
                    sb.AppendLine("; Action body begin");
                    sb.AppendLine(ASTCompiler.CompileAST(new SyntaxTree(Definition)));
                    sb.AppendLine("; Action body end");
                }

                sb.AppendLine("    ret");
                sb.AppendLine($"{scopes.Peek().EndLabel}:");
                return sb.ToString();
            }
            finally
            {
                scopes.Pop();
            }
        }
    }
}
