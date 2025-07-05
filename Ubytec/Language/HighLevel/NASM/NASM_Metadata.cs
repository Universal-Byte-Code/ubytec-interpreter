using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_Metadata<T> where T : IUbytecHighLevelEntity
    {
        public NASM_Metadata(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullableRequires = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.ID)) ||
                !contextEntity.HasProperty(nameof(Module.Requires)))
                throw new NotImplementedException($"Property ID/Requires missing in {typeof(T).Name}.");

            var tmpId = ((dynamic)contextEntity).ID;
            var tmpRequires = ((dynamic)contextEntity).Requires;

            // always emit header; skip only requires loop if nullableRequires && null
            sb.Append(FormatCompiledLines("; ---------------- Metadata ----------------", scopes.GetDepth()));
            sb.Append(FormatCompiledLines($"; Compilation UTC Time: {DateTime.UtcNow:yyyy-MM-dd HH:mm:ss}Z", scopes.GetDepth()));
            sb.Append(FormatCompiledLines($"; Module UUID: {tmpId}", scopes.GetDepth()));

            if (!(nullableRequires && tmpRequires == null))
            {
                if (tmpRequires is not string[] requires)
                    throw new InvalidCastException($"Requires is not string[] in {typeof(T).Name}.");

                if (requires.Length > 0)
                {
                    sb.Append(FormatCompiledLines("; Requires:", scopes.GetDepth()));
                    foreach (var req in requires)
                        sb.Append(FormatCompiledLines($"; - {req}", scopes.GetDepth()));
                }
            }

            sb.AppendLine();
        }
    }
}
