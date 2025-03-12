using System.Collections.ObjectModel;

namespace ubytec_interpreter
{
    internal static class ToolBox
    {
        public static ReadOnlyCollection<byte> EncodeOperands(byte extensionGroup, byte extendedOpCode, ushort value)
        {
            return new ReadOnlyCollection<byte>([
                extensionGroup,  // First-level extension (0x10)
                extendedOpCode,  // Second-level extension (unique per instruction)
                (byte)(value & 0xFF),  // Lower byte of value (LSB)
                (byte)((value >> 8) & 0xFF) // Upper byte of value (MSB)
            ]);
        }
    }
}
