using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using Ubytec.Language.HighLevel;
using static Ubytec.Language.Syntax.TypeSystem.Types;
using Action = Ubytec.Language.HighLevel.Action;
using Enum = Ubytec.Language.HighLevel.Enum;

namespace Ubytec.Language.AST;

/// <summary>
/// Replaces parser-instance GUIDs with stable semantic UUIDv8 identifiers before code generation.
/// Runtime/trace identities remain UUIDv7 and are intentionally kept separate.
/// </summary>
internal sealed class SemanticIdentity
{
    private const string Domain = "ubytec:semantic-id:v1";
    private readonly Dictionary<Guid, string> _claims = new();

    internal static Module Normalize(Module module)
    {
        var normalizer = new SemanticIdentity();
        return normalizer.NormalizeModule(module, Key("module", module.Name, module.Version));
    }

    private Module NormalizeModule(Module module, string path)
    {
        var members = NormalizeMembers(module.Properties, module.Functions, module.Actions, path);
        return new Module(
            module.Name,
            module.Version,
            module.Requires,
            module.Author,
            module.Fields.Select(field => NormalizeField(field, path)).ToArray(),
            members.Properties,
            members.Functions,
            members.Actions,
            module.Interfaces.Select(@interface => NormalizeInterface(@interface, path)).ToArray(),
            module.Classes.Select(@class => NormalizeClass(@class, path)).ToArray(),
            module.Structs.Select(@struct => NormalizeStruct(@struct, path)).ToArray(),
            module.Records.Select(record => NormalizeRecord(record, path)).ToArray(),
            module.Enums.Select(@enum => NormalizeEnum(@enum, path)).ToArray(),
            module.SubModules.Select(submodule =>
                NormalizeModule(submodule, Key(path, "module", submodule.Name, submodule.Version))).ToArray(),
            Id(path),
            NormalizeLocal(module.LocalContext, path),
            NormalizeGlobal(module.GlobalContext, path),
            module.Modifiers);
    }

    private Field NormalizeField(Field field, string parent)
    {
        string path = Key(parent, "field", field.Name);
        return new Field(field.Name, field.Type, Id(path), field.Value, field.Modifiers);
    }

    private Property NormalizeProperty(Property property, string parent)
    {
        string path = Key(parent, "property", property.Name);
        var accessors = property.AccessorContext.ToArray()
            .Select(accessor => NormalizeFunction(accessor, Key(path, "accessor")))
            .ToArray();
        var context = new AccessorContext(accessors, Id(Key(path, "accessors")), property.Type);
        return new Property(property.Name, property.Type, context, Id(path), property.Modifiers);
    }

    private Func NormalizeFunction(Func function, string parent)
    {
        string path = Key(parent, "func", function.Name, Signature(function.Arguments, function.ReturnType));
        return new Func(
            function.Name,
            function.ReturnType,
            Id(path),
            NormalizeArguments(function.Arguments, path),
            NormalizeLocal(function.Locals, path),
            function.Modifiers,
            function.Definition);
    }

    private Action NormalizeAction(Action action, string parent)
    {
        string path = Key(parent, "action", action.Name, Signature(action.Arguments, new UType(PrimitiveType.Void)));
        return new Action(
            action.Name,
            Id(path),
            NormalizeArguments(action.Arguments, path),
            NormalizeLocal(action.Locals, path),
            action.Modifiers,
            action.Definition);
    }

    private Argument[] NormalizeArguments(Argument[] arguments, string parent) =>
        arguments.Select(argument => NormalizeArgument(argument, parent)).ToArray();

    private Argument NormalizeArgument(Argument argument, string parent)
    {
        string path = Key(parent, "arg", argument.Name, TypeKey(argument.Type));
        return new Argument(argument.Name, argument.Type, Id(path), argument.Modifiers);
    }

    private Variable NormalizeVariable(Variable variable, string parent)
    {
        string path = Key(parent, "var", variable.Name, TypeKey(variable.Type));
        return new Variable(variable.Name, variable.Type, Id(path), variable.Modifiers, variable.Value);
    }

    private LocalContext? NormalizeLocal(LocalContext? context, string parent)
    {
        if (context is null)
            return null;

        string path = Key(parent, "local");
        var callables = NormalizeCallables(context.Value.Functions, context.Value.Actions, path);
        return new LocalContext(
            context.Value.Variables.Select(variable => NormalizeVariable(variable, path)).ToArray(),
            callables.Functions,
            callables.Actions,
            Id(path));
    }

    private GlobalContext? NormalizeGlobal(GlobalContext? context, string parent)
    {
        if (context is null)
            return null;

        string path = Key(parent, "global");
        var members = NormalizeMembers(context.Value.Properties, context.Value.Functions, context.Value.Actions, path);
        return new GlobalContext(
            context.Value.Fields.Select(field => NormalizeField(field, path)).ToArray(),
            members.Properties,
            members.Functions,
            members.Actions,
            Id(path));
    }

