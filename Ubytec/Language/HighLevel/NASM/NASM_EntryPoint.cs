using Namotion.Reflection;
using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using static Ubytec.Language.Tools.FormattingHelper;

namespace Ubytec.Language.HighLevel.NASM
{
    public struct NASM_EntryPoint<T> where T : IUbytecHighLevelEntity
    {
        public NASM_EntryPoint(CompilationScopes scopes, StringBuilder sb, T contextEntity, bool nullableFunctions = false)
        {
            sb.AppendLine();
            if (!contextEntity.HasProperty(nameof(Module.Functions))) throw new NotImplementedException($"Property '{nameof(Module.Functions)}' does not exists in type {typeof(T).Name}.");
            var temp = ((dynamic)contextEntity).Functions;
            if (nullableFunctions && temp == null) return;
            if (temp is not Func[] functions) throw new InvalidCastException($"'{nameof(Module.Functions)}' property of type {typeof(T).Name} is not of the correct type.");
            var mainFunc = functions.FirstOrDefault(f => f.Name == "Main");
            sb.Append(FormatCompiledLines("_start:", scopes.GetDepth()));
            if (!string.IsNullOrEmpty(mainFunc.Name) && mainFunc.Definition is not null)
                sb.Append(FormatCompiledLines(
                    $"call {nameof(Func).ToLower()}_{mainFunc.Name}_{mainFunc.ID}_start",
                    scopes.GetDepth(1)
                ));
            sb.Append(FormatCompiledLines("mov eax, 60", scopes.GetDepth(1)));
            sb.Append(FormatCompiledLines("xor edi, edi", scopes.GetDepth(1)));
            sb.Append(FormatCompiledLines("syscall", scopes.GetDepth(1)));

        }
    }
}
