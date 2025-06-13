using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;

namespace Ubytec.Language.Syntax.Fast.Metadata
{
    /// <summary>
    /// A high-performance registry of metadata entries, stored in unmanaged memory.
    /// Each entry is a fixed-size key/value pair, serialized to UTF-8.
    /// </summary>
    [SkipLocalsInit]
    [StructLayout(LayoutKind.Auto)]
    public unsafe struct MetadataRegistry : IDisposable
    {
        private MetadataEntry* _entries;
        private uint _count;
        private uint _capacity;

        /// <summary>
        /// Gets the number of metadata entries currently stored.
        /// </summary>
        public readonly uint Count => _count;

        /// <summary>
        /// Initializes a new <see cref="MetadataRegistry"/> with the specified initial capacity.
        /// </summary>
        /// <param name="capacity">
        /// The initial number of entries to allocate space for. 
        /// If less than 1, it will be rounded up to 1.
        /// </param>
        public MetadataRegistry(uint capacity)
        {
            if (capacity < 1) capacity = 1;
            _capacity = capacity;
            _count    = 0;

            nuint totalBytes = capacity * (nuint)sizeof(MetadataEntry);
            _entries = (MetadataEntry*)NativeMemory.Alloc(totalBytes, (nuint)sizeof(MetadataEntry));
            Unsafe.InitBlock(_entries, 0, (uint)totalBytes);
        }

        /// <summary>
        /// Adds a new metadata entry with the given key and value.
        /// </summary>
        /// <param name="key">The metadata key (string).</param>
        /// <param name="value">The metadata value (object); will be converted to string.</param>
        /// <exception cref="InvalidOperationException">
        /// Thrown if the <paramref name="value"/> cannot be serialized to JSON.
        /// </exception>
        /// <exception cref="ArgumentException">
        /// Thrown if the <paramref name="key"/> or the stringified <paramref name="value"/> exceed
        /// the fixed buffer size (<see cref="MetadataEntry.KEY_SIZE"/> or <see cref="MetadataEntry.VALUE_SIZE"/>).
        /// </exception>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void Add(string key, object value)
        {
            string str = value?.ToString() ?? string.Empty;
            // Validate JSON-serializable
            try { _ = JsonSerializer.SerializeToElement(str); }
            catch (Exception ex)
            {
                throw new InvalidOperationException($"Value '{str}' cannot be JSON-serialized.", ex);
            }

            if (_count >= _capacity)
                Expand(_capacity * 2);

            var entry = _entries + _count;
            if (!entry->TrySetKey(key))
                throw new ArgumentException($"Key '{key}' too long for {MetadataEntry.KEY_SIZE}-byte buffer.");
            if (!entry->TrySetValue(str))
                throw new ArgumentException($"Value '{str}' too long for {MetadataEntry.VALUE_SIZE}-byte buffer.");

            _count++;
        }

        /// <summary>
        /// Attempts to retrieve the string value associated with the given key.
        /// </summary>
        /// <param name="key">The metadata key to look up.</param>
        /// <param name="value">
        /// When this method returns, contains the metadata value if found; otherwise, <c>null</c>.
        /// </param>
        /// <returns>
        /// <c>true</c> if an entry with the specified key was found; otherwise, <c>false</c>.
        /// </returns>
        public readonly bool TryGetValue(string key, out string? value)
        {
            for (int i = 0; i < _count; i++)
            {
                var e = _entries + i;
                if (MetadataEntry.KeyEquals(e, key))
                {
                    byte* pVal = MetadataEntry.GetValuePointer(e);
                    int len = 0;
                    while (len < MetadataEntry.VALUE_SIZE && pVal[len] != 0) len++;

                    value = Encoding.UTF8.GetString(pVal, len);
                    return true;
                }
            }

            value = null;
            return false;
        }

        /// <summary>
        /// Gets a pointer to the <see cref="MetadataEntry"/> at the specified index.
        /// </summary>
        /// <param name="index">The zero-based index of the entry.</param>
        /// <returns>A pointer to the entry.</returns>
        /// <exception cref="IndexOutOfRangeException">
        /// Thrown if <paramref name="index"/> is outside the range of stored entries (0..Count-1).
        /// </exception>
        public readonly MetadataEntry* GetEntryPointer(uint index)
        {
            if (index >= _count)
                throw new IndexOutOfRangeException($"Index {index} is out of range (0..{_count - 1}).");
            return _entries + index;
        }

        /// <summary>
        /// Releases all unmanaged memory held by this registry.
        /// </summary>
        /// <remarks>
        /// After calling <see cref="Dispose"/>, this instance must not be used again.
        /// </remarks>
        public void Dispose()
        {
            if (_entries != null)
            {
                NativeMemory.Free(_entries);
                _entries  = null;
                _count    = 0;
                _capacity = 0;
            }
        }

        /// <summary>
        /// Doubles (or sets) the internal capacity and re-allocates the unmanaged buffer,
        /// copying existing entries into the new block.
        /// </summary>
        /// <param name="newCap">The new capacity; must be strictly greater than the current capacity.</param>
        /// <exception cref="InvalidOperationException">
        /// Thrown if <paramref name="newCap"/> is not larger than the existing capacity.
        /// </exception>
        [MethodImpl(MethodImplOptions.NoInlining)]
        private void Expand(uint newCap)
        {
            if (newCap <= _capacity)
                throw new InvalidOperationException("New capacity must be larger.");

            nuint newSize = newCap * (nuint)sizeof(MetadataEntry);
            var newBuf = (MetadataEntry*)NativeMemory.Alloc(newSize, (nuint)sizeof(MetadataEntry));
            Unsafe.InitBlockUnaligned(newBuf, 0, (uint)newSize);
            Buffer.MemoryCopy(_entries, newBuf, newSize, _count * (nuint)sizeof(MetadataEntry));

            NativeMemory.Free(_entries);
            _entries  = newBuf;
            _capacity = newCap;
        }
    }
}