    private Interface NormalizeInterface(Interface @interface, string parent)
    {
        string path = Key(parent, "interface", @interface.Name);
        var members = NormalizeMembers(@interface.Properties, @interface.Functions, @interface.Actions, path);
        return new Interface(
            @interface.Name,
            members.Properties,
            members.Functions,
            members.Actions,
            Id(path),
            @interface.Modifiers);
    }

    private Class NormalizeClass(Class @class, string parent)
    {
        string path = Key(parent, "class", @class.Name);
        var members = NormalizeMembers(@class.Properties, @class.Functions, @class.Actions, path);
        return new Class(
            @class.Name,
            @class.Fields.Select(field => NormalizeField(field, path)).ToArray(),
            members.Properties,
            members.Functions,
            members.Actions,
            @class.Interfaces.Select(@interface => NormalizeInterface(@interface, path)).ToArray(),
            @class.Classes.Select(nested => NormalizeClass(nested, path)).ToArray(),
            @class.Structs.Select(nested => NormalizeStruct(nested, path)).ToArray(),
            @class.Records.Select(nested => NormalizeRecord(nested, path)).ToArray(),
            @class.Enums.Select(nested => NormalizeEnum(nested, path)).ToArray(),
            Id(path),
            NormalizeLocal(@class.Locals, path),
            NormalizeGlobal(@class.Globals, path),
            @class.Modifiers);
    }

    private Struct NormalizeStruct(Struct @struct, string parent)
    {
        string path = Key(parent, "struct", @struct.Name);
        var members = NormalizeMembers(@struct.Properties, @struct.Functions, @struct.Actions, path);
        return new Struct(
            @struct.Name,
            @struct.Fields.Select(field => NormalizeField(field, path)).ToArray(),
            members.Properties,
            members.Functions,
            members.Actions,
            Id(path),
            NormalizeLocal(@struct.Locals, path),
            NormalizeGlobal(@struct.Globals, path),
            @struct.Modifiers);
    }

    private Record NormalizeRecord(Record record, string parent)
    {
        string path = Key(parent, "record", record.Name);
        var members = NormalizeMembers(record.Properties, record.Functions, record.Actions, path);
        return new Record(
            record.Name,
            members.Properties,
            members.Functions,
            members.Actions,
            Id(path),
            NormalizeLocal(record.Locals, path),
            NormalizeGlobal(record.Globals, path),
            record.Modifiers);
    }

    private Enum NormalizeEnum(Enum @enum, string parent)
    {
        string path = Key(parent, "enum", @enum.Name);
        return new Enum(
            @enum.Name,
            @enum.Members,
            Id(path),
            @enum.TypeSize,
            @enum.IsBitfield,
            @enum.Modifiers);
    }

    private (Property[] Properties, Func[] Functions, Action[] Actions) NormalizeMembers(
        Property[] properties,
        Func[] functions,
        Action[] actions,
        string path)
    {
        var callables = NormalizeCallables(functions, actions, path);
        return (
            properties.Select(property => NormalizeProperty(property, path)).ToArray(),
            callables.Functions,
            callables.Actions);
    }

    private (Func[] Functions, Action[] Actions) NormalizeCallables(
        Func[] functions,
        Action[] actions,
        string path) =>
        (
            functions.Select(function => NormalizeFunction(function, path)).ToArray(),
            actions.Select(action => NormalizeAction(action, path)).ToArray());

    private Guid Id(string canonical)
    {
        byte[] digest = SHA256.HashData(Encoding.UTF8.GetBytes(Domain + "\0" + canonical));
        digest[6] = (byte)((digest[6] & 0x0F) | 0x80); // UUID version 8: application-defined SHA-256 identity.
        digest[8] = (byte)((digest[8] & 0x3F) | 0x80); // RFC 4122/9562 variant.

        string hex = Convert.ToHexString(digest.AsSpan(0, 16));
        Guid id = Guid.ParseExact(
            $"{hex[..8]}-{hex[8..12]}-{hex[12..16]}-{hex[16..20]}-{hex[20..32]}",
            "D");

        if (_claims.TryGetValue(id, out string? existing) &&
            !string.Equals(existing, canonical, StringComparison.Ordinal))
            throw new InvalidOperationException(
                $"Deterministic semantic UUID collision between '{existing}' and '{canonical}'.");

        _claims[id] = canonical;
        return id;
    }

    private static string Signature(Argument[] arguments, UType returnType) =>
        Key(string.Join(",", arguments.Select(argument => TypeKey(argument.Type))), TypeKey(returnType));

    private static string TypeKey(UType type) =>
        Key(
            type.Type.ToString(),
            ((ulong)type.Modifiers).ToString(CultureInfo.InvariantCulture),
            type.Name,
            type.FixedArraySize.ToString(CultureInfo.InvariantCulture));

    private static string Key(params string[] parts)
    {
        var output = new StringBuilder();
        foreach (string raw in parts)
        {
            string part = (raw ?? string.Empty).Normalize(NormalizationForm.FormC);
            output.Append(part.Length.ToString(CultureInfo.InvariantCulture))
                .Append(':')
                .Append(part)
                .Append(';');
        }
        return output.ToString();
    }
}
