using System.Text.Json;
using System.Text.Json.Serialization;
using Ubytec.Language.Operations;

namespace Ubytec.Language.Tools.Serialization;

public class IOpCodeConverter : JsonConverter<IOpCode>
{
    public override IOpCode? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        // Parse the JSON document.
        using (var document = JsonDocument.ParseValue(ref reader))
        {
            JsonElement root = document.RootElement;
            // Ensure the discriminator property exists.
            if (!root.TryGetProperty("$type", out JsonElement typeElement))
                throw new JsonException("Missing discriminator property '$type'.");
            var typeDiscriminator = typeElement.GetString();

            // Map the discriminator to a concrete type.
            var coreTypes = typeof(CoreOperations).GetNestedTypes();
            var stackTypes = typeof(StackOperarions).GetNestedTypes();

            Type[] opCodeTypes = [ ..coreTypes, ..stackTypes];
            Type? targetType = null;

            foreach (var opCodeType in opCodeTypes)
                if (opCodeType.Name == typeDiscriminator)
                    targetType = opCodeType;

            if (targetType == null) throw new JsonException($"Unknown $type discriminator '{typeDiscriminator}'.");

            // Deserialize the JSON to the concrete type.
            string json = root.GetRawText();
            return (IOpCode?)JsonSerializer.Deserialize(json, targetType, options);
        }
    }

    public override void Write(Utf8JsonWriter writer, IOpCode value, JsonSerializerOptions options)
    {
        // Serialize the concrete object into a JsonDocument.
        using (var document = JsonDocument.Parse(JsonSerializer.Serialize(value, value.GetType(), options)))
        {
            writer.WriteStartObject();
            // Write the discriminator using the Name property.
            writer.WriteString("$type", value.GetType().Name);
            // Write all other properties from the concrete object.
            foreach (JsonProperty property in document.RootElement.EnumerateObject())
            {
                property.WriteTo(writer);
            }
            writer.WriteEndObject();
        }
    }
}

