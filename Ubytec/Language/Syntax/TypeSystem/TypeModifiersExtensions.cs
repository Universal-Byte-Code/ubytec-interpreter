using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.TypeSystem
{
    public static class TypeModifiersExtensions
    {
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
