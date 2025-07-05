using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Syntax.TypeSystem.Types;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_Exports<T> where T : IUbytecHighLevelEntity
    {
        public NASM_Exports(
            CompilationScopes scopes,
            StringBuilder sb,
            T contextEntity,
            bool nullableFunctions = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.Functions)))
                throw new NotImplementedException($"Property Functions missing in {typeof(T).Name}.");

            var tmpFuncs = ((dynamic)contextEntity).Functions;

            if (!(nullableFunctions && tmpFuncs == null))
            {
                if (tmpFuncs is not Func[] funcs)
                    throw new InvalidCastException($"Functions is not Func[] in {typeof(T).Name}.");

                foreach (var fn in funcs.Where(f => f.Modifiers.HasFlag(TypeModifiers.Global)))
                    sb.Append(FormatCompiledLines($"global func_{fn.Name}_{fn.ID}_start", scopes.GetDepth()));
            }

            sb.AppendLine();
        }
    }
}
