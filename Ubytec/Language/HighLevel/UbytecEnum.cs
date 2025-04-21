using Ubytec.Language.HighLevel.Interfaces;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecEnum(string name, (string Name, long Value)[] members, PrimitiveType typeSize = PrimitiveType.Byte, TypeModifiers modifiers = TypeModifiers.None, Guid? customID = null) : IUbytecContextEntity
    {
        public string Name { get; } = name;
        public Guid? CustomID { get; } = customID;
        public PrimitiveType TypeSize { get; } = typeSize;
        public TypeModifiers Modifiers { get; } = modifiers;
        public bool IsBitfield { get; }

        public (string Name, long Value)[] Members { get; } = members;
    }
}
