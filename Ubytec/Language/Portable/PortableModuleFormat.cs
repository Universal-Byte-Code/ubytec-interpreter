using System.Buffers.Binary;
using System.Text;
using System.Text.Json;
using Ubytec.Language.HighLevel;

namespace Ubytec.Language.Portable;

/// <summary>Standard section identifiers in Portable Module Format v0.</summary>
public enum PortableModuleSectionKind : ushort
{
    /// <summary>Canonical normalized semantic AST.</summary>
    SemanticAst = 0x0001,

    /// <summary>Portable import/export contract metadata.</summary>
    ContractManifest = 0x0002,

    /// <summary>Portable execution-environment capability requirements.</summary>
    CapabilityManifest = 0x0003
}

/// <summary>Section behavior flags in Portable Module Format v0.</summary>
[Flags]
public enum PortableModuleSectionFlags : ushort
{
    /// <summary>No special handling is required.</summary>
    None = 0,

    /// <summary>A reader must understand the section before accepting the module.</summary>
    Critical = 1
}

/// <summary>One verified section from a portable module.</summary>
/// <param name="Kind">Numeric section kind.</param>
/// <param name="Flags">Validated section flags.</param>
/// <param name="Payload">Exact canonical payload bytes.</param>
public sealed record PortableModuleSection(
    ushort Kind,
    PortableModuleSectionFlags Flags,
    ReadOnlyMemory<byte> Payload);

/// <summary>A structurally verified Portable Module Format image.</summary>
/// <param name="MajorVersion">Container major version.</param>
/// <param name="MinorVersion">Container minor version.</param>
/// <param name="Sections">Verified sections in canonical order.</param>
public sealed record PortableModuleImage(
    ushort MajorVersion,
    ushort MinorVersion,
    IReadOnlyList<PortableModuleSection> Sections)
{
    /// <summary>Returns a required standard section.</summary>
    public PortableModuleSection GetRequiredSection(PortableModuleSectionKind kind) =>
        Sections.FirstOrDefault(section => section.Kind == (ushort)kind)
        ?? throw new InvalidDataException($"Portable module does not contain required section '{kind}'.");

    /// <summary>Returns an optional standard section when present.</summary>
    public PortableModuleSection? GetSection(PortableModuleSectionKind kind) =>
        Sections.FirstOrDefault(section => section.Kind == (ushort)kind);
}

/// <summary>Encoder and bounded structural verifier for Portable Module Format v0.</summary>
public static class PortableModuleFormat
{
    private static ReadOnlySpan<byte> Magic => "UBCM"u8;
    private static readonly UTF8Encoding StrictUtf8 = new(false, true);

    /// <summary>Current PMF major version.</summary>
    public const ushort CurrentMajorVersion = 0;

    /// <summary>Current PMF minor version.</summary>
    public const ushort CurrentMinorVersion = 0;

    /// <summary>Reference-runtime maximum accepted module size.</summary>
    public const int MaxModuleBytes = 64 * 1024 * 1024;

    /// <summary>Reference-runtime maximum accepted section count.</summary>
    public const int MaxSectionCount = 32;

    private const int HeaderSize = 12;
    private const int SectionHeaderSize = 12;
    private const ushort KnownFlagMask = (ushort)PortableModuleSectionFlags.Critical;

