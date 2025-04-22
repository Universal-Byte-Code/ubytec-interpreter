using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    // Argument inside a function
    public readonly struct Argument : IUbytecHighLevelEntity
    {
        public string Name { get; }
        public UType Type { get; }
        public TypeModifiers Modifiers { get; }
        public Guid ID { get; }

        public Argument(string name, UType type, Guid id, TypeModifiers modifiers = TypeModifiers.None)
        {
            Name= name;
            Type= type;
            Modifiers= modifiers;
            ID= id;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Argument name cannot be null or empty.");

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
                TypeModifiers.Const |
                TypeModifiers.Global |
                TypeModifiers.Local;

            if ((Modifiers & invalidModifiers) != 0)
                throw new Exception($"Argument '{Name}' has invalid modifiers: {Modifiers & invalidModifiers}");

            if ((Modifiers & (TypeModifiers.ReadOnly | TypeModifiers.Const)).CountSetBits() > 1)
                throw new Exception($"Argument '{Name}' cannot be both readonly and const.");
        }

        public string Compile(CompilationScopes scopes)
        {
            // Define a constant for this argument's stack offset label.
            // Actual allocation should occur once in the function prologue.
            var offsetLabel = $"arg_{Name}_{ID}_offset";
            return $"{offsetLabel} equ rsp  ; reference for argument {Name}";
        }
    }
}
