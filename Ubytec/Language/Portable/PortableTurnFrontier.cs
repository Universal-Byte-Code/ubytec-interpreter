namespace Ubytec.Language.Portable;

/// <summary>Pure ordering/validation of a complete batch. No publication authority.</summary>
public static class PortableTurnFrontier
{
    public static IReadOnlyList<PortableTurnProposal> Order(IReadOnlyList<PortableTurnKey> frontier,
        IReadOnlyList<PortableTurnProposal> arrivals) => OrderCore(frontier, arrivals, proposal => proposal.Key);

    internal static IReadOnlyList<T> OrderCore<T>(IReadOnlyList<PortableTurnKey> frontier,
        IReadOnlyList<T> arrivals, Func<T, PortableTurnKey> keyOf)
    {
        ArgumentNullException.ThrowIfNull(frontier);
        ArgumentNullException.ThrowIfNull(arrivals);
        if (arrivals.Count != frontier.Count) throw new InvalidDataException("Incomplete or oversized frontier.");
        var allowed = frontier.ToHashSet();
        if (allowed.Count != frontier.Count) throw new InvalidDataException("Duplicate frontier key.");
        var byKey = new Dictionary<PortableTurnKey, T>();
        foreach (var proposal in arrivals)
        {
            var key = keyOf(proposal);
            if (!allowed.Contains(key) || !byKey.TryAdd(key, proposal))
                throw new InvalidDataException("Duplicate, stale or foreign turn.");
        }
        return Array.AsReadOnly(frontier.Select(key => byKey[key]).ToArray());
    }
}
