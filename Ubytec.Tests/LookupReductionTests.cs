using Ubytec.Language.AST;
using Xunit;

namespace Ubytec.Tests;

public class LookupReductionTests
{
    public static IEnumerable<object[]> Profiles() => Enumerable.Range(0,8).Select(n => new object[] { n });
    internal static string Source(string start = "0", int stride = 24, int lengthOffset = 8) => $$"""
        module (name:"lookup_contract",version:"0.1",author:"Ubytec") {
        func Find(t_uint64 records,t_uint64 count,t_uint64 key,t_uint64 length) -> t_uint64 {
        local { t_uint64 i {{start}} t_uint64 j 7 t_uint64 entryptr 11 t_uint64 name 13 }
        while @i < @count
        load @records
        load @i
        push {{stride}}
        mul
        add
        store @entryptr
        load @entryptr
        push {{lengthOffset}}
        add
        load t_uint64
        load @length
        eq
        if
        load @entryptr
        load t_uint64
        store @name
        push 0
        store @j
        while @j < @length
        load @name
        load @j
        add
        load t_byte
        load @key
        load @j
        add
        load t_byte
        neq
        if
        break
        end
        load @j
        inc
        store @j
        end
        if @j == @length
        load @i
        inc
        return
        end
        end
        load @i
        inc
        store @i
        end
        push 0
        return
        }
        }
        """;
    internal static SourceCompilation Compile(string source,int profile,bool optimize = true) => SourceCompiler.Compile(source,
        emitProcessEntryPoint:false,optimizeStackTransfers:(profile&1)!=0,optimizeFrameValues:(profile&2)!=0,
        optimizeFrameRegisters:(profile&4)!=0,optimizeLookupReductions:optimize);

