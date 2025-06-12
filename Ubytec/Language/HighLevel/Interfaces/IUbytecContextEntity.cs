using Ubytec.Language.Syntax.TypeSystem;

namespace Ubytec.Language.HighLevel.Interfaces
{
    public interface IUbytecContextEntity : IUbytecHighLevelEntity
    {
        public string Name { get; }
        Types.TypeModifiers Modifiers { get; }
    }
}
