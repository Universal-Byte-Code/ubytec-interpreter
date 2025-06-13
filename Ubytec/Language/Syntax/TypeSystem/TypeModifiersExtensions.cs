using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.TypeSystem
{
    /// <summary>
    /// Provides extension methods for the <see cref="TypeModifiers"/> enum,
    /// allowing bitwise operations and analyses on modifier flags.
    /// </summary>
    public static class TypeModifiersExtensions
    {
        /// <summary>
        /// Counts the number of individual flags set in the given <see cref="TypeModifiers"/> value.
        /// </summary>
        /// <param name="modifiers">The combined <see cref="TypeModifiers"/> flags to inspect.</param>
        /// <returns>
        /// The number of bits set to 1 in the integer representation of <paramref name="modifiers"/>.
        /// </returns>
        public static int CountSetBits(this TypeModifiers modifiers)
        {
            int count = 0;
            int val = (int)modifiers;
            while (val != 0)
            {
                count += val & 1;
                val >>= 1;
            }
            return count;
        }
    }
}
