using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_BSS<T> where T : IUbytecHighLevelEntity
    {
        public NASM_BSS(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullableProperties = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.Properties)))
                throw new NotImplementedException($"Property Properties missing in {typeof(T).Name}.");

            var tmpProps = ((dynamic)contextEntity).Properties;
            sb.Append(FormatCompiledLines("section .bss", scopes.GetDepth()));
            if (!(nullableProperties && tmpProps == null))
            {
                if (tmpProps is not Property[] props)
                    throw new InvalidCastException($"Properties is not Property[] in {typeof(T).Name}.");

                foreach (var p in props)
                    sb.Append(FormatCompiledLines(p.Compile(scopes), scopes.GetDepth()));
            }
            sb.AppendLine();
        }
    }
}
