using System.Text.RegularExpressions;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>Local x64 transfers, preserving writes to consumed stack cells.</summary>
internal static class StackTransferOptimizer
{
    private static readonly Regex Transfer = new(
        @"^(push|pop) (rax|rbx|rcx|rdx|rsi|rdi|rbp|r(?:[89]|1[0-5]))$",
        RegexOptions.CultureInvariant);

    internal static string Optimize(string assembly)
    {
        var lines = assembly.Replace("\r\n", "\n").Split('\n');
        var output = new List<string>(lines.Length);
        for (int i = 0; i < lines.Length; i++)
        {
            var first = Transfer.Match(lines[i].Trim());
            var second = i + 1 < lines.Length ? Transfer.Match(lines[i + 1].Trim()) : Match.Empty;
            if (first.Success && second.Success && first.Groups[1].Value == "push" && second.Groups[1].Value == "pop")
            {
                string source = first.Groups[2].Value, target = second.Groups[2].Value;
                // PUSH writes below RSP even when POP consumes the value immediately.
                // Keep that write: unsafe code can subsequently read the stale cell.
                output.Add($"  mov qword [rsp - 8], {source}");
                if (source != target) output.Add($"  mov {target}, {source}");
                i++;
            }
            else output.Add(lines[i]);
        }
        return string.Join("\n", output);
    }
}
