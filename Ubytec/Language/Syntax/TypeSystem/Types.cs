using System.Collections.ObjectModel;

namespace Ubytec.Language.Syntax.TypeSystem
{
    /// <summary>
    /// Provides primitive and composite type representations for the Ubytec language.
    /// The <see cref="UType"/> struct encapsulates a base <see cref="PrimitiveType"/>,
    /// type modifiers (such as nullability or array flags), and optional metadata.
    /// </summary>
    public static partial class Types
    {
        // ───────────────────────────  numeric meta table  ──────────────────────────

        /// <summary>
        /// Read-only mapping of numeric <see cref="PrimitiveType"/> values to their metadata:
        /// rank (widening order), signedness, and whether they represent floating-point types.
        /// </summary>
        /// <remarks>
        /// (rank ↑  ⇒  size ↑)
        /// </remarks>
        public static readonly ReadOnlyDictionary<PrimitiveType, (int rank, bool signed, bool floating)>
            NumericTypeInfo = new(new Dictionary<PrimitiveType, (int, bool, bool)>
        {
            // (rank, signed?, float?)
            { PrimitiveType.SByte   , (1,  true , false) },
            { PrimitiveType.Byte    , (1, false , false) },
            { PrimitiveType.Int16   , (2,  true , false) },
            { PrimitiveType.UInt16  , (2, false , false) },
            { PrimitiveType.Int32   , (3,  true , false) },
            { PrimitiveType.UInt32  , (3, false , false) },
            { PrimitiveType.Int64   , (4,  true , false) },
            { PrimitiveType.UInt64  , (4, false , false) },
            { PrimitiveType.Int128  , (5,  true , false) },
            { PrimitiveType.UInt128 , (5, false , false) },
            { PrimitiveType.Half    , (2,  true ,  true) },
            { PrimitiveType.Float32 , (3,  true ,  true) },
            { PrimitiveType.Float64 , (4,  true ,  true) },
            { PrimitiveType.Float128, (5,  true ,  true) },
        });

        /// <summary>
        /// Returns true if the type represents a single-byte ASCII character.
        /// </summary>
        public static bool IsASCII(this PrimitiveType pt) => pt == PrimitiveType.Char8;

        /// <summary>
        /// Returns true if the type represents a 16-bit Unicode character.
        /// </summary>
        public static bool IsUTF(this PrimitiveType pt) => pt == PrimitiveType.Char16;

        /// <summary>
        /// Returns true if the type is <c>Void</c> (no value).
        /// </summary>
        public static bool IsVoid(this PrimitiveType pt) => pt == PrimitiveType.Void;

        /// <summary>
        /// Returns true if the type is <c>Bool</c>.
        /// </summary>
        public static bool IsBool(this PrimitiveType pt) => pt == PrimitiveType.Bool;

        /// <summary>
        /// Determines if the type is numeric (integer or floating-point).
        /// </summary>
        public static bool IsNumeric(this PrimitiveType pt) => NumericTypeInfo.ContainsKey(pt);

        /// <summary>
        /// Determines if the numeric type is floating-point.
        /// </summary>
        public static bool IsFloat(this PrimitiveType pt) => pt.IsNumeric() && NumericTypeInfo[pt].floating;

        /// <summary>
        /// Determines if the numeric type is signed (including floating-point).
        /// </summary>
        public static bool IsSigned(this PrimitiveType pt) => pt.IsNumeric() && NumericTypeInfo[pt].signed;

        /// <summary>
        /// Determines if the numeric type is unsigned integer (non-floating).
        /// </summary>
        public static bool IsUnsigned(this PrimitiveType pt) => pt.IsNumeric() && !NumericTypeInfo[pt].signed && !pt.IsFloat();

        /// <summary>
        /// Retrieves the widening rank of the numeric type, or -1 if not numeric.
        /// </summary>
        public static int Rank(this PrimitiveType pt) => pt.IsNumeric() ? NumericTypeInfo[pt].rank : -1;

        /// <summary>
        /// Validates whether a conversion between two primitive types is allowed,
        /// enforcing implicit or explicit rules similar to C# (plus bool⇄numeric by design).
        /// </summary>
        /// <param name="from">Source type.</param>
        /// <param name="to">Target type.</param>
        /// <param name="explicitAllowed">
        /// If true, allows explicit (potentially lossy) conversions; otherwise only implicit.
        /// </param>
        /// <returns>True if conversion is valid under the given mode; otherwise false.</returns>
        private static bool CanConvert(PrimitiveType from, PrimitiveType to, bool explicitAllowed)
        {
            // identical
            if (from == to) return true;

            // disallow any interaction with void
            if (from.IsVoid() || to.IsVoid()) return false;

            // bool rules
            if (from.IsBool())
                return to.IsNumeric() || (explicitAllowed && !to.IsVoid());

            // purely numeric path
            if (from.IsNumeric() && to.IsNumeric())
            {
                var (rFrom, sFrom, fFrom) = NumericTypeInfo[from];
                var (rTo, sTo, fTo) = NumericTypeInfo[to];

                // float targets always accept (potentially lossy) integer inputs explicitly
                if (fTo && !explicitAllowed && !fFrom) return false;

                // widening
                if (rFrom <= rTo && (!sFrom || sTo) && (fFrom == fTo))
                    return true;

                // explicit cast path
                return explicitAllowed;
            }

            return false;
        }

        /// <summary>
        /// Determines if an implicit cast from the source to target type is valid.
        /// </summary>
        public static bool ValidateImplicitCast(PrimitiveType from, PrimitiveType to)
            => CanConvert(from, to, explicitAllowed: false);

        /// <summary>
        /// Determines if an explicit (C#-style) cast from source to target type is valid.
        /// </summary>
        public static bool ValidateExplicitCast(PrimitiveType from, PrimitiveType to)
            => CanConvert(from, to, explicitAllowed: true);

        /// <summary>
        /// Throws an <see cref="Exception"/> if the byte-coded <paramref name="actual"/>
        /// cannot be assigned to the <paramref name="expected"/> type under implicit or explicit rules.
        /// </summary>
        /// <param name="expected">Byte representing the expected <see cref="PrimitiveType"/>.</param>
        /// <param name="actual">Byte representing the actual <see cref="PrimitiveType"/>.</param>
        /// <exception cref="Exception">
        /// Throws <c>Exception</c> indicating whether an explicit cast is required
        /// or the conversion is invalid.</exception>
        public static void ValidateCasts(byte expected, byte actual)
        {
            var exp = (PrimitiveType)expected;
            var act = (PrimitiveType)actual;

            if (ValidateImplicitCast(act, exp)) return;        // OK – implicit
            if (ValidateExplicitCast(act, exp))
                throw new Exception(
                    $"Explicit cast required: cannot implicitly convert {act} to {exp}.");
            throw new Exception($"Type mismatch: cannot convert {act} to {exp}.");
        }
    }
}
