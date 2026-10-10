using System.Runtime.InteropServices;
using Ubytec.Language.AST;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Tools;
using Xunit;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Tests;

public class TypedMemoryTests
{
    [Theory]
    [InlineData(PrimitiveType.Byte, 255)]
    [InlineData(PrimitiveType.SByte, -1)]
    [InlineData(PrimitiveType.Char8, 255)]
    [InlineData(PrimitiveType.UInt16, 65535)]
    [InlineData(PrimitiveType.Int16, -1)]
    [InlineData(PrimitiveType.Char16, 65535)]
    [InlineData(PrimitiveType.UInt32, 4294967295)]
    [InlineData(PrimitiveType.Int32, -1)]
    [InlineData(PrimitiveType.UInt64, -1)]
    [InlineData(PrimitiveType.Int64, -1)]
    [InlineData(PrimitiveType.Bool, 1)]
    public void TypedLoadExtendsUnalignedValues(PrimitiveType type, long expected)
    {
        nint memory = Marshal.AllocHGlobal(17);
        try
        {
            Marshal.Copy(Enumerable.Repeat((byte)255, 17).ToArray(), 0, memory, 17);
            string body = $"mov rax, 0x{unchecked((ulong)(memory + 1)):X16}\n push rax\n" +
                new MemoryOperations.LOAD(AccessType: type).Compile(new CompilationScopes());
            Assert.Equal(expected, Assert.Single(NativeStack.Run(body, 1)));
        }
        finally { Marshal.FreeHGlobal(memory); }
    }

    [Theory]
    [InlineData(PrimitiveType.Byte, 1)]
    [InlineData(PrimitiveType.SByte, 1)]
    [InlineData(PrimitiveType.Char8, 1)]
    [InlineData(PrimitiveType.UInt16, 2)]
    [InlineData(PrimitiveType.Int16, 2)]
    [InlineData(PrimitiveType.Char16, 2)]
    [InlineData(PrimitiveType.UInt32, 4)]
    [InlineData(PrimitiveType.Int32, 4)]
    [InlineData(PrimitiveType.UInt64, 8)]
    [InlineData(PrimitiveType.Int64, 8)]
    [InlineData(PrimitiveType.Bool, 1)]
    public void TypedStoreChangesOnlyItsStorageWidth(PrimitiveType type, int width)
    {
        nint memory = Marshal.AllocHGlobal(17);
        try
        {
            byte[] expected = Enumerable.Repeat((byte)0xA5, 17).ToArray();
            Marshal.Copy(expected, 0, memory, expected.Length);
            const ulong value = 0x123456789ABCDEF0;
            for (int i = 0; i < width; i++) expected[1 + i] = type == PrimitiveType.Bool ? (byte)1 : (byte)(value >> (i * 8));
            string body = $"mov rax, 0x{unchecked((ulong)(memory + 1)):X16}\n push rax\n mov rax, 0x{value:X16}\n push rax\n" +
                new MemoryOperations.STORE(AccessType: type).Compile(new CompilationScopes());
            Assert.Empty(NativeStack.Run(body, 0));
            byte[] actual = new byte[17];
            Marshal.Copy(memory, actual, 0, actual.Length);
            Assert.Equal(expected, actual);
        }
        finally { Marshal.FreeHGlobal(memory); }
    }

    [Theory]
    [InlineData(PrimitiveType.Float32)]
    [InlineData(PrimitiveType.Int128)]
    [InlineData(PrimitiveType.Void)]
    public void UnsupportedAccessTypesAreRejected(PrimitiveType type)
    {
        Assert.ThrowsAny<Exception>(() => new MemoryOperations.LOAD(AccessType: type).Compile(new CompilationScopes()));
        Assert.ThrowsAny<Exception>(() => new MemoryOperations.STORE(AccessType: type).Compile(new CompilationScopes()));
    }

    [Fact]
    public void TypedMemoryOperationsRoundTripThroughJson()
    {
        var options = new System.Text.Json.JsonSerializerOptions();
        options.Converters.Add(new Ubytec.Language.Tools.Serialization.IOpCodeConverter());
        foreach (IOpCode instruction in new IOpCode[] { new MemoryOperations.LOAD(AccessType: PrimitiveType.Byte), new MemoryOperations.STORE(AccessType: PrimitiveType.Int16) })
        {
            string json = System.Text.Json.JsonSerializer.Serialize(instruction, options);
            var restored = System.Text.Json.JsonSerializer.Deserialize<IOpCode>(json, options);
            Assert.Equal(instruction, restored);
        }
    }

    [Fact]
    public void TypedMemorySyntaxParsesAndExecutes()
    {
        string source = "module (name:\"typed\",version:\"0.1\",author:\"Ubytec\")\n{\nfunc Read(t_uint64 address) -> t_int32\n{\nload @address\nload t_sbyte\nreturn\n}\n}";
        var compiled = SourceCompiler.Compile(source);
        using var guarded = new GuardedCString([255, 0]);
        string body = $"mov rax, 0x{unchecked((ulong)guarded.Pointer):X16}\n push rax\n call {compiled.GetFunctionLabel("Read")}\n add rsp, 8\n push rax";
        Assert.Equal(-1, Assert.Single(NativeStack.Run(body, 1, compiled.Assembly)));
    }

    [Fact]
    public void TypedStoreSyntaxWritesExactlyOneByte()
    {
        string source = "module (name:\"typed\",version:\"0.1\",author:\"Ubytec\")\n{\nfunc Write(t_uint64 address, t_int64 value) -> t_void\n{\nload @address\nload @value\nstore t_byte\nreturn\n}\n}";
        var compiled = SourceCompiler.Compile(source);
        using var buffer = new GuardedCString([0, 0]);
        string body = $"mov rax, 0x{unchecked((ulong)buffer.Pointer):X16}\n push rax\n push 65\n call {compiled.GetFunctionLabel("Write")}\n add rsp, 16";
        Assert.Empty(NativeStack.Run(body, 0, compiled.Assembly));
        Assert.Equal(65, Marshal.ReadByte(buffer.Pointer));
        Assert.Equal(0, Marshal.ReadByte(buffer.Pointer, 1));
    }
}
