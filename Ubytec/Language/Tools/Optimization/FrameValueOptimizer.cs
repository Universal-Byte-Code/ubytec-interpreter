using System.Globalization;
using System.Text.RegularExpressions;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>Forward ordinary frame-cell values inside a conservative straight-line span.</summary>
internal static class FrameValueOptimizer
{
    private const string Reg = @"(rax|rbx|rcx|rdx|rsi|rdi|r(?:[89]|1[0-5]))";
    private static readonly Regex Load = new(@"^mov " + Reg + @", qword \[rbp ([+-]) ([0-9]+)\]$");
    private static readonly Regex Store = new(@"^mov qword \[rbp ([+-]) ([0-9]+)\], " + Reg + @"$");
    private static readonly Regex Move = new(@"^mov " + Reg + @", " + Reg + @"$");
    private static readonly Regex Immediate = new(@"^mov " + Reg + @", (?:0x[0-9A-Fa-f]+|-?[0-9]+)$");
    private static readonly Regex Unary = new(@"^(?:inc|dec|neg|not) " + Reg + @"$");
    private static readonly Regex Binary = new(@"^(?:add|sub|and|or|xor|imul) " + Reg + @", (?:" + Reg + @"|0x[0-9A-Fa-f]+|-?[0-9]+)$");
    private static readonly Regex Compare = new(@"^(?:cmp|test) " + Reg + @", (?:" + Reg + @"|0x[0-9A-Fa-f]+|-?[0-9]+)$");

    internal static string Optimize(string assembly)
    {
        var known = new Dictionary<long, SortedSet<string>>();
        var output = new List<string>();
        void Forget(string register) { foreach (var registers in known.Values) registers.Remove(register); }
        void Remember(long offset, string register)
        {
            if (!known.TryGetValue(offset, out var registers)) known[offset] = registers = new(StringComparer.Ordinal);
            registers.Add(register);
        }
        foreach (string original in assembly.Replace("\r\n", "\n").Split('\n'))
        {
            string line = original.Trim();
            if (line.Length == 0 || line.StartsWith(';')) { output.Add(original); continue; }
            var load = Load.Match(line);
            if (load.Success && int.TryParse(load.Groups[3].Value, NumberStyles.None, CultureInfo.InvariantCulture, out int distance))
            {
                long offset = load.Groups[2].Value == "-" ? -(long)distance : distance;
                string target = load.Groups[1].Value;
                string? source = known.TryGetValue(offset, out var registers) ? registers.FirstOrDefault() : null;
                // Preserve register state while removing only a previously satisfied ordinary RAM read.
                if (registers?.Contains(target) == true) { continue; }
                Forget(target);
                Remember(offset, target);
                output.Add(source is null ? original : $"  mov {target}, {source}");
                continue;
            }
            var store = Store.Match(line);
            if (store.Success && int.TryParse(store.Groups[2].Value, NumberStyles.None, CultureInfo.InvariantCulture, out distance))
            {
                long offset = store.Groups[1].Value == "-" ? -(long)distance : distance;
                // Unaligned, overlapping qword slots must also lose their cached values.
                foreach (long key in known.Keys.Where(key => key < offset + 8 && offset < key + 8).ToArray()) known.Remove(key);
                Remember(offset, store.Groups[3].Value);
                output.Add(original);
                continue;
            }
            var move = Move.Match(line);
            if (move.Success)
            {
                string target = move.Groups[1].Value, source = move.Groups[2].Value;
                long[] values = known.Where(pair => pair.Value.Contains(source)).Select(pair => pair.Key).ToArray();
                Forget(target);
                foreach (long offset in values) Remember(offset, target);
            }
            else
            {
                var immediate = Immediate.Match(line);var unary = Unary.Match(line);var binary = Binary.Match(line);
                if (immediate.Success) Forget(immediate.Groups[1].Value);
                else if (unary.Success) Forget(unary.Groups[1].Value);
                else if (binary.Success) Forget(binary.Groups[1].Value);
                else if (!Compare.IsMatch(line)) known.Clear();
            }
            // Unknown instructions, subregister writes, all non-frame writes, stack operations,
            // calls, labels, jumps and frame-base changes are barriers.
            output.Add(original);
        }
        return string.Join("\n", output);
    }
}
