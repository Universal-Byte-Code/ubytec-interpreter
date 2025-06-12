namespace Ubytec.Language.Syntax.TypeSystem
{
    public static partial class Types
    {
        /// <summary>
        /// Enumerates built-in value categories supported by Ubytec.
        /// </summary>
        public enum PrimitiveType : byte
        {
            /// <summary>No actual data type; represents the absence of a value.</summary>
            Void = 0x00,
            /// <summary>8-bit boolean type (true/false), stored as 1 byte.</summary>
            Bool = 0x01,
            /// <summary>8-bit character type (e.g., ASCII).</summary>
            Char8 = 0x02,
            /// <summary>16-bit character type (e.g., UTF-16).</summary>
            Char16 = 0x03,
            /// <summary>8-bit unsigned integer.</summary>
            Byte = 0x04,
            /// <summary>8-bit signed integer.</summary>
            SByte = 0x05,
            /// <summary>16-bit unsigned integer.</summary>
            UInt16 = 0x06,
            /// <summary>16-bit signed integer.</summary>
            Int16 = 0x07,
            /// <summary>32-bit unsigned integer.</summary>
            UInt32 = 0x08,
            /// <summary>32-bit signed integer.</summary>
            Int32 = 0x09,
            /// <summary>64-bit unsigned integer.</summary>
            UInt64 = 0x0A,
            /// <summary>64-bit signed integer.</summary>
            Int64 = 0x0B,
            /// <summary>128-bit unsigned integer (rarely used).</summary>
            UInt128 = 0x0C,
            /// <summary>128-bit signed integer (rarely used).</summary>
            Int128 = 0x0D,
            /// <summary>16-bit IEEE floating-point (half precision).</summary>
            Half = 0x0E,
            /// <summary>32-bit IEEE floating-point (single precision).</summary>
            Float32 = 0x0F,
            /// <summary>64-bit IEEE floating-point (double precision).</summary>
            Float64 = 0x10,
            /// <summary>128-bit IEEE floating-point (quadruple precision, rarely used).</summary>
            Float128 = 0x11,
            /// <summary>Implementation-defined default type placeholder.</summary>
            Default = 0xF0,
            /// <summary>Marker for dynamically resolved custom types.</summary>
            CustomType = 0xFE,
            /// <summary>Unknown or uninitialized type indicator.</summary>
            Unknown = 0xFF
        }

        /// <summary>GUID for the <c>Void</c> primitive.</summary>
        public static readonly Guid Void = Guid.Parse("00000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Bool</c> primitive.</summary>
        public static readonly Guid Bool = Guid.Parse("01000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Char8</c> primitive.</summary>
        public static readonly Guid Char8 = Guid.Parse("02000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Char16</c> primitive.</summary>
        public static readonly Guid Char16 = Guid.Parse("03000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Byte</c> primitive.</summary>
        public static readonly Guid Byte = Guid.Parse("04000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>SByte</c> primitive.</summary>
        public static readonly Guid SByte = Guid.Parse("05000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>UInt16</c> primitive.</summary>
        public static readonly Guid UInt16 = Guid.Parse("06000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Int16</c> primitive.</summary>
        public static readonly Guid Int16 = Guid.Parse("07000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>UInt32</c> primitive.</summary>
        public static readonly Guid UInt32 = Guid.Parse("08000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Int32</c> primitive.</summary>
        public static readonly Guid Int32 = Guid.Parse("09000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>UInt64</c> primitive.</summary>
        public static readonly Guid UInt64 = Guid.Parse("0A000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Int64</c> primitive.</summary>
        public static readonly Guid Int64 = Guid.Parse("0B000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>UInt128</c> primitive.</summary>
        public static readonly Guid UInt128 = Guid.Parse("0C000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Int128</c> primitive.</summary>
        public static readonly Guid Int128 = Guid.Parse("0D000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Half</c> primitive.</summary>
        public static readonly Guid Half = Guid.Parse("0E000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Float32</c> primitive.</summary>
        public static readonly Guid Float32 = Guid.Parse("0F000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Float64</c> primitive.</summary>
        public static readonly Guid Float64 = Guid.Parse("10000000-0000-0000-0000-000000000000");
        /// <summary>GUID for the <c>Float128</c> primitive.</summary>
        public static readonly Guid Float128 = Guid.Parse("11000000-0000-0000-0000-000000000000");

        /// <summary>GUID for the <c>Default</c> placeholder type.</summary>
        public static readonly Guid Default = Guid.Parse("F0000000-0000-0000-0000-000000000000");
        /// <summary>GUID for custom types resolved by name.</summary>
        public static readonly Guid CustomType = Guid.Parse("FE000000-0000-0000-0000-000000000000");
        /// <summary>GUID for unknown or uninitialized types.</summary>
        public static readonly Guid Unknown = Guid.Parse("FF000000-0000-0000-0000-000000000000");

        /// <summary>
        /// Maps a <see cref="PrimitiveType"/> to its corresponding GUID constant.
        /// </summary>
        /// <param name="pt">The primitive type to look up.</param>
        /// <returns>
        /// The <see cref="Guid"/> associated with <paramref name="pt"/>, or the <c>Unknown</c> GUID if unrecognized.
        /// </returns>
        public static Guid FromPrimitive(PrimitiveType pt) => pt switch
        {
            PrimitiveType.Void => Void,
            PrimitiveType.Bool => Bool,
            PrimitiveType.Char8 => Char8,
            PrimitiveType.Char16 => Char16,
            PrimitiveType.Byte => Byte,
            PrimitiveType.SByte => SByte,
            PrimitiveType.UInt16 => UInt16,
            PrimitiveType.Int16 => Int16,
            PrimitiveType.UInt32 => UInt32,
            PrimitiveType.Int32 => Int32,
            PrimitiveType.UInt64 => UInt64,
            PrimitiveType.Int64 => Int64,
            PrimitiveType.UInt128 => UInt128,
            PrimitiveType.Int128 => Int128,
            PrimitiveType.Half => Half,
            PrimitiveType.Float32 => Float32,
            PrimitiveType.Float64 => Float64,
            PrimitiveType.Float128 => Float128,
            PrimitiveType.Default => Default,
            PrimitiveType.CustomType => CustomType,
            _ => Unknown
        };
    }
}
