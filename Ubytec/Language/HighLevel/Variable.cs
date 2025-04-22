using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Variable : IUbytecHighLevelEntity
    {
        public string Name { get; }
        public UType Type { get; }
        public TypeModifiers Modifiers { get; }
        public object? Value { get; }
        public Guid ID { get; }

        public Variable(string name, UType type, Guid id, TypeModifiers modifiers = TypeModifiers.None, object? value = null)
        {
            Name = name;
            Type = type;
            Modifiers = modifiers;
            Value = value;
            ID = id;

            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Variable name cannot be null or empty.");

            const TypeModifiers invalidModifiers =
                TypeModifiers.Public |
                TypeModifiers.Private |
                TypeModifiers.Protected |
                TypeModifiers.Internal |
                TypeModifiers.Secret |
                TypeModifiers.Abstract |
                TypeModifiers.Virtual |
                TypeModifiers.Override |
                TypeModifiers.Sealed |
                TypeModifiers.Global |
                TypeModifiers.Local;

            if ((Modifiers & invalidModifiers) != 0)
                throw new Exception($"Variable '{Name}' has invalid modifiers: {Modifiers & invalidModifiers}");

            if ((Modifiers & (TypeModifiers.Const | TypeModifiers.ReadOnly)).CountSetBits() > 1)
                throw new Exception($"Variable '{Name}' cannot be both const and readonly.");

            if (Modifiers.HasFlag(TypeModifiers.Const) && Value is null)
                throw new Exception($"Const variable '{Name}' must have an assigned value.");
        }

        public string Compile(CompilationScopes scopes)
        {
            // Define a constant for this variable's stack offset.
            // Actual stack space is allocated once in LocalContext prologue.
            var offsetLabel = $"var_{Name}_{ID}_offset";
            return $"{offsetLabel} equ rsp  ; reference for variable {Name}";
        }
    }
}
