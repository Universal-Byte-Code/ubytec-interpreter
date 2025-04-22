namespace Ubytec.Language.HighLevel.Interfaces
{
    public interface IUbytecHighLevelEntity : IUbytecEntity
    {
        public Guid ID { get; }
        public void Validate();
    }
}
