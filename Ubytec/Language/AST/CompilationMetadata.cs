using System.Security.Cryptography;
using System.Text;
using Ubytec.Language.HighLevel;

namespace Ubytec.Language.AST;

/// <summary>
/// Volatile provenance for one compiler invocation. This data is intentionally
/// kept outside the canonical NASM artifact so timestamps and runtime UUIDs do
/// not affect reproducible output.
/// </summary>
public sealed record CompilationMetadata(
    Guid CompilationId,
    DateTimeOffset TimestampUtc,
    CompilerProvenance Compiler,
    ModuleProvenance Module,
    TargetProvenance Target,
    ArtifactHashes Hashes,
    string[] Features)
{
    /// <summary>Creates sidecar provenance for a completed compilation.</summary>
    public static CompilationMetadata Create(
        Module module,
        string source,
        string assembly,
        string targetIsa,
        IEnumerable<string>? features = null)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(targetIsa);

        return new CompilationMetadata(
            Guid.CreateVersion7(),
            DateTimeOffset.UtcNow,
            new CompilerProvenance(
                "ubytec",
                typeof(SourceCompiler).Assembly.GetName().Version?.ToString() ?? "0.0.0.0"),
            new ModuleProvenance(module.Name, module.Version, module.Author, module.ID),
            new TargetProvenance("linux", "x86-64", "nasm", targetIsa),
            new ArtifactHashes(Hash(source), Hash(assembly)),
            (features ?? [])
                .Distinct(StringComparer.Ordinal)
                .OrderBy(feature => feature, StringComparer.Ordinal)
                .ToArray());
    }

    private static string Hash(string text)
    {
        byte[] bytes = Encoding.UTF8.GetBytes(text.ReplaceLineEndings("\n"));
        return Convert.ToHexString(SHA256.HashData(bytes)).ToLowerInvariant();
    }
}

/// <summary>Compiler identity recorded in a build-provenance sidecar.</summary>
public sealed record CompilerProvenance(string Name, string Version);

/// <summary>Stable semantic module identity plus human-readable source metadata.</summary>
public sealed record ModuleProvenance(string Name, string Version, string Author, Guid SemanticId);

/// <summary>Target selected for the produced artifact.</summary>
public sealed record TargetProvenance(string Os, string Architecture, string Format, string Isa);

/// <summary>Hashes of canonical compilation input and output text.</summary>
public sealed record ArtifactHashes(string SourceSha256, string AssemblySha256);
