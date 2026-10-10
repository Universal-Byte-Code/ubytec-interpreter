using System.Text.RegularExpressions;

namespace Ubytec.Language.AST;

/// <summary>Opt-in source generation for scoped arena calls to typed imports.</summary>
public static class ArenaImportGenerator
{
    /// <summary>Generates ordinary source wrappers and optionally the bundled arena library.</summary>
    public static string Generate(string source, bool includeArenaLibrary = true)
    {
        source = source.Replace("\r\n", "\n");
        const string marker = "// BEGIN GENERATED ARENA IMPORTS";
        if (source.Contains(marker, StringComparison.Ordinal))
            throw new ArgumentException("Source already contains generated arena wrappers.");
        var contracts = new ModuleContracts();
        contracts.Read(source);
        if (contracts.Imports.Count == 0) throw new ArgumentException("Arena generation requires typed imports.");
        if (!source.TrimEnd().EndsWith('}')) throw new ArgumentException("Expected a module ending with }.");
        var names = Regex.Matches(source, @"\b(?:func|action)\s+(\w+)").Select(m => m.Groups[1].Value)
            .Concat(contracts.Imports.Select(i => i.Alias)).ToHashSet(StringComparer.Ordinal);
        string arena = "";
        if (includeArenaLibrary)
        {
            using var stream = typeof(ArenaImportGenerator).Assembly.GetManifestResourceStream("Ubytec.Runtime.arena.ubc")
                ?? throw new InvalidOperationException("Bundled arena library is unavailable.");
            using var reader = new StreamReader(stream);
            string library = reader.ReadToEnd().Replace("\r\n", "\n");
            arena = library[(library.IndexOf('{') + 1)..library.LastIndexOf('}')];
            foreach (Match match in Regex.Matches(arena, @"\bfunc\s+(\w+)"))
                if (!names.Add(match.Groups[1].Value))
                    throw new ArgumentException($"Arena library name collision: {match.Groups[1].Value}.");
        }
        var wrappers = new List<string>();
        foreach (var import in contracts.Imports)
        {
            if (import.Signature == ModuleContracts.BufferSignature)
                throw new ArgumentException($"Reserved legacy buffer ABI: {import.Alias}. Use typed loans for arena calls.");
            string name = "Arena_" + import.Alias;
            if (!names.Add(name)) throw new ArgumentException($"Wrapper name collision: {name}.");
            var args = import.Arguments;
            int[] loans = Enumerable.Range(0, args.Length).Where(i => args[i].StartsWith("Loan", StringComparison.Ordinal)).ToArray();
            var parameters = new List<string>();
            var locals = new List<string>();
            var body = new List<string>();
            void Load(string value) => body.Add("load @" + value);
            void Reject(IEnumerable<int>? acquired = null)
            {
                foreach (int i in (acquired ?? []).Reverse())
                {
                    Load($"a{i}_arena"); Load($"a{i}_pointer");
                    body.AddRange(["call ArenaUnpin", "store @ignored"]);
                }
                body.AddRange(["push 1", "return"]);
            }
            for (int i = 0; i < args.Length; i++)
            {
                if (loans.Contains(i))
                {
                    parameters.AddRange(new[] { "arena", "pointer", "offset", "length" }.Select(s => $"t_uint64 a{i}_{s}"));
                    locals.AddRange([$"t_uint64 node{i} 0", $"t_uint64 size{i} 0"]);
                }
                else parameters.Add($"{(args[i] == "Int64" ? "t_int64" : "t_uint64")} a{i}");
            }
            parameters.AddRange(["t_uint64 budget", "t_uint64 resultcell"]);
            locals.AddRange(["t_uint64 ignored 0", "t_int64 status 1"]);
            Load("resultcell"); body.AddRange(["push 0", "store t_int64"]);
            // Validate every span before pinning; subtraction avoids range overflow.
            foreach (int i in loans)
            {
                Load($"a{i}_arena"); Load($"a{i}_pointer");
                body.AddRange(["call ArenaFind", $"store @node{i}", $"if @node{i} == 0"]); Reject(); body.Add("end");
                Load($"node{i}"); body.AddRange(["push 8", "add", "load t_uint64", $"store @size{i}", $"if @a{i}_offset > @size{i}"]);
                Reject(); body.Add("end");
                Load($"size{i}"); Load($"a{i}_offset");
                body.AddRange(["sub", $"store @size{i}", $"if @a{i}_length > @size{i}"]); Reject(); body.Add("end");
            }
            var pinned = new List<int>();
            foreach (int i in loans)
            {
                Load($"a{i}_arena"); Load($"a{i}_pointer");
                body.AddRange(["call ArenaPin", "store @ignored", "if @ignored == 0"]);
                Reject(pinned); body.Add("end"); pinned.Add(i);
            }
            for (int i = 0; i < args.Length; i++)
            {
                if (loans.Contains(i))
                {
                    Load($"a{i}_pointer"); Load($"a{i}_offset"); body.Add("add"); Load($"a{i}_length");
                }
                else Load($"a{i}");
            }
            Load("budget"); Load("resultcell"); body.AddRange(["call " + import.Alias, "store @status"]);
            foreach (int i in loans.Reverse())
            {
                Load($"a{i}_arena"); Load($"a{i}_pointer"); body.AddRange(["call ArenaUnpin", "store @ignored"]);
            }
            Load("status"); body.Add("return");
            wrappers.Add($"func {name}({string.Join(',', parameters)}) -> t_int64 {{\nlocal {{ {string.Join(' ', locals)} }}\n{string.Join('\n', body)}\n}}\n");
        }
        string generated = marker + "\n" + string.Concat(wrappers) + "// END GENERATED ARENA IMPORTS\n";
        return source.TrimEnd()[..^1] + (includeArenaLibrary ? arena + "\n" : "") + generated + "}\n";
    }
}
