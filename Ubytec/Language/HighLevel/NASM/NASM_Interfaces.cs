using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_Interfaces<T> where T : IUbytecHighLevelEntity
    {
        public NASM_Interfaces(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullableInterfaces = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.Interfaces)))
                throw new NotImplementedException($"Property Interfaces missing in {typeof(T).Name}.");

            var tmpIfaces = ((dynamic)contextEntity).Interfaces;
            if (!(nullableInterfaces && tmpIfaces == null))
            {
                if (tmpIfaces is not Interface[] ifaces)
                    throw new InvalidCastException($"Interfaces is not Interface[] in {typeof(T).Name}.");

                foreach (var iface in ifaces)
                    sb.Append(FormatCompiledLines(iface.Compile(scopes), scopes.GetDepth()));
            }
        }
    }
}
