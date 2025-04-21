// MetadataEntry.cs
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace Ubytec.Language.Syntax.Fast.Metadata
{
    [SkipLocalsInit]
    [StructLayout(LayoutKind.Sequential, Pack = 1, Size = 320)]
    public unsafe struct MetadataEntry
    {
        public const int KEY_SIZE = 64;
        public const int VALUE_SIZE = 256;

        [FixedAddressValueType]
        // inline UTF‑8 key buffer (64 bytes)
        public fixed byte Key[KEY_SIZE];
        [FixedAddressValueType]
        // inline UTF‑8 value buffer (256 bytes)
        public fixed byte Value[VALUE_SIZE];

        public MetadataEntry()
        {
            Unsafe.InitBlock(ref Key[0], 0, KEY_SIZE);
            Unsafe.InitBlock(ref Value[0], 0, VALUE_SIZE);
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public readonly bool TrySetKey(string key)
        {
            fixed (byte* pKey = Key)
            {
                var span = new Span<byte>(pKey, KEY_SIZE);
                span.Clear();  // zero‑fill entire buffer

                int needed = Encoding.UTF8.GetByteCount(key);
                if (needed >= KEY_SIZE) return false;

                Encoding.UTF8.GetBytes(key, span);
                return true;
            }
        }

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public readonly bool TrySetValue(string str)
        {
            fixed (byte* pValue = Value)
            {
                var span = new Span<byte>(pValue, VALUE_SIZE);
                span.Clear();  // zero‑fill entire buffer

                int needed = Encoding.UTF8.GetByteCount(str);
                if (needed >= VALUE_SIZE) return false;

                Encoding.UTF8.GetBytes(str, span);
                return true;
            }
        }

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

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static byte* GetValuePointer(MetadataEntry* entry) => (byte*)entry + KEY_SIZE;
    }
}
