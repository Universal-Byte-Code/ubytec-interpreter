using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecAction(string name, UbytecArgument[]? arguments = null, UbytecLocalContext? locals = null, Guid? customID = null, SyntaxSentence? definitionSentence = null) : IUbytecContextEntity
    {
        public string Name { get; } = name;
        public Guid? CustomID { get; } = customID;
        public UbytecArgument[] Arguments { get; } = arguments ?? [];
        public UbytecLocalContext? Locals { get; } = locals;
        public SyntaxSentence? Definition { get; } = definitionSentence;
    }
}
