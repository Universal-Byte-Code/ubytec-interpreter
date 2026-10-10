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

            // Canonical assembly contains semantic metadata only. Build/run provenance
            // (timestamp, compilation UUID, host, hashes) belongs in the sidecar metadata file.
            sb.Append(FormatCompiledLines("; ---------------- Metadata ----------------", scopes.GetDepth()));
            sb.Append(FormatCompiledLines($"; Module Semantic UUID: {tmpId}", scopes.GetDepth()));

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
