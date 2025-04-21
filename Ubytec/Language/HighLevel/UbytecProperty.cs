using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecProperty(string name, UbytecType type, UbytecAccessorContext accessorContext, TypeModifiers modifiers = TypeModifiers.None, Guid? customID = null)
    {
        public string Name { get; } = name;
        public UbytecType Type { get; } = type;
        public TypeModifiers Modifiers { get; } = modifiers;
        public Guid? CustomID { get; } = customID;
        public UbytecAccessorContext AccessorContext { get; } = accessorContext;
    }
}
