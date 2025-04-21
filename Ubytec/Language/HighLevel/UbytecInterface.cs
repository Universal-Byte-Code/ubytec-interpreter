using Ubytec.Language.HighLevel.Interfaces;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecInterface(string name, UbytecProperty[] properties, UbytecFunc[] funcs, UbytecAction[] actions, Guid? customID = null) : IUbytecContextEntity
    {
        public string Name { get; } = name;
        public Guid? CustomID { get; } = customID;
        public UbytecProperty[] Properties { get; } = properties;
        public UbytecFunc[] Functions { get; } = funcs;
        public UbytecAction[] Actions { get; } = actions;
    }
}
