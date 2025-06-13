using System.Text.Json;
using System.Text.Json.Serialization;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Tools.Serialization
{
    /// <summary>
    /// JSON converter for <see cref="SyntaxTree"/>, handling polymorphic serialization
    /// and deserialization based on a fixed <c>$schema</c> discriminator URL.
    /// </summary>
    public class ISyntaxTreeConverter : JsonConverter<SyntaxTree>
    {
        /// <summary>
        /// The URL of the JSON schema used to validate and discriminate
        /// <see cref="SyntaxTree"/> instances.
        /// </summary>
        private const string SCHEMA_URL =
            "https://raw.githubusercontent.com/Universal-Byte-Code/schema/refs/heads/main/.ubc.ast.json";

        /// <summary>
        /// Reads and converts the JSON to a <see cref="SyntaxTree"/> instance,
        /// ensuring the <c>$schema</c> property matches the expected schema URL.
        /// </summary>
        /// <param name="reader">The <see cref="Utf8JsonReader"/> to read JSON from.</param>
        /// <param name="typeToConvert">The target type to convert (should be <see cref="SyntaxTree"/>).</param>
        /// <param name="options">Serialization options for reading JSON.</param>
        /// <returns>A deserialized <see cref="SyntaxTree"/>, never <c>null</c>.</returns>
        /// <exception cref="JsonException">
        /// Thrown if the <c>$schema</c> property is missing or does not match <see cref="SCHEMA_URL"/>.
        /// </exception>
        /// <exception cref="SyntaxTreeDeserializationException">
        /// Thrown if the JSON deserializes to <c>null</c> unexpectedly.
        /// </exception>
        public override SyntaxTree Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            using var document = JsonDocument.ParseValue(ref reader);
            var root = document.RootElement;

            if (!root.TryGetProperty("$schema", out JsonElement schemaElement))
                throw new JsonException("Missing discriminator property '$schema'.");

            string? schemaDiscriminator = schemaElement.GetString();
            if (schemaDiscriminator != SCHEMA_URL)
                throw new JsonException($"Unknown $schema discriminator '{schemaDiscriminator}'.");

            string json = root.GetRawText();
            return JsonSerializer.Deserialize<SyntaxTree>(json, options)
                   ?? throw new SyntaxTreeDeserializationException(
                       0xB52A7DB8522F1192,
                       "Syntax tree is null on deserialization");
        }

        /// <summary>
        /// Writes a <see cref="SyntaxTree"/> instance to JSON,
        /// emitting the <c>$schema</c> discriminator followed by the
        /// <c>RootSentence</c> and <c>Metadata</c> properties.
        /// </summary>
        /// <param name="writer">The <see cref="Utf8JsonWriter"/> to write JSON to.</param>
        /// <param name="value">The <see cref="SyntaxTree"/> instance to serialize.</param>
        /// <param name="options">Serialization options for writing JSON.</param>
        public override void Write(Utf8JsonWriter writer, SyntaxTree value, JsonSerializerOptions options)
        {
            writer.WriteStartObject();

            // $schema discriminator
            writer.WriteString("$schema", SCHEMA_URL);

            // RootSentence
            writer.WritePropertyName("RootSentence");
            JsonSerializer.Serialize(writer, value.RootSentence, options);

            // Metadata
            writer.WritePropertyName("Metadata");
            JsonSerializer.Serialize(writer, value.SerializableMetadata, options);

            writer.WriteEndObject();
        }
    }
}
