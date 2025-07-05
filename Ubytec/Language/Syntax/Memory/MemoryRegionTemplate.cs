namespace Ubytec.Language.Syntax.Memory
{
    [CLSCompliant(false)]
    public readonly record struct MemoryRegionTemplate(
        string SectionName,     // p.ej. ".data", ".bss", ".rodata"
        nuint Alignment,        // alineamiento obligatorio en bytes
        nuint Size,             // tamaño total en bytes
        long DefaultValue,      // valor con el que inicializar
        bool EmitZeroDirective  // si usar ".zero N" o bien ".quad/VALUE"
    );
}