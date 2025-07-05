using System.Collections.Immutable;
using System.Runtime.InteropServices;
using System.Text;
using Ubytec.Language.Syntax.Fast.Metadata;

namespace Ubytec.Language.Syntax.Fast.Metadata
{
    /// <summary>
    /// Provides extension methods for <see cref="MetadataRegistry"/>, 
    /// enabling enumeration and retrieval of entries by index.
    /// </summary>
    [CLSCompliant(true)]
    public static class MetadataRegistryExtensions
    {
        /// <summary>
        /// Converts the contents of the <see cref="MetadataRegistry"/> into an immutable dictionary.
        /// </summary>
        /// <param name="registry">The metadata registry to enumerate.</param>
        /// <returns>
        /// An <see cref="ImmutableDictionary{TKey, TValue}"/> containing all key/value pairs 
        /// present in <paramref name="registry"/> in insertion order.
        /// </returns>
        [CLSCompliant(false)]
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

        /// <summary>
        /// Attempts to retrieve the metadata entry at the specified index.
        /// </summary>
        /// <param name="registry">The metadata registry to query.</param>
        /// <param name="index">The zero-based index of the entry to retrieve.</param>
        /// <param name="key">
        /// When this method returns, contains the UTF-8 decoded key of the entry 
        /// if found; otherwise, an empty string.
        /// </param>
        /// <param name="value">
        /// When this method returns, contains the UTF-8 decoded value of the entry 
        /// if found; otherwise, <c>null</c>.
        /// </param>
        /// <returns>
        /// <c>true</c> if an entry at the specified <paramref name="index"/> exists; 
        /// otherwise, <c>false</c>.
        /// </returns>
        [CLSCompliant(false)]
        public unsafe static bool TryGetByIndex(this MetadataRegistry registry, uint index, out string key, out object? value)
        {
            key = string.Empty;
            value = null;

            if (index >= registry.Count)
                return false;

            MetadataEntry* entry = registry.GetEntryPointer(index);

            // Decode key
            byte* keyPtr = entry->Key;
            int keyLength = 0;
            while (keyLength < MetadataEntry.KEY_SIZE && keyPtr[keyLength] != 0)
                keyLength++;
            key = Encoding.UTF8.GetString(keyPtr, keyLength);

            // Decode value
            byte* valPtr = entry->Value;
            int valLength = 0;
            while (valLength < MetadataEntry.VALUE_SIZE && valPtr[valLength] != 0)
                valLength++;
            value = Encoding.UTF8.GetString(valPtr, valLength);

            return true;
        }
    }
}
