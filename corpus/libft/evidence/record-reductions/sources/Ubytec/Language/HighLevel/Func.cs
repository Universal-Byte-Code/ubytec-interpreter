using System.Numerics;
using System.Text;
using Ubytec.Language.AST;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Model;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Func : IUbytecContextEntity
    {
        public string Name { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public UType ReturnType { get; }
        public Argument[] Arguments { get; }
        public LocalContext? Locals { get; }
        public SyntaxSentence? Definition { get; }

        public Func(string name, UType returnType, Guid id, Argument[]? arguments = null, LocalContext? locals = null, TypeModifiers modifiers = TypeModifiers.None, SyntaxSentence? definitionSentence = null)
        {
            Name= name;
            ID= id;
            Modifiers= modifiers;
            ReturnType= returnType;
            Arguments= arguments ?? [];
            Locals= locals;
            Definition= definitionSentence;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Function name cannot be null or empty.");

            if ((Modifiers & (TypeModifiers.Const | TypeModifiers.Sealed)) != 0)
                throw new Exception($"Function '{Name}' cannot have modifiers: const or sealed.");

            if ((Modifiers & (TypeModifiers.Public | TypeModifiers.Private | TypeModifiers.Protected |
                              TypeModifiers.Internal | TypeModifiers.Secret)).CountSetBits() > 1)
                throw new Exception($"Function '{Name}' cannot have more than one access modifier.");

            if ((Modifiers & (TypeModifiers.Global | TypeModifiers.Local)).CountSetBits() > 1)
                throw new Exception($"Function '{Name}' cannot be both global and local.");

            if (Modifiers.HasFlag(TypeModifiers.Abstract) && Definition is not null)
                throw new Exception($"Function '{Name}' is abstract and should not have a body.");

            if (!Modifiers.HasFlag(TypeModifiers.Abstract) && Definition is null)
                throw new Exception($"Function '{Name}' must have a definition unless it is abstract.");

            var argumentNames = new HashSet<string>();
            foreach (var arg in Arguments)
            {
                if (!argumentNames.Add(arg.Name))
                    throw new Exception($"Duplicate argument name '{arg.Name}' in function '{Name}'.");
                arg.Validate();
            }

            Locals?.Validate();
        }

        public string Compile(CompilationScopes scopes)
        {
            Validate();
            return Ubytec.Language.Operations.FunctionEmitter.Compile(Name, ID, "func", Arguments, Locals, Definition, ReturnType, scopes);
        }
    }
}
