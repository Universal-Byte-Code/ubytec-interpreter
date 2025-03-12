using System.Collections.ObjectModel;

namespace ubytec_interpreter.Operations
{
    public static class Primitives
    {
        public static readonly ReadOnlyDictionary<PrimitiveType, (int rank, bool isSigned, bool isFloat)> NumericTypeInfo = new(
            new Dictionary<PrimitiveType, (int rank, bool isSigned, bool isFloat)>
            {
                // (rank, isSigned, isFloat)
                // Higher rank => bigger type

                // 8-bit signed
                { PrimitiveType.SByte,   (1, true,  false) },
                // 8-bit unsigned
                { PrimitiveType.Byte,    (1, false, false) },

                // 16-bit
                { PrimitiveType.Int16,   (2, true,  false) },
                { PrimitiveType.UInt16,  (2, false, false) },

                // 32-bit
                { PrimitiveType.Int32,   (3, true,  false) },
                { PrimitiveType.UInt32,  (3, false, false) },

                // 64-bit
                { PrimitiveType.Int64,   (4, true,  false) },
                { PrimitiveType.UInt64,  (4, false, false) },

                // 128-bit
                { PrimitiveType.Int128,  (5, true,  false) },
                { PrimitiveType.UInt128, (5, false, false) },

                // Floating
                { PrimitiveType.Half,    (2, true,  true ) },
                { PrimitiveType.Float32, (3, true,  true ) },
                { PrimitiveType.Float64, (4, true,  true ) },
                { PrimitiveType.Float128,(5, true,  true ) },
            });

        public static bool IsASCII(PrimitiveType pt) => pt ==  PrimitiveType.Char8;
        public static bool IsUTF(PrimitiveType pt) => pt ==  PrimitiveType.Char16;
        public static bool IsVoid(PrimitiveType pt) => pt == PrimitiveType.Void;
        public static bool IsBool(PrimitiveType pt) => pt == PrimitiveType.Bool;

        // We'll say "IsInTypeInfo" means it's in that dictionary
        public static bool IsNumeric(PrimitiveType pt) => NumericTypeInfo.ContainsKey(pt);

        // Also define small helpers
        public static bool IsFloat(PrimitiveType pt)
            => IsNumeric(pt) && NumericTypeInfo[pt].isFloat;

        public static bool IsSigned(PrimitiveType pt)
            => IsNumeric(pt) && NumericTypeInfo[pt].isSigned;

        public static bool IsUnsigned(PrimitiveType pt)
            => IsNumeric(pt) && !NumericTypeInfo[pt].isSigned && !NumericTypeInfo[pt].isFloat;

        public static int GetRank(PrimitiveType pt)
            => IsNumeric(pt) ? NumericTypeInfo[pt].rank : -1;

        /// <summary>
        /// Returns true if `from` can be implicitly converted to `to` according to typical C#-like rules.
        /// </summary>
        private static bool ValidateConversion(PrimitiveType from, PrimitiveType to, bool isExplicit)
        {
            // Same type is obviously allowed (this check is also in ValidateReturnType)
            if (from == to) return true;

            // 'void' cannot be converted to anything else implicitly, nor can anything become 'void' except exact match
            if (IsVoid(from) || IsVoid(to)) return false;

            if (IsBool(from))
            {
                // We'll allow conversion from bool to any numeric type
                //  => 0 => false,1 => true for integers
                //  => 0.0 => false, 1.0 => true for floats
                // Typically, in many languages it's explicit
                // but I want it as an implicit option, that's my design :)

                // We'll define "numeric" as any integer or float type
                return IsNumeric(to);
            }

            if (IsNumeric(from) && IsNumeric(to))
            {
                // let's handle "from float => to float" or "from int => bigger int => to float" etc.
                var (fromRank, fromIsSigned, _) = NumericTypeInfo[from];
                var (toRank, toIsSigned, _)   = NumericTypeInfo[to];

                if (fromRank <= toRank)
                {
                    if (fromIsSigned) // If from => see if 'to' can handle negative
                        if (!isExplicit) return toIsSigned || IsBool(to);
                        else return !toIsSigned;
                    else if (!fromIsSigned) // Else from => see if 'to' can handle unsigned
                        if (!isExplicit) return !toIsSigned || IsBool(to);
                        else return toIsSigned;
                }
                else
                {
                    return isExplicit;
                }
            }

            // If we get here, no recognized implicit conversion
            return false;
        }
        public static bool ValidateImplicitCast(PrimitiveType from, PrimitiveType to) => ValidateConversion(to, from, isExplicit: false);
        public static bool ValidateExplicitCast(PrimitiveType from, PrimitiveType to) => ValidateConversion(from, to, isExplicit: true);
        public static void ValidateCasts(byte expectedType, byte actualType)
        {
            if (!ValidateImplicitCast((PrimitiveType)expectedType, (PrimitiveType)actualType))
            {
                if (!ValidateExplicitCast((PrimitiveType)expectedType, (PrimitiveType)actualType))
                    throw new Exception($"Type mismatch at RETURN. Expected {expectedType:X2}, but got {actualType:X2}");
                else
                    throw new Exception($"Unexpected implicit primitive type cast, use a explicit cast...\n" +
                        $"Mismatch at RETURN. Expected {expectedType:X2}, but got {actualType:X2}");
            }
        }

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

            //Special
            Default = 0xFF  //Defaults to implementation type
        }
    }

}
