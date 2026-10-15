using System.Buffers.Binary;
using System.Text;
using Ubytec.Language.Syntax.TypeSystem;

namespace Ubytec.Language.Portable;

/// <summary>Portable optional process-entry metadata carried as PMF section 0x0017.</summary>
public sealed record PortableProcessEntrypointInfo(uint? FunctionIndex);

/// <summary>
/// Process-entry extension for indexed executable PMF v0.
/// Absence means library. Presence with NoIndex means a process image with no Ubytec entry function.
/// </summary>
public static class PortableProcessEntrypoint
{
    public const ushort SectionKind = 0x0017;
    public const uint NoIndex = uint.MaxValue;

    /// <summary>Attaches process-entry metadata to canonical indexed PMF bytes.</summary>
    public static byte[] Attach(ReadOnlySpan<byte> bytes, uint? functionIndex)
    {
        PortableBinaryVerifier.Verify(bytes);
        PortableBinaryModule module = PortableBinaryCodec.Decode(bytes);
        if (module.Executable is null)
            throw new NotSupportedException("Process entrypoint metadata requires the indexed executable PMF profile.");
        if (module.ContainerSections.Any(section => section.Kind == SectionKind))
            throw new InvalidDataException("Portable process entrypoint section already exists.");

        if (functionIndex is uint index)
            ValidateFunction(module.Executable, index);

        byte[] payload = new byte[4];
        BinaryPrimitives.WriteUInt32LittleEndian(payload, functionIndex ?? NoIndex);
        PortableModuleSection[] container =
        [
            .. module.ContainerSections,
            new PortableModuleSection(SectionKind, PortableModuleSectionFlags.None, payload)
        ];

        byte[] output = PortableBinaryCodec.Encode(module with { ContainerSections = container });
        Verify(output);
        return output;
    }

    /// <summary>Validates PMF plus process-entry metadata from raw canonical bytes.</summary>
    public static void Verify(ReadOnlySpan<byte> bytes)
    {
        PortableBinaryVerifier.Verify(bytes);
        _ = Read(PortableBinaryCodec.Decode(bytes));
    }

    /// <summary>Reads and validates process-entry metadata from a typed PMF module.</summary>
    public static PortableProcessEntrypointInfo? Read(PortableBinaryModule module)
    {
        ArgumentNullException.ThrowIfNull(module);
        PortableModuleSection[] sections = module.ContainerSections
            .Where(section => section.Kind == SectionKind)
            .ToArray();
        if (sections.Length == 0)
            return null;
        if (sections.Length != 1)
            throw new InvalidDataException("Portable process entrypoint section must appear at most once.");

        PortableModuleSection section = sections[0];
        if (section.Flags != PortableModuleSectionFlags.None)
            throw new InvalidDataException("Portable process entrypoint section flags must be zero.");
        if (section.Payload.Length != 4)
            throw new InvalidDataException("Portable process entrypoint payload must be exactly four bytes.");
        if (module.Executable is not { } executable)
            throw new InvalidDataException("Portable process entrypoint requires the indexed executable profile.");

        uint raw = BinaryPrimitives.ReadUInt32LittleEndian(section.Payload.Span);
        if (raw == NoIndex)
            return new PortableProcessEntrypointInfo(null);

        ValidateFunction(executable, raw);
        return new PortableProcessEntrypointInfo(raw);
    }

    private static void ValidateFunction(PortableExecutableModule executable, uint functionIndex)
    {
        if (functionIndex >= executable.Functions.Count)
            throw new InvalidDataException("Process entry FunctionIndex is outside the Function table.");
        PortableExecutableFunction function = executable.Functions[checked((int)functionIndex)];
        if (function.ArgumentTypeIndices.Count != 0)
            throw new InvalidDataException("Portable process entry function must have zero arguments.");
    }
}

/// <summary>Linux x86-64 process wrapper over the binary-only portable x64 backend.</summary>
public static class PortableProcessX64Backend
{
    /// <summary>Verifies, decodes and emits Linux x86-64 NASM including _start when process metadata is present.</summary>
    public static PortableX64Compilation Compile(ReadOnlySpan<byte> bytes)
    {
        PortableProcessEntrypoint.Verify(bytes);
        return Compile(PortableBinaryCodec.Decode(bytes));
    }

    /// <summary>Emits Linux x86-64 NASM from a typed portable module and optional process-entry metadata.</summary>
    public static PortableX64Compilation Compile(PortableBinaryModule module)
    {
        ArgumentNullException.ThrowIfNull(module);
        byte[] canonical = PortableBinaryCodec.Encode(module);
        PortableProcessEntrypoint.Verify(canonical);

        PortableX64Compilation native = PortableX64Backend.Compile(module);
        PortableProcessEntrypointInfo? entrypoint = PortableProcessEntrypoint.Read(module);
        if (entrypoint is null)
            return native;

        PortableExecutableModule executable = module.Executable
            ?? throw new InvalidDataException("Portable process image has no indexed executable profile.");
        var output = new StringBuilder(native.Assembly);
        output.AppendLine("section .text");
        output.AppendLine("global _start");
        output.AppendLine("_start:");

        if (entrypoint.FunctionIndex is uint index)
        {
            PortableExecutableFunction function = executable.Functions[checked((int)index)];
            output.AppendLine($"  call {native.GetFunctionLabel(checked((int)index))}");
            PortableExecutableType returnType = executable.Types[checked((int)function.ReturnTypeIndex)];
            output.AppendLine(returnType.Primitive == Types.PrimitiveType.Void
                ? "  xor edi, edi"
                : "  mov rdi, rax");
        }
        else
        {
            output.AppendLine("  xor edi, edi");
        }

        output.AppendLine("  mov eax, 60");
        output.AppendLine("  syscall");
        output.AppendLine("section .note.GNU-stack noalloc noexec nowrite progbits");

        return new PortableX64Compilation(
            output.ToString().ReplaceLineEndings("\n"),
            native.FunctionLabels,
            native.ImportLabels,
            native.ExportLabels);
    }
}
