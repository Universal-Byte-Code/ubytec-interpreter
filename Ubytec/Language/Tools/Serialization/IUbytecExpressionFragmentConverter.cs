using System.Text.Json;
using System.Text.Json.Serialization;
using Ubytec.Language.Syntax.ExpressionFragments;
using Ubytec.Language.Syntax.Interfaces;

namespace Ubytec.Language.Tools.Serialization
{
    /// <summary>
    /// JSON converter for <see cref="IUbytecExpressionFragment"/>,
    /// handling polymorphic serialization and deserialization based on a "$type" discriminator.
    /// </summary>
    public class IUbytecExpressionFragmentConverter : JsonConverter<IUbytecExpressionFragment>
    {
        /// <summary>
        /// Reads and converts the JSON to a concrete <see cref="IUbytecExpressionFragment"/> instance
        /// using the "$type" discriminator property.
        /// </summary>
        /// <param name="reader">The reader to read JSON from.</param>
        /// <param name="typeToConvert">The target type to convert (expected <see cref="IUbytecExpressionFragment"/>).</param>
        /// <param name="options">Serialization options to use when deserializing.</param>
        /// <returns>
        /// A concrete <see cref="IUbytecExpressionFragment"/> instance,
        /// or <c>null</c> if the JSON value is null.
        /// </returns>
        /// <exception cref="JsonException">
        /// Thrown if the "$type" property is missing or unknown,
        /// or if deserialization fails.
        /// </exception>
        public override IUbytecExpressionFragment? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            using (var document = JsonDocument.ParseValue(ref reader))
            {
                JsonElement root = document.RootElement;
                if (!root.TryGetProperty("$type", out JsonElement typeElement))
                    throw new JsonException("Missing discriminator property '$type'.");

                string? typeDiscriminator = typeElement.GetString();
                Type targetType = typeDiscriminator switch
                {
                    nameof(ConditionExpressionFragment) => typeof(ConditionExpressionFragment),
                    nameof(VariableExpressionFragment) => typeof(VariableExpressionFragment),
                    _ => throw new JsonException($"Unknown $type discriminator '{typeDiscriminator}'.")
                };

                string json = root.GetRawText();
                return (IUbytecExpressionFragment?)JsonSerializer.Deserialize(json, targetType, options);
            }
        }

        /// <summary>
        /// Writes the <see cref="IUbytecExpressionFragment"/> instance to JSON,
        /// including a "$type" discriminator property.
        /// </summary>
        /// <param name="writer">The writer to write JSON to.</param>
        /// <param name="value">The <see cref="IUbytecExpressionFragment"/> instance to serialize.</param>
        /// <param name="options">Serialization options to use when writing.</param>
        /// <exception cref="JsonException">Thrown if serialization fails.</exception>
        public override void Write(Utf8JsonWriter writer, IUbytecExpressionFragment value, JsonSerializerOptions options)
        {
            using (var document = JsonDocument.Parse(JsonSerializer.Serialize(value, value.GetType(), options)))
            {
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
}
