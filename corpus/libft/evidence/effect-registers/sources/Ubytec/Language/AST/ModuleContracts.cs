using System.Text;
using System.Text.RegularExpressions;
using Ubytec.Language.HighLevel;
namespace Ubytec.Language.AST;
internal sealed class ModuleContracts
{
    internal sealed record Import(string Alias,string Module,string Export,string Signature,int Handle) {
        internal string[] Arguments => Signature.Split(':')[0].Length==0 ? [] : Signature.Split(':')[0].Split(',');
        internal int CallArguments => Signature==BufferSignature?5:Arguments.Sum(a=>a.StartsWith("Loan")?2:1)+2;
    }
    internal List<Import> Imports { get; } = [];
    internal List<(string Function,string Name,string? Signature)> Exports { get; } = [];
    internal const string BufferSignature="UInt64,UInt64,UInt64,UInt64:Int64";
    internal string Read(string source)
    {
        var output=new StringBuilder(); bool body=false;
        var names=new HashSet<string>(StringComparer.Ordinal);
        foreach(var line in source.Split('\n'))
        {
            if(Regex.IsMatch(line,@"^\s*module\b")) body=true;
            if(!Regex.IsMatch(line,@"^\s*(import|export)\b")) { output.AppendLine(line); continue; }
            if(body) throw new ArgumentException("Contract declarations precede the module declaration.");
            var match=Regex.Match(line,@"^\s*import\s+(\w+)\s+from\s+(\w+)\.(\w+)\s*\(([^)]*)\)\s*->\s*(\w+)\s*$");
            if(match.Success)
            {
                string alias=Identifier(match.Groups[1].Value);
                if(!names.Add(alias) || alias=="ModuleInvoke" || Imports.Count>=16) throw new ArgumentException("Duplicate or invalid import.");
                var args=match.Groups[4].Value.Split(',',StringSplitOptions.TrimEntries|StringSplitOptions.RemoveEmptyEntries);
                string signature=string.Join(",",args.Select(Type))+":"+Type(match.Groups[5].Value);
                if(signature!=BufferSignature) ValidateTyped(signature);
                Imports.Add(new(alias,Identifier(match.Groups[2].Value),Identifier(match.Groups[3].Value),signature,Imports.Count+1));
            }
            else
            {
                match=Regex.Match(line,@"^\s*export\s+(\w+)\s+as\s+(\w+)(?:\s*\(([^)]*)\)\s*->\s*(\w+))?\s*$");
                if(!match.Success || Exports.Count>=16) throw new ArgumentException("Invalid export declaration.");
                string name=Identifier(match.Groups[2].Value);
                if(Exports.Any(e=>e.Name==name)) throw new ArgumentException("Duplicate public export.");
                string? signature=null;
                if(match.Groups[4].Success) {
                    var arguments=match.Groups[3].Value.Length==0?[]:match.Groups[3].Value.Split(',',StringSplitOptions.TrimEntries);
                    signature=string.Join(",",arguments.Select(Type))+":"+Type(match.Groups[4].Value);
                    ValidateTyped(signature);
                }
                Exports.Add((Identifier(match.Groups[1].Value),name,signature));
            }
            output.AppendLine();
        }
        return output.ToString();
    }
    private static string Identifier(string s) => Regex.IsMatch(s,@"\A[A-Za-z_][A-Za-z0-9_]{0,62}\z") ? s :
        throw new ArgumentException("Invalid contract identifier.");
    private static string Type(string s) => s switch {
        "t_uint64"=>"UInt64", "t_int64"=>"Int64", "t_uint32"=>"UInt32", "t_int32"=>"Int32",
        "t_loan_ro"=>"LoanRead", "t_loan_rw"=>"LoanWrite", "t_byte"=>"Byte", "t_void"=>"Void", _=>throw new ArgumentException("Unsupported contract type.") };
    private static void ValidateTyped(string signature) {
        var halves=signature.Split(':'); var args=halves[0].Length==0?[]:halves[0].Split(',');
        if(args.Length>6 || args.Count(a=>a.StartsWith("Loan"))>2 ||
           args.Any(a=>a is not ("LoanRead" or "LoanWrite" or "UInt64" or "Int64")) ||
           halves[1] is not ("Int64" or "UInt64"))
            throw new ArgumentException("Typed calls support up to six 64-bit arguments and two loans.");
    }
    internal string Emit(SourceCompilation compilation)
    {
        var manifest=new StringBuilder("UBC1\n");
        var assembly=new StringBuilder();
        foreach(var import in Imports)
        {
            manifest.AppendLine($"I|{import.Handle}|{import.Alias}|{import.Module}|{import.Export}|{import.Signature}");
            assembly.AppendLine($"section .text\nubytec_import_{import.Alias}:\n push rbp\n mov rbp,rsp\n push {import.Handle}");
            if(import.Signature==BufferSignature) {
                foreach(int offset in new[]{48,40,32,24,16}) assembly.AppendLine($" push qword [rbp+{offset}]");
                assembly.AppendLine(" call ubytec_module_invoke\n mov rsp,rbp\n pop rbp\n ret");
            } else {
                // Discard the legacy handle push, then build private argument records.
                assembly.AppendLine(" add rsp,8");
                var args=import.Arguments; int cells=import.CallArguments, cell=0;
                assembly.AppendLine($" sub rsp,{Math.Max(24,args.Length*24)}");
                int Offset(int index)=>16+(cells-1-index)*8;
                for(int i=0;i<args.Length;i++) {
                    int record=-Math.Max(24,args.Length*24)+i*24;
                    int kind=args[i] switch {"LoanWrite"=>1,"LoanRead"=>2,"UInt64"=>3,_=>4};
                    assembly.AppendLine($" mov qword [rbp{record}],{kind}\n mov rax,[rbp+{Offset(cell++)}]\n mov [rbp{record+8}],rax");
                    if(kind<=2) assembly.AppendLine($" mov rax,[rbp+{Offset(cell++)}]\n mov [rbp{record+16}],rax");
                    else assembly.AppendLine($" mov qword [rbp{record+16}],0");
                }
                assembly.AppendLine($" extern ubytec_bridge_many\n mov rdi,{import.Handle}\n lea rsi,[rbp-{Math.Max(24,args.Length*24)}]\n mov rdx,{args.Length}\n mov rcx,[rbp+{Offset(cell++)}]\n mov r8,[rbp+{Offset(cell)}]\n and rsp,-16\n call ubytec_bridge_many\n mov rsp,rbp\n pop rbp\n ret");
            }
        }
        foreach(var export in Exports)
        {
            var fn=compilation.Module.Functions.FirstOrDefault(f=>f.Name==export.Function);
            if(string.IsNullOrEmpty(fn.Name)) throw new ArgumentException("Unknown exported function.");
            string signature=string.Join(",",fn.Arguments.Select(a=>a.Type.Type.ToString()))+":"+fn.ReturnType.Type;
            if(export.Signature is { } declared) {
                string actual=declared.Replace("LoanRead","UInt64").Replace("LoanWrite","UInt64");
                if(actual!=signature) throw new ArgumentException("Export loan annotations must match its scalar ABI.");
                signature=declared;
            }
            string symbol="ubytec_host_contract_"+export.Name;
            if(symbol.Length>=64) throw new ArgumentException("Public export name exceeds the adapter symbol limit.");
            manifest.AppendLine($"E|{export.Name}|{symbol}|{signature}");
            assembly.Append(compilation.GetLinuxSystemVAdapter(export.Function,symbol));
        }
        manifest.AppendLine("END");
        compilation.ContractManifest=manifest.ToString().Replace("\r\n","\n");
        var bytes=Encoding.ASCII.GetBytes(compilation.ContractManifest);
        if(bytes.Length>4096) throw new ArgumentException("Contract too large.");
        assembly.AppendLine("section .ubytec_contract alloc noexec nowrite progbits");
        assembly.AppendLine("db "+string.Join(",",bytes));
        return assembly.ToString();
    }
}
