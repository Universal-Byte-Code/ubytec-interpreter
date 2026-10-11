using System.Runtime.InteropServices;
using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class TextAnalyzerTests
{
    private static readonly Lazy<SourceCompilation> Compilation=new(()=>
    {
        string Body(string name){string s=File.ReadAllText(Path.Combine(AppContext.BaseDirectory,name));return s[(s.IndexOf('{')+1)..s.LastIndexOf('}')];}
        string source=Body("text-analyzer.ubc").Split("func TextMain",StringSplitOptions.None)[0];
        const string fixtures="""
        func HostWrite(t_uint64 a,t_uint64 b,t_uint64 c,t_uint64 d,t_uint64 e) -> t_int64 { push 1
        return
        }
        func TextSortDefault(t_uint64 words,t_uint64 scratch) -> t_uint64 {
        load @words
        fnaddr TextRecordCompare
        load @scratch
        call TextSort
        return
        }
        """;
        return SourceCompiler.Compile("module (name:\"text_tests\",version:\"0.1\",author:\"Ubytec\") {\n"+Body("libft-arena.ubc")+Body("libft-scalar.ubc")+Body("libft-memory.ubc")+Body("vector.ubc")+source+fixtures+"\n}");
    });
    private static ulong A(nint p)=>unchecked((ulong)p);
    private static ulong Run(string name,params ulong[] args)
    {
        var c=Compilation.Value;string body=string.Concat(args.Select(x=>$"mov rax, 0x{x:X16}\npush rax\n"));
        return unchecked((ulong)Assert.Single(NativeStack.Run(body+$"call {c.GetFunctionLabel(name)}\nadd rsp, {args.Length*8}\npush rax",1,c.Assembly)));
    }
    private sealed class Buffer : IDisposable
    {
        internal readonly nint Pointer;internal readonly int Length;
        internal Buffer(int size,byte fill=0){Length=size;Pointer=Marshal.AllocHGlobal(size);Marshal.Copy(Enumerable.Repeat(fill,size).ToArray(),0,Pointer,size);}
        internal ulong At(int offset)=>unchecked((ulong)Marshal.ReadInt64(Pointer,offset));
        internal byte[] Read(){var b=new byte[Length];Marshal.Copy(Pointer,b,0,Length);return b;}
        public void Dispose()=>Marshal.FreeHGlobal(Pointer);
    }
    private sealed class Fixture : IDisposable
    {
        internal readonly Buffer Arena,Words=new(40),Token=new(40),Scratch=new(24);
        internal ulong Owner=>A(Arena.Pointer);internal ulong W=>A(Words.Pointer);internal ulong T=>A(Token.Pointer);internal ulong S=>A(Scratch.Pointer);
        internal Fixture(int capacity=16384){Arena=new Buffer(16+capacity+16,0xA5);Assert.Equal(1UL,Run("ArenaInit",Owner,(ulong)capacity));Assert.Equal(1UL,Run("VectorInit",W,Owner,24));Assert.Equal(1UL,Run("VectorInit",T,Owner,1));}
        internal ulong Feed(byte[] data,int chunk){using var input=new Buffer(Math.Max(1,data.Length));Marshal.Copy(data,0,input.Pointer,data.Length);for(int i=0;i<data.Length;i+=chunk){ulong status=Run("TextFeed",W,T,A(input.Pointer+i),(ulong)Math.Min(chunk,data.Length-i),S);if(status==0)return 0;}return 1;}
        internal Dictionary<string,ulong> ReadWords(){var result=new Dictionary<string,ulong>();ulong data=Words.At(8),count=Words.At(16);for(ulong i=0;i<count;i++){nint record=(nint)(data+i*24);int size=(int)Marshal.ReadInt64(record,8);byte[] text=new byte[size];Marshal.Copy((nint)Marshal.ReadInt64(record),text,0,size);result.Add(System.Text.Encoding.ASCII.GetString(text),unchecked((ulong)Marshal.ReadInt64(record,16)));}return result;}
        public void Dispose(){Scratch.Dispose();Token.Dispose();Words.Dispose();Arena.Dispose();}
    }
    [Theory]
    [InlineData(1)] [InlineData(7)] [InlineData(64)]
    public void ChunkBoundariesBinaryDelimitersAndSortPreserveCounts(int chunk)
    {
        using var f=new Fixture();byte[] data=System.Text.Encoding.ASCII.GetBytes("Zoo APPLE apple zebra _42 123 zoo\0X").Concat(new byte[]{255,128}).Concat(System.Text.Encoding.ASCII.GetBytes("x alpha")).ToArray();
        Assert.Equal(1UL,f.Feed(data,chunk));Assert.Equal(1UL,Run("TextFlush",f.W,f.T,f.S));Assert.Equal(10UL,Run("TextTotal",f.W));
        var expected=new Dictionary<string,ulong>{{"zoo",2},{"apple",2},{"zebra",1},{"_42",1},{"123",1},{"x",2},{"alpha",1}};
        Assert.Equal(expected.OrderBy(k=>k.Key,StringComparer.Ordinal),f.ReadWords().OrderBy(k=>k.Key,StringComparer.Ordinal));Assert.Equal(1UL,Run("TextSortDefault",f.W,f.S));Assert.Equal(expected.Keys.OrderBy(k=>k,StringComparer.Ordinal),f.ReadWords().Keys);
        Assert.Equal(1UL,Run("TextCleanup",f.W,f.T,0));Assert.Equal(0UL,f.Arena.At(8));Assert.Equal(new byte[40],f.Words.Read());Assert.Equal(new byte[40],f.Token.Read());Assert.All(f.Arena.Read()[^16..],x=>Assert.Equal(0xA5,x));
    }
    [Fact]
    public void PinnedSortRejectsBeforeReordering()
    {
        using var f=new Fixture();Assert.Equal(1UL,f.Feed(System.Text.Encoding.ASCII.GetBytes("z a "),16));Assert.Equal(1UL,Run("VectorPin",f.W));byte[] before=f.Arena.Read();Assert.Equal(0UL,Run("TextSortDefault",f.W,f.S));Assert.Equal(before,f.Arena.Read());Assert.Equal(1UL,Run("VectorUnpin",f.W));Assert.Equal(1UL,Run("TextCleanup",f.W,f.T,0));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Fact]
    public void BoundedMemoryFailureCanReleaseAllIntermediateState()
    {
        using var f=new Fixture(256);Assert.Equal(0UL,f.Feed(System.Text.Encoding.ASCII.GetBytes("one two three four five six seven "),7));Assert.Equal(1UL,Run("TextCleanup",f.W,f.T,0));Assert.Equal(0UL,f.Arena.At(8));Assert.All(f.Arena.Read()[^16..],x=>Assert.Equal(0xA5,x));
    }
    [Theory]
    [InlineData(false)] [InlineData(true)]
    public void FlushRejectsPinnedInputsBeforeChangingCounts(bool pinToken)
    {
        using var f=new Fixture();Assert.Equal(1UL,f.Feed(System.Text.Encoding.ASCII.GetBytes("a a"),16));
        ulong vector=pinToken?f.T:f.W;Assert.Equal(1UL,Run("VectorPin",vector));byte[] before=f.Arena.Read();
        Assert.Equal(0UL,Run("TextFlush",f.W,f.T,f.S));Assert.Equal(before,f.Arena.Read());
        Assert.Equal(1UL,Run("VectorUnpin",vector));Assert.Equal(1UL,Run("TextFlush",f.W,f.T,f.S));Assert.Equal(2UL,f.ReadWords()["a"]);
        Assert.Equal(1UL,Run("TextCleanup",f.W,f.T,0));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Theory]
    [InlineData(false)] [InlineData(true)]
    public void FlushRejectsIncorrectRecordWidths(bool token)
    {
        using var f=new Fixture();Assert.Equal(1UL,f.Feed(System.Text.Encoding.ASCII.GetBytes("a a"),16));
        nint descriptor=token?f.Token.Pointer:f.Words.Pointer;long width=Marshal.ReadInt64(descriptor,32);Marshal.WriteInt64(descriptor,32,2);
        byte[] before=f.Arena.Read();Assert.Equal(0UL,Run("TextFlush",f.W,f.T,f.S));Assert.Equal(before,f.Arena.Read());
        Marshal.WriteInt64(descriptor,32,width);Assert.Equal(1UL,Run("TextCleanup",f.W,f.T,0));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Fact]
    public void FlushFindsLastRecordAfterRepeatedGrowthAndRejectsCountOverflow()
    {
        using var f=new Fixture();string input=string.Join(" ",Enumerable.Range(0,80).Select(i=>$"w{i}"))+" w79";
        Assert.Equal(1UL,f.Feed(System.Text.Encoding.ASCII.GetBytes(input),7));Assert.Equal(1UL,Run("TextFlush",f.W,f.T,f.S));Assert.Equal(2UL,f.ReadWords()["w79"]);
        nint record=(nint)(f.Words.At(8)+79*24);Marshal.WriteInt64(record,16,-1);
        Assert.Equal(1UL,f.Feed(System.Text.Encoding.ASCII.GetBytes("w79"),7));byte[] before=f.Arena.Read();
        Assert.Equal(0UL,Run("TextFlush",f.W,f.T,f.S));Assert.Equal(before,f.Arena.Read());
        Assert.Equal(1UL,Run("TextCleanup",f.W,f.T,0));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Fact]
    public void WordClassificationCoversEveryByte()
    {
        var c=Compilation.Value;var asm=new System.Text.StringBuilder();var expected=new List<long>();for(int i=0;i<256;i++){asm.AppendLine($"push {i}\ncall {c.GetFunctionLabel("TextIsWord")}\nadd rsp, 8\npush rax");expected.Add(i is >=48 and <=57 or >=65 and <=90 or >=97 and <=122 or 95?1:0);}Assert.Equal(expected,NativeStack.Run(asm.ToString(),256,c.Assembly));
    }
    [Theory]
    [InlineData(0UL,"0")] [InlineData(1UL,"1")] [InlineData(10UL,"10")] [InlineData(ulong.MaxValue,"18446744073709551615")]
    public void DecimalFormattingCoversFullWidthCounts(ulong value,string expected)
    {
        using var b=new Buffer(32,0xA5);ulong count=Run("TextDecimal",value,A(b.Pointer));Assert.Equal((ulong)expected.Length,count);Assert.Equal(expected,System.Text.Encoding.ASCII.GetString(b.Read(),0,(int)count));Assert.All(b.Read()[(int)count..],x=>Assert.Equal(0xA5,x));
    }
}
