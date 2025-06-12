using System.Runtime.InteropServices;

namespace Ubytec.Language.Syntax.TypeSystem
{
    public static partial class Types
    {
        /// <summary>
        /// Represents a type descriptor in the Ubytec type system, including primitive category,
        /// modifiers such as array or nullability, and optional identifier and name.
        /// </summary>
        /// <param name="type">Base <see cref="PrimitiveType"/> of the type.</param>
        /// <param name="modifiers">Flags indicating array, nullability, or other modifiers.</param>
        /// <param name="id">Optional unique identifier for the type.</param>
        /// <param name="name">Optional custom name; defaults to the <paramref name="type"/> name.</param>
        /// <param name="fixedArraySize">If <paramref name="modifiers"/> includes <c>TypeModifiers.IsArray</c>, this
        /// specifies the fixed size of the array; defaults to 1 for non-array types.</param>
        /// <remarks>
        /// <para>
        /// Use <see cref="FromOperands(byte, byte)"/> to reconstruct a <see cref="UType"/> from
        /// low-level operand bytes.</para>
        /// </remarks>
        /// <example>
        /// <code language="csharp">
        /// // Simple primitive:
        /// var t1 = new UType(PrimitiveType.Int);
        /// Console.WriteLine(t1); // "Int"
        /// 
        /// // Nullable primitive:
        /// var t2 = new UType(PrimitiveType.Bool, TypeModifiers.Nullable);
        /// Console.WriteLine(t2); // "Bool?"
        /// 
        /// // Array of strings (nullable items):
        /// var t3 = new UType(PrimitiveType.String, TypeModifiers.IsArray | TypeModifiers.NullableItems);
        /// Console.WriteLine(t3); // "String?[]"
        /// 
        /// // Fully nullable array:
        /// var t4 = new UType(PrimitiveType.Byte, TypeModifiers.IsArray | TypeModifiers.NullableArray | TypeModifiers.NullableItems);
        /// Console.WriteLine(t4); // "Byte?[]?"
        /// </code>
        /// </example>
        [StructLayout(LayoutKind.Sequential)]
        public readonly struct UType(
            PrimitiveType type = PrimitiveType.Default,
            TypeModifiers modifiers = TypeModifiers.None,
            Guid? id = null,
            string? name = null,
            nuint fixedArraySize = 1)
        {
            /// <summary>
            /// Lookup table mapping custom type names to GUID identifiers.
            /// </summary>
            public static readonly Dictionary<string, Guid> TypeIDLUT = [];

            /// <summary>
            /// Gets the base primitive category of this type.
            /// </summary>
            public PrimitiveType Type { get; } = type;

            /// <summary>
            /// Gets the optional unique identifier associated with this type, if any.
            /// </summary>
            public Guid? ID { get; } = id;

            /// <summary>
            /// Gets the display name of this type. Returns <c>name</c> if provided;
            /// otherwise, the <see cref="Type"/> name.
            /// </summary>
            public string Name => name ?? Type.ToString();

            /// <summary>
            /// Gets any modifiers applied to this type, such as array, nullability, or custom flags.
            /// </summary>
            public TypeModifiers Modifiers { get; } = modifiers;

            /// <summary>
            /// Gets the fixed size for array types; defaults to 1 for non-array types.
            /// </summary>
            public ulong FixedArraySize { get; } = fixedArraySize;

            /// <summary>True if this type represents an array.</summary>
            public bool IsArray => Modifiers.HasFlag(TypeModifiers.IsArray);
            /// <summary>True if the array itself is nullable (i.e., <c>Type[]?</c>).</summary>
            public bool IsNullableArray => Modifiers.HasFlag(TypeModifiers.NullableArray);
            /// <summary>True if individual array items are nullable (i.e., <c>Type?[]</c>).</summary>
            public bool IsNullableItems => Modifiers.HasFlag(TypeModifiers.NullableItems);
            /// <summary>True if both the array and its items are nullable.</summary>
            public bool IsFullyNullableArray => Modifiers.HasFlag(TypeModifiers.NullableArray) && Modifiers.HasFlag(TypeModifiers.NullableItems);
            /// <summary>True if this non-array type is nullable (i.e., <c>Type?</c>).</summary>
            public bool IsSingleNullable => Modifiers.HasFlag(TypeModifiers.Nullable) && !IsArray;

            /// <summary>
            /// Constructs a <see cref="UType"/> from raw operand bytes representing
            /// <see cref="PrimitiveType"/> and <see cref="TypeModifiers"/> flags.
            /// </summary>
            /// <param name="typeByte">Underlying byte value for <see cref="PrimitiveType"/>.</param>
            /// <param name="flagsByte">Underlying byte value for <see cref="TypeModifiers"/>.</param>
            /// <returns>A new <see cref="UType"/> instance.</returns>
            public static UType FromOperands(byte typeByte, byte flagsByte)
            {
                var type = (PrimitiveType)typeByte;
                var modifiers = (TypeModifiers)flagsByte;
                return new UType(type, modifiers);
            }

            /// <summary>
            /// Returns a string representation including array and nullability suffixes.
            /// </summary>
            /// <returns>Formatted type name (e.g., "Int", "Bool?", "String[]?").</returns>
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
