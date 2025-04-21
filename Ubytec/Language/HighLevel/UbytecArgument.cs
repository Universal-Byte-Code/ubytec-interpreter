using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    // Argument inside a function
    public readonly struct UbytecArgument(string name, UbytecType type, TypeModifiers modifiers = TypeModifiers.None, Guid? customID = null)
    {
        public string Name { get; } = name;
        public UbytecType Type { get; } = type;
        public TypeModifiers Modifiers { get; } = modifiers;
        public Guid? CustomID { get; } = customID;
    }
}
