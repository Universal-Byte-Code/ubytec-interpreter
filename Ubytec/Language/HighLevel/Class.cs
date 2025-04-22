using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Class : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public Field[] Fields { get; }
        public Property[] Properties { get; }
        public Func[] Functions { get; }
        public Action[] Actions { get; }
        public Interface[] Interfaces { get; }
        public Class[] Classes { get; }
        public Struct[] Structs { get; }
        public Record[] Records { get; }
        public Enum[] Enums { get; }
        public LocalContext? Locals { get; }
        public GlobalContext? Globals { get; }

        public Class(string name, Field[] fields, Property[] properties, Func[] funcs, Action[] actions, Interface[] interfaces, Class[] classes, Struct[] structs, Record[] records, Enum[] enums, Guid id, LocalContext? locals = null, GlobalContext? globals = null, TypeModifiers modifiers = TypeModifiers.None)
        {
            Name= name;
            ID= id;
            Modifiers= modifiers;
            Fields= fields;
            Properties= properties;
            Functions= funcs;
            Actions= actions;
            Interfaces= interfaces;
            Classes= classes;
            Structs= structs;
            Records= records;
            Enums= enums;
            Locals= locals;
            Globals= globals;
            Validate();
        }

        public void Validate()
        {
            var memberNames = new HashSet<string>();

            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Class name cannot be null or empty.");

            // Validate class-level modifiers
            if (Modifiers.HasFlag(TypeModifiers.Const))
                throw new Exception($"Class '{Name}' cannot be const.");

            if (Modifiers.HasFlag(TypeModifiers.ReadOnly))
                throw new Exception($"Class '{Name}' cannot be readonly.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected | TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Class '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Local | TypeModifiers.Global)).CountSetBits() > 1)
                throw new Exception($"Class '{Name}' cannot be both local and global.");

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

                if ((memberModifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected | TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                    throw new Exception($"Member '{Name}' cannot have more than one access modifier.");

                if (!memberNames.Add(name))
                    throw new Exception($"Duplicate member name '{name}' in class '{Name}'.");

                if (memberModifiers.HasFlag(TypeModifiers.Sealed))
                    throw new Exception($"Member '{name}' cannot be sealed.");

                if (memberModifiers.HasFlag(TypeModifiers.Abstract) && !Modifiers.HasFlag(TypeModifiers.Abstract))
                    throw new Exception($"Member '{name}' cannot be abstract because the containing class '{Name}' is not abstract.");

                if (memberModifiers.HasFlag(TypeModifiers.Virtual) && !Modifiers.HasFlag(TypeModifiers.Virtual) && !Modifiers.HasFlag(TypeModifiers.Abstract))
                    throw new Exception($"Member '{name}' cannot be virtual because the containing class '{Name}' is neither virtual nor abstract.");

                if (Modifiers.HasFlag(TypeModifiers.Abstract) &&
                    memberModifiers.HasFlag(TypeModifiers.Override) &&
                    !memberModifiers.HasFlag(TypeModifiers.Virtual))
                {
                    throw new Exception($"Member '{name}' cannot be override in an abstract class '{Name}' unless it is also virtual.");
                }

                if (memberModifiers.HasFlag(TypeModifiers.Const) && memberModifiers.HasFlag(TypeModifiers.ReadOnly))
                    throw new Exception($"Member '{name}' cannot be both const and readonly.");

                if (memberModifiers.HasFlag(TypeModifiers.Global) && memberModifiers.HasFlag(TypeModifiers.Local))
                    throw new Exception($"Member '{name}' cannot be both global and local.");

                if (Modifiers.HasFlag(TypeModifiers.Abstract) &&
                    !memberModifiers.HasFlag(TypeModifiers.Abstract) &&
                    !memberModifiers.HasFlag(TypeModifiers.Virtual))
                {
                    throw new Exception($"Member '{name}' must be abstract or virtual because the containing class '{Name}' is abstract.");
                }

                if (Modifiers.HasFlag(TypeModifiers.Abstract) &&
                    (memberModifiers.HasFlag(TypeModifiers.Local) || memberModifiers.HasFlag(TypeModifiers.Global)))
                {
                    throw new Exception($"Member '{name}' cannot be local or global in an abstract class '{Name}'.");
                }
            }

            if (Modifiers.HasFlag(TypeModifiers.Abstract) && Modifiers.HasFlag(TypeModifiers.Sealed))
                throw new Exception($"Class '{Name}' cannot be both abstract and sealed.");

            // Recursive validation of sub-entities
            foreach (var f in Fields) f.Validate();
            foreach (var p in Properties) p.Validate();
            foreach (var fn in Functions) fn.Validate();
            foreach (var a in Actions) a.Validate();
            foreach (var i in Interfaces) i.Validate();
            foreach (var c in Classes) c.Validate();
            foreach (var s in Structs) s.Validate();
            foreach (var r in Records) r.Validate();
            foreach (var e in Enums) e.Validate();

            Locals?.Validate();
            Globals?.Validate();
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext { StartLabel = $"class_{Name}_{ID}_start", EndLabel = $"class_{Name}_{ID}_end", DeclaredByKeyword = "class" });
            try
            {
                Validate();
                var sb = new StringBuilder();

                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; Class: {Name} (ID: {ID})");
                sb.AppendLine();

                // Compile fields
                foreach (var field in Fields)
                    sb.AppendLine(field.Compile(scopes));

                // Compile properties as methods
                foreach (var prop in Properties)
                    sb.Append(prop.Compile(scopes)).AppendLine();

                // Compile functions
                foreach (var func in Functions)
                    sb.Append(func.Compile(scopes)).AppendLine();

                // Compile actions
                foreach (var action in Actions)
                    sb.Append(action.Compile(scopes)).AppendLine();

                // Compile nested types
                foreach (var nested in Classes)
                    sb.Append(nested.Compile(scopes)).AppendLine();
                foreach (var nested in Structs)
                    sb.Append(nested.Compile(scopes)).AppendLine();
                foreach (var nested in Records)
                    sb.Append(nested.Compile(scopes)).AppendLine();
                foreach (var nested in Enums)
                    sb.Append(nested.Compile(scopes)).AppendLine();

                sb.AppendLine($"; End of class {Name}");
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
