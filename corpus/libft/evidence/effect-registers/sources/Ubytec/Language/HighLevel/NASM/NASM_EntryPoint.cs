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
                    $"call {Ubytec.Language.Operations.FunctionEmitter.Binding(mainFunc).Label}",
                    scopes.GetDepth(1)
                ));
            if (!string.IsNullOrEmpty(mainFunc.Name) && mainFunc.Arguments.Length != 0)
                throw new Ubytec.Language.Exceptions.SyntaxException(0xBAD074, "Main must have no arguments.");
            sb.Append(FormatCompiledLines(
                !string.IsNullOrEmpty(mainFunc.Name) && mainFunc.ReturnType.Type != Ubytec.Language.Syntax.TypeSystem.Types.PrimitiveType.Void
                    ? "mov rdi, rax" : "xor edi, edi", scopes.GetDepth(1)));
            sb.Append(FormatCompiledLines("mov eax, 60", scopes.GetDepth(1)));
            sb.Append(FormatCompiledLines("syscall", scopes.GetDepth(1)));

        }
    }
}
