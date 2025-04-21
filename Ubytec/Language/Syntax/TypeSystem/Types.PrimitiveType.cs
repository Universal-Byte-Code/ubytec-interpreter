namespace Ubytec.Language.Syntax.TypeSystem
{
    public static partial class Types
    {
        public enum PrimitiveType : byte
        {
            // 0x00  => Not an actual data type, used to represent nothing
            Void = 0x00,

            // 8-bit logical type (true/false), typically stored as 1 byte
            Bool = 0x01,

            // 8-bit character type (if you want a single-byte char, e.g. ASCII)
            Char8 = 0x02,

            // 16-bit character type (often used in C# for Unicode UTF-16)
            Char16 = 0x03,

            // 8-bit signed/unsigned
            Byte = 0x04,  //  8-bit unsigned
            SByte = 0x05,  //  8-bit signed

            // 16-bit
            UInt16 = 0x06,  // 16-bit unsigned
            Int16 = 0x07,  // 16-bit signed

            // 32-bit
            UInt32 = 0x08,  // 32-bit unsigned
            Int32 = 0x09,  // 32-bit signed

            // 64-bit
            UInt64 = 0x0A,  // 64-bit unsigned
            Int64 = 0x0B,  // 64-bit signed

            // 128-bit
            UInt128 = 0x0C,  // 128-bit unsigned
            Int128 = 0x0D,  // 128-bit signed

            // Floating-point types
            Half = 0x0E,  // 16-bit float
            Float32 = 0x0F,  // 32-bit float
            Float64 = 0x10,  // 64-bit float
            Float128 = 0x11,   // 128-bit float (rarely used)

            // Reserved for special logic
            Default = 0xF0,   // Defaults to implementation-defined type
            CustomType = 0xFE, // Marker for type resolved via string
            Unknown = 0xFF    // For internal errors or uninitialized values
        }
    }
}
