using System.Text.Json;

namespace Ubytec.Language.Portable;

[Flags]
public enum PortableSharedRights { Read = 1, Write = 2, Atomic = 4 }
public readonly record struct PortableSharedLocationId(Guid Session, ulong Ordinal);
public readonly record struct PortableSharedRequest(PortableSharedLocationId Location, ulong Operand = 0, ulong Expected = 0);
public readonly record struct PortableMessageRequest(PortableRuntimeContextId Peer, ulong Payload = 0);
public sealed record PortableSharedEffectData(ulong Location, ulong Before, ulong After,
    ulong BeforeVersion, ulong AfterVersion, ulong Operand, ulong Expected, bool Written);
public sealed record PortableMessageEffectData(ulong Source, ulong Destination, ulong Payload);

public sealed partial class PortableTemporalCoordinator
{
    private sealed class Cell(ulong initial)
    {
        internal readonly ulong Initial = initial;
        internal ulong Value = initial;
        internal ulong Version;
        internal PortableRuntimeEventId? Writer;
        internal readonly SortedDictionary<ulong, PortableSharedRights> Grants = new();
    }
    private sealed record Message(ulong Payload, PortableRuntimeEventId Send);
    private readonly SortedDictionary<ulong, Cell> _cells = new();
    private readonly SortedDictionary<(ulong Source, ulong Destination), Queue<Message>> _channels = new();
    private readonly Dictionary<ulong, PortableMessageRequest> _blocked = new();
    private readonly int _maxLocations, _maxChannels, _maxMessages;
    private int _messageCount;

    public int BlockedReceiveCount => _blocked.Count;
    public int QueuedMessageCount => _messageCount;

    // Host admission only, before the first round. Names alone are not grants.
    public PortableSharedLocationId CreateSharedLocation(ulong initial)
    {
        RequireInitial();
        if (_cells.Count >= _maxLocations) throw new InvalidOperationException("Shared location limit.");
        ulong ordinal = checked((ulong)_cells.Count + 1);
        _cells.Add(ordinal, new(initial));
        return new(Session, ordinal);
    }

    public void GrantShared(PortableRuntimeContextId context, PortableSharedLocationId location, PortableSharedRights rights)
    {
        RequireInitial();
        if (context.Session != Session || !_live.Contains(context.Ordinal) ||
            location.Session != Session || !_cells.TryGetValue(location.Ordinal, out var cell) ||
            rights == 0 || (rights & ~(PortableSharedRights.Read | PortableSharedRights.Write | PortableSharedRights.Atomic)) != 0)
            throw new InvalidDataException("Invalid shared grant.");
        cell.Grants.Add(context.Ordinal, rights);
    }

    // A directional channel grants its source send and its destination receive, and nothing else.
    public void GrantChannel(PortableRuntimeContextId source, PortableRuntimeContextId destination)
    {
        RequireInitial();
        if (source.Session != Session || destination.Session != Session ||
            !_live.Contains(source.Ordinal) || !_live.Contains(destination.Ordinal))
            throw new InvalidDataException("Invalid channel endpoints.");
        if (_channels.Count >= _maxChannels) throw new InvalidOperationException("Channel limit.");
        _channels.Add((source.Ordinal, destination.Ordinal), new());
    }

    private void RequireInitial()
    {
        RequireBoundary();
        if (_started) throw new InvalidOperationException("Initial resource admission closed.");
    }

