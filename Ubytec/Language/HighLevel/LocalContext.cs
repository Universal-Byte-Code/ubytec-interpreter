using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct LocalContext : IUbytecHighLevelEntity
    {
        public Variable[] Variables { get; }
        public Func[] Functions { get; }
        public Action[] Actions { get; }
        public Guid ID { get; }

        public LocalContext(Variable[] variables, Func[] funcs, Action[] actions, Guid id)
        {
            Variables= variables;
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
                    throw new Exception($"Duplicate {kind} name '{name}' in LocalContext.");
            }

            foreach (var v in Variables)
            {
                Add(v.Name, "variable");
                v.Validate();
            }

            foreach (var f in Functions)
            {
                Add(f.Name, "function");
                f.Validate();
            }

            foreach (var a in Actions)
            {
                Add(a.Name, "action");
                a.Validate();
            }
        }

        public string Compile(CompilationScopes scopes)
        {
            // Push local scope with unique labels
            scopes.Push(new ScopeContext
            {
                StartLabel         = $"local_{ID}_start",
                EndLabel           = $"local_{ID}_end",
                DeclaredByKeyword  = "local"
            });
            try
            {
                Validate();
                var sb = new StringBuilder();

                // Emit start label and context info
                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; LocalContext ID: {ID}");

                // Prologue: reservar espacio para todas las variables juntas
                int totalVarSize = 0;
                foreach (var v in Variables)
                {
                    int size = v.Type.Type switch
                    {
                        PrimitiveType.Bool    or
                        PrimitiveType.Char8   or
                        PrimitiveType.SByte   or
                        PrimitiveType.Byte => 1,
                        PrimitiveType.Int16   or
                        PrimitiveType.UInt16 => 2,
                        PrimitiveType.Int32   or
                        PrimitiveType.UInt32   or
                        PrimitiveType.Float32 => 4,
                        PrimitiveType.Int64   or
                        PrimitiveType.UInt64   or
                        PrimitiveType.Float64 => 8,
                        PrimitiveType.Int128  or
                        PrimitiveType.UInt128  or
                        PrimitiveType.Float128 => 16,
                        _ => 8  // puntero o tipo custom
                    };
                    totalVarSize += size;
                }

                if (totalVarSize > 0)
                {
                    sb.AppendLine($"    sub rsp, {totalVarSize}  ; reserve {totalVarSize} bytes for all variables");
                    // Etiquetas de offset para cada variable
                    foreach (var v in Variables)
                        sb.AppendLine(v.Compile(scopes));
                }

                // Compile nested functions
                foreach (var f in Functions)
                    sb.Append(f.Compile(scopes)).AppendLine();

                // Compile nested actions
                foreach (var a in Actions)
                    sb.Append(a.Compile(scopes)).AppendLine();

                // Emit end label
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
