using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecFunc(string name, UbytecType returnType, UbytecArgument[]? arguments = null, UbytecLocalContext? locals = null, Guid? customID = null, SyntaxSentence? definitionSentence = null) : IUbytecContextEntity
    {
        public string Name { get; } = name;
        public Guid? CustomID { get; } = customID;
        public UbytecType ReturnType { get; } = returnType;
        public UbytecArgument[] Arguments { get; } = arguments ?? [];
        public UbytecLocalContext? Locals { get; } = locals;
        public SyntaxSentence? Definition { get; } = definitionSentence;
    }
}
