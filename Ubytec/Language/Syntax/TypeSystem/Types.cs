using System.Collections.ObjectModel;

namespace Ubytec.Language.Syntax.TypeSystem
{
    public static partial class Types
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

        public static bool IsNumeric(PrimitiveType pt) => NumericTypeInfo.ContainsKey(pt);

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
                // We'll allow conversion from bool to any numeric type
                //  => 0 => false,1 => true for integers
                //  => 0.0 => false, 1.0 => true for floats
                // Typically, in many languages it's explicit
                // but I want it as an implicit option, that's my design :)

                // We'll define "numeric" as any integer or float type
                return IsNumeric(to);

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
                    throw new Exception($"Type mismatch at end statement. Expected {expectedType:X2}, but got {actualType:X2}");
                else
                    throw new Exception($"Unexpected implicit primitive type cast, use a explicit cast...\n" +
                        $"Mismatch at end statement. Expected {expectedType:X2}, but got {actualType:X2}");
            }
        }
    }
}
