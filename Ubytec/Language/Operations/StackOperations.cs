using Ubytec.Language.Syntax.Scopes;

namespace Ubytec.Language.Operations
{
    public static class StackOperarions
    {
        public readonly record struct PUSH(byte[] operands) : IOpCode
        {
            public readonly byte OpCode => 0x11;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct POP : IOpCode
        {
            public readonly byte OpCode => 0x12;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct DUP : IOpCode
        {
            public readonly byte OpCode => 0x13;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct SWAP : IOpCode
        {
            public readonly byte OpCode => 0x14;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct ROT : IOpCode
        {
            public readonly byte OpCode => 0x15;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct OVER : IOpCode
        {
            public readonly byte OpCode => 0x16;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct NIP : IOpCode
        {
            public readonly byte OpCode => 0x17;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct DROP(byte stackIndex) : IOpCode
        {
            public readonly byte OpCode => 0x18;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct TwoDUP : IOpCode
        {
            public readonly byte OpCode => 0x19;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct TwoSWAP : IOpCode
        {
            public readonly byte OpCode => 0x1A;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct TwoROT : IOpCode
        {
            public readonly byte OpCode => 0x1B;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct TwoOVER : IOpCode
        {
            public readonly byte OpCode => 0x1C;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct PICK(byte n) : IOpCode
        {
            public readonly byte OpCode => 0x1D;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
        public readonly record struct ROLL(byte n) : IOpCode
        {
            public readonly byte OpCode => 0x1E;

            string IUbytecEntity.Compile(CompilationScopes scopes)
            {
                throw new NotImplementedException();
            }
        }
    }

}
