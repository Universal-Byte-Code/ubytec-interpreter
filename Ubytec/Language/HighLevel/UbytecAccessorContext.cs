namespace Ubytec.Language.HighLevel
{
    public readonly struct UbytecAccessorContext(UbytecFunc[] accessors)
    {
        public UbytecFunc[] Accesors { get; } = accessors;
    }
}
