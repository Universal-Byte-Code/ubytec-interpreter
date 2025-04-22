using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Struct : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public Field[] Fields { get; }
        public Property[] Properties { get; }
        public Func[] Functions { get; }
        public Action[] Actions { get; }
        public LocalContext? Locals { get; }
        public GlobalContext? Globals { get; }

        public Struct(string name, Field[] fields, Property[] properties, Func[] funcs, Action[] actions, Guid id,
                      LocalContext? locals = null, GlobalContext? globals = null,
                      TypeModifiers modifiers = TypeModifiers.None)
        {
            Name = name;
            ID = id;
            Modifiers = modifiers;
            Fields = fields;
            Properties = properties;
            Functions = funcs;
            Actions = actions;
            Locals = locals;
            Globals = globals;

            Validate();
        }

        public void Validate()
        {
            var memberNames = new HashSet<string>();

            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Struct name cannot be null or empty.");

            if (Modifiers.HasFlag(TypeModifiers.Abstract))
                throw new Exception($"Struct '{Name}' cannot be abstract.");

            if (Modifiers.HasFlag(TypeModifiers.Virtual))
                throw new Exception($"Struct '{Name}' cannot be virtual.");

            if (Modifiers.HasFlag(TypeModifiers.Sealed))
                throw new Exception($"Struct '{Name}' cannot be sealed.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Struct '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Local | TypeModifiers.Global)).CountSetBits() > 1)
                throw new Exception($"Struct '{Name}' cannot be both local and global.");

            foreach (var member in Fields.Cast<object>()
                .Concat(Properties.Cast<object>())
                .Concat(Functions.Cast<object>())
                .Concat(Actions.Cast<object>()))
            {
                var memberModifiers = member switch
                {
                    Field f => f.Modifiers,
                    Property p => p.Modifiers,
                    Func f => f.Modifiers,
                    Action a => a.Modifiers,
                    _ => TypeModifiers.None
                };

                var name = member switch
                {
                    Field f => f.Name,
                    Property p => p.Name,
                    Func f => f.Name,
                    Action a => a.Name,
                    _ => "<unknown>"
                };

                if (!memberNames.Add(name))
                    throw new Exception($"Duplicate member name '{name}' in struct '{Name}'.");

                if ((memberModifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                                        TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                    throw new Exception($"Member '{name}' cannot have more than one access modifier.");

                if (memberModifiers.HasFlag(TypeModifiers.Abstract))
                    throw new Exception($"Member '{name}' in struct '{Name}' cannot be abstract.");

                if (memberModifiers.HasFlag(TypeModifiers.Virtual))
                    throw new Exception($"Member '{name}' in struct '{Name}' cannot be virtual.");

                if (memberModifiers.HasFlag(TypeModifiers.Override))
                    throw new Exception($"Member '{name}' in struct '{Name}' cannot be override.");

                if (memberModifiers.HasFlag(TypeModifiers.Sealed))
                    throw new Exception($"Member '{name}' in struct '{Name}' cannot be sealed.");

                if (memberModifiers.HasFlag(TypeModifiers.Const) && memberModifiers.HasFlag(TypeModifiers.ReadOnly))
                    throw new Exception($"Member '{name}' cannot be both const and readonly.");

                if (memberModifiers.HasFlag(TypeModifiers.Global) && memberModifiers.HasFlag(TypeModifiers.Local))
                    throw new Exception($"Member '{name}' cannot be both global and local.");
            }

            // Validación recursiva
            foreach (var f in Fields) f.Validate();
            foreach (var p in Properties) p.Validate();
            foreach (var fn in Functions) fn.Validate();
            foreach (var a in Actions) a.Validate();

            Locals?.Validate();
            Globals?.Validate();
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel = $"struct_{Name}_{ID}_start",
                EndLabel   = $"struct_{Name}_{ID}_end",
                DeclaredByKeyword = "struct"
            });
            try
            {
                Validate();
                var sb = new StringBuilder();

                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; Struct: {Name} (ID: {ID})");

                // Compile fields
                foreach (var field in Fields)
                    sb.AppendLine(field.Compile(scopes));

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

                sb.AppendLine($"; End of struct {Name}");
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
