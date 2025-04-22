using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Record : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public Property[] Properties { get; }
        public Func[] Functions { get; }
        public Action[] Actions { get; }
        public LocalContext? Locals { get; }
        public GlobalContext? Globals { get; }

        public Record(string name, Property[] properties, Func[] funcs, Action[] actions, Guid id,
                      LocalContext? locals = null, GlobalContext? globals = null,
                      TypeModifiers modifiers = TypeModifiers.None)
        {
            Name = name;
            ID = id;
            Modifiers = modifiers;
            Properties = properties;
            Functions = funcs;
            Actions = actions;
            Locals = locals;
            Globals = globals;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Record name cannot be null or empty.");

            if ((Modifiers & (TypeModifiers.Abstract | TypeModifiers.Virtual | TypeModifiers.Sealed | TypeModifiers.Override)) != 0)
                throw new Exception($"Record '{Name}' cannot be abstract, virtual, sealed, or override.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Record '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Global | TypeModifiers.Local)).CountSetBits() > 1)
                throw new Exception($"Record '{Name}' cannot be both global and local.");

            var memberNames = new HashSet<string>();

            foreach (var p in Properties)
            {
                if (!memberNames.Add(p.Name))
                    throw new Exception($"Duplicate property name '{p.Name}' in record '{Name}'.");
                p.Validate();
            }

            foreach (var f in Functions)
            {
                if (!memberNames.Add(f.Name))
                    throw new Exception($"Duplicate function name '{f.Name}' in record '{Name}'.");
                f.Validate();
            }

            foreach (var a in Actions)
            {
                if (!memberNames.Add(a.Name))
                    throw new Exception($"Duplicate action name '{a.Name}' in record '{Name}'.");
                a.Validate();
            }

            Locals?.Validate();
            Globals?.Validate();
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel = $"record_{Name}_{ID}_start",
                EndLabel   = $"record_{Name}_{ID}_end",
                DeclaredByKeyword = "record"
            });
            try
            {
                Validate();
                var sb = new StringBuilder();

                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; Record: {Name} (ID: {ID})");

                // Compile properties
                foreach (var prop in Properties)
                    sb.Append(prop.Compile(scopes)).AppendLine();

                // Compile functions
                foreach (var func in Functions)
                    sb.Append(func.Compile(scopes)).AppendLine();

                // Compile actions
                foreach (var action in Actions)
                    sb.Append(action.Compile(scopes)).AppendLine();

                // Compile contexts
                sb.Append(Locals?.Compile(scopes));
                sb.Append(Globals?.Compile(scopes));

                sb.AppendLine($"; End of record {Name}");
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
