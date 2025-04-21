// MetadataRegistry.cs
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;

namespace Ubytec.Language.Syntax.Fast.Metadata
{
    [SkipLocalsInit]
    [StructLayout(LayoutKind.Auto)]
    public unsafe struct MetadataRegistry : IDisposable
    {
        private MetadataEntry* _entries;
        private uint _count;
        private uint _capacity;

        public MetadataRegistry(uint capacity)
        {
            if (capacity < 1) capacity = 1;
            _capacity = capacity;
            _count    = 0;

            nuint totalBytes = capacity * (nuint)sizeof(MetadataEntry);
            // After Alloc in constructor:
            _entries = (MetadataEntry*)NativeMemory.Alloc(totalBytes, (nuint)sizeof(MetadataEntry));
            // zero it:
            Unsafe.InitBlock(_entries, 0, (uint)totalBytes);
        }

        public readonly uint Count => _count;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void Add(string key, object value)
        {
            string str = value?.ToString() ?? "";
            // Validate JSON‑serializable
            try { _ = JsonSerializer.SerializeToElement(str); }
            catch (Exception ex)
            {
                throw new InvalidOperationException($"Value '{str}' cannot be JSON‑serialized.", ex);
            }

            // New slot (grow if needed)
            if (_count >= _capacity)
                Expand(_capacity * 2);

            var ne = _entries + _count;
            if (!ne->TrySetKey(key))
                throw new ArgumentException($"Key '{key}' too long for {MetadataEntry.KEY_SIZE}-byte buffer.");
            if (!ne->TrySetValue(str))
                throw new ArgumentException($"Value '{str}' too long for {MetadataEntry.VALUE_SIZE}-byte buffer.");

            _count++;
        }

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

        [MethodImpl(MethodImplOptions.NoInlining)]
        private void Expand(uint newCap)
        {
            if (newCap <= _capacity)
                throw new InvalidOperationException("New capacity must be larger.");

            nuint newSize = newCap * (nuint)sizeof(MetadataEntry);
            // In Expand:
            var newBuf = (MetadataEntry*)NativeMemory.Alloc(newSize, (nuint)sizeof(MetadataEntry));
            // clear the new buffer:
            Unsafe.InitBlockUnaligned(newBuf, 0, (uint)newSize);
            // then copy the old entries on top:
            Buffer.MemoryCopy(_entries, newBuf, newSize, _count * (nuint)sizeof(MetadataEntry));

            NativeMemory.Free(_entries);
            _entries  = newBuf;
            _capacity = newCap;
        }

        public readonly MetadataEntry* GetEntryPointer(uint index)
        {
            if (index >= _count)
                throw new IndexOutOfRangeException($"Index {index} is out of range (0..{_count-1}).");
            return _entries + index;
        }

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
    }
}
