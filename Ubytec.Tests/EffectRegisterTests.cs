using Ubytec.Language.AST;
using Xunit;
using System.Text.RegularExpressions;

namespace Ubytec.Tests;

public class EffectRegisterTests
{
    public static IEnumerable<object[]> Profiles() => Enumerable.Range(0,8).Select(n => new object[] { n });
    private static SourceCompilation Compile(string source, int profile, bool enabled) => SourceCompiler.Compile(source,
        emitProcessEntryPoint:false, optimizeStackTransfers:(profile&1)!=0, optimizeFrameValues:(profile&2)!=0,
        optimizeFrameRegisters:(profile&4)!=0, optimizeEffectRegisters:enabled);

    private static long[] Run(SourceCompilation c, long value=42, int skew=0, bool returnSite=false)
    {
        string seed=string.Join('\n',Enumerable.Range(5,30).Select(n=>$"mov qword [rsp - {n*8}], 12345"));
        string body=seed+$"\nmov rax, 0x{unchecked((ulong)value):X16}\npush rax\nlea rax, [rsp + {skew}]\npush rax\ncall {c.GetFunctionLabel("Observe")}\nadd rsp, 16\nmov rdx, rsp\npush rax\n";
        string assembly=c.Assembly;
        if (returnSite)
        {
            string target=assembly.Contains("call rax")?"rax":c.GetFunctionLabel("Touch");
            string pattern=@"(?m)^\s*call "+Regex.Escape(target)+@"\s*$";
            Assert.Single(Regex.Matches(assembly,pattern).Cast<Match>());
            assembly=Regex.Replace(assembly,pattern,m=>m.Value+"\neffect_return_site:");
        }
        foreach (int offset in new[]{40,48,56,64,72,80,88})
        {
            body+=$"mov rax, qword [rdx - {offset}]\n";
            if (returnSite && offset==88) body+="lea rcx, [rel effect_return_site]\nsub rax, rcx\n";
            body+="push rax\n";
        }
        return NativeStack.Run(body,8,assembly);
    }
    private static void Compare(string source,int profile,long expected,long initial=42,int skew=0,bool returnSite=false)
    {
        var old=Compile(source,profile,false);var next=Compile(source,profile,true);
        Assert.Contains("; effect-registers:",next.Assembly);
        var reference=Run(old,initial,skew,returnSite);var actual=Run(next,initial,skew,returnSite);
        Assert.Equal(expected,reference[0]);Assert.Equal(reference,actual);
        if (returnSite) Assert.Equal(0,actual[7]);
    }

    [Theory][MemberData(nameof(Profiles))]
    public void DirectCallsMutateCallerAndClobberVolatileCopies(int profile) => Calls(profile,false);
    [Theory][MemberData(nameof(Profiles))]
    public void IndirectCallsMutateCallerAndClobberVolatileCopies(int profile) => Calls(profile,true);
    private static void Calls(int profile,bool indirect)
    {
        string call=indirect?"fnaddr Touch\ncalli 2 t_uint64":"call Touch";
        string source="""
            module (name:"effect_calls",version:"0.1",author:"Ubytec") {
            func Touch(t_uint64 pointer,t_uint64 next) -> t_uint64 {
            load @pointer
            load @next
            store t_uint64
            push 1
            push 2
            push 3
            push 4
            push 5
            push 6
            tworot
            pop
            pop
            pop
            pop
            pop
            pop
            push 123
            return
            }
            func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
            local { t_uint64 i 0 t_uint64 sum 0 t_uint64 a 7 t_uint64 b 9 }
            while @i < 3
            load @pointer
            load @value
            inc
            """+"\n"+call+"\n"+"""
            load @sum
            add
            store @sum
            load @i
            inc
            store @i
            end
            load @value
            load @sum
            add
            return
            }
            }
            """;
        Compare(source,profile,414,returnSite:true);
    }

    [Theory][MemberData(nameof(Profiles))]
    public void PartialUnalignedByteWriteReloadsWholeCachedCell(int profile) => Partial(profile,"t_byte",0xAA,1);
    [Theory][MemberData(nameof(Profiles))]
    public void PartialUnalignedWordWriteReloadsWholeCachedCell(int profile) => Partial(profile,"t_uint16",0xAABB,2);
    [Theory][MemberData(nameof(Profiles))]
    public void PartialUnalignedDwordWriteReloadsWholeCachedCell(int profile) => Partial(profile,"t_uint32",0xAABBCCDD,4);
    private static void Partial(int profile,string type,ulong inserted,int width)
    {
        string source=$$"""
            module (name:"effect_partial",version:"0.1",author:"Ubytec") {
            func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
            local { t_uint64 i 0 t_uint64 sum 0 t_uint64 a 7 t_uint64 b 9 }
            while @i < 3
            load @value
            pop
            load @pointer
            push {{inserted}}
            store {{type}}
            load @i
            inc
            store @i
            end
            load @value
            return
            }
            }
            """;
        const ulong initial=0x1122334455667788;
        ulong mask=((1UL<<(width*8))-1)<<8;
        Compare(source,profile,unchecked((long)((initial&~mask)|(inserted<<8))),unchecked((long)initial),1);
    }

    [Theory][MemberData(nameof(Profiles))]
    public void RawWritesStayCoherentOnContinueBreakAndBranchJoin(int profile)
    {
        const string source="""
            module (name:"effect_flow",version:"0.1",author:"Ubytec") {
            func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
            local { t_uint64 i 0 t_uint64 sum 0 t_uint64 a 7 t_uint64 b 9 }
            loop
            load @pointer
            load @value
            inc
            store t_uint64
            load @i
            inc
            store @i
            if @i == 2
            continue
            end
            if @value == 45
            break
            end
            if @value == 43
            load @sum
            load @value
            add
            store @sum
            else
            push 99
            store @sum
            end
            end
            load @value
            load @sum
            add
            return
            }
            }
            """;
        Compare(source,profile,88);
    }

    [Fact]
    public void DefaultAndLegacyOptionsDoNotEnableEffectCopies()
    {
        const string source="""
            module (name:"effect_default",version:"0.1",author:"Ubytec") {
            func Observe(t_uint64 value,t_uint64 pointer) -> t_uint64 {
            local { t_uint64 i 0 }
            while @i < 1
            load @pointer
            load @value
            store t_uint64
            load @i
            inc
            store @i
            end
            load @value
            return
            }
            }
            """;
        Assert.DoesNotContain("; effect-registers:",Compile(source,7,false).Assembly);
        Assert.Contains("; effect-registers: reload after STORE",Compile(source,7,true).Assembly);
    }
}
