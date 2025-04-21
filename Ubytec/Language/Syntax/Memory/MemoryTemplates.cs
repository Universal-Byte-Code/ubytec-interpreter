using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Syntax.Memory
{
    // Devuelve la plantilla de memoria según tipo y modificadores
    public static class MemoryTemplates
    {
        private static readonly Dictionary<PrimitiveType, MemoryRegionTemplate> _baseTemplates
            = new()
            {
                // No se almacena nada para Void, tamaño 0
                [PrimitiveType.Void]      = new MemoryRegionTemplate(".data", 1, 0, 0, true),

                // Booleanos y caracteres
                [PrimitiveType.Bool]      = new MemoryRegionTemplate(".data", 1, 1, 0, true),
                [PrimitiveType.Char8]     = new MemoryRegionTemplate(".data", 1, 1, 0, true),
                [PrimitiveType.Char16]    = new MemoryRegionTemplate(".data", 2, 2, 0, true),

                // Enteros de 8 bits
                [PrimitiveType.Byte]      = new MemoryRegionTemplate(".data", 1, 1, 0, true),
                [PrimitiveType.SByte]     = new MemoryRegionTemplate(".data", 1, 1, 0, true),

                // Enteros de 16 bits
                [PrimitiveType.UInt16]    = new MemoryRegionTemplate(".data", 2, 2, 0, true),
                [PrimitiveType.Int16]     = new MemoryRegionTemplate(".data", 2, 2, 0, true),

                // Enteros de 32 bits
                [PrimitiveType.UInt32]    = new MemoryRegionTemplate(".data", 4, 4, 0, true),
                [PrimitiveType.Int32]     = new MemoryRegionTemplate(".data", 4, 4, 0, true),

                // Enteros de 64 bits
                [PrimitiveType.UInt64]    = new MemoryRegionTemplate(".data", 8, 8, 0, true),
                [PrimitiveType.Int64]     = new MemoryRegionTemplate(".data", 8, 8, 0, true),

                // Enteros de 128 bits
                [PrimitiveType.UInt128]   = new MemoryRegionTemplate(".data", 16, 16, 0, true),
                [PrimitiveType.Int128]    = new MemoryRegionTemplate(".data", 16, 16, 0, true),

                // Flotantes
                [PrimitiveType.Half]      = new MemoryRegionTemplate(".data", 2, 2, 0, false),
                [PrimitiveType.Float32]   = new MemoryRegionTemplate(".data", 4, 4, 0, false),
                [PrimitiveType.Float64]   = new MemoryRegionTemplate(".data", 8, 8, 0, false),
                [PrimitiveType.Float128]  = new MemoryRegionTemplate(".data", 16, 16, 0, false),

                // Casos especiales
                [PrimitiveType.Default]     = new MemoryRegionTemplate(".data", 8, 8, 0, true),
                [PrimitiveType.CustomType]  = new MemoryRegionTemplate(".data", 8, 8, 0, true),
                [PrimitiveType.Unknown]     = new MemoryRegionTemplate(".data", 8, 8, 0, true),
            };

        // Registro inyectable para tipos definidos por el usuario
        public static IDictionary<Guid, MemoryRegionTemplate> CustomTypeRegistry { get; set; }
            = new Dictionary<Guid, MemoryRegionTemplate>();

        /*public static MemoryRegionTemplate For(UbytecType twf)
        {
            MemoryRegionTemplate tpl;

            if (twf.Type == PrimitiveType.CustomType)
            {
                if (twf.CustomID == null || !CustomTypeRegistry.TryGetValue(twf.CustomID.Value, out tpl))
                    throw new NotSupportedException($"CustomType sin registro para ID={twf.CustomID}");
            }
            else if (!_baseTemplates.TryGetValue(twf.Type, out tpl))
            {
                throw new NotSupportedException($"Tipo primitivo {twf.Type} no soportado.");
            }

            // Alineación según plantilla
            var section = tpl.SectionName;
            var elementSz = tpl.Size;
            nuint totalSize = 0;
            if (twf.IsArray)
                totalSize = elementSz * twf.FixedArraySize; // usa TW Size aquí
            var emitZero = tpl.EmitZeroDirective;
            var defaultVal = tpl.DefaultValue;

            if (twf.IsNullable)
            {
                section  = ".bss";  // sin inicializar
                emitZero = true;
            }

            return tpl with
            {
                SectionName      = section,
                Alignment        = tpl.Alignment,
                Size             = totalSize,
                DefaultValue     = defaultVal,
                EmitZeroDirective= emitZero
            };
        }*/
    }
}