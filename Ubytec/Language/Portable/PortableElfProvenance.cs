using System.Buffers.Binary;
using System.Security.Cryptography;
using System.Text;

namespace Ubytec.Language.Portable;

/// <summary>Resolved half-open interval in a linked ELF image. Addresses are relative to ImageBase.</summary>
public sealed record PortableElfSite(PortableInstructionOccurrence Occurrence,
    ulong Start, ulong End, IReadOnlyList<ulong> Ud2Offsets)
{
    /// <summary>Validated marker annotations in the same order as Ud2Offsets.</summary>
    public IReadOnlyList<PortableNativeTrap> Traps { get; init; } = Array.Empty<PortableNativeTrap>();
}

/// <summary>A resolved site is evidence of provenance, not proof of translation correctness or authority.</summary>
public readonly record struct PortableElfAttribution(PortableInstructionOccurrence Occurrence, bool ExactUd2,
    PortableTrapKind TrapKind = PortableTrapKind.Unknown, int? InputIndex = null);

/// <summary>
/// Linux ELF64 little-endian x86-64 provenance for a trusted, single-module linked image.
/// The linker must preserve the local marker symbols. No ELF rewriting or runtime process inspection.
/// </summary>
public sealed class PortableElfProvenance
{
    private readonly record struct Segment(ulong Address, ulong FileOffset, ulong FileSize, ulong MemorySize, bool Executable);
    private readonly record struct Section(uint Type, ulong Flags, ulong Address, ulong Offset, ulong Size, uint Link, ulong EntrySize);
    private readonly record struct Symbol(ulong Address, ushort SectionIndex);

    /// <summary>SHA-256 of the exact linked ELF bytes, distinct from assembly and UBCM digests.</summary>
    public string ArtifactDigest { get; }
    /// <summary>SHA-256 of the associated emitted assembly (trusted build association).</summary>
    public string AssemblyDigest { get; }
    /// <summary>Minimum PT_LOAD virtual address; use ELF load bias plus ImageBase to obtain mapped base.</summary>
    public ulong ImageBase { get; }
    /// <summary>Validated image-relative marker intervals.</summary>
    public IReadOnlyList<PortableElfSite> Sites { get; }

    private PortableElfProvenance(string artifactDigest, string assemblyDigest, ulong imageBase, PortableElfSite[] sites)
    {
        ArtifactDigest = artifactDigest;
        AssemblyDigest = assemblyDigest;
        ImageBase = imageBase;
        Sites = Array.AsReadOnly(sites);
    }

