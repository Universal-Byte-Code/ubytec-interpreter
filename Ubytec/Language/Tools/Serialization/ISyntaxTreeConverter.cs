using System.Diagnostics.CodeAnalysis;
using System.Text.Json;
using System.Text.Json.Serialization;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Tools.Serialization;

public class ISyntaxTreeConverter : JsonConverter<SyntaxTree>
{
    const string SCHEMA_URL = @"https://raw.githubusercontent.com/Universal-Byte-Code/schema/refs/heads/main/.ubc.ast.json";

    public override SyntaxTree Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        using var document = JsonDocument.ParseValue(ref reader);
        var root = document.RootElement;

        if (!root.TryGetProperty("$schema", out JsonElement schemaElement))
            throw new JsonException("Missing discriminator property '$schema'.");

        var schemaDiscriminator = schemaElement.GetString();
        Type targetType = schemaDiscriminator switch
        {
            SCHEMA_URL => typeof(SyntaxTree),
            _ => throw new JsonException($"Unknown $schema discriminator '{schemaDiscriminator}'.")
        };

        string json = root.GetRawText();
        return (SyntaxTree?)JsonSerializer.Deserialize(json, targetType, options)
            ?? throw new SyntaxTreeDeserializationException(0xB52A7DB8522F1192, "Syntax tree is null on deserialization");
    }

    public override void Write(Utf8JsonWriter writer, SyntaxTree value, JsonSerializerOptions options)
    {
        writer.WriteStartObject();

        // $schema discriminator
        writer.WriteString("$schema", SCHEMA_URL);

        // RootSentence
        writer.WritePropertyName("RootSentence");
        JsonSerializer.Serialize(writer, value.RootSentence, options);

        writer.WritePropertyName("Metadata");
        JsonSerializer.Serialize(writer, value.SerializableMetadata, options);

        writer.WriteEndObject();
    }
}
