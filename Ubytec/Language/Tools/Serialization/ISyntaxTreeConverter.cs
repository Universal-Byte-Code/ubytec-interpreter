using System.Text.Json;
using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.Syntaxes;

namespace Ubytec.Language.Tools.Serialization;

public class ISyntaxTreeConverter : JsonConverter<SyntaxTree>
{
    public override SyntaxTree? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        // Parse the JSON document.
        using (var document = JsonDocument.ParseValue(ref reader))
        {
            JsonElement root = document.RootElement;
            // Ensure the discriminator property exists.
            if (!root.TryGetProperty("$schema", out JsonElement schemaElement))
                throw new JsonException("Missing discriminator property '$schema'.");

            // Map the discriminator to a concrete type.
            var schemaDiscriminator = schemaElement.GetString();
            Type targetType = schemaDiscriminator switch
            {
                @"https://raw.githubusercontent.com/Universal-Byte-Code/schema/refs/heads/main/.ubc.ast.json" => typeof(SyntaxTree),
                _ => throw new JsonException($"Unknown $schema discriminator '{schemaDiscriminator}'.")
            };


            // Deserialize the JSON to the concrete type.
            string json = root.GetRawText();
            return (SyntaxTree?)JsonSerializer.Deserialize(json, targetType, options);
        }
    }
    public override void Write(Utf8JsonWriter writer, SyntaxTree value, JsonSerializerOptions options)
    {
        writer.WriteStartObject();

        // ✅ Write schema at the root level
        writer.WriteString("$schema", "https://raw.githubusercontent.com/Universal-Byte-Code/schema/refs/heads/main/.ubc.ast.json");

        // ✅ Manually serialize each property of SyntaxTree to avoid recursive calls
        writer.WritePropertyName("RootSentence");
        JsonSerializer.Serialize(writer, value.RootSentence, options);

        writer.WritePropertyName("Metadata");
        JsonSerializer.Serialize(writer, value.Metadata, options);

        writer.WriteEndObject();
    }
}

