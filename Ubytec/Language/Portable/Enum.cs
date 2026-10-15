namespace Ubytec.Language.Portable;

/// <summary>Resolves enum validation inside the portable namespace without shadowing Ubytec high-level enum types globally.</summary>
internal static class Enum
{
    internal static bool IsDefined(Type enumType, object value) => System.Enum.IsDefined(enumType, value);
}
