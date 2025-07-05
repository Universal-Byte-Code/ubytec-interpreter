using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_Data<T> where T : IUbytecHighLevelEntity
    {
        public NASM_Data(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullableFields = false,
            bool nullableGlobalContext = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.Fields)) ||
                !contextEntity.HasProperty(nameof(Module.GlobalContext)))
                throw new NotImplementedException($"Property Fields/GlobalContext missing in {typeof(T).Name}.");

            var tmpFields = ((dynamic)contextEntity).Fields;
            if (!(nullableFields && tmpFields == null))
            {
                if (tmpFields is not Field[] fields)
                    throw new InvalidCastException($"Fields is not Field[] in {typeof(T).Name}.");

                sb.Append(FormatCompiledLines("section .data", scopes.GetDepth()));
                foreach (var fld in fields)
                    sb.Append(FormatCompiledLines(fld.Compile(scopes), scopes.GetDepth()));
            }

            var tmpGC = ((dynamic)contextEntity).GlobalContext;
            if (!(nullableGlobalContext && tmpGC == null))
            {
                if (tmpGC is not GlobalContext gc)
                    throw new InvalidCastException($"GlobalContext is not of type '{nameof(GlobalContext)}' in {typeof(T).Name}.");

                if (!tmpFields is Field[]) // ensure section header only once
                    sb.Append(FormatCompiledLines("section .data", scopes.GetDepth()));
                sb.Append(FormatCompiledLines(gc.Compile(scopes), scopes.GetDepth()));
            }

            sb.AppendLine();
        }
    }
}
