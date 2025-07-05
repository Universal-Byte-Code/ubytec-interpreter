using System.Text.Json;
using System.Text.Json.Serialization;
using Ubytec.Language.Operations;
using Ubytec.Language.Operations.Interfaces;

namespace Ubytec.Language.Tools.Serialization
{
    /// <summary>
    /// JSON converter for <see cref="IOpCode"/>, handling polymorphic serialization
    /// and deserialization based on a "$type" discriminator.
    /// </summary>
    public class IOpCodeConverter : JsonConverter<IOpCode>
    {
        /// <summary>
        /// Reads and converts the JSON to a concrete <see cref="IOpCode"/> instance
        /// using the "$type" discriminator property.
        /// </summary>
        /// <param name="reader">The <see cref="Utf8JsonReader"/> to read JSON from.</param>
        /// <param name="typeToConvert">The target type to convert (should be <see cref="IOpCode"/>).</param>
        /// <param name="options">Serialization options to use when reading JSON.</param>
        /// <returns>
        /// A concrete <see cref="IOpCode"/> instance,
        /// or <c>null</c> if the JSON value is <c>null</c>.
        /// </returns>
        /// <exception cref="JsonException">
        /// Thrown if the "$type" property is missing or unknown, or if deserialization fails.
        /// </exception>
        public override IOpCode? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            using var document = JsonDocument.ParseValue(ref reader);
            JsonElement root = document.RootElement;

            if (!root.TryGetProperty("$type", out JsonElement typeElement))
                throw new JsonException("Missing discriminator property '$type'.");

            string? typeDiscriminator = typeElement.GetString();

            // Gather opcode types from CoreOperations and StackOperations
            var coreTypes = typeof(CoreOperations).GetNestedTypes();
            var stackTypes = typeof(StackOperations).GetNestedTypes();
            var opCodeTypes = coreTypes.Concat(stackTypes);

            Type? targetType = opCodeTypes.FirstOrDefault(t => t.Name == typeDiscriminator)??throw new JsonException($"Unknown $type discriminator '{typeDiscriminator}'.");
            string json = root.GetRawText();
            return (IOpCode?)JsonSerializer.Deserialize(json, targetType, options);
        }

        /// <summary>
        /// Writes the <see cref="IOpCode"/> instance to JSON,
        /// including a "$type" discriminator property.
        /// </summary>
        /// <param name="writer">The <see cref="Utf8JsonWriter"/> to write JSON to.</param>
        /// <param name="value">The <see cref="IOpCode"/> instance to serialize.</param>
        /// <param name="options">Serialization options to use when writing JSON.</param>
        /// <exception cref="JsonException">Thrown if serialization fails.</exception>
        public override void Write(Utf8JsonWriter writer, IOpCode value, JsonSerializerOptions options)
        {
            using var document = JsonDocument.Parse(JsonSerializer.Serialize(value, value.GetType(), options));
            writer.WriteStartObject();
            writer.WriteString("$type", value.GetType().Name);
            foreach (JsonProperty property in document.RootElement.EnumerateObject())
            {
                property.WriteTo(writer);
            }
            writer.WriteEndObject();
        }
    }
}
