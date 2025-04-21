using Ubytec.Language.HighLevel.Interfaces;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecStruct(string name, UbytecField[] fields, UbytecProperty[] properties, UbytecFunc[] funcs, UbytecAction[] actions, TypeModifiers modifiers = TypeModifiers.None, Guid? customID = null) : IUbytecContextEntity
    {
        public string Name { get; } = name;
        public Guid? CustomID { get; } = customID;
        public TypeModifiers Modifiers { get; } = modifiers;
        public UbytecField[] Fields { get; } = fields;
        public UbytecProperty[] Properties { get; } = properties;
        public UbytecFunc[] Functions { get; } = funcs;
        public UbytecAction[] Actions { get; } = actions;
    }
}
