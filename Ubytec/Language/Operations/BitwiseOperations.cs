using System.Collections.ObjectModel;
using static Ubytec.Language.Operations.StackOperarions;

namespace Ubytec.Language.Operations
{
    public static class BitwiseOperations
    {
        public readonly record struct AND : IOpCode
        {
            public readonly byte OpCode => 0x30;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct OR : IOpCode
        {
            public readonly byte OpCode => 0x31;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct XOR : IOpCode
        {
            public readonly byte OpCode => 0x32;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct NOT : IOpCode
        {
            public readonly byte OpCode => 0x33;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct SHL : IOpCode
        {
            public readonly byte OpCode => 0x34;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct SHR : IOpCode
        {
            public readonly byte OpCode => 0x35;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
    }
}
