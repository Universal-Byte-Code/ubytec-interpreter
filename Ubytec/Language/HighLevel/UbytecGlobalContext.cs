namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecGlobalContext(UbytecVariable[] variables, UbytecProperty[] properties, UbytecFunc[] funcs, UbytecAction[] actions)
    {
        public UbytecVariable[] Variables { get; } = variables;
        public UbytecFunc[] Functions { get; } = funcs;
        public UbytecAction[] Actions { get; } = actions;
    }
}
