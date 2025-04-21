using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static class BitwiseOperations
    {
        public readonly record struct AND : IOpCode
        {
            public readonly byte OpCode => 0x30;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct OR : IOpCode
        {
            public readonly byte OpCode => 0x31;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct XOR : IOpCode
        {
            public readonly byte OpCode => 0x32;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct NOT : IOpCode
        {
            public readonly byte OpCode => 0x33;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct SHL : IOpCode
        {
            public readonly byte OpCode => 0x34;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct SHR : IOpCode
        {
            public readonly byte OpCode => 0x35;

            public string Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
    }
}
