namespace Ubytec.Language.Operations
{
    public static partial class CoreOperations
    {
        private static readonly Dictionary<string, int> _prefixToLabelCounterMap = [];

        // Generate a unique label for jumps
        private static string NextLabel(string prefix)
        {
            _prefixToLabelCounterMap.TryAdd(prefix, 0);
            return $"{prefix}_{_prefixToLabelCounterMap[prefix]++}";
        }
    }
}