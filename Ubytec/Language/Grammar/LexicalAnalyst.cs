using TextMateSharp.Grammars;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Grammar;

/// <summary>
/// Provides lexical analysis functionality using a TextMate grammar for Ubytec code.
/// </summary>
public static class LexicalAnalyst
{
    private const string UBYTEC_SOURCE = "source.ubytec";
    private static IGrammar? _grammar;
    private static TextMateSharp.Registry.Registry? _registry;
    private static readonly UbytecRegistryOptions _options = new();

    /// <summary>
    /// Initializes the Ubytec grammar from the remote lexicon.
    /// </summary>
    /// <exception cref="FetchLexiconException">Thrown when the grammar could not be loaded.</exception>
    public static void InitializeGrammar()
    {
        try
        {
            _registry = new TextMateSharp.Registry.Registry(_options);
            _grammar = _registry.LoadGrammar(UBYTEC_SOURCE) ?? throw new FetchLexiconException(0x9E1B2DAEBFC4E73B, "Ubytec lexicon was not correctly loaded.");
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine(ex);
        }
    }

    /// <summary>
    /// Tokenizes Ubytec source code into a list of syntax tokens.
    /// </summary>
    /// <param name="code">The Ubytec code to tokenize.</param>
    /// <returns>List of syntax tokens extracted from the input.</returns>
    /// <exception cref="TokenizationOperationException">Thrown when tokenization fails or the grammar is uninitialized.</exception>
    /// <exception cref="AggregateException">Wraps internal exceptions during tokenization.</exception>
    public static List<SyntaxToken> Tokenize(string code)
    {
        try
        {
            if (_grammar is null)
                throw new TokenizationOperationException(0xA89A8C2ED5267C03, "Grammar not initialized. Call InitializeGrammar first.");

            var tokens = new List<SyntaxToken>(code.Length / 4);
            IStateStack? ruleStack = null;
            var lines = code.Split('\n');

            for (int lineIndex = 0; lineIndex < lines.Length; lineIndex++)
            {
                var lineSpan = lines[lineIndex].AsSpan().TrimEnd('\r');
                var lineText = lineSpan.ToString();

                var result = _grammar.TokenizeLine(lineText, ruleStack, TimeSpan.MaxValue)
                    ?? throw new TokenizationOperationException(0xD9AA53092CB09456, $"Failed to tokenize line {lineIndex}. Grammar: {_options.LexiconUrl}");

                ruleStack = result.RuleStack;

                foreach (var token in result.Tokens)
                {
                    int start = Math.Min(token.StartIndex, lineSpan.Length);
                    int end = Math.Min(token.EndIndex, lineSpan.Length);
                    var tokenText = lineSpan[start..end].ToString();

                    tokens.Add(new SyntaxToken(tokenText, lineIndex, start, end, [.. token.Scopes]));
                }
            }

            return tokens;
        }
        catch (Exception ex)
        {
            throw new AggregateException(ex, new TokenizationOperationException(0x27C625DB73BE6F75, "Tokenization failed."));
        }
    }
}