    private void CommitShared(ulong context, PortableTurnKind kind, PortableSharedRequest request)
    {
        if (request.Location.Session != Session || !_cells.TryGetValue(request.Location.Ordinal, out var cell))
            throw new UnauthorizedAccessException("Unknown shared location.");
        var required = kind switch
        {
            PortableTurnKind.SharedRead => PortableSharedRights.Read,
            PortableTurnKind.SharedWrite => PortableSharedRights.Write,
            _ => PortableSharedRights.Read | PortableSharedRights.Write | PortableSharedRights.Atomic
        };
        if (!cell.Grants.TryGetValue(context, out var granted) || (granted & required) != required)
            throw new UnauthorizedAccessException("Shared operation not granted.");
        if ((kind == PortableTurnKind.SharedRead && request.Operand != 0) ||
            (kind != PortableTurnKind.SharedCompareExchange && request.Expected != 0))
            throw new InvalidDataException("Noncanonical shared request.");

        ulong before = cell.Value, after = before;
        bool written = false;
        PortableTemporalEffectKind effect;
        switch (kind)
        {
            case PortableTurnKind.SharedRead: effect = PortableTemporalEffectKind.SharedRead; break;
            case PortableTurnKind.SharedWrite:
                effect = PortableTemporalEffectKind.SharedWrite;
                after = request.Operand; written = true; break;
            case PortableTurnKind.SharedAdd:
                effect = PortableTemporalEffectKind.SharedAdd;
                after = unchecked(before + request.Operand); written = true; break;
            case PortableTurnKind.SharedCompareExchange:
                effect = PortableTemporalEffectKind.SharedCompareExchange;
                written = before == request.Expected;
                if (written) after = request.Operand;
                break;
            default: throw new InvalidDataException("Unsupported shared effect.");
        }
        ulong version = written ? checked(cell.Version + 1) : cell.Version;
        var detail = new PortableSharedEffectData(request.Location.Ordinal, before, after,
            cell.Version, version, request.Operand, request.Expected, written);
        var deps = cell.Writer is { } writer ? new[] { writer } : Array.Empty<PortableRuntimeEventId>();
        Publication.RequireCapacity();
        var evt = Publication.Publish(new PortableTemporalEffect(Identity.AllocateEffect(Id(context)),
            effect, Round, after, Array.AsReadOnly(deps), Shared: detail));
        if (written)
        {
            cell.Value = after;
            cell.Version = version;
            cell.Writer = evt.Id;
        }
    }

    private void CommitMessage(ulong context, PortableTurnKind kind, PortableMessageRequest request)
    {
        if (request.Peer.Session != Session) throw new UnauthorizedAccessException("Foreign message endpoint.");
        bool sending = kind == PortableTurnKind.Send;
        var key = sending ? (context, request.Peer.Ordinal) : (request.Peer.Ordinal, context);
        if (!_channels.TryGetValue(key, out var queue))
            throw new UnauthorizedAccessException("Message channel not granted.");
        if (sending)
        {
            if (!_live.Contains(request.Peer.Ordinal)) throw new InvalidOperationException("Destination terminated.");
            if (_messageCount >= _maxMessages) throw new InvalidOperationException("Message limit.");
            Publication.RequireCapacity();
            var evt = Publication.Publish(new PortableTemporalEffect(Identity.AllocateEffect(Id(context)),
                PortableTemporalEffectKind.MessageSend, Round, request.Payload, Array.Empty<PortableRuntimeEventId>(),
                Message: new(key.Item1, key.Item2, request.Payload)));
            queue.Enqueue(new(request.Payload, evt.Id));
            _messageCount++;
        }
        else
        {
            if (request.Payload != 0) throw new InvalidDataException("Receive has no payload.");
            if (!queue.TryPeek(out var message))
            {
                _blocked[context] = request;
                return; // no event, no identity allocation, no partial effect
            }
            Publication.RequireCapacity();
            Publication.Publish(new PortableTemporalEffect(Identity.AllocateEffect(Id(context)),
                PortableTemporalEffectKind.MessageReceive, Round, message.Payload, Array.AsReadOnly(new[] { message.Send }),
                Message: new(key.Item1, key.Item2, message.Payload)));
            queue.Dequeue();
            _messageCount--;
            _blocked.Remove(context);
        }
    }

    private bool CanProgress(ulong context) =>
        !_timers.ContainsKey(context) &&
        (!_blocked.TryGetValue(context, out var request) ||
            _channels[(request.Peer.Ordinal, context)].Count != 0);

    private IReadOnlyList<string> CaptureResources()
    {
        var rows = new List<string>();
        rows.Add(JsonSerializer.Serialize(new { MaxLocations = _maxLocations, MaxChannels = _maxChannels, MaxMessages = _maxMessages }));
        foreach (var pair in _cells)
        {
            var c = pair.Value;
            rows.Add(JsonSerializer.Serialize(new { Location = pair.Key, c.Initial, c.Value, c.Version,
                Writer = c.Writer is { } w ? new[] { w.Context.Ordinal, w.Sequence } : null,
                Grants = c.Grants.Select(g => new { Context = g.Key, Rights = (int)g.Value }).ToArray() }));
        }
        foreach (var pair in _channels)
            rows.Add(JsonSerializer.Serialize(new { pair.Key.Source, pair.Key.Destination,
                Messages = pair.Value.Select(m => new { m.Payload, Sender = m.Send.Context.Ordinal, m.Send.Sequence }).ToArray() }));
        foreach (var pair in _blocked.OrderBy(p => p.Key))
            rows.Add(JsonSerializer.Serialize(new { Blocked = pair.Key, Peer = pair.Value.Peer.Ordinal }));
        return rows.AsReadOnly();
    }
}
