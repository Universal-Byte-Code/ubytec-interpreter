using System.Runtime.InteropServices;
using Ubytec.Language.AST;
using Xunit;
namespace Ubytec.Tests;

public class VectorTests
{
    private static readonly Lazy<SourceCompilation> Compilation = new(() =>
    {
        string Body(string n) { string s=File.ReadAllText(Path.Combine(AppContext.BaseDirectory,n));return s[(s.IndexOf('{')+1)..s.LastIndexOf('}')]; }
        return SourceCompiler.Compile("module (name:\"vector_tests\",version:\"0.1\",author:\"Ubytec\") {\n"+Body("libft-arena.ubc")+Body("libft-scalar.ubc")+Body("vector.ubc")+Body("vector-apps.ubc")+"\n}");
    });
    private static ulong A(nint p)=>unchecked((ulong)p);
    private static long Run(string name,params ulong[] args)
    {
        var c=Compilation.Value;string body=string.Concat(args.Select(x=>$"mov rax, 0x{x:X16}\n push rax\n"));body+=$"call {c.GetFunctionLabel(name)}\n add rsp, {args.Length*8}\n push rax";return Assert.Single(NativeStack.Run(body,1,c.Assembly));
    }
    private sealed class Buffer : IDisposable
    {
        internal nint Pointer {get;} private readonly int size;
        internal Buffer(byte[] bytes){size=bytes.Length;Pointer=Marshal.AllocHGlobal(size);Marshal.Copy(bytes,0,Pointer,size);}
        internal byte[] Read(){var b=new byte[size];Marshal.Copy(Pointer,b,0,size);return b;}
        public void Dispose()=>Marshal.FreeHGlobal(Pointer);
    }
    private sealed class Fixture : IDisposable
    {
        internal readonly Buffer Arena=new(Enumerable.Repeat((byte)0xA5,16+16384+16).ToArray());
        internal readonly Buffer Descriptor=new(new byte[40]);
        internal ulong Vec=>A(Descriptor.Pointer);internal ulong Owner=>A(Arena.Pointer);
        internal Fixture(int width){Assert.Equal(1,Run("ArenaInit",Owner,16384));Assert.Equal(1,Run("VectorInit",Vec,Owner,(ulong)width));}
        public void Dispose(){Arena.Dispose();Descriptor.Dispose();}
    }
    [Theory]
    [InlineData(1)] [InlineData(3)] [InlineData(8)] [InlineData(16)] [InlineData(255)]
    public void GenericElementsGrowInsertSelfEraseAndRelease(int width)
    {
        using var f=new Fixture(width);var expected=new List<byte[]>();
        for(int i=0;i<20;i++){byte[] bytes=Enumerable.Range(0,width).Select(j=>(byte)(i+j)).ToArray();using var element=new Buffer(bytes);Assert.Equal(1,Run("VectorPush",f.Vec,A(element.Pointer)));expected.Add(bytes);}
        ulong last=unchecked((ulong)Run("VectorAt",f.Vec,19));Assert.Equal(1,Run("VectorInsert",f.Vec,0,last));expected.Insert(0,(byte[])expected[19].Clone());
        Assert.Equal(1,Run("VectorErase",f.Vec,3,5));expected.RemoveRange(3,5);Assert.Equal(expected.Count,Run("VectorLength",f.Vec));
        using var output=new Buffer(new byte[width]);for(int i=0;i<expected.Count;i++){Assert.Equal(1,Run("VectorGet",f.Vec,(ulong)i,A(output.Pointer)));Assert.Equal(expected[i],output.Read());}
        Assert.Equal(0,Run("VectorAt",f.Vec,ulong.MaxValue));Assert.Equal(0,Run("VectorErase",f.Vec,0,ulong.MaxValue));Assert.Equal(1,Run("VectorClear",f.Vec));Assert.Equal(1,Run("VectorDestroy",f.Vec));Assert.Equal(new byte[40],f.Descriptor.Read());Assert.Equal(0,Marshal.ReadInt64(f.Arena.Pointer,8));Assert.All(f.Arena.Read()[16400..],x=>Assert.Equal(0xA5,x));
    }
    [Fact]
    public void PinRejectsMutationAndReleaseWithoutChangingState()
    {
        using var f=new Fixture(8);using var item=new Buffer(BitConverter.GetBytes(123UL));Assert.Equal(1,Run("VectorPush",f.Vec,A(item.Pointer)));Assert.Equal(1,Run("VectorPin",f.Vec));byte[] before=f.Arena.Read(),header=f.Descriptor.Read();
        Assert.Equal(0,Run("VectorReserve",f.Vec,32));Assert.Equal(0,Run("VectorPush",f.Vec,A(item.Pointer)));Assert.Equal(0,Run("VectorSet",f.Vec,0,A(item.Pointer)));Assert.Equal(0,Run("VectorErase",f.Vec,0,1));Assert.Equal(0,Run("VectorClear",f.Vec));Assert.Equal(0,Run("VectorDestroy",f.Vec));Assert.Equal(before,f.Arena.Read());Assert.Equal(header,f.Descriptor.Read());Assert.Equal(1,Run("VectorUnpin",f.Vec));Assert.Equal(1,Run("VectorDestroy",f.Vec));
    }
    [Fact]
    public void FailedReservePreservesDescriptorAndArenaThenRecovers()
    {
        using var f=new Fixture(16);using var item=new Buffer(new byte[16]);Assert.Equal(1,Run("VectorPush",f.Vec,A(item.Pointer)));byte[] before=f.Arena.Read(),header=f.Descriptor.Read();Assert.Equal(0,Run("VectorReserve",f.Vec,ulong.MaxValue));Assert.Equal(0,Run("VectorInit",f.Vec,f.Owner,1));Assert.Equal(before,f.Arena.Read());Assert.Equal(header,f.Descriptor.Read());Assert.Equal(1,Run("VectorReserve",f.Vec,128));Assert.Equal(1,Run("VectorDestroy",f.Vec));
    }
    [Fact]
    public void ExplicitPendingStateAndBinaryTextUseTheSameLibrary()
    {
        using var scratch=new Buffer(new byte[16]);using var state=new Fixture(16);
        foreach(ulong depth in new[]{0UL,1UL,63UL,256UL}){Assert.Equal(unchecked((long)(3*depth*(depth-1)/2+5*depth)),Run("VectorStateSum",state.Vec,A(scratch.Pointer),depth));Assert.Equal(0,Run("VectorLength",state.Vec));}
        Assert.Equal(-1,Run("VectorStateSum",state.Vec,A(scratch.Pointer),ulong.MaxValue));Assert.Equal(0,Run("VectorLength",state.Vec));Assert.Equal(1,Run("VectorDestroy",state.Vec));
        using var text=new Fixture(1);using var input=new Buffer([97,0,255,122]);Assert.Equal(1,Run("VectorAppendText",text.Vec,A(scratch.Pointer),A(input.Pointer),4));nint p=(nint)Run("VectorAt",text.Vec,0);Assert.Equal(new byte[]{65,0,255,90},Enumerable.Range(0,4).Select(i=>Marshal.ReadByte(p,i)).ToArray());byte[] before=text.Arena.Read(),header=text.Descriptor.Read();Assert.Equal(0,Run("VectorAppendText",text.Vec,A(scratch.Pointer),A(input.Pointer),ulong.MaxValue));Assert.Equal(before,text.Arena.Read());Assert.Equal(header,text.Descriptor.Read());Assert.Equal(1,Run("VectorDestroy",text.Vec));
    }
}