    [Theory,MemberData(nameof(Profiles))]
    public void BranchesReturnsAndAllWrittenFrameResidualCellsMatchReference(int profile)
    {
        string fixtures = "\nfirst: db 'aBCDEFGH'\nsecond: db 'ABCDEXGH'\nthird: db 'ABCDEFGH'\nkey: db 'ABCDEFGH'\n";
        foreach(var (count,length,start,expected) in new[] { (0,8,"0",0L),(3,7,"0",0L),(1,8,"0",0L),
            (2,8,"0",0L),(3,8,"0",3L),(3,8,"2",3L),(3,0,"0",0L),(1,8,"3",0L) })
        {
            var reference = Compile(ReferenceSource(Source(start)),profile,false);var optimized = Compile(Source(start),profile);
            Assert.Contains("; lookup-reductions:",optimized.Assembly);
            string Invoke(SourceCompilation c) => Seed()+Table()+$"\nlea rax, [rsp-512]\npush rax\npush {count}\nlea rax, [rel key]\npush rax\npush {length}\ncall {c.GetFunctionLabel("Find")}\nadd rsp, 32\n";
            string body = "sub rsp, 64\n"+Invoke(reference)+"mov [rsp], rax\n"+Snapshot()+Invoke(optimized)+"xor rax, [rsp]\nmov rcx, rax\n"+Difference()+"mov [rsp], rcx\n";
            Assert.Equal(0,NativeStack.Run(body,8,reference.Assembly+optimized.Assembly+fixtures)[^1]);
            string single=Table()+$"lea rax, [rsp-512]\npush rax\npush {count}\nlea rax, [rel key]\npush rax\npush {length}\ncall {optimized.GetFunctionLabel("Find")}\nadd rsp, 32\npush rax";
            Assert.Equal(new[] { expected },NativeStack.Run(single,1,optimized.Assembly+fixtures));
        }
    }
    [Theory,MemberData(nameof(Profiles))]
    public void EmptyInputsAndEmptyNamesDoNotReadFabricatedPointers(int profile)
    {
        var compiled=Compile(Source(),profile);
        string empty=$"push -1\npush 0\npush -1\npush -1\ncall {compiled.GetFunctionLabel("Find")}\nadd rsp, 32\npush rax";
        Assert.Equal(new long[] { 0 },NativeStack.Run(empty,1,compiled.Assembly));
        string zero=$"lea rax, [rel records]\npush rax\npush 1\npush -1\npush 0\ncall {compiled.GetFunctionLabel("Find")}\nadd rsp, 32\npush rax";
        Assert.Equal(new long[] { 1 },NativeStack.Run(zero,1,compiled.Assembly+"\nrecords: dq -1,0,0\n"));
    }
    [Theory,MemberData(nameof(Profiles))]
    public void RawRecordAndKeyPointersMayReadTheEvaluationLedgerAndFrame(int profile)
    {
        foreach(var (recordOffset,keyOffset,keyLength,aliasRecord) in new[] { (-112,0,7,true),(-96,0,7,true),
            (-72,0,7,true),(-64,0,7,true),(-88,0,7,true),(0,-112,8,false),(0,-96,8,false),
            (0,-88,8,false),(0,-72,8,false),(0,-64,8,false),(0,-71,8,false) })
        {
            var reference=Compile(ReferenceSource(Source()),profile,false);var optimized=Compile(Source(),profile);
            string Invoke(SourceCompilation c) => Seed()+Table()+
                (aliasRecord?$"\nlea rax, [rsp{recordOffset}]\n":"\nlea rax, [rsp-512]\n")+
                "push rax\npush 1\n"+(aliasRecord?"lea rax, [rel key]\n":$"lea rax, [rsp{keyOffset+16}]\n")+
                $"push rax\npush {keyLength}\ncall {c.GetFunctionLabel("Find")}\nadd rsp, 32\n";
            string body="sub rsp, 64\n"+Invoke(reference)+"mov [rsp], rax\n"+Snapshot()+Invoke(optimized)+"xor rax, [rsp]\nmov rcx, rax\n"+Difference()+"mov [rsp], rcx\n";
            Assert.Equal(0,NativeStack.Run(body,8,reference.Assembly+optimized.Assembly+"\nfirst: db 'aBCDEFGH'\nsecond: db 'ABCDEXGH'\nthird: db 'ABCDEFGH'\nkey: db 'ABCDEFGH'\n")[^1]);
        }
    }
    [Theory,MemberData(nameof(Profiles))]
    public void OtherLayoutsAndBindingOrdersKeepOrdinalResults(int profile)
    {
        string source=Source("1",32,16).Replace("Find","LookupOther")
            .Replace("t_uint64 records,t_uint64 count,t_uint64 key,t_uint64 length","t_uint64 length,t_uint64 key,t_uint64 count,t_uint64 records")
            .Replace("t_uint64 i 1 t_uint64 j 7 t_uint64 entryptr 11 t_uint64 name 13","t_uint64 name 13 t_uint64 entryptr 11 t_uint64 j 7 t_uint64 i 1");
        var compiled=Compile(source,profile);
        string body=Table(32,16,3,"key","key")+$"push 3\nlea rax, [rel key]\npush rax\npush 2\nlea rax, [rsp-488]\npush rax\ncall {compiled.GetFunctionLabel("LookupOther")}\nadd rsp, 32\npush rax";
        Assert.Equal(new long[] { 2 },NativeStack.Run(body,1,compiled.Assembly+"\nkey: db 'abc'\n"));
    }
    [Fact]
    public void UnsignedOrdinalAndWrappingAddressKeepOneRecord()
    {
        var compiled=Compile(Source("18446744073709551614"),7);
        string body=$"lea rax, [rel records+48]\npush rax\npush -1\npush -1\npush 0\ncall {compiled.GetFunctionLabel("Find")}\nadd rsp, 32\npush rax";
        Assert.Equal(new long[] { -1 },NativeStack.Run(body,1,compiled.Assembly+"\nrecords: dq -1,0,0\n"));
    }
    [Theory]
    [InlineData("load t_byte","load t_sbyte")]
    [InlineData("while @i < @count","while @i <= @count")]
    [InlineData("push 24\nmul","push 0\nmul")]
    [InlineData("push 0\nstore @j","push 1\nstore @j")]
    [InlineData("load @i\ninc\nreturn","load @i\nreturn")]
    [InlineData("if @j == @length","if @j != @length")]
    public void DifferentConditionsWidthsAndEffectsRemainOnReference(string before,string after)
    {
        Assert.DoesNotContain("; lookup-reductions:",Compile(Source().Replace(before,after),7).Assembly);
    }
    [Fact]
    public void DefaultValidationAndOtherOptimizationsRemainIndependent()
    {
        Assert.DoesNotContain("; lookup-reductions:",Compile(Source(),7,false).Assembly);
        string invalid=Source().Replace("return","return t_int32");
        Assert.ThrowsAny<Exception>(()=>Compile(invalid,7,false));Assert.ThrowsAny<Exception>(()=>Compile(invalid,7));
        Assert.Contains("; lookup-reductions:",SourceCompiler.Compile(Source(),emitProcessEntryPoint:false,
            optimizeLookupReductions:true,optimizeRecordReductions:true,optimizeNativeBlockReductions:true).Assembly);
    }
    // Reference and optimized variants must share one native address space because the
    // observable contract includes pointer-valued residual cells. A test-only module
    // version gives the reference variant its own deterministic label namespace.
    private static string ReferenceSource(string source) =>
        source.Replace("version:\"0.1\"", "version:\"0.1.1\"", StringComparison.Ordinal);
    // With four arguments and a 32-byte frame: B-56..B-80 are locals,
    // B-88..B-104 are the three residual evaluation cells.
    private static string Table(int stride=24,int offset=8,int length=8,params string[] labels)
    {
        if(labels.Length==0) labels=["first","second","third"];
        return "\n"+string.Join('\n',labels.Select((n,i)=>$"lea rax, [rel {n}]\nmov [rsp-{512-i*stride}], rax\nmov qword [rsp-{512-i*stride-offset}], {length}"))+"\n";
    }
    private static readonly int[] Cells=[56,64,72,80,88,96,104];
    private static string Seed()=>string.Join('\n',Enumerable.Range(7,24).Select(i=>$"mov qword [rsp-{i*8}], 12345"));
    private static string Snapshot()=>string.Join('\n',Cells.Select((n,i)=>$"mov rax, [rsp-{n}]\nmov [rsp+{8*(i+1)}], rax"))+"\n";
    private static string Difference()=>string.Join('\n',Cells.Select((n,i)=>$"mov rax, [rsp-{n}]\nxor rax, [rsp+{8*(i+1)}]\nor rcx, rax"))+"\n";
}
