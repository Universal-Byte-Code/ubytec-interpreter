using System.Collections.ObjectModel;
using static ubytec_interpreter.Operations.StackOperarions;

namespace ubytec_interpreter.Operations
{
    public static class ArithmeticOperations
    {
        public readonly record struct ADD : IOpCode
        {
            public readonly byte OpCode => 0x20;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct SUB : IOpCode
        {
            public readonly byte OpCode => 0x21;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct MUL : IOpCode
        {
            public readonly byte OpCode => 0x22;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct DIV : IOpCode
        {
            public readonly byte OpCode => 0x23;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct MOD : IOpCode
        {
            public readonly byte OpCode => 0x24;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct INC : IOpCode
        {
            public readonly byte OpCode => 0x25;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct DEC : IOpCode
        {
            public readonly byte OpCode => 0x26;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct NEG : IOpCode
        {
            public readonly byte OpCode => 0x27;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct ABS : IOpCode
        {
            public readonly byte OpCode => 0x28;

            string IOpCode.Compile(params Stack<object>[]? stacks)
            {
                throw new NotImplementedException();
            }
        }
    }
}
