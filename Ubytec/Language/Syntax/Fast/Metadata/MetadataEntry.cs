using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace Ubytec.Language.Syntax.Fast.Metadata
{
    /// <summary>
    /// A fixed-size metadata entry storing a UTF-8 key/value pair inline in unmanaged memory.
    /// </summary>
    [SkipLocalsInit]
    [StructLayout(LayoutKind.Sequential, Pack = 1, Size = 320)]
    [CLSCompliant(false)]
    public unsafe struct MetadataEntry
    {
        /// <summary>
        /// Number of bytes reserved for the key buffer.
        /// </summary>
        public const int KEY_SIZE = 64;

        /// <summary>
        /// Number of bytes reserved for the value buffer.
        /// </summary>
        public const int VALUE_SIZE = 256;

        /// <summary>
        /// Inline UTF-8 key buffer (fixed <see cref="KEY_SIZE"/> bytes).
        /// </summary>
        public fixed byte Key[KEY_SIZE];

        /// <summary>
        /// Inline UTF-8 value buffer (fixed <see cref="VALUE_SIZE"/> bytes).
        /// </summary>
        public fixed byte Value[VALUE_SIZE];

        /// <summary>
        /// Initializes a new instance of <see cref="MetadataEntry"/>,
        /// zeroing out both key and value buffers.
        /// </summary>
        public MetadataEntry()
        {
            Unsafe.InitBlock(ref Key[0], 0, KEY_SIZE);
            Unsafe.InitBlock(ref Value[0], 0, VALUE_SIZE);
        }

        /// <summary>
        /// Attempts to encode and store the specified string into the key buffer.
        /// </summary>
        /// <param name="key">The string to encode as UTF-8.</param>
        /// <returns>
        /// <c>true</c> if the UTF-8 bytes fit within <see cref="KEY_SIZE"/>; otherwise <c>false</c>.
        /// </returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public readonly bool TrySetKey(string key)
        {
            fixed (byte* pKey = Key)
            {
                var span = new Span<byte>(pKey, KEY_SIZE);
                span.Clear();

                int needed = Encoding.UTF8.GetByteCount(key);
                if (needed >= KEY_SIZE) return false;

                Encoding.UTF8.GetBytes(key, span);
                return true;
            }
        }

        /// <summary>
        /// Attempts to encode and store the specified string into the value buffer.
        /// </summary>
        /// <param name="str">The string to encode as UTF-8.</param>
        /// <returns>
        /// <c>true</c> if the UTF-8 bytes fit within <see cref="VALUE_SIZE"/>; otherwise <c>false</c>.
        /// </returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public readonly bool TrySetValue(string str)
        {
            fixed (byte* pValue = Value)
            {
                var span = new Span<byte>(pValue, VALUE_SIZE);
                span.Clear();

                int needed = Encoding.UTF8.GetByteCount(str);
                if (needed >= VALUE_SIZE) return false;

                Encoding.UTF8.GetBytes(str, span);
                return true;
            }
        }

        /// <summary>
        /// Compares the stored key against the provided string for exact match.
        /// </summary>
        /// <param name="entry">Pointer to the entry to inspect.</param>
        /// <param name="key">The string to compare.</param>
        /// <returns>
        /// <c>true</c> if the stored key bytes equal the UTF-8 encoding of <paramref name="key"/>; otherwise <c>false</c>.
        /// </returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static bool KeyEquals(MetadataEntry* entry, string key)
        {
            byte* pKey = (byte*)entry;
            var stored = new ReadOnlySpan<byte>(pKey, KEY_SIZE);

            int storedLen = stored.IndexOf((byte)0);
            if (storedLen < 0) storedLen = KEY_SIZE;

            Span<byte> encoded = stackalloc byte[KEY_SIZE];
            int encLen = Encoding.UTF8.GetBytes(key, encoded);

            return encLen == storedLen
                && stored[..storedLen].SequenceEqual(encoded[..encLen]);
        }

        /// <summary>
        /// Gets a pointer to the start of the value buffer within the entry.
        /// </summary>
        /// <param name="entry">Pointer to the entry.</param>
        /// <returns>Pointer to the first byte of the value buffer.</returns>
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static byte* GetValuePointer(MetadataEntry* entry)
            => (byte*)entry + KEY_SIZE;
    }
}
