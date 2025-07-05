using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_LocalContext<T> where T : IUbytecHighLevelEntity
    {
        public NASM_LocalContext(CompilationScopes scopes, StringBuilder sb, T contextEntity, bool nullableLocalContext = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.LocalContext))) throw new NotImplementedException($"Property {nameof(Module.LocalContext)} does not exists in type {typeof(T).Name}.");
            var temp = ((dynamic)contextEntity).LocalContext;
            if (nullableLocalContext && temp == null) return;
            if (temp is not LocalContext localContext) throw new InvalidCastException($"'{nameof(Module.LocalContext)}' property of type {typeof(T).Name} is not of the correct type.");
            sb.Append(FormatCompiledLines(localContext.Compile(scopes), scopes.GetDepth()));
        }
    }
}
