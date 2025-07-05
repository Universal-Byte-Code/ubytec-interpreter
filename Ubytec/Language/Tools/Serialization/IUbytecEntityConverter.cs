using System.Text.Json;
using System.Text.Json.Serialization;

namespace Ubytec.Language.Tools.Serialization
{
    /// <summary>
    /// JSON converter for <see cref="IUbytecEntity"/>, handling polymorphic
    /// serialization and deserialization based on a "$entityType" discriminator.
    /// </summary>
    public class IUbytecEntityConverter : JsonConverter<IUbytecEntity>
    {
        public override IUbytecEntity? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            using var document = JsonDocument.ParseValue(ref reader);
            JsonElement root = document.RootElement;

            if (!root.TryGetProperty("$entityType", out JsonElement typeElement))
                throw new JsonException("Missing discriminator property '$entityType'.");

            string? typeDiscriminator = typeElement.GetString();
            if (string.IsNullOrWhiteSpace(typeDiscriminator))
                throw new JsonException("Discriminator '$entityType' is empty.");

            // Gather all IUbytecEntity implementations
            var entityTypes = typeof(IUbytecEntity).Assembly
                .GetTypes()
                .Where(t => !t.IsAbstract && typeof(IUbytecEntity).IsAssignableFrom(t));

            Type? targetType = entityTypes
                .FirstOrDefault(t => string.Equals(t.Name, typeDiscriminator, StringComparison.OrdinalIgnoreCase));

            if (targetType == null)
                throw new JsonException($"Unknown $entityType discriminator '{typeDiscriminator}'.");

            string json = root.GetRawText();
            return (IUbytecEntity?)JsonSerializer.Deserialize(json, targetType, options);
        }

        public override void Write(Utf8JsonWriter writer, IUbytecEntity value, JsonSerializerOptions options)
        {
            using var document = JsonDocument.Parse(JsonSerializer.Serialize(value, value.GetType(), options));

            writer.WriteStartObject();

            // Write $entityType at the top level
            writer.WriteString("$entityType", value.GetType().Name);

            // Write all properties of the object
            foreach (JsonProperty property in document.RootElement.EnumerateObject())
            {
                property.WriteTo(writer);
            }

            writer.WriteEndObject();
        }
    }
}
