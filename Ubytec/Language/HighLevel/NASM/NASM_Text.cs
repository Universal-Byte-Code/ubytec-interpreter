using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_Text<T> where T : IUbytecHighLevelEntity
    {
        public NASM_Text(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullable = false)
        {
            // No dynamic props here, but keep signature for consistency
            if (nullable && contextEntity == null) return;

            sb.Append(FormatCompiledLines("section .text", scopes.GetDepth()));
            sb.Append(FormatCompiledLines("global _start", scopes.GetDepth()));
            sb.AppendLine();
        }
    }
}
