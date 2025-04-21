using System.Collections.Immutable;
using System.Runtime.InteropServices;
using System.Text;

namespace Ubytec.Language.Syntax.Fast.Metadata
{
    public static class MetadataRegistryExtensions
    {
        public static ImmutableDictionary<string, object> ToImmutable(this MetadataRegistry registry)
        {
            var builder = ImmutableDictionary.CreateBuilder<string, object>();

            for (uint i = 0; i < registry.Count; i++)
            {
                if (registry.TryGetByIndex(i, out var key, out var value))
                    builder[key] = value!;
            }

            return builder.ToImmutable();
        }

        public unsafe static bool TryGetByIndex(this MetadataRegistry registry, uint index, out string key, out object? value)
        {
            key = string.Empty;
            value = null;

            if (index >= registry.Count)
                return false;

            MetadataEntry* entry = registry.GetEntryPointer(index);

            // Clave
            byte* keyPtr = entry->Key;
            int keyLength = 0;
            for (; keyLength < 64 && keyPtr[keyLength] != 0; keyLength++) ;
            key = Encoding.UTF8.GetString(keyPtr, keyLength);

            // Valor
            byte* valPtr = entry->Value;
            int valLength = 0;
            for (; valLength < 256 && valPtr[valLength] != 0; valLength++) ;
            value = Encoding.UTF8.GetString(valPtr, valLength);

            return true;
        }
    }
}
