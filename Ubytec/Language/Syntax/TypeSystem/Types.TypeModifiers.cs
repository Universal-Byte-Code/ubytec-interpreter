using System;

namespace Ubytec.Language.Syntax.TypeSystem
{
    public static partial class Types
    {
        /// <summary>
        /// Flags to modify the behavior and metadata of <see cref="UType"/> instances.
        /// </summary>
        /// <remarks>
        /// These modifiers control nullability, array semantics, access levels,
        /// mutability, and other compile-time behaviors for types in the Ubytec language.
        /// </remarks>
        [Flags]
        public enum TypeModifiers : int
        {
            /// <summary>No modifiers applied.</summary>
            None = 0,

            // Nullable / Array
            /// <summary>Type is nullable (e.g., <c>Type?</c>).</summary>
            Nullable = 1 << 0,
            /// <summary>Type is an array (e.g., <c>[Type]</c>).</summary>
            IsArray = 1 << 1,

            /// <summary>Array itself is nullable (e.g., <c>[Type]?</c>).</summary>
            NullableArray = 1 << 2,
            /// <summary>Array items are nullable (e.g., <c>[Type?]</c>).</summary>
            NullableItems = 1 << 3,

            // Access modifiers
            /// <summary>Public visibility.</summary>
            Public = 1 << 4,
            /// <summary>Private visibility.</summary>
            Private = 1 << 5,
            /// <summary>Protected visibility.</summary>
            Protected = 1 << 6,
            /// <summary>Internal visibility.</summary>
            Internal = 1 << 7,
            /// <summary>Secret or restricted visibility.</summary>
            Secret = 1 << 8,

            // Mutability
            /// <summary>Constant: value must be known at compile-time and cannot change.</summary>
            Const = 1 << 9,
            /// <summary>Read-only: value is initialized once and cannot be reassigned.</summary>
            ReadOnly = 1 << 10,

            // Behavior
            /// <summary>Abstract: type or member cannot be instantiated directly.</summary>
            Abstract = 1 << 11,
            /// <summary>Virtual: member can be overridden in derived types.</summary>
            Virtual = 1 << 12,
            /// <summary>Override: member overrides a base class implementation.</summary>
            Override = 1 << 13,
            /// <summary>Sealed: prevents further overrides of a member.</summary>
            Sealed = 1 << 14,

            // Scope
            /// <summary>Local scope: valid only within the declaring block.</summary>
            Local = 1 << 15,
            /// <summary>Global scope: valid across the entire program.</summary>
            Global = 1 << 16,

            // Reserved for future use
            /// <summary>Reserved bit for future modifiers.</summary>
            Reserved = 1 << 17
        }
    }
}
