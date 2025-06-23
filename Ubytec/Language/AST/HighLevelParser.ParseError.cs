namespace Ubytec.Language.AST;

public static partial class HighLevelParser
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Line"></param>
    /// <param name="Where"></param>
    /// <param name="Message"></param>
    public readonly record struct ParseError(int Line, string Where, string Message);
}