    /// <summary>
    /// Encodes a normalized semantic module using deterministic PMF v0 framing.
    /// Contract metadata is included when non-empty; capabilities are sorted and deduplicated.
    /// </summary>
    public static byte[] Encode(
        Module module,
        string? contractManifest = null,
        IEnumerable<string>? capabilities = null)
    {
        byte[] serializedAst = JsonSerializer.SerializeToUtf8Bytes(module, global::SerializerOptionsHelper.Options);
        byte[] canonicalAst = CanonicalizeJson(
            serializedAst,
            requireObject: true,
            stripVolatileSyntaxMetadata: true);

        var sections = new List<EncodedSection>
        {
            new((ushort)PortableModuleSectionKind.SemanticAst,
                PortableModuleSectionFlags.Critical,
                canonicalAst)
        };

        if (!string.IsNullOrEmpty(contractManifest))
        {
            string canonicalContract = NormalizeContractManifest(contractManifest);
            sections.Add(new(
                (ushort)PortableModuleSectionKind.ContractManifest,
                PortableModuleSectionFlags.Critical,
                StrictUtf8.GetBytes(canonicalContract)));
        }

        if (capabilities is not null)
        {
            string[] normalizedCapabilities = capabilities
                .Select(capability => capability?.Trim() ?? string.Empty)
                .Where(capability => capability.Length != 0)
                .Distinct(StringComparer.Ordinal)
                .OrderBy(capability => capability, StringComparer.Ordinal)
                .ToArray();
            if (normalizedCapabilities.Length != 0)
            {
                byte[] capabilityJson = JsonSerializer.SerializeToUtf8Bytes(normalizedCapabilities);
                sections.Add(new(
                    (ushort)PortableModuleSectionKind.CapabilityManifest,
                    PortableModuleSectionFlags.Critical,
                    CanonicalizeJson(capabilityJson, requireObject: false)));
            }
        }

        sections.Sort(static (left, right) => left.Kind.CompareTo(right.Kind));
        return EncodeSections(sections);
    }

