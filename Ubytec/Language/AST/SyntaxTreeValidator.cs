using Newtonsoft.Json.Linq;
using NJsonSchema;
using NJsonSchema.Validation;
using System.Text.Json;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Tools.Serialization;

namespace Ubytec.Language.AST
{
    /// <summary>
    /// Provides functionality to validate a <see cref="SyntaxTree"/> against its JSON schema.
    /// </summary>
    public static class SyntaxTreeValidator
    {
        /// <summary>
        /// Shared <see cref="HttpClient"/> instance used to download JSON schemas.
        /// </summary>
        private static readonly HttpClient _httpClient = new();

        /// <summary>
        /// <see cref="JsonSerializerOptions"/> configured for serializing a <see cref="SyntaxTree"/>.
        /// </summary>
        private static readonly JsonSerializerOptions _options = new()
        {
            WriteIndented = false,
            IncludeFields = false,
            RespectNullableAnnotations = true
        };

        /// <summary>
        /// Static constructor: registers converters needed for proper AST serialization.
        /// </summary>
        static SyntaxTreeValidator()
        {
            _options.Converters.Add(new IOpCodeConverter());
            _options.Converters.Add(new ISyntaxTreeConverter());
            _options.Converters.Add(new IUbytecExpressionFragmentConverter());
        }

        /// <summary>
        /// Validates that the provided syntax tree matches the JSON schema specified
        /// in its <c>$schema</c> property.
        /// </summary>
        /// <param name="tree">The <see cref="SyntaxTree"/> to validate.</param>
        /// <returns>
        /// A collection of <see cref="ValidationError"/> objects describing any schema violations.
        /// Empty if the tree is valid.
        /// </returns>
        /// <exception cref="Exception">
        /// Thrown if the tree’s JSON does not contain a valid <c>$schema</c> URL,
        /// or if downloading the schema fails.
        /// </exception>
        public static ICollection<ValidationError> CheckSyntaxTreeSchema(SyntaxTree tree)
        {
            // Serialize the SyntaxTree to JSON
            string jsonString = JsonSerializer.Serialize(tree, _options);
            var treeToCheck = JObject.Parse(jsonString);

            // Extract the "$schema" URL
            if (!treeToCheck.TryGetValue("$schema", out JToken? schemaUrlToken)
                || schemaUrlToken.Type != JTokenType.String)
            {
                throw new Exception("The JSON AST does not contain a valid $schema URL.");
            }

            string schemaUrl = schemaUrlToken.ToString();
            Console.WriteLine($"Fetching schema from: {schemaUrl}");

            // Download the schema
            string schemaJson = FetchSchema(schemaUrl).Result;
            JsonSchema schema = JsonSchema.FromJsonAsync(schemaJson).Result;

            // Validate the JSON AST against the schema
            return schema.Validate(treeToCheck);
        }

        /// <summary>
        /// Downloads the JSON schema from the specified URL.
        /// </summary>
        /// <param name="schemaUrl">The URL of the JSON schema to fetch.</param>
        /// <returns>
        /// A <see cref="Task{TResult}"/> that produces the raw JSON schema text.
        /// </returns>
        /// <exception cref="Exception">Thrown if the HTTP request fails.</exception>
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
