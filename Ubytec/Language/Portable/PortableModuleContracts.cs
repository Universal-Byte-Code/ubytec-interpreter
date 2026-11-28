using Ubytec.Language.AST;
using Ubytec.Language.HighLevel;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Portable;

/// <summary>Portable calling semantics for one module-boundary argument.</summary>
public enum PortablePassingMode : byte
{
    /// <summary>Ordinary value argument.</summary>
    Value = 0,

    /// <summary>Read-only borrowed region/capability.</summary>
    LoanRead = 1,

    /// <summary>Writable borrowed region/capability.</summary>
    LoanWrite = 2
}

/// <summary>A logical module-boundary parameter before table-index assignment.</summary>
/// <param name="PassingMode">Boundary passing semantics.</param>
/// <param name="CarrierType">Portable language type carried by the boundary contract.</param>
public sealed record PortableBoundaryParameter(
    PortablePassingMode PassingMode,
    PrimitiveType CarrierType);

/// <summary>Semantic import retained from source compilation.</summary>
/// <param name="SourceAlias">Source-local alias used to resolve CALL operands. It is not serialized.</param>
/// <param name="Module">Portable provider module identity.</param>
/// <param name="Symbol">Portable exported symbol identity.</param>
/// <param name="ReturnType">Portable return carrier type.</param>
/// <param name="Arguments">Logical boundary arguments.</param>
public sealed record PortableImportContract(
    string SourceAlias,
    string Module,
    string Symbol,
    PrimitiveType ReturnType,
    IReadOnlyList<PortableBoundaryParameter> Arguments);

/// <summary>Semantic export retained from source compilation.</summary>
/// <param name="FunctionName">Internal Ubytec function resolved to FunctionIndex during lowering.</param>
/// <param name="Symbol">Portable public export identity.</param>
/// <param name="ReturnType">Portable return carrier type.</param>
/// <param name="Arguments">Logical boundary arguments.</param>
public sealed record PortableExportContract(
    string FunctionName,
    string Symbol,
    PrimitiveType ReturnType,
    IReadOnlyList<PortableBoundaryParameter> Arguments);

/// <summary>
/// Immutable semantic module-contract view used by portable lowering. Runtime bridge handles and
/// generated host symbols are deliberately absent because they are not portable identities.
/// </summary>
public sealed record PortableModuleContracts(
    IReadOnlyList<PortableImportContract> Imports,
    IReadOnlyList<PortableExportContract> Exports)
{
    /// <summary>An empty contract set.</summary>
    public static PortableModuleContracts Empty { get; } = new([], []);

    internal static PortableModuleContracts From(ModuleContracts contracts, Module module)
    {
        ArgumentNullException.ThrowIfNull(contracts);
        ArgumentNullException.ThrowIfNull(module);

        PortableImportContract[] imports = contracts.Imports
            .Select(import =>
            {
                BoundarySignature signature = ParseSignature(import.Signature);
                return new PortableImportContract(
                    import.Alias,
                    import.Module,
                    import.Export,
                    signature.ReturnType,
                    signature.Arguments);
            })
            .ToArray();

        PortableExportContract[] exports = contracts.Exports
            .Select(export =>
            {
                Ubytec.Language.HighLevel.Func function = module.Functions.FirstOrDefault(
                    item => string.Equals(item.Name, export.Function, StringComparison.Ordinal));
                if (string.IsNullOrEmpty(function.Name))
                    throw new ArgumentException($"Unknown exported function '{export.Function}'.");

                BoundarySignature signature = export.Signature is { } declared
                    ? ParseSignature(declared)
                    : new BoundarySignature(
                        function.ReturnType.Type,
                        function.Arguments
                            .Select(argument => new PortableBoundaryParameter(
                                PortablePassingMode.Value,
                                argument.Type.Type))
                            .ToArray());

                ValidateExportCompatibility(function, signature);
                return new PortableExportContract(
                    export.Function,
                    export.Name,
                    signature.ReturnType,
                    signature.Arguments);
            })
            .ToArray();

        return new PortableModuleContracts(imports, exports);
    }

    private static BoundarySignature ParseSignature(string signature)
    {
        string[] halves = signature.Split(':');
        if (halves.Length != 2)
            throw new InvalidDataException($"Invalid module contract signature '{signature}'.");

        PortableBoundaryParameter[] arguments = halves[0].Length == 0
            ? []
            : halves[0].Split(',').Select(ParseParameter).ToArray();
        PrimitiveType returnType = ParseCarrierType(halves[1], allowVoid: true);
        return new BoundarySignature(returnType, arguments);
    }

    private static PortableBoundaryParameter ParseParameter(string value) => value switch
    {
        "LoanRead" => new(PortablePassingMode.LoanRead, PrimitiveType.UInt64),
        "LoanWrite" => new(PortablePassingMode.LoanWrite, PrimitiveType.UInt64),
        _ => new(PortablePassingMode.Value, ParseCarrierType(value, allowVoid: false))
    };

    private static PrimitiveType ParseCarrierType(string value, bool allowVoid)
    {
        PrimitiveType type = value switch
        {
            "Void" => PrimitiveType.Void,
            "Byte" => PrimitiveType.Byte,
            "UInt32" => PrimitiveType.UInt32,
            "Int32" => PrimitiveType.Int32,
            "UInt64" => PrimitiveType.UInt64,
            "Int64" => PrimitiveType.Int64,
            _ => throw new InvalidDataException($"Unsupported portable contract carrier type '{value}'.")
        };

        if (!allowVoid && type == PrimitiveType.Void)
            throw new InvalidDataException("Void is not a valid module-boundary argument type.");
        return type;
    }

    private static void ValidateExportCompatibility(
        Ubytec.Language.HighLevel.Func function,
        BoundarySignature signature)
    {
        if (function.ReturnType.Type != signature.ReturnType)
            throw new ArgumentException(
                $"Export '{function.Name}' return contract does not match its function signature.");
        if (function.Arguments.Length != signature.Arguments.Count)
            throw new ArgumentException(
                $"Export '{function.Name}' argument contract does not match its function signature.");

        for (int index = 0; index < function.Arguments.Length; index++)
        {
            PrimitiveType internalType = function.Arguments[index].Type.Type;
            PortableBoundaryParameter boundary = signature.Arguments[index];
            if (internalType != boundary.CarrierType)
                throw new ArgumentException(
                    $"Export '{function.Name}' boundary argument {index} does not match its carrier type.");
            if (boundary.PassingMode is PortablePassingMode.LoanRead or PortablePassingMode.LoanWrite &&
                boundary.CarrierType != PrimitiveType.UInt64)
                throw new ArgumentException("v0 loan boundaries require a UInt64 carrier type.");
        }
    }

    private sealed record BoundarySignature(
        PrimitiveType ReturnType,
        IReadOnlyList<PortableBoundaryParameter> Arguments);
}
