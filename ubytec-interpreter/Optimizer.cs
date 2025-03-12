using System.Text.RegularExpressions;

namespace ubytec_interpreter
{
    internal static class Optimizer
    {
        private static readonly Dictionary<string, string[]> SubregisterSynonyms = new()
        {
            // 64-bit “legacy” registers
            { "rax", new[] { "rax", "eax", "ax", "ah", "al" } },
            { "rbx", new[] { "rbx", "ebx", "bx", "bh", "bl" } },
            { "rcx", new[] { "rcx", "ecx", "cx", "ch", "cl" } },
            { "rdx", new[] { "rdx", "edx", "dx", "dh", "dl" } },
            { "rsi", new[] { "rsi", "esi", "si", "sil" } },
            { "rdi", new[] { "rdi", "edi", "di", "dil" } },
            { "rbp", new[] { "rbp", "ebp", "bp", "bpl" } },
            { "rsp", new[] { "rsp", "esp", "sp", "spl" } },
        
            // r8–r15 synonyms
            { "r8",  new[] { "r8",  "r8d",  "r8w",  "r8b"  } },
            { "r9",  new[] { "r9",  "r9d",  "r9w",  "r9b"  } },
            { "r10", new[] { "r10", "r10d", "r10w", "r10b" } },
            { "r11", new[] { "r11", "r11d", "r11w", "r11b" } },
            { "r12", new[] { "r12", "r12d", "r12w", "r12b" } },
            { "r13", new[] { "r13", "r13d", "r13w", "r13b" } },
            { "r14", new[] { "r14", "r14d", "r14w", "r14b" } },
            { "r15", new[] { "r15", "r15d", "r15w", "r15b" } },
        };
        // NEW: A separate method focusing on "mov reg, reg", "jmp next line", "unused labels" etc.
        public static string OptimizePushPop(string assemblyCode)
        {
            // 1) Split code into lines.
            var lines = assemblyCode.Split(new[] { "\r\n", "\n" }, StringSplitOptions.None).ToList();

            bool changed;
            do
            {
                changed = false;
                var newLines = new List<string>();
                int i = 0;

                while (i < lines.Count)
                {
                    string originalLine = lines[i];
                    string line = originalLine.Trim();
                    string indent = Regex.Match(originalLine, @"^\s*").Value;

                    // If this isn't an actual code line, just keep it
                    if (IsNonCodeLine(line))
                    {
                        newLines.Add(originalLine);
                        i++;
                        continue;
                    }

                    // Try to remove "pop reg" .. [some lines with no usage of reg] .. "push reg"
                    if (TryRemovePopThenPush(lines, ref i, newLines))
                    {
                        changed = true;
                        continue;
                    }

                    // Try to remove "push reg" .. [some lines with no usage of reg] .. "pop reg"
                    if (TryRemovePushThenPop(lines, ref i, newLines))
                    {
                        changed = true;
                        continue;
                    }

                    // Otherwise keep line
                    newLines.Add(originalLine);
                    i++;
                }

                lines = newLines;
            }
            while (changed);

            return string.Join("\n", lines);
        }

        // Attempt to remove a 'pop reg' ... 'push reg' pattern 
        // if 'reg' is not used in the intervening lines
        private static bool TryRemovePopThenPush(List<string> lines, ref int i, List<string> output)
        {
            string originalLine = lines[i];
            string line = originalLine.Trim();
            var popMatch = Regex.Match(line, @"^\s*pop\s+(\w+)$", RegexOptions.IgnoreCase);
            if (!popMatch.Success) return false;

            // This is 'pop reg'
            string reg = popMatch.Groups[1].Value;

            // We'll store the popped line but not add to output yet
            int startIndex = i;

            // Scan forward to find a "push reg" with no usage of `reg` in between.
            int j = i + 1;
            while (j < lines.Count)
            {
                string nextLineRaw = lines[j];
                string nextLine = nextLineRaw.Trim();

                if (IsNonCodeLine(nextLine))
                {
                    j++;
                    continue;
                }

                // If we see "push reg" => might remove both 
                var pushMatch = Regex.Match(nextLine, @"^\s*push\s+" + reg + @"$", RegexOptions.IgnoreCase);
                if (pushMatch.Success)
                {
                    // Confirm reg wasn't used in the intervening lines
                    if (!RegisterUsed(lines, i + 1, j - 1, reg))
                    {
                        // We can remove pop and push
                        i = j + 1;
                        return true; // skip lines i..j
                    }
                    else
                    {
                        // The register was used, so we can't remove them
                        return false;
                    }
                }

                // If there's a read/write to 'reg', then we can't remove
                if (LineUsesRegister(nextLine, reg))
                    return false;

                // If there's a "pop reg" or "push differentReg" => keep scanning
                j++;
            }
            return false;
        }

        // Attempt to remove 'push reg' ... 'pop reg' pattern
        private static bool TryRemovePushThenPop(List<string> lines, ref int i, List<string> output)
        {
            string originalLine = lines[i];
            string line = originalLine.Trim();
            var pushMatch = Regex.Match(line, @"^\s*push\s+(\w+)$", RegexOptions.IgnoreCase);
            if (!pushMatch.Success) return false;

            string reg = pushMatch.Groups[1].Value;

            int j = i + 1;
            while (j < lines.Count)
            {
                string nextLineRaw = lines[j];
                string nextLine = nextLineRaw.Trim();

                if (IsNonCodeLine(nextLine))
                {
                    j++;
                    continue;
                }

                // If we see "pop reg"
                var popMatch = Regex.Match(nextLine, @"^\s*pop\s+" + reg + @"$", RegexOptions.IgnoreCase);
                if (popMatch.Success)
                {
                    // confirm reg wasn't used in the intervening lines
                    if (!RegisterUsed(lines, i + 1, j - 1, reg))
                    {
                        i = j + 1; // skip lines i..j
                        return true;
                    }
                    else
                    {
                        // The register was used
                        return false;
                    }
                }

                // If there's a read/write to 'reg', can't remove
                if (LineUsesRegister(nextLine, reg))
                    return false;

                j++;
            }
            return false;
        }

        // Check if `reg` is used from lines[start]..lines[end]
        private static bool RegisterUsed(List<string> lines, int start, int end, string reg)
        {
            for (int k = start; k <= end; k++)
            {
                if (k < 0 || k >= lines.Count) break;
                string line = lines[k].Trim();
                if (LineUsesRegister(line, reg)) return true;
            }
            return false;
        }

        private static bool LineUsesRegister(string line, string reg)
        {
            // e.g. if reg="rax", synonymsForReg = ["rax","eax","ax","ah","al"]
            if (!SubregisterSynonyms.TryGetValue(reg.ToLower(), out var synonymsForReg))
            {
                // If no synonyms known, fallback to a simpler pattern
                synonymsForReg = new[] { reg.ToLower() };
            }

            // Build an OR pattern with the synonyms
            var synonyms = string.Join("|", synonymsForReg.Select(Regex.Escape));
            // Combine direct usage + bracket usage
            var pattern = $@"\b({synonyms})\b|\[.*?\b({synonyms})\b.*?\]";

            // Case-insensitive matching
            return Regex.IsMatch(line, pattern, RegexOptions.IgnoreCase);
        }

        private static bool IsNonCodeLine(string line)
        {
            if (string.IsNullOrWhiteSpace(line)) return true;
            if (line.StartsWith(';')) return true;
            return false;
        }
    }
}
