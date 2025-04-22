using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Interface : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public Property[] Properties { get; }
        public Func[] Functions { get; }
        public Action[] Actions { get; }

        public Interface(string name, Property[] properties, Func[] funcs, Action[] actions, Guid id, TypeModifiers modifiers = TypeModifiers.None)
        {
            Name= name;
            ID= id;
            Modifiers= modifiers;
            Properties= properties;
            Functions= funcs;
            Actions= actions;
            Validate();
        }

        public void Validate()
        {
            var memberNames = new HashSet<string>();

            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Interface name cannot be null or empty.");

            if ((Modifiers & ~(TypeModifiers.Global)) != 0)
                throw new Exception($"Interface '{Name}' can only have the 'global' modifier.");

            foreach (var member in Properties.Cast<object>()
                .Concat(Functions.Cast<object>())
                .Concat(Actions.Cast<object>()))
            {
                var memberModifiers = member switch
                {
                    Property p => p.Modifiers,
                    Func f => f.Modifiers,
                    Action a => a.Modifiers,
                    _ => TypeModifiers.None
                };

                var name = member switch
                {
                    Property p => p.Name,
                    Func f => f.Name,
                    Action a => a.Name,
                    _ => "<unknown>"
                };

                if (!memberNames.Add(name))
                    throw new Exception($"Duplicate member name '{name}' in interface '{Name}'.");

                if ((memberModifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                                        TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                    throw new Exception($"Member '{name}' cannot have more than one access modifier.");

                if (!memberModifiers.HasFlag(TypeModifiers.Abstract))
                    throw new Exception($"Member '{name}' in interface '{Name}' must be abstract.");

                if (memberModifiers.HasFlag(TypeModifiers.Sealed))
                    throw new Exception($"Member '{name}' in interface '{Name}' cannot be sealed.");

                if (memberModifiers.HasFlag(TypeModifiers.Virtual))
                    throw new Exception($"Member '{name}' in interface '{Name}' cannot be virtual.");

                if (memberModifiers.HasFlag(TypeModifiers.Override))
                    throw new Exception($"Member '{name}' in interface '{Name}' cannot be override.");

                if (memberModifiers.HasFlag(TypeModifiers.Const))
                    throw new Exception($"Member '{name}' in interface '{Name}' cannot be const.");

                if (memberModifiers.HasFlag(TypeModifiers.ReadOnly))
                    throw new Exception($"Member '{name}' in interface '{Name}' cannot be readonly.");

                if (memberModifiers.HasFlag(TypeModifiers.Global) || memberModifiers.HasFlag(TypeModifiers.Local))
                    throw new Exception($"Member '{name}' in interface '{Name}' cannot be local or global.");
            }

            foreach (var p in Properties) p.Validate();
            foreach (var f in Functions) f.Validate();
            foreach (var a in Actions) a.Validate();
        }


        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel = $"interface_{Name}_{ID}_start",
                EndLabel   = $"interface_{Name}_{ID}_end",
                DeclaredByKeyword = "interface"
            });
            try
            {
                Validate();
                var sb = new StringBuilder();

                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; Interface: {Name} (ID: {ID})");

                foreach (var prop in Properties)
                    sb.AppendLine($"; abstract property {prop.Name}:{prop.Type}");
                foreach (var func in Functions)
                    sb.AppendLine($"; abstract function {func.Name} returns {func.ReturnType}");
                foreach (var action in Actions)
                    sb.AppendLine($"; abstract action {action.Name}()");

                sb.AppendLine($"; End of interface {Name}");
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
