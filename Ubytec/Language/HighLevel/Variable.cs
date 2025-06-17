using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.TypeSystem;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    /// <summary>
    /// Represents a high-level language variable, encapsulating its name, type,
    /// modifiers, optional initial value, and unique identifier.
    /// 
    /// <example>
    /// <code language="csharp">
    /// // Create a simple integer variable:
    /// var variable = new Variable(
    ///     name: "counter",
    ///     type: UType.Int,
    ///     id: Guid.NewGuid(),
    ///     modifiers: TypeModifiers.None,
    ///     value: valueToken.Source
    /// );
    /// 
    /// // Validate and compile to assembly directive:
    /// variable.Validate();
    /// string asm = variable.Compile(new CompilationScopes());
    /// </code>
    /// </example>
    /// </summary>
    
    public readonly struct Variable : IUbytecHighLevelEntity
    {
        /// <summary>
        /// Gets the name of the variable.
        /// </summary>
        public string Name { get; }

        /// <summary>
        /// Gets the <see cref="UType"/> of the variable.
        /// </summary>
        public UType Type { get; }

        /// <summary>
        /// Gets the <see cref="TypeModifiers"/> applied to the variable.
        /// </summary>
        public TypeModifiers Modifiers { get; }

        /// <summary>
        /// Gets the initial value of the variable, or <c>null</c> if none is set.
        /// </summary>
        public object? Value { get; }

        /// <summary>
        /// Gets the unique identifier for this variable instance.
        /// </summary>
        public Guid ID { get; }

        /// <summary>
        /// Initializes a new instance of the <see cref="Variable"/> struct.
        /// </summary>
        /// <param name="name">The variable’s name. Must be non-null and non-empty.</param>
        /// <param name="type">The <see cref="UType"/> of the variable.</param>
        /// <param name="id">A unique <see cref="Guid"/> identifying this variable.</param>
        /// <param name="modifiers">
        /// Optional <see cref="TypeModifiers"/> flags. Only storage-related modifiers
        /// (e.g. <c>Const</c>, <c>ReadOnly</c>) are allowed.
        /// </param>
        /// <param name="value">
        /// Optional initial value. Must be non-null if <see cref="TypeModifiers.Const"/> is specified.
        /// </param>
        /// <exception cref="Exception">
        /// Thrown if the name is null/empty, invalid modifiers are present,
        /// both <c>Const</c> and <c>ReadOnly</c> are set, or a const variable has no value.
        /// </exception>
        public Variable(string name, UType type, Guid id, TypeModifiers modifiers = TypeModifiers.None, object? value = null)
        {
            Name = name;
            Type = type;
            Modifiers = modifiers;
            Value = value;
            ID = id;

            Validate();
        }

        /// <summary>
        /// Validates the variable’s configuration, ensuring:
        /// <list type="bullet">
        ///   <item>Name is not null or whitespace.</item>
        ///   <item>No invalid modifiers (visibility, abstract, override, etc.) are set.</item>
        ///   <item>At most one of <c>Const</c> or <c>ReadOnly</c> is specified.</item>
        ///   <item>Const variables have a non-null <see cref="Value"/>.</item>
        /// </list>
        /// </summary>
        /// <exception cref="Exception">
        /// Thrown if any of the above validation rules are violated.
        /// </exception>
        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Variable name cannot be null or empty.");

            const TypeModifiers invalidModifiers =
                TypeModifiers.Public |
                TypeModifiers.Private |
                TypeModifiers.Protected |
                TypeModifiers.Internal |
                TypeModifiers.Secret |
                TypeModifiers.Abstract |
                TypeModifiers.Virtual |
                TypeModifiers.Override |
                TypeModifiers.Sealed |
                TypeModifiers.Global |
                TypeModifiers.Local;

            if ((Modifiers & invalidModifiers) != 0)
                throw new Exception($"Variable '{Name}' has invalid modifiers: {Modifiers & invalidModifiers}");

            if ((Modifiers & (TypeModifiers.Const | TypeModifiers.ReadOnly)).CountSetBits() > 1)
                throw new Exception($"Variable '{Name}' cannot be both const and readonly.");

            if (Modifiers.HasFlag(TypeModifiers.Const) && Value is null)
                throw new Exception($"Const variable '{Name}' must have an assigned value.");
        }

        /// <summary>
        /// Compiles the variable declaration into a low-level assembly reference code snippet.
        /// </summary>
        /// <param name="scopes">
        /// The <see cref="CompilationScopes"/> providing context for label generation.
        /// </param>
        /// <returns>
        /// An assembly directive string that defines a constant label for the variable’s stack offset.
        /// </returns>
        public string Compile(CompilationScopes scopes)
        {
            // Define a constant for this variable's stack offset.
            // Actual stack space is allocated once in LocalContext prologue.
            var offsetLabel = $"var_{Name}_{ID}_offset";
            return $"    {offsetLabel} equ rsp  ; reference for variable {Name}";
        }
    }
}
