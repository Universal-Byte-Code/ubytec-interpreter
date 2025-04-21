using Newtonsoft.Json.Linq;
using NJsonSchema;
using NJsonSchema.Validation;
using System.Text.Json;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Tools.Serialization;

namespace Ubytec.Language.AST
{
    public static class SyntaxTreeValidator
    {
        private static readonly HttpClient _httpClient = new();
        private static readonly JsonSerializerOptions _options = new()
        {
            WriteIndented = false,
            IncludeFields = false,
            RespectNullableAnnotations = true
        };
        static SyntaxTreeValidator()
        {
            _options.Converters.Add(new IOpCodeConverter());
            _options.Converters.Add(new ISyntaxTreeConverter());
            _options.Converters.Add(new IUbytecExpressionFragmentConverter());
        }

        public static ICollection<ValidationError> CheckSyntaxTreeSchema(SyntaxTree tree)
        {
            // Serialize the SyntaxTree to JSON
            string jsonString = JsonSerializer.Serialize(tree, _options);
            var treeToCheck = JObject.Parse(jsonString);

            // Extract the "$schema" URL
            if (!treeToCheck.TryGetValue("$schema", out JToken? schemaUrlToken) || schemaUrlToken.Type != JTokenType.String)
                throw new Exception("The JSON AST does not contain a valid $schema URL.");

            string schemaUrl = schemaUrlToken.ToString();
            Console.WriteLine($"Fetching schema from: {schemaUrl}");

            // Download the schema
            string schemaJson = FetchSchema(schemaUrl).Result;
            JsonSchema schema = JsonSchema.FromJsonAsync(schemaJson).Result;

            // Validate the JSON AST against the schema
            return schema.Validate(treeToCheck);
        }

        private static async Task<string> FetchSchema(string schemaUrl)
        {
            try
            {
                return await _httpClient.GetStringAsync(schemaUrl);
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to fetch schema from {schemaUrl}: {ex.Message}");
            }
        }
    }
}
