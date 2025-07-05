using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_SubModules<T> where T : IUbytecHighLevelEntity
    {
        public NASM_SubModules(CompilationScopes scopes, StringBuilder sb, T contextEntity, bool nullableSubModules = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.SubModules))) throw new NotImplementedException($"Property {nameof(Module.SubModules)} does not exists in type {typeof(T).Name}.");
            var temp = ((dynamic)contextEntity).SubModules;
            if (nullableSubModules && temp == null) return;
            if (temp is not Module[] subModules) throw new InvalidCastException($"'{nameof(Module.SubModules)}' property of type {typeof(T).Name} is not of the correct type.");
            foreach (var sub in subModules)
            {
                sb.Append(FormatCompiledLines($"; ===== sub-module: {sub.Name} =====", scopes.GetDepth()));
                sb.Append(FormatCompiledLines(sub.Compile(scopes), scopes.GetDepth()));
            }
        }
    }
}
