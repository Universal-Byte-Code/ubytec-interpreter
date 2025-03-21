using TextMateSharp.Grammars;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Syntaxes;

namespace Ubytec.Language.Lexical;

/// <summary>
/// 
/// </summary>
public static class LexicalAnalyst
{
    // Campo para la gramática cargada.
    private static IGrammar? _grammar;
    private static TextMateSharp.Registry.Registry? _registry;
    private static readonly UbytecRegistryOptions _options = new();

    /// <summary>
    /// Initialize Ubytec grammar from the git repository on the cloud.
    /// </summary>
    /// <exception cref="FetchLexiconException"></exception>
    public static void InitializeGrammar()
    {
        _registry = new TextMateSharp.Registry.Registry(_options);
        _grammar = _registry.LoadGrammar("source.ubytec");
        if (_grammar == null) throw new FetchLexiconException(0x9E1B2DAEBFC4E73B, "Ubytec lexicon was not correctly loaded.");
    }

    /// <summary>
    /// Tokenize the code using the loaded grammar.
    /// </summary>
    /// <param name="code"></param>
    /// <returns></returns>
    /// <exception cref="TokenizationOperationException"></exception>
    /// <exception cref="AggregateException"></exception>
    public static List<SyntaxToken> Tokenize(string code)
    {
        try
        {
            if (_grammar == null) throw new TokenizationOperationException(0xA89A8C2ED5267C03, "Grammar has not been initialized. Please first call to InitializeGrammar.");
            var tokens = new List<SyntaxToken>();

            // Obtén el estado inicial del tokenizador.
            IStateStack? ruleStack = null;

            // Dividir el código en líneas
            var lines = code.Split(['\n'], StringSplitOptions.None);
            
            for (int lineIndex = 0; lineIndex < lines.Length; lineIndex++)
            {
                string line = lines[lineIndex].Replace("\r", ""); // normalizar

                // Tokeniza la línea; la API actual devuelve un resultado que incluye tokens y el estado de la pila.
                var tokenizationResult = _grammar.TokenizeLine(line, ruleStack, TimeSpan.MaxValue);

                if (tokenizationResult != null)
                {
                    ruleStack = tokenizationResult.RuleStack;

                    // Para cada token en la línea, extrae el texto y los scopes.
                    foreach (var token in tokenizationResult.Tokens)
                    {
                        int startIndex = (token.StartIndex > line.Length) ? line.Length : token.StartIndex;
                        int endIndex = (token.EndIndex > line.Length) ? line.Length : token.EndIndex;

                        string tokenText = line[startIndex..endIndex];

                        // GetScopes devuelve una lista de scopes para este token
                        var scopes = token.Scopes;

                        tokens.Add(new SyntaxToken(tokenText, lineIndex, startIndex, endIndex, [.. scopes]));
                    }
                }
                else
                {
                    throw new TokenizationOperationException(0xD9AA53092CB09456, $"There was a problem tokenizing the line with the specified grammar {_options.LexiconUrl}, tokenization result is null...");
                }
            }

            return tokens;
        }
        catch (Exception ex)
        {
            throw new AggregateException(ex, new TokenizationOperationException(0x27C625DB73BE6F75, "There was a problem whilst tokenizing the input code..."));
        }
    }
}
