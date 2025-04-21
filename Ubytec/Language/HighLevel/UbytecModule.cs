using Ubytec.Language.HighLevel.Interfaces;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecModule(string name, string version, string[]? requires, string author, UbytecLocalContext localContext, UbytecGlobalContext globalContext, UbytecField[] fields, UbytecProperty[] properties, UbytecFunc[] funcs, UbytecAction[] actions, UbytecInterface[] interfaces, UbytecClass[] classes, UbytecStruct[] structs, UbytecRecord[] records, UbytecEnum[] enums, UbytecModule[] subModules, TypeModifiers modifiers = TypeModifiers.None, Guid? id = null) : IUbytecContextEntity
    {
        public string Name { get; } = name;
        public string Version { get; } = version;
        public string Author { get; } = author;
        public string[]? Requires { get; } = requires;
        public Guid? ID { get; } = id;
        public UbytecLocalContext LocalContext { get; } = localContext;
        public UbytecGlobalContext GlobalContext { get; } = globalContext;
        public UbytecField[] Fields { get; } = fields;
        public UbytecProperty[] Properties { get; } = properties;
        public UbytecFunc[] Functions { get; } = funcs;
        public UbytecAction[] Actions { get; } = actions;
        public UbytecInterface[] Interfaces { get; } = interfaces;
        public UbytecClass[] Classes { get; } = classes;
        public UbytecStruct[] Structs { get; } = structs;
        public UbytecRecord[] Records { get; } = records;
        public UbytecEnum[] Enums { get; } = enums;
        public UbytecModule[] SubModules { get; } = subModules;
    }
}
