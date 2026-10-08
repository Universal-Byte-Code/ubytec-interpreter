using System.Runtime.InteropServices;
using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class ListTests
{
    private static readonly Lazy<SourceCompilation> Compilation = new(() =>
    {
        string Body(string n) { string s=File.ReadAllText(Path.Combine(AppContext.BaseDirectory,n));return s[(s.IndexOf('{')+1)..s.LastIndexOf('}')]; }
        return SourceCompiler.Compile("module (name:\"lists_tests\",version:\"0.1\",author:\"Ubytec\") {\n"+Body("libft-arena.ubc")+Body("lists.ubc")+Body("lists-fixtures.ubc")+"\n}");
    });
    private static ulong A(nint p)=>unchecked((ulong)p);
    private static ulong Run(string name,params ulong[] args)
    {
        var c=Compilation.Value;
        string body=string.Concat(args.Select(x=>$"mov rax, 0x{x:X16}\npush rax\n"));
        body+=$"call {c.GetFunctionLabel(name)}\nadd rsp, {args.Length*8}\npush rax";
        return unchecked((ulong)Assert.Single(NativeStack.Run(body,1,c.Assembly)));
    }
    private sealed class Buffer : IDisposable
    {
        internal nint Pointer {get;}
        private readonly int size;
        internal Buffer(int length,byte fill=0){size=length;Pointer=Marshal.AllocHGlobal(size);Marshal.Copy(Enumerable.Repeat(fill,size).ToArray(),0,Pointer,size);}
        internal ulong At(int offset)=>unchecked((ulong)Marshal.ReadInt64(Pointer,offset));
        internal void Set(int offset,ulong value)=>Marshal.WriteInt64(Pointer,offset,unchecked((long)value));
        internal byte[] Read(){var b=new byte[size];Marshal.Copy(Pointer,b,0,size);return b;}
        public void Dispose()=>Marshal.FreeHGlobal(Pointer);
    }
    private sealed class Fixture : IDisposable
    {
        internal readonly Buffer Arena;
        internal readonly Buffer Head=new(8),Stats=new(48);
        internal ulong Owner=>A(Arena.Pointer);
        internal ulong Root=>Head.At(0);
        internal Fixture(int capacity=8192){Arena=new Buffer(16+capacity+16,0xA5);Assert.Equal(1UL,Run("ArenaInit",Owner,(ulong)capacity));}
        internal ulong Add(ulong value,bool front=false)
        {
            ulong content=Run("ArenaAlloc",Owner,24);Assert.NotEqual(0UL,content);
            Marshal.WriteInt64((nint)content,0,unchecked((long)Owner));
            Marshal.WriteInt64((nint)content,8,unchecked((long)value));
            Marshal.WriteInt64((nint)content,16,unchecked((long)A(Stats.Pointer)));
            ulong node=Run("ft_lstnew_arena",Owner,content);Assert.NotEqual(0UL,node);
            Assert.Equal(1UL,Run(front?"ft_lstadd_front_arena":"ft_lstadd_back_arena",Owner,A(Head.Pointer),node));return node;
        }
        internal List<ulong> Values(ulong root)
        {
            var values=new List<ulong>();
            for(ulong n=root;n!=0;n=unchecked((ulong)Marshal.ReadInt64((nint)n,8)))values.Add(unchecked((ulong)Marshal.ReadInt64((nint)Marshal.ReadInt64((nint)n),8)));
            return values;
        }
        public void Dispose(){Stats.Dispose();Head.Dispose();Arena.Dispose();}
    }
    [Fact]
    public void EmptyAndNullContentHaveDefinedBehavior()
    {
        using var f=new Fixture();Assert.Equal(0UL,Run("ft_lstsize",0));Assert.Equal(0UL,Run("ft_lstlast",0));Assert.Equal(1UL,Run("ft_lstiter",0,0));Assert.Equal(1UL,Run("ft_lstclear_arena",f.Owner,A(f.Head.Pointer),0));
        ulong node=Run("ft_lstnew_arena",f.Owner,0);Assert.NotEqual(0UL,node);Assert.Equal(1UL,Run("ListDelete",f.Owner,node));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Fact]
    public void FrontBackIterationAndMappingAgreeWithSequenceModel()
    {
        using var f=new Fixture();var values=new List<ulong>();
        for(ulong i=0;i<12;i++){bool front=i%3==0;f.Add(i,front);if(front)values.Insert(0,i);else values.Add(i);}
        Assert.Equal(values,f.Values(f.Root));Assert.Equal(12UL,Run("ft_lstsize",f.Root));
        Assert.Equal(1UL,Run("ListIter",f.Root));values=values.Select(v=>v+3).ToList();Assert.Equal(values,f.Values(f.Root));Assert.Equal(12UL,f.Stats.At(16));
        ulong mapped=Run("ListMap",f.Owner,f.Root);Assert.NotEqual(0UL,mapped);Assert.Equal(values.Select(v=>v*2+7),f.Values(mapped));Assert.Equal(values,f.Values(f.Root));
        using var result=new Buffer(8);result.Set(0,mapped);Assert.Equal(1UL,Run("ListClear",f.Owner,A(result.Pointer)));Assert.Equal(0UL,result.At(0));Assert.Equal(1UL,Run("ListClear",f.Owner,A(f.Head.Pointer)));Assert.Equal(0UL,f.Root);Assert.Equal(0UL,f.Arena.At(8));Assert.Equal(24UL,f.Stats.At(8));Assert.All(f.Arena.Read()[^16..],x=>Assert.Equal(0xA5,x));
    }
    [Theory]
    [InlineData(1)] [InlineData(2)] [InlineData(4)]
    public void FailedTransformReleasesPartialMapWithoutChangingSource(int failAt)
    {
        using var f=new Fixture();for(ulong i=0;i<4;i++)f.Add(i);var before=f.Values(f.Root);ulong used=f.Arena.At(8),head=f.Root;f.Stats.Set(24,(ulong)failAt);
        Assert.Equal(0UL,Run("ListMap",f.Owner,f.Root));Assert.Equal(before,f.Values(f.Root));Assert.Equal(head,f.Root);Assert.Equal(used,f.Arena.At(8));Assert.Equal((ulong)failAt,f.Stats.At(0));Assert.Equal((ulong)failAt-1,f.Stats.At(8));
        Assert.Equal(1UL,Run("ListClear",f.Owner,A(f.Head.Pointer)));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Theory]
    [InlineData(288,1)] [InlineData(368,2)]
    public void NodeAllocationFailureDestroysFreshContentAndPartialMap(int capacity,int deleted)
    {
        using var f=new Fixture(capacity);f.Add(10);f.Add(20);Assert.Equal(208UL,f.Arena.At(8));
        Assert.Equal(0UL,Run("ListMap",f.Owner,f.Root));Assert.Equal(new ulong[]{10,20},f.Values(f.Root));Assert.Equal((ulong)deleted,f.Stats.At(8));Assert.Equal(208UL,f.Arena.At(8));
        Assert.Equal(1UL,Run("ListClear",f.Owner,A(f.Head.Pointer)));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Fact]
    public void PinPreflightRejectsClearBeforeAnyCallbackAndAllowsReadingMap()
    {
        using var f=new Fixture();f.Add(1);ulong last=f.Add(2);Assert.Equal(1UL,Run("ArenaPin",f.Owner,last));byte[] before=f.Arena.Read();
        Assert.Equal(0UL,Run("ListClear",f.Owner,A(f.Head.Pointer)));Assert.Equal(before,f.Arena.Read());Assert.Equal(0UL,f.Stats.At(8));Assert.Equal(0UL,Run("ListDelete",f.Owner,last));
        ulong result=Run("ListMap",f.Owner,f.Root);Assert.NotEqual(0UL,result);using var mapped=new Buffer(8);mapped.Set(0,result);Assert.Equal(1UL,Run("ListClear",f.Owner,A(mapped.Pointer)));
        Assert.Equal(1UL,Run("ArenaUnpin",f.Owner,last));Assert.Equal(1UL,Run("ListClear",f.Owner,A(f.Head.Pointer)));Assert.Equal(0UL,f.Arena.At(8));
    }
    [Fact]
    public void DuplicateNodesCyclesAndMissingCallbacksAreRejected()
    {
        using var f=new Fixture();ulong first=f.Add(1),last=f.Add(2);Assert.Equal(0UL,Run("ft_lstadd_back_arena",f.Owner,A(f.Head.Pointer),last));Assert.Equal(0UL,Run("ft_lstiter",f.Root,0));Assert.Equal(0UL,Run("ft_lstmap_arena",f.Owner,f.Root,0,0));
        Marshal.WriteInt64((nint)last,8,unchecked((long)first));Assert.Equal(0UL,Run("ListCheck",f.Owner,f.Root,0));Assert.Equal(0UL,Run("ListClear",f.Owner,A(f.Head.Pointer)));Assert.Equal(0UL,f.Stats.At(8));Marshal.WriteInt64((nint)last,8,0);Assert.Equal(1UL,Run("ListClear",f.Owner,A(f.Head.Pointer)));
    }
}
