using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Property : IUbytecContextEntity
    {
        public string Name { get; }
        public UType Type { get; }
        public TypeModifiers Modifiers { get; }
        public Guid ID { get; }
        public AccessorContext AccessorContext { get; }

        public Property(string name, UType type, AccessorContext accessorContext, Guid id, TypeModifiers modifiers = TypeModifiers.None)
        {
            Name = name;
            Type = type;
            Modifiers = modifiers;
            ID = id;
            AccessorContext = accessorContext;

            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Property name cannot be null or empty.");

            if ((Modifiers & (TypeModifiers.Sealed | TypeModifiers.ReadOnly | TypeModifiers.Const)) != 0)
                throw new Exception($"Property '{Name}' has invalid modifiers: {Modifiers & (TypeModifiers.Sealed | TypeModifiers.ReadOnly | TypeModifiers.Const)}.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Property '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Global | TypeModifiers.Local)).CountSetBits() > 1)
                throw new Exception($"Property '{Name}' cannot be both global and local.");

            // Validación del contexto de acceso
            AccessorContext.Validate();
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel = $"prop_{Name}_{ID}_start",
                EndLabel   = $"prop_{Name}_{ID}_end",
                DeclaredByKeyword = "property"
            });
            try
            {
                Validate();
                var sb = new StringBuilder();

                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; Property: {Name} (ID: {ID}), Type: {Type}");
                sb.Append(AccessorContext.Compile(scopes));
                sb.AppendLine($"{scopes.Peek().EndLabel}:");
                return sb.ToString();
            }
            finally { scopes.Pop(); }
        }
    }
}
