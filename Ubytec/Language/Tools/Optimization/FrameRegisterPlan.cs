using Ubytec.Language.Operations;
using Ubytec.Language.Syntax.Scopes.Contexts;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Tools.Optimization;

/// <summary>Write-through register copies for validated leaf functions containing loops.</summary>
internal static class FrameRegisterPlan
{
    internal static bool Apply(FunctionValueIR ir, ScopeContext frame, HashSet<string> initialized, bool allowEffects = false)
    {
        // Every original write remains. The optional effect mode reloads all copies
        // after a raw store or returning call, without adding spill cells to the frame.
        var forbidden = allowEffects ? ValueEffects.Unknown
            : ValueEffects.WriteRaw | ValueEffects.Call | ValueEffects.Unknown;
        if (!ir.Instructions.Any(i => i.LoopDepth > 0) || ir.Instructions.Any(i =>
            (i.Effects & forbidden) != 0)) return false;
        string[] free = new[] { "r8", "r9", "r10" }
            .Except(ir.Instructions.SelectMany(i => i.Clobbers), StringComparer.Ordinal).ToArray();
        var scores = new Dictionary<string, int>(StringComparer.Ordinal);
        foreach (var instruction in ir.Instructions)
            foreach (string name in instruction.Reads)
                scores[name] = scores.GetValueOrDefault(name) + (instruction.LoopDepth > 0 ? 8 : 1);
        var selected = frame.Symbols.Values.Where(binding => initialized.Contains(binding.Name) &&
            binding.Type.Type is PrimitiveType.Int64 or PrimitiveType.UInt64 && scores.GetValueOrDefault(binding.Name) > 1)
            .OrderByDescending(binding => scores[binding.Name]).ThenBy(binding => Math.Abs(binding.Offset))
            .ThenBy(binding => binding.Name, StringComparer.Ordinal).Take(free.Length).ToArray();
        for (int i = 0; i < selected.Length; i++)
            frame.Symbols[selected[i].Name] = selected[i] with { Register = free[i] };
        return selected.Length != 0;
    }
}
