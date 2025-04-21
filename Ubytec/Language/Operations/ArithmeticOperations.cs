using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static class ArithmeticOperations
    {
        public readonly record struct ADD : IOpCode
        {
            public readonly byte OpCode => 0x20;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct SUB : IOpCode
        {
            public readonly byte OpCode => 0x21;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct MUL : IOpCode
        {
            public readonly byte OpCode => 0x22;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct DIV : IOpCode
        {
            public readonly byte OpCode => 0x23;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct MOD : IOpCode
        {
            public readonly byte OpCode => 0x24;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct INC : IOpCode
        {
            public readonly byte OpCode => 0x25;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct DEC : IOpCode
        {
            public readonly byte OpCode => 0x26;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct NEG : IOpCode
        {
            public readonly byte OpCode => 0x27;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct ABS : IOpCode
        {
            public readonly byte OpCode => 0x28;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
    }
}
