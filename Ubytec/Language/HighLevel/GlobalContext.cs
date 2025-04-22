using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;

namespace Ubytec.Language.HighLevel
{
    public readonly struct GlobalContext : IUbytecHighLevelEntity
    {
        public Field[] Fields { get; }
        public Property[] Properties { get; }
        public Func[] Functions { get; }
        public Action[] Actions { get; }
        public Guid ID { get; }

        public GlobalContext(Field[] fields, Property[] properties, Func[] funcs, Action[] actions, Guid id)
        {
            Fields= fields;
            Properties= properties;
            Functions= funcs;
            Actions= actions;
            ID= id;
            Validate();
        }

        public void Validate()
        {
            var memberNames = new HashSet<string>();

            void Add(string name, string kind)
            {
                if (!memberNames.Add(name))
                    throw new Exception($"Duplicate {kind} name '{name}' in GlobalContext.");
            }

            foreach (var f in Fields)
            {
                Add(f.Name, "field");
                f.Validate();
            }

            foreach (var p in Properties)
            {
                Add(p.Name, "property");
                p.Validate();
            }

            foreach (var fn in Functions)
            {
                Add(fn.Name, "function");
                fn.Validate();
            }

            foreach (var a in Actions)
            {
                Add(a.Name, "action");
                a.Validate();
            }
        }

        public string Compile(CompilationScopes scopes)
        {
            // Push global scope
            scopes.Push(new ScopeContext
            {
                StartLabel        = $"global_{ID}_start",
                EndLabel          = $"global_{ID}_end",
                DeclaredByKeyword = "global"
            });

            try
            {
                Validate();
                var sb = new StringBuilder();
                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; GlobalContext ID: {ID}");

                sb.AppendLine("section .data");
                foreach (var f in Fields)
                {
                    sb.AppendLine(f.Compile(scopes));
                }

                sb.AppendLine();
                sb.AppendLine("section .bss");
                foreach (var p in Properties)
                {
                    sb.AppendLine(p.Compile(scopes));
                }

                sb.AppendLine();
                sb.AppendLine("section .text");
                foreach (var fn in Functions)
                    sb.Append(fn.Compile(scopes)).AppendLine();
                foreach (var a in Actions)
                    sb.Append(a.Compile(scopes)).AppendLine();

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
