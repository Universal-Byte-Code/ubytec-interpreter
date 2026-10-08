using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.Operations.Interfaces;
using Ubytec.Language.Exceptions;
using Ubytec.Language.HighLevel;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Operations.CoreOperations;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.Operations;

/// <summary>Internal stack ABI: argument cells on stack, result in RAX, callee restores RBP/RSP.</summary>
internal static class FunctionEmitter
{
    internal static CallableBinding Binding(Func function) =>
        new(function.Name, FunctionCode.Label("func", function.Name, function.ID, "start"), function.Arguments.Length, function.ReturnType);
    internal static CallableBinding Binding(Ubytec.Language.HighLevel.Action action) =>
        new(action.Name, FunctionCode.Label("action", action.Name, action.ID, "start"), action.Arguments.Length, new UType(PrimitiveType.Void));

    internal static IEnumerable<IOpCode> Instructions(SyntaxSentence sentence)
    {
        IEnumerable<IOpCode> Visit(SyntaxNode node)
        {
            if (node.Entity is IOpCode op) yield return op;
            foreach (var child in node.Children ?? [])
                foreach (var opCode in Visit(child)) yield return opCode;
        }
        foreach (var node in sentence.Nodes.Reverse())
            foreach (var op in Visit(node)) yield return op;
        foreach (var child in sentence.Sentences)
            foreach (var op in Instructions(child)) yield return op;
    }

    internal static string Compile(string name, Guid id, string kind, Argument[] arguments, LocalContext? locals,
        SyntaxSentence? definition, UType returnType, CompilationScopes scopes)
    {
        if (definition is null) throw new SyntaxException(0xBAD06B, $"'{name}' has no executable body.");
        if (returnType.Type != PrimitiveType.Void && !FunctionCode.IsCellType(returnType))
            throw new SyntaxException(0xBAD06C, $"Return type {returnType} is not supported by the cell ABI.");
        var frame = new ScopeContext
        {
            StartLabel = FunctionCode.Label(kind, name, id, "start"),
            EndLabel = FunctionCode.Label(kind, name, id, "end"),
            DeclaredByKeyword = kind,
            ExpectedReturnType = returnType,
            ArgumentCount = arguments.Length
        };
        frame.Callables.Add(name, new(name, frame.StartLabel, arguments.Length, returnType));
        void Add(StackBinding binding)
        {
            if (!FunctionCode.IsCellType(binding.Type))
                throw new SyntaxException(0xBAD06E, $"Unsupported frame type for '{binding.Name}': {binding.Type}.");
            if (!frame.Symbols.TryAdd(binding.Name, binding))
                throw new SyntaxException(0xBAD06F, $"Duplicate frame symbol '{binding.Name}'.");
        }
        for (int i = 0; i < arguments.Length; i++)
        {
            var arg = arguments[i];
            Add(new(arg.Name, arg.Type, 16 + (arguments.Length - 1 - i) * 8,
                arg.Modifiers.HasFlag(TypeModifiers.ReadOnly)));
        }
        int slots = 0;
        foreach (var local in locals?.Variables ?? [])
            Add(new(local.Name, local.Type, -8 * ++slots,
                local.Modifiers.HasFlag(TypeModifiers.ReadOnly) || local.Modifiers.HasFlag(TypeModifiers.Const)));
        foreach (VAR op in Instructions(definition).OfType<VAR>())
            Add(new(op.Variable.Name, op.Variable.Type, -8 * ++slots,
                op.Variable.Type.Modifiers.HasFlag(TypeModifiers.ReadOnly) || op.Variable.Type.Modifiers.HasFlag(TypeModifiers.Const)));
        foreach (var selection in Instructions(definition).OfType<SWITCH>()) frame.SwitchSlots.Enqueue(-8 * ++slots);
        frame.FrameSize = (slots * 8 + 15) & ~15;

        foreach (var nested in locals?.Functions ?? []) frame.Callables.Add(nested.Name, Binding(nested));
        foreach (var nested in locals?.Actions ?? []) frame.Callables.Add(nested.Name, Binding(nested));

        int originalCount = scopes.Count;
        scopes.Push(frame);
        try
        {
            FunctionStackValidator.Validate(definition, scopes, returnType);
            var valueIR = scopes.OptimizeLoopReductions || scopes.OptimizeBlockReductions || scopes.OptimizeFrameRegisters
                ? Ubytec.Language.Tools.Optimization.FunctionValueIR.Lower(definition) : null;
            var reduction = scopes.OptimizeLoopReductions || scopes.OptimizeBlockReductions
                ? Ubytec.Language.Tools.Optimization.ByteReductionPlan.TryCreate(valueIR!, frame, arguments, locals, returnType)
                : null;
            bool registers = reduction is null && scopes.OptimizeFrameRegisters &&
                Ubytec.Language.Tools.Optimization.FrameRegisterPlan.Apply(
                    valueIR!, frame,
                    new HashSet<string>(arguments.Select(a => a.Name).Concat(
                        (locals?.Variables ?? []).Select(v => v.Name)), StringComparer.Ordinal));
            var output = new StringBuilder();
            output.AppendLine(frame.StartLabel + ":");
            output.AppendLine("push rbp\n  mov rbp, rsp");
            if (frame.FrameSize != 0) output.AppendLine($"sub rsp, {frame.FrameSize}");
            foreach (var local in locals?.Variables ?? [])
            {
                long initial = FunctionCode.InitialValue(local.Type, local.Value);
                output.AppendLine($"mov rax, 0x{unchecked((ulong)initial):X16}\n  mov qword {frame.Symbols[local.Name].Address}, rax");
            }
            if (registers)
            {
                output.AppendLine("; frame-registers: write-through leaf values");
                foreach (var binding in frame.Symbols.Values.Where(b => b.Register is not null))
                    output.AppendLine($"mov {binding.Register}, qword {binding.Address}");
            }
            // Compile the reference body even when replacing it: its scope/type/readonly
            // validation and return tracking must run with exactly the original rules.
            string body = ASTCompiler.CompileAST(new SyntaxTree(definition), scopes);
            output.Append(reduction is null ? body : scopes.OptimizeBlockReductions
                ? Ubytec.Language.Tools.Optimization.BlockByteReductionPlan.Emit(reduction, frame)
                : reduction.Emit(frame));
            if (scopes.Count != originalCount + 1)
                throw new SyntaxException(0xBAD070, $"Unbalanced block scopes in '{name}'.");
            if (returnType.Type == PrimitiveType.Void) output.AppendLine("xor eax, eax");
            output.AppendLine(frame.EndLabel + ":\n  mov rsp, rbp\n  pop rbp\n  ret");
            // Nested definitions sit after RET; executing the parent cannot fall into them.
            foreach (var nested in locals?.Functions ?? []) output.AppendLine(nested.Compile(scopes));
            foreach (var nested in locals?.Actions ?? []) output.AppendLine(nested.Compile(scopes));
            return output.ToString();
        }
        finally
        {
            while (scopes.Count > originalCount) scopes.Pop();
        }
    }
}
