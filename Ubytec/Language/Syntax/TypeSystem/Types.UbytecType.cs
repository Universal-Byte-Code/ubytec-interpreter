using System.Runtime.InteropServices;

namespace Ubytec.Language.Syntax.TypeSystem
{
    public static partial class Types
    {
        [StructLayout(LayoutKind.Sequential)]
        public readonly struct UType(
            PrimitiveType type = PrimitiveType.Default,
            TypeModifiers modifiers = TypeModifiers.None,
            Guid? customID = null,
            string? name = null,
            nuint fixedArraySize = 1)
        {
            public PrimitiveType Type { get; } = type;
            public Guid? CustomID { get; } = customID;
            public string Name => name ?? Type.ToString();
            public TypeModifiers Modifiers { get; } = modifiers;
            public ulong FixedArraySize { get; } = fixedArraySize;

            // Precise nullability handling
            public bool IsArray => Modifiers.HasFlag(TypeModifiers.IsArray);
            public bool IsNullableArray => Modifiers.HasFlag(TypeModifiers.NullableArray);
            public bool IsNullableItems => Modifiers.HasFlag(TypeModifiers.NullableItems);
            public bool IsFullyNullableArray => Modifiers.HasFlag(TypeModifiers.NullableArray) && Modifiers.HasFlag(TypeModifiers.NullableItems);
            public bool IsSingleNullable => Modifiers.HasFlag(TypeModifiers.Nullable) && !IsArray;

            public static UType FromOperands(byte typeByte, byte flagsByte)
            {
                var type = (PrimitiveType)typeByte;
                var modifiers = (TypeModifiers)flagsByte;
                return new UType(type, modifiers);
            }

            public override string ToString()
            {
                string suffix = "";

                if (IsArray)
                {
                    suffix = (IsNullableItems ? "?" : "") + "[]";
                    if (IsNullableArray) suffix += "?";
                }
                else if (IsSingleNullable)
                {
                    suffix = "?";
                }

                return $"{Type}{suffix}";
            }
        }

    }
}
