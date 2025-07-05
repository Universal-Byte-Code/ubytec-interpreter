using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_FunctionsAndActions<T> where T : IUbytecHighLevelEntity
    {
        public NASM_FunctionsAndActions(CompilationScopes scopes, StringBuilder sb, T contextEntity, bool nullableFunctions = false, bool nullableActions = false)
        {
            if (!contextEntity.HasProperty(nameof(Module.Functions))) throw new NotImplementedException($"Property {nameof(Module.Functions)} does not exists in type {typeof(T).Name}.");
            var tempFuncs = ((dynamic)contextEntity).Functions;
            if (!(nullableFunctions && tempFuncs == null))
            {
                if (tempFuncs is not Func[] functions) throw new InvalidCastException($"'{nameof(Module.Functions)}' property of type {typeof(T).Name} is not of the correct type.");

                foreach (var fn in functions)
                    sb.Append(FormatCompiledLines(fn.Compile(scopes), scopes.GetDepth()));
            }

            if (!contextEntity.HasProperty(nameof(Module.Actions))) throw new NotImplementedException($"Property {nameof(Module.Actions)} does not exists in type {typeof(T).Name}.");
            var tempActions = ((dynamic)contextEntity).Actions;
            if (!(nullableActions && tempActions == null))
            {
                if (tempActions is not Action[] actions) throw new InvalidCastException($"'{nameof(Module.Actions)}' property of type {typeof(T).Name} is not of the correct type.");

                foreach (var ac in actions)
                    sb.Append(FormatCompiledLines(ac.Compile(scopes), scopes.GetDepth()));
            }
        }
    }
}
