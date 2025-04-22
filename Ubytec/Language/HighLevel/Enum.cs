using System.Linq;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Enum : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public PrimitiveType TypeSize { get; }
        public TypeModifiers Modifiers { get; }
        public bool IsBitfield { get; }

        public (string Name, long Value)[] Members { get; }

        public Enum(string name, (string Name, long Value)[] members, Guid id, PrimitiveType typeSize = PrimitiveType.Byte, bool isBitField = false, TypeModifiers modifiers = TypeModifiers.None)
        {
            Name= name;
            ID= id;
            TypeSize= typeSize;
            Modifiers= modifiers;
            IsBitfield= isBitField;
            Members= members;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Enum name cannot be null or empty.");

            if ((Modifiers & (TypeModifiers.Abstract | TypeModifiers.Virtual | TypeModifiers.Sealed |
                              TypeModifiers.ReadOnly | TypeModifiers.Const)) != 0)
                throw new Exception($"Enum '{Name}' cannot have modifiers: {Modifiers}.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Enum '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Global | TypeModifiers.Local)).CountSetBits() > 1)
                throw new Exception($"Enum '{Name}' cannot be both global and local.");

            if (!IsNumeric(TypeSize))
                throw new Exception($"Enum '{Name}' has invalid underlying type '{TypeSize}'.");

            var nameSet = new HashSet<string>();
            var valueSet = new HashSet<long>();
            var isBitfield = true;

            foreach (var (memberName, value) in Members)
            {
                if (!nameSet.Add(memberName))
                    throw new Exception($"Duplicate member name '{memberName}' in enum '{Name}'.");

                if (!valueSet.Add(value))
                    throw new Exception($"Duplicate value '{value}' in enum '{Name}'.");

                if (value == 0) continue; // allow zero

                if ((value & (value - 1)) != 0)
                    isBitfield = false;
            }

            if (Members.Length == 0)
                throw new Exception($"Enum '{Name}' must have at least one member.");

            if (Members.Length == 1 && Members[0].Value != 0)
                isBitfield = false;

            // Set internal flag if needed (if mutable, or expose via constructor instead)
            // Currently, we just validate that it's a valid bitfield
            if (IsBitfield != isBitfield)
                throw new Exception($"Enum '{Name}' is declared as {(IsBitfield ? "" : "non-")}bitfield, but values do {(isBitfield ? "" : "not ")}match.");
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel = $"enum_{Name}_{ID}_start",
                EndLabel   = $"enum_{Name}_{ID}_end",
                DeclaredByKeyword = "enum"
            });
            try
            {
                Validate();
                var sb = new StringBuilder();

                sb.AppendLine($"{scopes.Peek().StartLabel}:");
                sb.AppendLine($"; Enum: {Name} (ID: {ID}), Underlying type: {TypeSize}, Bitfield: {IsBitfield}");

                string directive = TypeSize switch
                {
                    PrimitiveType.Byte => "db",
                    PrimitiveType.SByte => "db",
                    PrimitiveType.Int16 => "dw",
                    PrimitiveType.UInt16 => "dw",
                    PrimitiveType.Int32 => "dd",
                    PrimitiveType.UInt32 => "dd",
                    PrimitiveType.Int64 => "dq",
                    PrimitiveType.UInt64 => "dq",
                    _ => "dq"
                };

                foreach (var (memberName, value) in Members)
                {
                    sb.AppendLine($"{memberName}_{ID}: {directive} {value}");
                }

                sb.AppendLine($"; End of enum {Name}");
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
