using System.Text.Json;

namespace Ubytec.Language.Portable;

/// <summary>Complete single-context observation. A fault terminates the supervised process.</summary>
public sealed record PortableNativeTraceResult(IReadOnlyList<PortablePublishedEvent> Events, int? ExitCode);

/// <summary>
/// Reference offline consumer of the trusted Linux observer's JSONL stream. Validates
/// the complete stream before exposing a ledger. No inference of activation from PC alone.
/// Not a production loader, authentication boundary or parallel scheduler.
/// </summary>
public static class PortableNativeActivationTrace
{
    public static PortableNativeTraceResult Consume(ReadOnlySpan<byte> ubcm, PortableExecutionProfile profile,
        PortableElfProvenance map, ReadOnlySpan<byte> elf, string observations)
    {
        ArgumentNullException.ThrowIfNull(observations);
        if (observations.Length > 2_000_000 || map.ActivationMarkers.Count == 0)
            throw new InvalidDataException("Missing markers or oversized observation stream.");
        var markers = map.ActivationMarkers.ToDictionary(marker => marker.Offset);
        var identity = new PortableRuntimeIdentity();
        var instance = identity.Load(ubcm, profile);
        identity.BindNative(instance, map, elf);
        var context = identity.CreateContext();
        var publication = new PortableEventPublication(identity.Session);
        var stack = new Stack<(PortableLifecycleEvent Entry, ulong Rsp)>();
        bool terminal = false;
        int? exit = null;
        using var reader = new StringReader(observations);
        int count = 0;
        while (reader.ReadLine() is { } line)
        {
            if (++count > 4097 || terminal || line.Length == 0)
                throw new InvalidDataException("Invalid observation stream length or terminal ordering.");
            using var document = JsonDocument.Parse(line);
            var row = document.RootElement;
            switch (row.GetProperty("kind").GetString())
            {
                case "activation":
                    ulong offset = row.GetProperty("image_offset").GetUInt64();
                    ulong rsp = row.GetProperty("rsp").GetUInt64();
                    if (!markers.TryGetValue(offset, out var marker))
                        throw new InvalidDataException("Observed breakpoint has no verified activation marker.");
                    if (marker.Enter)
                    {
                        if (stack.TryPeek(out var parent) && rsp >= parent.Rsp)
                            throw new InvalidDataException("Nested invocation did not descend the native stack.");
                        var entry = identity.EnterObserved(context, instance, marker.FunctionIndex);
                        publication.Publish(entry);
                        stack.Push((entry, rsp));
                    }
                    else
                    {
                        if (!stack.TryPeek(out var frame) || frame.Entry.FunctionIndex != marker.FunctionIndex ||
                            frame.Rsp != rsp)
                            throw new InvalidDataException("Native return conflicts with active invocation.");
                        publication.Publish(identity.CloseObserved(frame.Entry.Activation));
                        stack.Pop();
                    }
                    break;
                case "fault":
                    if (!stack.TryPeek(out var active))
                        throw new InvalidDataException("Fault outside a known activation; context-only fault model pending.");
                    var pc = row.GetProperty("image_offset");
                    int signal = row.GetProperty("signal").GetInt32(), code = row.GetProperty("code").GetInt32();
                    if (signal is not (4 or 7 or 8 or 11) || code <= 0)
                        throw new InvalidDataException("Not a supported synchronous fault observation.");
                    var fault = identity.RecordNativeFault(active.Entry.Activation,
                        pc.ValueKind == JsonValueKind.Null ? null : pc.GetUInt64(), signal, code);
                    publication.Publish(fault);
                    while (stack.TryPop(out var abandoned))
                        publication.Publish(identity.CloseObserved(abandoned.Entry.Activation, aborted: true));
                    terminal = true;
                    break;
                case "exit":
                    exit = row.GetProperty("code").GetInt32();
                    if (stack.Count != 0 || exit is < 0 or > 255)
                        throw new InvalidDataException("Process exited with unresolved activations or invalid status.");
                    terminal = true;
                    break;
                default:
                    throw new InvalidDataException("Unknown observation kind.");
            }
        }
        if (!terminal) throw new InvalidDataException("Observation stream has no terminal event.");
        identity.RetireContext(context);
        identity.Unload(instance);
        return new PortableNativeTraceResult(publication.Events, exit);
    }
}
