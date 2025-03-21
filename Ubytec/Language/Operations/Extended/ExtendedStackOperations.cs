using System.Collections.ObjectModel;
using Ubytec.Language.Operations;
using static Ubytec.Language.Operations.StackOperarions;

namespace Ubytec.Language.Operations.Extended
{
    public static class ExtendedStackOperations
    {
        public readonly record struct PUSH16(ushort stackIndex) : IExtendedOpCode
        {
            public byte OpCode => 0xFF;
            public readonly byte ExtensionGroup => 0x10;
            public readonly byte ExtendedOpCode => 0x11;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }

        public readonly record struct DROP16(ushort stackIndex) : IExtendedOpCode
        {
            public byte OpCode => 0xFF;
            public readonly string Name => nameof(DROP16);
            public readonly byte ExtensionGroup => 0x10;
            public readonly byte ExtendedOpCode => 0x18;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }

        public readonly record struct PICK16(ushort n) : IExtendedOpCode
        {
            public byte OpCode => 0xFF;
            public readonly byte ExtensionGroup => 0x10;
            public readonly byte ExtendedOpCode => 0x1D;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }

        public readonly record struct ROLL16(ushort n) : IExtendedOpCode
        {
            public byte OpCode => 0xFF;
            public readonly byte ExtensionGroup => 0x10;
            public readonly byte ExtendedOpCode => 0x1E;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
    }
}
