using System.Text;
using TextMateSharp.Internal.Grammars.Reader;
using TextMateSharp.Internal.Themes.Reader;
using TextMateSharp.Internal.Types;
using TextMateSharp.Registry;
using TextMateSharp.Themes;
using Ubytec.Language.Exceptions;

namespace Ubytec.Language.Grammar
{
    /// <summary>
    /// Provides configuration options and retrieval methods for TextMate grammars and themes
    /// used by the Ubytec language support in editors.
    /// </summary>
    [CLSCompliant(true)]
    public class UbytecRegistryOptions : IRegistryOptions
    {
        private static readonly HttpClient _httpClient = new();

        /// <summary>
        /// URL of the TextMate grammar (lexicon) JSON file defining Ubytec syntax.
        /// </summary>
        public Uri? LexiconUrl { get; set; } = new Uri(
            "https://raw.githubusercontent.com/Universal-Byte-Code/vscode-ubytec/refs/heads/master/syntaxes/ubytec.tmLanguage.json");

        /// <summary>
        /// URL of the default TextMate theme JSON file for Ubytec syntax highlighting.
        /// </summary>
        public Uri? DefaultThemeUrl { get; set; } = new Uri(
            "https://raw.githubusercontent.com/Universal-Byte-Code/vscode-ubytec/refs/heads/master/themes/ubytec-future-thunder-theme.json");

#nullable disable
        /// <summary>
        /// Returns a collection of scope names that should be injected into the given scope.
        /// </summary>
        /// <param name="scopeName">The name of the scope for which to retrieve injections.</param>
        /// <returns>A collection of scope names to inject, or null if none.</returns>
        public ICollection<string> GetInjections(string scopeName) => null;

        /// <summary>
        /// Retrieves and parses the TextMate grammar for the specified scope.
        /// </summary>
        /// <param name="scopeName">The grammar scope name to load (e.g., "source.ubytec").</param>
        /// <returns>An <see cref="IRawGrammar"/> representing the parsed grammar, or null on failure.</returns>
#nullable enable
        [CLSCompliant(false)]
        public IRawGrammar? GetGrammar(string scopeName)
#nullable disable
        {
            var lexiconFetchTask = FetchLexicon(LexiconUrl?.AbsoluteUri);
            var lexiconReadTask = lexiconFetchTask.ContinueWith(task =>
            {
                if (task.IsFaulted || task.IsCanceled)
                    return null;

                using var stream = GetStreamWithStreamWriter(task.Result);
                using var reader = new StreamReader(stream);
                return GrammarReader.ReadGrammarSync(reader);
            });

            lexiconReadTask.Wait();
            return lexiconReadTask.Result;
        }

        /// <summary>
        /// Retrieves a TextMate theme for the specified scope.
        /// </summary>
        /// <param name="scopeName">The theme scope name to load.</param>
        /// <returns>An <see cref="IRawTheme"/> representing the theme, or null if not available.</returns>
        [CLSCompliant(false)]
        public IRawTheme GetTheme(string scopeName) => null;

        /// <summary>
        /// Retrieves and parses the default TextMate theme for Ubytec syntax highlighting.
        /// </summary>
        /// <returns>An <see cref="IRawTheme"/> representing the default theme.</returns>
        /// <exception cref="HttpIOException">Thrown if the theme cannot be fetched or parsed.</exception>
#nullable enable
        [CLSCompliant(false)]
        public IRawTheme? GetDefaultTheme()
#nullable disable
        {
            var themeFetchTask = FetchTheme(DefaultThemeUrl?.AbsoluteUri);
            var themeReadTask = themeFetchTask.ContinueWith(task =>
            {
                if (task.IsFaulted || task.IsCanceled)
                    return null;

                using var stream = GetStreamWithStreamWriter(task.Result);
                using var reader = new StreamReader(stream);
                return ThemeReader.ReadThemeSync(reader);
            });

            themeReadTask.Wait();
            return themeReadTask.Result
                ?? throw new HttpIOException(HttpRequestError.ConnectionError);
        }
#nullable restore

        /// <summary>
        /// Asynchronously fetches the lexicon (grammar) content from the specified URL.
        /// </summary>
        /// <param name="lexiconUrl">The absolute URI of the lexicon JSON file.</param>
        /// <returns>A <see cref="Task{String}"/> producing the JSON content.</returns>
        /// <exception cref="FetchLexiconException">Thrown if the HTTP request fails.</exception>
        private static async Task<string> FetchLexicon(string? lexiconUrl)
        {
            try
            {
                return await _httpClient.GetStringAsync(lexiconUrl!).ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                throw new FetchLexiconException(
                    0xEE462C77F1DB7F64,
                    $"Failed to fetch lexicon from {lexiconUrl}: {ex.Message}");
            }
        }

        /// <summary>
        /// Asynchronously fetches the theme content from the specified URL.
        /// </summary>
        /// <param name="themeUrl">The absolute URI of the theme JSON file.</param>
        /// <returns>A <see cref="Task{String}"/> producing the JSON content.</returns>
        /// <exception cref="FetchLexiconException">Thrown if the HTTP request fails.</exception>
        private static async Task<string> FetchTheme(string? themeUrl)
        {
            try
            {
                return await _httpClient.GetStringAsync(themeUrl!).ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                throw new FetchLexiconException(
                    0xF5D3670DF469370E,
                    $"Failed to fetch theme from {themeUrl}: {ex.Message}");
            }
        }

        /// <summary>
        /// Creates a <see cref="MemoryStream"/> containing the specified string encoded using the given encoding.
        /// </summary>
        /// <param name="sampleString">The string to write into the stream.</param>
        /// <param name="encoding">The text encoding to apply. Defaults to <see cref="Encoding.Default"/> if null.</param>
        /// <returns>A <see cref="MemoryStream"/> positioned at the beginning containing the encoded text.</returns>
        private static MemoryStream GetStreamWithStreamWriter(
            string sampleString,
            Encoding? encoding = null)
        {
            encoding ??= Encoding.Default;
            var byteCount = encoding.GetByteCount(sampleString);
            var stream = new MemoryStream(byteCount);

            using (var writer = new StreamWriter(stream, encoding, leaveOpen: true))
            {
                writer.Write(sampleString);
                writer.Flush();
            }

            stream.Position = 0;
            return stream;
        }
    }
}
