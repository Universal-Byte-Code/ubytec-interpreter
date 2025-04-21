using System.Text;
using TextMateSharp.Internal.Grammars.Reader;
using TextMateSharp.Internal.Themes.Reader;
using TextMateSharp.Internal.Types;
using TextMateSharp.Registry;
using TextMateSharp.Themes;
using Ubytec.Language.Exceptions;

namespace Ubytec.Language.Grammar;

public class UbytecRegistryOptions : IRegistryOptions
{
    private static readonly HttpClient _httpClient = new();

    public string? LexiconUrl { get; set; } = @"https://raw.githubusercontent.com/Universal-Byte-Code/vscode-ubytec/refs/heads/master/syntaxes/ubytec.tmLanguage.json";
    public string? DefaultThemeUrl { get; set; } = @"https://raw.githubusercontent.com/Universal-Byte-Code/vscode-ubytec/refs/heads/master/themes/ubytec-future-thunder-theme.json";

#nullable disable
    public ICollection<string> GetInjections(string scopeName) => null;

    public IRawGrammar GetGrammar(string scopeName)
    {
        var lexiconFetchTask = FetchLexicon(LexiconUrl);
        var lexiconReadTask = lexiconFetchTask.ContinueWith(task =>
        {
            if (task.IsFaulted)
                return null;
            else if (task.IsCanceled)
            {
                return null;
            }

            var stream = GetStreamWithStreamWriter(task.Result);
            var reader = new StreamReader(stream);
            var grammar = GrammarReader.ReadGrammarSync(reader);
            stream.Flush();
            stream.Dispose();
            return grammar;
        });

        lexiconReadTask.Wait();

        if (lexiconReadTask.IsFaulted)
            return null;
        else if (lexiconReadTask.IsCanceled)
        {
            return null;
        }

        return lexiconReadTask.Result;
    }

    public IRawTheme GetTheme(string scopeName) => null;

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    /// <exception cref="HttpIOException"></exception>
    public IRawTheme GetDefaultTheme()
    {
        var themeFetchTask = FetchTheme(DefaultThemeUrl);
        var themeReadTask = themeFetchTask.ContinueWith(task =>
        {
            if (task.IsFaulted)
                return null;
            else if (task.IsCanceled)
            {
                return null;
            }

            var stream = GetStreamWithStreamWriter(task.Result);
            var reader = new StreamReader(stream);
            var rawTheme = ThemeReader.ReadThemeSync(reader);
            stream.Flush();
            stream.Dispose();
            return rawTheme;
        });

        themeReadTask.Wait();

        if (themeReadTask.IsFaulted)
            return null;
        else if (themeReadTask.IsCanceled)
        {
            return null;
        }

        return themeReadTask.Result ?? throw new HttpIOException(HttpRequestError.ConnectionError);
    }
#nullable restore

    private static async Task<string> FetchLexicon(string? lexiconUrl)
    {
        try
        {
            return await _httpClient.GetStringAsync(lexiconUrl);
        }
        catch (Exception ex)
        {
            throw new FetchLexiconException(0xEE462C77F1DB7F64, $"Failed to fetch lexicon from {lexiconUrl}: {ex.Message}");
        }
    }

    private static async Task<string> FetchTheme(string? themeUrl)
    {
        try
        {
            return await _httpClient.GetStringAsync(themeUrl);
        }
        catch (Exception ex)
        {
            throw new FetchLexiconException(0xF5D3670DF469370E, $"Failed to fetch theme from {themeUrl}: {ex.Message}");
        }
    }

    private static MemoryStream GetStreamWithStreamWriter(string sampleString, Encoding? encoding = null)
    {
        encoding ??= Encoding.Default;

        var stream = new MemoryStream(encoding.GetByteCount(sampleString));
        using var writer = new StreamWriter(stream, encoding, -1, true);
        writer.Write(sampleString);
        writer.Flush();
        stream.Position = 0;

        return stream;
    }
}