    /// <summary>
    /// Resolve the marker set against the linked image produced by a trusted build.
    /// Checks layout, marker uniqueness and UD2 bytes. A malicious linker can forge markers;
    /// this is not independent translation validation or authentication of build provenance.
    /// </summary>
    public static PortableElfProvenance Resolve(ReadOnlySpan<byte> elf, PortableX64Provenance provenance)
    {
        ArgumentNullException.ThrowIfNull(provenance);
        if (elf.Length < 64 || !elf[..4].SequenceEqual(new byte[] { 0x7F, 0x45, 0x4C, 0x46 }) ||
            elf[4] != 2 || elf[5] != 1 || elf[6] != 1 || U32(elf, 20) != 1 ||
            U16(elf, 16) is not (2 or 3) || U16(elf, 18) != 62 || U16(elf, 52) != 64)
            throw Invalid("Expected a linked little-endian ELF64 x86-64 image.");
        if (Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(provenance.Compilation.Assembly))) != provenance.AssemblyDigest)
            throw Invalid("Assembly digest mismatch.");

        ulong phoff = U64(elf, 32), shoff = U64(elf, 40);
        int phsize = U16(elf, 54), phcount = U16(elf, 56);
        int shsize = U16(elf, 58), shcount = U16(elf, 60);
        if (phsize != 56 || shsize != 64 || phcount == 0 || phcount == 0xFFFF || shcount == 0 || shcount >= 0xFF00)
            throw Invalid("Unsupported or absent ELF header tables.");
        _ = Range(elf, phoff, (ulong)phsize * (ulong)phcount);
        _ = Range(elf, shoff, (ulong)shsize * (ulong)shcount);
        var segments = new List<Segment>();
        for (int i = 0; i < phcount; i++)
        {
            var p = Range(elf, phoff + (ulong)(i * phsize), (ulong)phsize);
            if (U32(p, 0) != 1) continue; // PT_LOAD
            var segment = new Segment(U64(p, 16), U64(p, 8), U64(p, 32), U64(p, 40), (U32(p, 4) & 1) != 0);
            if (segment.FileSize > segment.MemorySize || segment.Address > ulong.MaxValue - segment.MemorySize)
                throw Invalid("Invalid load segment.");
            _ = Range(elf, segment.FileOffset, segment.FileSize);
            segments.Add(segment);
        }
        if (segments.Count == 0) throw Invalid("No load segments.");
        ulong imageBase = segments.Min(s => s.Address);
        var sections = new Section[shcount];
        for (int i = 0; i < shcount; i++)
        {
            var s = Range(elf, shoff + (ulong)(i * shsize), (ulong)shsize);
            sections[i] = new Section(U32(s, 4), U64(s, 8), U64(s, 16), U64(s, 24),
                U64(s, 32), U32(s, 40), U64(s, 56));
        }

        var wanted = new HashSet<string>(StringComparer.Ordinal);
        foreach (var site in provenance.Sites)
        {
            if (!wanted.Add(site.BeginLabel) || !wanted.Add(site.EndLabel))
                throw Invalid("Duplicate provenance marker request.");
            foreach (string trap in site.Ud2Labels)
                if (!wanted.Add(trap)) throw Invalid("Duplicate trap marker request.");
        }
        var found = new Dictionary<string, Symbol>(StringComparer.Ordinal);
        var utf8 = new UTF8Encoding(false, true);
        foreach (var table in sections.Where(s => s.Type == 2)) // SHT_SYMTAB
        {
            if (table.EntrySize != 24 || table.Size % 24 != 0 ||
                table.Link >= (uint)sections.Length || sections[(int)table.Link].Type != 3)
                throw Invalid("Malformed ELF symbol table.");
            var strings = sections[(int)table.Link];
            var names = Range(elf, strings.Offset, strings.Size);
            var rows = Range(elf, table.Offset, table.Size);
            for (int pos = 0; pos < rows.Length; pos += 24)
            {
                var row = rows.Slice(pos, 24);
                uint nameOffset = U32(row, 0);
                if (nameOffset >= (uint)names.Length) throw Invalid("Invalid ELF symbol name offset.");
                var tail = names[(int)nameOffset..];
                int end = tail.IndexOf((byte)0);
                if (end < 0) throw Invalid("Unterminated ELF symbol name.");
                if (!tail[..end].StartsWith("..@ubytec_prov_"u8)) continue;
                string name = utf8.GetString(tail[..end]);
                if (!wanted.Contains(name)) throw Invalid("Unexpected provenance marker (multiple modules or mismatched map).");
                ushort sectionIndex = U16(row, 6);
                if ((row[4] >> 4) != 0 || sectionIndex == 0 || sectionIndex >= sections.Length)
                    throw Invalid("Marker must be a defined local symbol.");
                if (!found.TryAdd(name, new Symbol(U64(row, 8), sectionIndex)))
                    throw Invalid("Duplicate ELF provenance marker.");
            }
        }
        if (found.Count != wanted.Count) throw Invalid("Missing ELF provenance symbols; image may be stripped.");

        var resolved = new List<PortableElfSite>();
        foreach (var site in provenance.Sites)
        {
            var begin = found[site.BeginLabel];
            var end = found[site.EndLabel];
            if (begin.SectionIndex != end.SectionIndex || end.Address < begin.Address || begin.Address < imageBase)
                throw Invalid("Invalid provenance interval.");
            var section = sections[begin.SectionIndex];
            if ((section.Flags & 6) != 6 || section.Type != 1 ||
                !Contains(section.Address, section.Size, begin.Address, end.Address - begin.Address))
                throw Invalid("Marker interval outside allocated executable section.");
            var matching = segments.Where(s => s.Executable &&
                Contains(s.Address, s.FileSize, begin.Address, end.Address - begin.Address)).ToArray();
            if (matching.Length != 1) throw Invalid("Marker interval outside unique executable file segment.");
            var segment = matching[0];
            var traps = new List<ulong>();
            if (site.Traps.Count != 0 && !site.Traps.Select(t => t.Label).SequenceEqual(site.Ud2Labels))
                throw Invalid("Trap annotations do not match marker order.");
            foreach (string trapName in site.Ud2Labels)
            {
                var trap = found[trapName];
                if (trap.SectionIndex != begin.SectionIndex || trap.Address < begin.Address ||
                    trap.Address >= end.Address || end.Address - trap.Address < 2)
                    throw Invalid("UD2 marker outside its interval.");
                ulong offset = segment.FileOffset + (trap.Address - segment.Address);
                if (!Range(elf, offset, 2).SequenceEqual(new byte[] { 0x0F, 0x0B }))
                    throw Invalid("UD2 marker does not point to UD2 machine bytes.");
                traps.Add(trap.Address - imageBase);
            }
            if (traps.Distinct().Count() != traps.Count) throw Invalid("Duplicate UD2 address.");
            resolved.Add(new PortableElfSite(site.Occurrence, begin.Address - imageBase,
                end.Address - imageBase, traps.AsReadOnly()) { Traps = Array.AsReadOnly(site.Traps.ToArray()) });
        }
        var ordered = resolved.OrderBy(s => s.Start).ThenBy(s => s.End).ToArray();
        ulong previousEnd = 0;
        foreach (var site in ordered.Where(s => s.End > s.Start))
        {
            if (site.Start < previousEnd) throw Invalid("Overlapping nonempty provenance intervals.");
            previousEnd = site.End;
        }
        return new PortableElfProvenance(Convert.ToHexString(SHA256.HashData(elf)),
            provenance.AssemblyDigest, imageBase, ordered);
    }

    /// <summary>Lookup using an already verified loaded artifact digest and image-relative instruction pointer.
    /// Unknown addresses (prologue, epilogue, foreign code) return null; no nearest-marker guessing.</summary>
    public PortableElfAttribution? Attribute(string loadedArtifactDigest, ulong imageOffset)
    {
        if (!string.Equals(loadedArtifactDigest, ArtifactDigest, StringComparison.Ordinal))
            throw Invalid("Loaded artifact digest mismatch.");
        foreach (var site in Sites)
            if (imageOffset >= site.Start && imageOffset < site.End)
            {
                for (int i = 0; i < site.Ud2Offsets.Count; i++)
                    if (site.Ud2Offsets[i] == imageOffset)
                        return i < site.Traps.Count
                            ? new PortableElfAttribution(site.Occurrence, true, site.Traps[i].Kind, site.Traps[i].InputIndex)
                            : new PortableElfAttribution(site.Occurrence, true);
                return new PortableElfAttribution(site.Occurrence, false);
            }
        return null;
    }

    private static bool Contains(ulong start, ulong length, ulong address, ulong size) =>
        address >= start && address - start <= length && size <= length - (address - start);

    private static ReadOnlySpan<byte> Range(ReadOnlySpan<byte> data, ulong start, ulong size)
    {
        if (start > (ulong)data.Length || size > (ulong)data.Length - start)
            throw Invalid("Truncated ELF range.");
        return data.Slice((int)start, (int)size);
    }
    private static ushort U16(ReadOnlySpan<byte> bytes, int offset) => BinaryPrimitives.ReadUInt16LittleEndian(bytes.Slice(offset, 2));
    private static uint U32(ReadOnlySpan<byte> bytes, int offset) => BinaryPrimitives.ReadUInt32LittleEndian(bytes.Slice(offset, 4));
    private static ulong U64(ReadOnlySpan<byte> bytes, int offset) => BinaryPrimitives.ReadUInt64LittleEndian(bytes.Slice(offset, 8));
    private static InvalidDataException Invalid(string message) => new(message);
}
