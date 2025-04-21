using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecVariable(string name, UbytecType type, TypeModifiers modifiers = TypeModifiers.None, object? value = null)
    {
        public string Name { get; } = name;
        public UbytecType Type { get; } = type;
        public TypeModifiers Modifiers { get; } = modifiers;
        public object? Value { get; } = value;
    }
}
