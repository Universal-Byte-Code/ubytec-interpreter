using Ubytec.Language.HighLevel.Interfaces;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecClass(string name, UbytecField[] fields, UbytecProperty[] properties, UbytecFunc[] funcs, UbytecAction[] actions, UbytecInterface[] interfaces, UbytecClass[] classes, UbytecStruct[] structs, UbytecRecord[] records, UbytecEnum[] enums, TypeModifiers modifiers = TypeModifiers.None, Guid? customID = null) : IUbytecContextEntity
    {
        public string Name { get; } = name;
        public Guid? CustomID { get; } = customID;
        public TypeModifiers Modifiers { get; } = modifiers;
        public UbytecField[] Fields { get; } = fields;
        public UbytecProperty[] Properties { get; } = properties;
        public UbytecFunc[] Functions { get; } = funcs;
        public UbytecAction[] Actions { get; } = actions;
        public UbytecInterface[] Interfaces { get; } = interfaces;
        public UbytecClass[] Classes { get; } = classes;
        public UbytecStruct[] Structs { get; } = structs;
        public UbytecRecord[] Records { get; } = records;
        public UbytecEnum[] Enums { get; } = enums;
    }
}
