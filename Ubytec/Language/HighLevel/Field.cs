using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Field : IUbytecHighLevelEntity
    {
        public string Name { get; }
        public object? Value { get; }
        public UType Type { get; }
        public TypeModifiers Modifiers { get; }
        public Guid ID { get; }

        public Field(string name, UType type, Guid id, object? value, TypeModifiers modifiers = TypeModifiers.None)
        {
            Name = name;
            Type = type;
            Modifiers = modifiers;
            ID = id;
            Value = value;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Field name cannot be null or empty.");

            if ((Modifiers & (TypeModifiers.Virtual | TypeModifiers.Override | TypeModifiers.Abstract | TypeModifiers.Sealed)) != 0)
                throw new Exception($"Field '{Name}' cannot have modifiers: {Modifiers & (TypeModifiers.Virtual | TypeModifiers.Override | TypeModifiers.Abstract | TypeModifiers.Sealed)}");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Field '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Global | TypeModifiers.Local)).CountSetBits() > 1)
                throw new Exception($"Field '{Name}' cannot be both global and local.");

            if (Modifiers.HasFlag(TypeModifiers.Const) && Modifiers.HasFlag(TypeModifiers.ReadOnly))
                throw new Exception($"Field '{Name}' cannot be both const and readonly.");
        }

        public string Compile(CompilationScopes scopes)
        {
            var label = $"{Name}_{ID}";

            if (Value is string s)
            {
                var esc = s.Replace("\"", "\\\"");
                return $"{label}: db \"{esc}\", 0";
            }

            string literal = Value switch
            {
                bool bo => bo ? "1" : "0",
                byte b => b.ToString(),
                sbyte sb => sb.ToString(),
                short sh => sh.ToString(),
                ushort us => us.ToString(),
                int i => i.ToString(),
                uint ui => ui.ToString(),
                long l => l.ToString(),
                ulong ul => ul.ToString(),
                float f => f.ToString("R"),
                double d => d.ToString("R"),
                decimal m => m.ToString(),
                char c => ((int)c).ToString(),
                _ => "0"
            };

            return Type.Type switch
            {
                PrimitiveType.Bool   or
                PrimitiveType.Char8  or
                PrimitiveType.SByte  or
                PrimitiveType.Byte => $"{label}: db {literal}",

                PrimitiveType.Int16  or
                PrimitiveType.UInt16 => $"{label}: dw {literal}",

                PrimitiveType.Int32  or
                PrimitiveType.UInt32  or
                PrimitiveType.Float32 => $"{label}: dd {literal}",

                PrimitiveType.Int64  or
                PrimitiveType.UInt64  or
                PrimitiveType.Float64 => $"{label}: dq {literal}",

                PrimitiveType.Int128 or
                PrimitiveType.UInt128 or
                PrimitiveType.Float128
                    => $"{label}: dq {literal}, 0",

                _ => $"{label}: dq {literal}"
            };
        }
    }
}