    /// <summary>Decodes and verifies PMF v0 framing and canonical standard-section payloads.</summary>
    public static PortableModuleImage Decode(ReadOnlySpan<byte> bytes)
    {
        if (bytes.Length > MaxModuleBytes)
            throw new InvalidDataException($"Portable module exceeds the {MaxModuleBytes}-byte runtime limit.");
        if (bytes.Length < HeaderSize)
            throw new InvalidDataException("Portable module header is truncated.");
        if (!bytes[..4].SequenceEqual(Magic))
            throw new InvalidDataException("Portable module magic must be ASCII 'UBCM'.");

        ushort major = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(4, 2));
        ushort minor = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(6, 2));
        if (major != CurrentMajorVersion || minor != CurrentMinorVersion)
            throw new InvalidDataException($"Unsupported portable module version {major}.{minor}.");

        uint sectionCount = BinaryPrimitives.ReadUInt32LittleEndian(bytes.Slice(8, 4));
        if (sectionCount == 0 || sectionCount > MaxSectionCount)
            throw new InvalidDataException($"Portable module section count must be between 1 and {MaxSectionCount}.");

        int offset = HeaderSize;
        int previousKind = -1;
        var sections = new List<PortableModuleSection>(checked((int)sectionCount));

        for (uint index = 0; index < sectionCount; index++)
        {
            if (bytes.Length - offset < SectionHeaderSize)
                throw new InvalidDataException("Portable module section header is truncated.");

            ushort kind = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(offset, 2));
            ushort rawFlags = BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(offset + 2, 2));
            ulong rawLength = BinaryPrimitives.ReadUInt64LittleEndian(bytes.Slice(offset + 4, 8));
            offset += SectionHeaderSize;

            if (kind <= previousKind)
                throw new InvalidDataException("Portable module sections must be unique and strictly ordered by kind.");
            previousKind = kind;

            if ((rawFlags & ~KnownFlagMask) != 0)
                throw new InvalidDataException($"Section 0x{kind:X4} uses reserved flag bits.");
            var flags = (PortableModuleSectionFlags)rawFlags;

            if (rawLength > int.MaxValue || rawLength > (ulong)(bytes.Length - offset))
                throw new InvalidDataException($"Section 0x{kind:X4} payload is truncated or too large.");

            int length = checked((int)rawLength);
            byte[] payload = bytes.Slice(offset, length).ToArray();
            offset += length;

            ValidateSection(kind, flags, payload);
            sections.Add(new PortableModuleSection(kind, flags, payload));
        }

        if (offset != bytes.Length)
            throw new InvalidDataException("Portable module contains trailing bytes after the final section.");

        PortableModuleSection? ast = sections.FirstOrDefault(section =>
            section.Kind == (ushort)PortableModuleSectionKind.SemanticAst);
        if (ast is null)
            throw new InvalidDataException("Portable module is missing the Semantic AST section.");
        if ((ast.Flags & PortableModuleSectionFlags.Critical) == 0)
            throw new InvalidDataException("Semantic AST section must be critical.");

        return new PortableModuleImage(major, minor, sections);
    }

    /// <summary>Verifies a module and discards the decoded view.</summary>
    public static void Verify(ReadOnlySpan<byte> bytes) => _ = Decode(bytes);

    private static byte[] EncodeSections(IReadOnlyList<EncodedSection> sections)
    {
        long totalLength = HeaderSize;
        foreach (EncodedSection section in sections)
            totalLength = checked(totalLength + SectionHeaderSize + section.Payload.Length);
        if (totalLength > MaxModuleBytes)
            throw new InvalidDataException($"Portable module exceeds the {MaxModuleBytes}-byte runtime limit.");

        byte[] output = new byte[checked((int)totalLength)];
        Magic.CopyTo(output);
        BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(4, 2), CurrentMajorVersion);
        BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(6, 2), CurrentMinorVersion);
        BinaryPrimitives.WriteUInt32LittleEndian(output.AsSpan(8, 4), checked((uint)sections.Count));

        int offset = HeaderSize;
        foreach (EncodedSection section in sections)
        {
            BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(offset, 2), section.Kind);
            BinaryPrimitives.WriteUInt16LittleEndian(output.AsSpan(offset + 2, 2), (ushort)section.Flags);
            BinaryPrimitives.WriteUInt64LittleEndian(output.AsSpan(offset + 4, 8), checked((ulong)section.Payload.Length));
            offset += SectionHeaderSize;
            section.Payload.CopyTo(output.AsSpan(offset));
            offset += section.Payload.Length;
        }

        return output;
    }

    private static void ValidateSection(
        ushort kind,
        PortableModuleSectionFlags flags,
        ReadOnlySpan<byte> payload)
    {
        bool critical = (flags & PortableModuleSectionFlags.Critical) != 0;
        switch ((PortableModuleSectionKind)kind)
        {
            case PortableModuleSectionKind.SemanticAst:
                if (!critical)
                    throw new InvalidDataException("Semantic AST section must be critical.");
                VerifyCanonicalJson(
                    payload,
                    requireObject: true,
                    "Semantic AST",
                    stripVolatileSyntaxMetadata: true);
                break;

            case PortableModuleSectionKind.ContractManifest:
                if (!critical)
                    throw new InvalidDataException("Contract manifest section must be critical.");
                _ = DecodeCanonicalContract(payload);
                break;

            case PortableModuleSectionKind.CapabilityManifest:
                if (!critical)
                    throw new InvalidDataException("Capability manifest section must be critical.");
                VerifyCapabilityManifest(payload);
                break;

            default:
                if (critical)
                    throw new InvalidDataException($"Unknown critical section 0x{kind:X4}.");
                break;
        }
    }

    private static void VerifyCanonicalJson(
        ReadOnlySpan<byte> payload,
        bool requireObject,
        string name,
        bool stripVolatileSyntaxMetadata = false)
    {
        byte[] canonical;
        try
        {
            canonical = CanonicalizeJson(
                payload,
                requireObject,
                stripVolatileSyntaxMetadata);
        }
        catch (JsonException error)
        {
            throw new InvalidDataException($"{name} section is not valid JSON.", error);
        }

        if (!payload.SequenceEqual(canonical))
            throw new InvalidDataException($"{name} section is not in canonical JSON v0 form.");
    }

    private static void VerifyCapabilityManifest(ReadOnlySpan<byte> payload)
    {
        VerifyCanonicalJson(payload, requireObject: false, "Capability manifest");
        using JsonDocument document = JsonDocument.Parse(payload.ToArray());
        if (document.RootElement.ValueKind != JsonValueKind.Array)
            throw new InvalidDataException("Capability manifest must be a JSON array.");

        string? previous = null;
        foreach (JsonElement item in document.RootElement.EnumerateArray())
        {
            if (item.ValueKind != JsonValueKind.String)
                throw new InvalidDataException("Capability manifest entries must be strings.");
            string capability = item.GetString() ?? string.Empty;
            if (capability.Length == 0 || !string.Equals(capability, capability.Trim(), StringComparison.Ordinal))
                throw new InvalidDataException("Capability names must be non-empty canonical strings.");
            if (previous is not null && string.CompareOrdinal(previous, capability) >= 0)
                throw new InvalidDataException("Capability manifest entries must be unique and ordinally sorted.");
            previous = capability;
        }
    }

    private static string NormalizeContractManifest(string contractManifest)
    {
        string normalized = contractManifest.ReplaceLineEndings("\n");
        if (normalized.Length != 0 && normalized[0] == '\uFEFF')
            throw new InvalidDataException("Contract manifest must not contain a BOM.");
        _ = StrictUtf8.GetBytes(normalized);
        return normalized;
    }

    private static string DecodeCanonicalContract(ReadOnlySpan<byte> payload)
    {
        string text;
        try
        {
            text = StrictUtf8.GetString(payload);
        }
        catch (DecoderFallbackException error)
        {
            throw new InvalidDataException("Contract manifest is not valid UTF-8.", error);
        }

        if (text.Length != 0 && text[0] == '\uFEFF')
            throw new InvalidDataException("Contract manifest must not contain a BOM.");
        if (text.Contains('\r', StringComparison.Ordinal))
            throw new InvalidDataException("Contract manifest must use LF line endings.");
        return text;
    }

    private static byte[] CanonicalizeJson(
        ReadOnlySpan<byte> utf8,
        bool requireObject,
        bool stripVolatileSyntaxMetadata = false)
    {
        using JsonDocument document = JsonDocument.Parse(utf8.ToArray(), new JsonDocumentOptions
        {
            AllowTrailingCommas = false,
            CommentHandling = JsonCommentHandling.Disallow,
            MaxDepth = 128
        });
        if (requireObject && document.RootElement.ValueKind != JsonValueKind.Object)
            throw new JsonException("Canonical payload root must be a JSON object.");

        using var stream = new MemoryStream();
        using (var writer = new Utf8JsonWriter(stream, new JsonWriterOptions
        {
            Indented = false,
            SkipValidation = false
        }))
        {
            WriteCanonicalJson(
                writer,
                document.RootElement,
                stripVolatileSyntaxMetadata,
                metadataObject: false);
        }
        return stream.ToArray();
    }

    private static void WriteCanonicalJson(
        Utf8JsonWriter writer,
        JsonElement element,
        bool stripVolatileSyntaxMetadata,
        bool metadataObject)
    {
        switch (element.ValueKind)
        {
            case JsonValueKind.Object:
                writer.WriteStartObject();
                var names = new HashSet<string>(StringComparer.Ordinal);
                JsonProperty[] properties = element.EnumerateObject().ToArray();
                foreach (JsonProperty property in properties)
                    if (!names.Add(property.Name))
                        throw new JsonException($"Duplicate JSON property '{property.Name}'.");
                foreach (JsonProperty property in properties.OrderBy(property => property.Name, StringComparer.Ordinal))
                {
                    if (stripVolatileSyntaxMetadata && metadataObject &&
                        string.Equals(property.Name, "guid", StringComparison.Ordinal))
                        continue;

                    writer.WritePropertyName(property.Name);
                    WriteCanonicalJson(
                        writer,
                        property.Value,
                        stripVolatileSyntaxMetadata,
                        string.Equals(property.Name, "Metadata", StringComparison.Ordinal));
                }
                writer.WriteEndObject();
                break;

            case JsonValueKind.Array:
                writer.WriteStartArray();
                foreach (JsonElement item in element.EnumerateArray())
                    WriteCanonicalJson(
                        writer,
                        item,
                        stripVolatileSyntaxMetadata,
                        metadataObject: false);
                writer.WriteEndArray();
                break;

            case JsonValueKind.String:
                writer.WriteStringValue(element.GetString());
                break;

            case JsonValueKind.Number:
                element.WriteTo(writer);
                break;

            case JsonValueKind.True:
                writer.WriteBooleanValue(true);
                break;

            case JsonValueKind.False:
                writer.WriteBooleanValue(false);
                break;

            case JsonValueKind.Null:
                writer.WriteNullValue();
                break;

            default:
                throw new JsonException($"Unsupported JSON token {element.ValueKind}.");
        }
    }

    private sealed record EncodedSection(
        ushort Kind,
        PortableModuleSectionFlags Flags,
        byte[] Payload);
}
