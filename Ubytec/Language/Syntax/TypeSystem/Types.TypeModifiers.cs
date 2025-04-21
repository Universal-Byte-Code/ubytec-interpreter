namespace Ubytec.Language.Syntax.TypeSystem
{
    public static partial class Types
    {
        [Flags]
        public enum TypeModifiers : int
        {
            None = 0,

            // Nullable / Array
            Nullable = 1 << 0,
            IsArray = 1 << 1,

            NullableArray = 1 << 2,
            NullableItems = 1 << 3,

            // Access modifiers
            Public = 1 << 4,
            Private = 1 << 5,
            Protected = 1 << 6,
            Internal = 1 << 7,
            Secret = 1 << 8,

            // Mutability
            Const = 1 << 9,
            ReadOnly = 1 << 10,

            // Behavior
            Abstract = 1 << 11,
            Virtual = 1 << 12,
            Override = 1 << 13,
            Sealed = 1 << 14,

            // Scope
            Local = 1 << 15,
            Global = 1 << 16,

            // Reserved
            Reserved = 1 << 17
        }
    }
}
