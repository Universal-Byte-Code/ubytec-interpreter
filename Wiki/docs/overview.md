# Ubytec Language Overview

Ubytec is a structured, statically-typed language that compiles to a low-level bytecode (and currently to x86-64 assembly). It combines high-level constructs (modules, types, functions) with a stack-based instruction set. This overview describes the syntax, grammar, semantics, opcodes, and type rules as **implemented in the current codebase**. Features present in the grammar or schema but not fully functional in the interpreter are marked as *WIP* (work in progress) or planned for future support.

## Module Structure

**Modules** are the top-level compilation units. A source file generally defines a single module using the `module` keyword. Modules can be nested (sub-modules declared inside a parent module). The module declaration includes a header with metadata and required dependencies. The syntax is:

```ubytec
[global] module(name: "ModuleName", version: "x.y", author: "AuthorName"[, requires: ["Dep1", "Dep2", ...]]) { ... }
```

* The `global` modifier on a module is optional and only this modifier is allowed at module level. (If present, it may designate an entry-point or special visibility, though currently it has no effect beyond passing validation.)
* **Header arguments** inside `(...)` provide the module’s **name**, **version**, **author**, and an optional **requires** list of other module names. The `requires` field is a comma-separated list within square brackets. All header keys are required except `requires`.
* The module’s body is enclosed in `{ }`. Inside, you can declare types, functions, and even nested sub-modules. Specifically, a module may contain:

  * Type definitions: classes, structs, records, interfaces, enums.
  * Function and action definitions (similar to free functions).
  * Field and property declarations (module-level variables).
  * At most one each of a **global context** and **local context** block (see below).
  * Nested `module` declarations for sub-modules.

For example:

```ubytec
module(name: "Example", version: "0.1", author: "A.User", requires: ["LibX"]) {
    global { 
        field t_int32 GlobalCounter 0      // global variable
        func InitGlobals() { ... }
    }
    // Module-level function
    func Main() -> t_int32 {
        // Function body...
        return
    }
    // Nested type
    class Helper { ... }
}
```

In the above, `GlobalCounter` is a module-global field initialized to 0, and `Main` is the entry function. **Main Function:** If a module defines a function named `Main`, the compiled program will treat it as the entry point. At runtime, `_start` will call `Main` and then exit. (Currently, the return value of `Main` is not propagated to the process exit code – the program always exits with 0, which is a planned improvement.)

## Global and Local Context Blocks

Ubytec provides **context blocks** to define groups of declarations with specific storage duration or linkage:

* **Global Context (`global { ... }`):** Inside a module or a type, a `global {}` block defines *static* members – data or functions associated with the module/type rather than instances. For a module, this is a place to declare truly global data or initialization functions. For a class or struct, the global context contains static fields, properties, or functions belonging to the class (like static members). Only one `global` block is allowed per module or per type. In the parser, only fields, properties, functions, and actions are allowed inside a `global` block. Example:

  ```ubytec
  class Config {
      global {
          field t_char8 Delimiter ','      // static field
          func LoadDefaults() { ... }      // static method
      }
      // ... instance members ...
  }
  ```

  In code generation, global-context fields are placed in the data segment and properties in BSS (zero-initialized) segment, and global-context functions are output in the text segment.

* **Local Context (`local { ... }`):** A `local {}` block defines local (automatic) variables or inner functions that exist per instance or scope. At most one local block is allowed per module or type. In a module, a `local` block might hold state that is allocated at program startup and freed on exit (though currently it behaves similarly to a function’s local frame). In classes/structs, a `local` block can declare instance-specific helper variables or inner functions. The parser allows only variable declarations (`<type> name ...`), inner `func`, and `action` definitions inside a local block. Example:

  ```ubytec
  module(name:"M", version:"1.0", author:"X") {
      local {
          t_int32 tempBufferSize 1024
          func helper() { ... }
      }
      // ... 
  }
  ```

  In code generation, a `local` context causes allocation on the stack at runtime for its variables: when the local context is entered, space for all declared variables is reserved on the stack (by decrementing RSP). The variables are referenced at fixed offsets from the stack frame. Any `func` or `action` inside the local block is treated as an inner function that can use these variables (though closures of this form are not fully implemented, they are parsed and compiled as nested functions). The local context ends by restoring the stack pointer (in current output, the stack is not explicitly restored until function exit or program end, which is an area to be refined – *WIP*).

> **Note:** The `global` and `local` **modifiers** can also appear before individual member declarations (e.g. `global field x` or `local func f`). In the current implementation, such modifiers are parsed and stored but have the same effect as placing the member in the corresponding context block. For example, a `global` field in a class is effectively static. However, using explicit context blocks is recommended for clarity. The interpreter’s validation ensures you do not combine `Global` and `Local` flags on the same member.

## Type Definitions

Ubytec supports several kinds of user-defined types: **classes**, **structs**, **records**, **interfaces**, and **enums**. All types can be nested within modules or other types (except interfaces cannot contain nested type definitions).

### Classes

A `class` defines a reference type with support for inheritance-related modifiers (though inheritance of classes is not implemented yet, these modifiers are parsed for future use). Class syntax:

```ubytec
[modifiers] class ClassName {
    [local { ... }]
    [global { ... }]
    members...
}
```

* Classes can include an optional leading `local {}` or `global {}` block (but **not both** in the current parser – if both appear, only the first is recognized). A local block here might define per-instance helper data (though instance fields can also just be declared as normal fields), and a global block defines static members.

* **Class Members:** Inside the class body (after any initial context block), you can declare:

  * Fields (`field` declarations) – instance fields by default.
  * Properties (typed variables with optional get/set accessors).
  * Methods (`func` functions) – instance methods.
  * Actions (`action` functions) – instance routines with no return value.
  * Nested types: classes, structs, records, interfaces, enums (classes can be nested arbitrarily).
  * Interfaces (if any) – though embedding an interface inside a class is parsed, it is unusual. (Interfaces inside classes are allowed by grammar as nested types.)

  The parser in `ParseClass` iterates over tokens and dispatches to the appropriate parse routine based on keywords. For example, `field` introduces a field, a recognized type name introduces a property, `func` a method, etc.

* **Modifiers:** Classes and class members support a range of modifiers:

  * Access control: `public`, `private`, `protected`, `internal`, `secret`. At most one access modifier can be applied. By default (no modifier), class and members are internal to the module.
  * Inheritance: `abstract`, `virtual`, `override`, `sealed`. These are parsed and validated for consistency (e.g. an abstract class cannot be marked sealed, an override method must be in an abstract class etc.), but actual base class inheritance is not yet implemented (*WIP*). In practice, you can declare an abstract class with abstract methods (which must have no body) and the compiler will enforce that the class cannot be `sealed` and that non-abstract members in an abstract class are marked `virtual`. However, since there is no mechanism to derive classes yet, these serve mainly as placeholders for future extension.
  * Storage: `global` (static) or `local` can mark a class or member as described earlier. A class cannot be both global and local. A member cannot have both modifiers simultaneously.
  * Other: `const` and `readonly` can apply to fields (with the same meaning as in C# – a `const` is a compile-time constant, and a `readonly` field can only be assigned once). A field cannot be both const and readonly. If a field is `const`, it must have an initializer (the current compiler doesn’t explicitly check this, but it will error at compile time if no value is provided). Classes themselves cannot be const or readonly (invalid).

* **Example:**

  ```ubytec
  public class Player {
      field t_int32 id            // an instance field
      field readonly t_int32 maxScore 100
      property t_char8 grade {    // property with custom getter
          func get { 
              // returns grade based on maxScore
              if maxScore >= 100 -> t_char8 {
                  return 'A'
              }
              return 'B'
          }
      }
      func ResetScore() {
          this.maxScore = 0  // (assignment WIP – see notes)
      }
  }
  ```

  In this example, `Player` is a public class. It has an `id` field, a readonly field `maxScore` initialized to 100, and a property `grade` with a custom `get` accessor (no `set` or `init`, so it's read-only). The `ResetScore` method attempts to reset `maxScore` – however, because `maxScore` is readonly, this would be disallowed (the compiler would throw an error if it tried to assign it outside of a constructor or initialization, which currently would appear as a runtime `Exception` from validation logic).

> **Note on Assignment (WIP):** The example above highlights that direct assignment to variables in code (e.g., `this.maxScore = 0`) is not fully implemented. The Ubytec interpreter does parse the `=` operator as an assignment, but storing new values to variables at runtime currently requires using the low-level `STORE` opcode (which is defined but not yet functional in code). As of now, modifying a variable after declaration is limited – this is a planned feature. In practice, one would use field initializers or compute values within expressions until assignment statements are supported.

### Structs

A `struct` is similar to a class but represents a value type. Structs are declared with the `struct` keyword and share much of the class syntax:

```ubytec
[modifiers] struct StructName {
    [local { ... }]
    [global { ... }]
    members...
}
```

* Structs can contain **fields, properties, funcs, actions** (but not other struct/class/record types in the current parser – any attempt to declare a nested type inside a struct is skipped or error, as nested types are not explicitly allowed in structs). They also may have at most one `local` and/or one `global` block (the parser will accept one of each in any order at the start of the struct body).
* Structs do **not** allow the declaration of a constructor method explicitly (there is no special constructor syntax in Ubytec yet).
* Inheritance-related modifiers (`abstract`, etc.) are not applicable to structs (they would be flagged as invalid if used).
* The default behavior of a struct is to be allocated on the stack (when used as a local) or in-line inside other structures. However, since the runtime is still stack-machine oriented, the distinction between value type and reference type is not strongly enforced beyond not supporting inheritance. You should treat structs as intended for small plain-old-data. (Copy semantics, etc., are not explicitly implemented yet.)
* **Example:**

  ```ubytec
  struct Point {
      t_int32 x
      t_int32 y
      func magnitudeSquared() -> t_int32 {
          return x*x + y*y
      }
  }
  ```

  This struct `Point` has two fields and a method. A struct can be instantiated by value (for example, as a local variable), but Ubytec has no `new` operator – a variable of struct type can be declared and its fields set directly (though again, direct assignment is limited).

### Records

A `record` is a special kind of class designed for immutable data containers (like a tuple or a data-transfer object). Records in Ubytec allow a **positional parameter list** that generates auto-properties. Syntax:

```ubytec
[modifiers] [type] record RecordName( Type1 name1, Type2 name2, ... ) {
    [local { ... }]
    [global { ... }]
    // additional properties, funcs, actions (no fields allowed)
}
```

* You can optionally prefix a record with the `type` keyword (e.g. `type record R(...)`) when defining it at the module level. This is accepted by the parser as a “module-level alias” marker, but currently it has no semantic effect. It’s essentially ignored during parsing.

* **Positional parameters:** The constructor-like parameter list after the record name declares a set of *positional properties*. For each `(Type Name)` in the list, the record will automatically include a public property of that type with that name. These are analogous to primary constructor parameters or auto-implemented properties. They are by default read-only (since no setter is provided) and cannot be fields (records do not allow explicit fields). For each such parameter, a `Property` is created internally with an empty AccessorContext (meaning it has an implicit getter).

* A record may have an optional body in `{ }`. If present, the body **cannot contain `field` declarations** – any attempt to put `field` inside a record will cause a compile exception. The body can contain:

  * Additional properties (explicitly declared property blocks).
  * Functions (`func`) and actions.
  * At most one `local` and/or `global` context (similar to classes/structs).

  These additional properties in the body are often called *non-positional* or “extra” properties. They might be used for derived values or other data that wasn’t captured positionally.

* **Immutability:** Ubytec doesn’t enforce immutability of records at runtime yet, but by convention records should be used with either only getters or no methods that mutate state. The parser explicitly prohibits fields in records to encourage use of properties (which at least require deliberate accessor code to mutate).

* **Example:**

  ```ubytec
  record Pair(t_int32 A, t_int32 B) {
      // A and B are auto-properties (read-only by default)
      func sum() -> t_int32 {
          return A + B
      }
  }
  ```

  Here `Pair` is a record with positional properties `A` and `B`. It also has a method `sum`. There is no explicit constructor; to instantiate a record, you would typically declare it as a literal if that becomes supported, or simply treat it as a value container (since records don’t have identity or behaviors beyond carrying data).

* Records are meant to be compared by value (in the future, equality might be defined in terms of property values). The compiler currently flags if all enum member values in an enum are powers of two (bit-field), but for records there is no special handling yet.

*(Planned:)* In the future, records may get additional generated methods (like `ToString`, `Equals`) and allow a concise construction syntax. For now, they behave as plain classes with restrictions.

### Interfaces

Interfaces in Ubytec declare abstract method signatures and properties without implementation. Syntax:

```ubytec
[modifiers] interface InterfaceName {
    // property signatures (Type Name;)
    // method signatures (func Name(...)[-> ReturnType];)
    // action signatures (action Name(...);)
}
```

* Interface members can only be **properties** or **function/action signatures**. They **cannot** include any `field` declarations or nested type definitions. If the parser encounters `field` or a type keyword inside an `interface`, it will throw an error.
* A property in an interface is written the same way as in a class except with no body. For example: `t_int32 Size;` would declare a property `Size` of type `int32` with no implementation. The Ubytec parser actually treats any bare type token followed by an identifier in an interface as a property declaration.
* Functions in interfaces are declared with the `func` keyword and a signature, but **no body** (not even an empty `{}`). The parser enforces that interface methods have `Definition is null` (no body). Syntactically, you write `func Name(params...)[-> ReturnType];` – in practice, the parser will accept a function header and then require that the next token is not a `{` but a terminator (which can be implicit end of block or a semicolon).
* Actions in interfaces are similar: declared with `action Name(params...);` and no body.
* Modifiers: Interfaces can have access modifiers (public, etc.) and also the `global` or `local` modifier (though global/local on an interface is not particularly meaningful – if used, it’s validated but doesn’t change behavior). Other modifiers like abstract/virtual are redundant for interfaces (all interface members are implicitly abstract). The compiler will reject an interface marked `sealed`, `override`, etc., as invalid.
* Interfaces cannot have `global` or `local` context blocks inside them (if attempted, it would be seen as an unknown token and likely error).
* **Example:**

  ```ubytec
  interface IReadable {
      func Read() -> t_int32;
      property t_int32 Position;
  }
  ```

  This interface declares a method `Read()` and a property `Position`. Any class implementing `IReadable` (Ubytec doesn’t have an `implements` syntax yet, but presumably a future version would allow class declarations to state they implement interfaces) would need to provide a `func Read { ... }` and a `property t_int32 Position { get; set; }` (or at least a getter) to satisfy the interface. Currently, interface usage is limited since there is no mechanism to enforce implementation or to use an interface as a type constraint – these are planned features.

### Enums

An `enum` defines a set of named constant values. Syntax:

```ubytec
[modifiers] enum EnumName [:: UnderlyingType] {
    Name1 [= const_expr],
    Name2 [= const_expr],
    ...
}
```

* You can specify an underlying integral type after a `::`. If omitted, the default underlying type is `t_byte` (8-bit unsigned). The underlying type must be one of the built-in integer types (e.g., `t_int32`, `t_uint16`, etc.). In the parse, if an underlying type is provided, the first token after `::` is consumed as a type and the primitive part is used as the underlying type.

* The enum members are listed within `{ }`. Each member is a name with an optional `= value`. If a value is not provided, it will be auto-assigned. Auto-assignment starts from 0 for the first member and increments by 1 for each subsequent member that doesn’t have an explicit value. If a member has an explicit value, subsequent auto-values continue from that value + 1. The parser uses a `long` (`autoVal`) to track the next implicit value.

* The value expressions in enums can be decimal, hex (`0x`), or binary (`0b`) numeric literals. They are parsed as constants at compile time (no references to other constants are allowed, just literal numbers). If a literal is out of range for a 64-bit signed, it might overflow the `long` (the implementation currently doesn’t guard overflow explicitly).

* A trailing comma after the last enum member is allowed (the parser will simply skip over a comma if it finds one before the closing `}`).

* After parsing the members, the compiler performs a check: if every member’s value is either 0 or a power of two, it marks the enum as a *bit flag* enum (a flag that it’s a bitfield). This is stored as a boolean `isBitField` on the Enum object. This can be used by tools or future semantic checks to allow bitwise combination of enum values. (If any value is not a power of two (and not zero), `isBitField` will be false.)

* Enums cannot include methods or other members – only the value list. Any attempt to put a function or other declaration inside the enum would result in a parser error or be ignored.

* **Example:**

  ```ubytec
  enum Color :: t_uint16 {
      Red = 1,
      Green = 2,
      Blue = 4,
      White
  }
  ```

  Here `Color` is an enum with underlying type `uint16`. We explicitly set Red=1, Green=2, Blue=4. The member `White` has no explicit value, so it gets auto-assigned to 5 (the last explicit value + 1). Since not all values are powers of two (White=5 is not), this enum would **not** be flagged as a bitfield (`isBitField` would be false). If White had been 8 instead, all values 1,2,4,8 are powers of two (plus 0 implicitly if not used) and `isBitField` would be true.

* Modifiers: Enums can have access modifiers (public, etc.). They cannot be `abstract`, `sealed`, or have `local/global` (those don’t make sense for enums). The parser will error if illegal modifiers are present. Const/readonly have no meaning on an enum either (each member is implicitly const).

* At runtime, an enum is essentially a primitive value of the underlying type. There is currently no enforcement of using an enum type in place of an integer; however, in the AST each enum member is represented as a pair of name and `long` value and the enum itself as a distinct type category. Future versions may introduce type-checking to prevent mixing enums and ints without casts.

## Variables and Properties

### Fields (Variables)

**Fields** are named variables that can be defined at module scope, in classes/structs (instance or static), or in global contexts. They are declared with the `field` keyword, a type, and a name, plus an optional initializer. For example: `field t_int32 count 5`.

* A field declared at module level or in a class with no `global` modifier is an instance field (for classes/structs) or a module variable.
* Fields in a `global {}` block or with the `global` modifier are static (there is a single storage for the field, not tied to an instance).
* The syntax is always `field <Type> <Name> [initial_value]`. The initial value is optional; if omitted, the field’s value defaults to 0 / false / null depending on type. If provided, it must be a constant expression (literal) because it’s assigned at compile time.
* **Type notation:** All types in Ubytec source are prefixed with `t_` for built-in primitives. For example `t_int32` for a 32-bit int, `t_bool` for boolean, `t_float64` for a double precision float. (User-defined class/struct names and enum names are used as-is without prefix.) The `field` parser consumes a token with scope `storage.type.*`. This means the type can also include nullability/array annotations (see Type System below).
* **Initializers:** If the initializer is present, the parser captures it as a token (it doesn’t evaluate expressions here – only simple constants are allowed). The field is then stored in the AST with an initial value string if provided. At code generation, if a field has an initializer:

  * For numeric or boolean values, the value is embedded in the data section.
  * For a string literal, the compiler emits the string bytes and a null terminator in the data section.
  * If no initializer, the field is allocated in BSS (zero-initialized memory) if it’s a property or left as 0 in data for a field.

  In the output assembly, a field named `X` gets a label like `X_guid: dq 5` (for a 64-bit value initialized to 5, as an example) or appropriate data size directive based on type. For example, a `t_int32` field initialized to 10 would compile to `fieldName_guid: dd 10`. The compiler picks `db`, `dw`, `dd`, or `dq` for 8-bit, 16-bit, 32-bit, or 64-bit storage respectively. Larger types (like 128-bit) are stored as multiple `dq` entries. A string initializer `"Hello"` would produce `fieldName_guid: db "Hello", 0`.
* **Const fields:** If a field is marked `const`, it must have an initializer, and that field’s value is considered a compile-time constant. The compiler will replace references to that field with the constant value (this is not fully implemented yet, but conceptually). `const` fields are placed in the data section like normal fields (they are not stored in read-only section specifically, though that could be a future enhancement). Note that currently there’s no separate syntax for constants; you just use `const` modifier on a field.
* **Readonly fields:** Marking a field `readonly` means it should only be assigned in an initializer or constructor. The compiler enforces that by raising an exception if a `readonly` is assigned outside of those contexts (since constructors aren’t explicitly supported yet, effectively any attempt to assign to a readonly field after definition would be invalid). This is partially enforced in the Validate logic for Field (no direct enforcement yet beyond disallowing conflicting const+readonly).
* **Memory layout:** All fields in the same module or type are stored sequentially in memory (in the order declared). The exact layout in memory is handled by the assembler; Ubytec does not support explicit alignment directives in the source, but the compiler’s `MemoryRegionTemplate` definitions show that fields and variables are intended to be aligned according to their size (e.g., 4-byte alignment for int32). In practice, the assembler will align `dd` and `dq` on natural boundaries by default in NASM (and the compiler emits each field on its own line, so alignment is handled).
* **Field references:** To use a field inside code, currently the language lacks a high-level syntax. One must either rely on future support for variables in expressions or use opcodes like `LOAD`/`STORE` (see Bytecode section). For example, if you have a global field `X`, and you want to push it to the stack, you would use `LOAD` with X’s label or address (this is low-level; a planned feature is to allow simply using `X` in expressions and have the compiler insert the load). This is *work in progress*.

### Properties

A **property** in Ubytec is like a high-level variable with encapsulated accessors (similar to properties in C#). Properties are declared by specifying a type and name without the `field` keyword, which the parser distinguishes as a property if it’s not preceded by `field`. For instance: `t_int32 count` (at module or class scope) declares a property named `count` of type `int32`. You can then optionally provide a property body with `get`, `set`, or `init` accessor functions.

* The parser rule is: if it encounters a token of scope `storage.type.*` and the next token is an identifier, **not** preceded by `field`, in a context where a field could appear, it treats it as a property declaration. It then looks ahead: if the next non-whitespace token after the identifier is a `{`, it will parse a property body; otherwise, it treats it as an auto-property with no explicit accessors.

* **Auto-properties:** If you write `t_type Name;` with no `{ }`, the compiler will create a property with default getters and setters. Internally, it synthesizes an `AccessorContext` with no custom functions, which means:

  * If this property is in a class/struct (instance property), it behaves like a field that can be gotten and set freely.
  * If it’s in an interface or if declared with no body in a class and no modifiers, by default it is like a read-write property. (However, since we don’t generate a backing field automatically yet, an auto-property is currently functionally equivalent to a public field in terms of generated code – it is stored as a field in `.bss` segment if at module/class level, and simple get/set would just read/write that memory. This is an implementation detail; conceptually it’s a property.)

* **Accessor definitions:** If you include a `{ ... }` after the property name, you can define one or more accessor functions:

  * `func get { ... }` – defines the getter. This must be a function with no parameters and return the property’s type. The name *must* be exactly `get` (case-insensitive), otherwise an error is thrown.
  * `func set { ... }` – defines the setter. This must be a function taking one parameter of the property’s type and returning `t_void`. The parameter name is arbitrary (often not used). The name must be `set`.
  * `func init { ... }` – defines an *initializer* accessor, intended to be like a setter that can only be called once during object initialization. It follows the same signature rules as `set` (one parameter of property type, returns void). Use of `init` is by convention; currently it’s treated similarly to `set` with a restriction that it cannot coexist with a `set` accessor on the same property.

  Inside the property body, no other members are allowed except these `func` accessors. The parser will skip any other tokens or throw an error if something else appears there.

* The compiler wraps the get/set/init functions into an `AccessorContext` object. During validation, it ensures:

  * At most 2 accessor functions are present (you can have `get` alone, `get`+`set`, or `get`+`init`, or `set` alone, etc. but not all three, and not both set and init together).
  * If a `get` is present, its return type must match the property’s type.
  * If a `set` is present, it must return void and take exactly one argument of the property’s type.
  * If an `init` is present, it must return void, take one argument of the property’s type, and you cannot also have a `set` (init and set are mutually exclusive since both serve to assign).
  * Duplicate accessors (two gets, etc.) are not allowed.

  These rules are enforced in the `AccessorContext.ValidateInternal` logic. Any violation will throw an exception at compile time.

* **Backing storage:** In the current implementation, each property, even with custom accessors, has an implicit backing field allocated in the BSS section (for uninitialized storage). The property’s get/set functions operate on that storage. The compiled output for a property is essentially a pair of labeled blocks: one in BSS for the value, and one in text for the get/set code. For example, a property `Foo` in a class will produce something like:

  ```nasm
  Foo_GUID: resq 1               ; reserve 8 bytes (if type is 64-bit) for backing store (.bss)
  ...
  prop_Foo_GUID_start:
      ; Property: Foo (ID: GUID), Type: <TypeName>
      ... get function code ...
      ... set/init function code ...
  prop_Foo_GUID_end:
  ```

  (The property is compiled similarly to a function, with labeled start/end and its accessors in between.)

  For auto-properties (no explicit get/set), the compiler still creates a backing field and would generate default get/set if needed. Currently, an auto-property is treated as having an AccessorContext with no functions, which the `Property.Compile` will still output as a labeled section with just start and end and no code in between. This results effectively in allocating space but not providing any code – meaning reads/writes to it are done as if it were a field. This is a bit of an artifact of the current compiler design; future versions may optimize auto-properties differently.

* **Usage:** Accessing a property uses the same syntax as a variable (just use its name). The compiler will route reads through the get accessor and writes through the set. However, note that currently in the bytecode, property access isn’t fully distinguished from field access unless you manually call the accessor. In practice, if you refer to `obj.Foo` in code, the compiler might inline that as a field reference or call, depending on context (this area is *WIP*; right now there’s no direct method call for a get in generated code – a read of a property is effectively compiled as a `LOAD` of its backing field, unless the get accessor has custom code, in which case the custom code is compiled but you would have to explicitly call it). This means that custom accessor logic is actually emitted but not automatically invoked. For now, to ensure custom logic runs, you might call the accessor function explicitly (like `obj.getFoo()` which is not a high-level syntax, but could be done by low-level call). This is another area for planned improvements in the code generator.

* **Example:**

  ```ubytec
  property t_int32 Counter {
      func get {
          return [this].value    // pseudocode: load backing store
      }
      func set {
          if (value < 0) {
              return   // ignore negative
          }
          [this].value = value   // set backing store
      }
  }
  ```

  This property has a custom getter and setter that ensure `Counter` never goes negative (any attempt to set a negative value is ignored). In the compiled output, a backing field for `Counter` will be reserved (for instance as `Counter_GUID: dq 0` in BSS) and the get/set code will be placed in the text section. The syntax `[this].value` above is not actual Ubytec syntax – it represents what the get/set would do in assembly (load or store the underlying memory). Ubytec currently doesn’t provide a direct way to reference “the value being set” except that in a `set`/`init` accessor, the single parameter represents the incoming value (the compiler internally names it and enforces its type). In the code, you could just write:

  ```ubytec
  func set {
      if (Arguments[0] < 0) return   // using the first argument implicitly (not actual syntax)
      // else store Arguments[0] into backing
  }
  ```

  There isn’t a clean syntax for accessing the backing field from within the property; however, since the compiler is responsible for generating the setter’s final assembly, you conceptually just use the parameter and assign it. This limitation in syntax will likely be improved (e.g., allowing `this.Counter` or similar within the set).

* **Summary:** A property without accessors acts like a public field (with potential for future encapsulation), and a property with accessors acts like a pair of methods with an implicit backing store. The implemented validation ensures properties don’t use invalid modifier combinations (e.g., marking a property `const` or `sealed` is disallowed as those don’t apply to properties) and that they have at most one visibility modifier.

### Local Variables

**Local variables** (as opposed to fields) are those declared within function bodies or within a `local {}` context. In function bodies, you can declare a variable by simply writing a type and name, similar to a property, but inside a function. For example, in a function: `t_int32 i  =  0` declares a local variable `i`.

However, Ubytec’s current grammar does not use a separate keyword for local declarations; instead, it treats any statement starting with a type as either a declaration of a local variable or an inline opcode (depending on context). In the statement parser, if a line begins with a type token, it is recognized as an **inline variable declaration opcode (`VAR`)**. Essentially, `t_type name value` inside a function becomes a `VAR` operation that allocates space on the stack for that variable and optionally initializes it.

Key points:

* Local variable syntax: same `t_<Type> <name> [initialValue]`. For instance, `t_int32 x 5` within a function will be parsed as a local variable definition.
* Locals are allocated on the stack when encountered. In the bytecode, encountering a local var triggers the generation of a `VAR` opcode which reserves space and possibly sets an initial value. The interpreter merges this information into the function’s active local variable list (so subsequent references to `x` can be resolved).
* Implementation detail: When the statement parser sees a type token at the start of a line, it collects the type, variable name, and an immediate value token if present. It also accumulates any modifiers on the declaration (like `readonly`, etc.) into a bitflag for that var (most of which are not yet meaningfully enforced for locals). It then constructs a `VariableExpressionFragment` containing the type, name, and value, and wraps that in a `VAR` opcode object. This `VAR` is marked as an `IOpCode` with opcode 0x10 (the byte for `VAR`) and stored.
* All local variables in a function are allocated together at function entry in the current codegen. The function compiler calculates total size needed for locals (summing the sizes of each declared local) and subtracts that from RSP once at the top of the function. It also generates label references for each local so they can be used within the function body (essentially treating them like fixed offsets in the stack frame).
* The `VAR` opcodes in the AST are used to track variable presence and initial value. When generating assembly, the compiler doesn’t output a specific instruction for `VAR` (there’s no runtime opcode doing allocation; it’s handled by the function prologue). Instead, it uses the info to lay out the stack frame. The initial value, if any, is then stored to that stack slot. *However,* at the moment, **initializers for local variables are not automatically emitted as moves** – this appears to be incomplete (the `VAR` opcode itself holds the initial value, but the assembly generator does not explicitly output code to set the stack memory to that value). This means a local like `t_int32 x 5` might allocate space but not actually initialize it to 5 unless the compiler handles it by converting that into a `PUSH 5` or similar. This is a known gap (WIP). As a result, be cautious: local initializers might be ignored in the current state, effectively leaving `x` undefined. This will likely be fixed so that the constant is stored.
* Local variables are by default mutable (unless you use `const` or `readonly` modifiers, which the parser will capture similarly to fields). A `const` local is conceptually possible (the compiler could treat it like an immediate), but since local assignment isn’t fully implemented, this distinction is minor.
* To **use local variables** in expressions, you simply write their name. The compiler needs to translate that into load/store operations. At present, referencing a local variable name in an expression will be parsed as either an opcode or an operand depending on context. If you write `x = 10;`, the parser sees `x` (not a keyword or type), tries to find it in the opcode map (fails) and likely throws an error (assignment statements to locals are not properly handled yet). If you write an expression like `x + 1`, the parser would treat `x` as an operand (possibly an “entity.name.var.reference”) but there is no code to actually *load* x’s value from the stack – the current implementation doesn’t generate that, as the high-level expression parser is incomplete. Therefore, local variable usage is very limited at the moment. You can declare them, but using them in calculations may not do what you expect unless combined with explicit opcodes (like using `PUSH` and `POP` around them).

In summary, local variables are recognized and allocated, but *assignment to them and use in expressions is only partially implemented*. They primarily serve as named stack slots. Future improvements will likely allow `=` to assign and reading them as part of expressions.

## Expressions and Operators

Ubytec supports a variety of operators, largely modeled on C/C#/Java syntax, for use in expressions and control flow conditions. The expression evaluation is based on a **stack machine** model: operands are pushed to an evaluation stack and operations consume them and push results. In the current implementation, infix expressions are parsed but then internally converted to postfix sequence of opcodes. For example, an expression `2 + 3 * 4` would be translated to push 2, push 3, push 4, multiply, then add (if the expression parser were fully implemented).

However, it’s important to note that **full expression parsing is still a work in progress**. Simple literal comparisons and arithmetic in conditions do work, but assignment and function calls in expressions are not yet functional.

Below is a list of the operators and their semantics as per the current design (with opcodes where applicable).

### Literal Constants

* **Integers:** An integer literal written in decimal (e.g. `42`) is by default interpreted as a 32-bit signed integer. The compiler will try to parse it into an `int` or `byte`, and if it doesn’t fit those, it currently fails (it does *not* yet automatically pick a 64-bit type, which is a limitation). You can also specify integers in hexadecimal (prefix `0x`) or binary (prefix `0b`). Hex and binary literals are parsed and converted to an integer internally. For example, `0xFF` -> 255, `0b1010` -> 10. Negative numbers are typically expressed with a unary negation operator (e.g. `-5` is parsed as the constant `5` with a `NEG` opcode applied).
* **Booleans:** The literals `true` and `false` (case-insensitive) are recognized. They are stored as 1 (true) or 0 (false) of type `t_bool`. For instance, a `constant.boolean.ubytec` token is turned into numeric 1 or 0 in operands.
* **Characters:** A character literal is written in single quotes, e.g. `'A'`. This will be converted to its ASCII/Unicode code (e.g. 65 for 'A'). In the AST, it’s treated as an integer of type `t_char8` or `t_char16` depending on context (default is `char8` if it fits).
* **Strings:** A string literal is written in double quotes, e.g. `"Hello"`. In the current compiler, string literals can appear as initializers for fields or possibly as operands for certain ops, but there is not a full string type. A string literal in a field initializer is stored in memory (as described in Fields section). In code, if a string literal appears, the parser flags it (scope `string.quoted.double.ubytec`), but `ProcessOperand` does not yet enqueue it to the operand queue (no direct handling). Practically, you would not use string literals in expressions yet except to assign to a field or pass to a syscall, etc. They are effectively pointers to static data (char arrays terminated by 0).
* **Null:** `null` is a literal representing a null reference. It is a keyword that corresponds to the `NULL` opcode (0x0F) which likely pushes a null pointer (0) onto the stack. The parser treats `null` as a keyword and generates a `NULL` opcode with no operands. In contexts like comparing to null or assigning null, it functions as expected (0 for pointer). The type of null can be any reference type; currently there is no type inference for null, but semantically it can be assigned to any class type or to a nullable value type.

### Arithmetic Operators

* **Addition (`+`), Subtraction (`-`), Multiplication (`*`), Division (`/`), Modulo (`%`):** These work on numeric types (integer or float). Each maps to an opcode: `ADD` (0x20), `SUB` (0x21), `MUL` (0x22), `DIV` (0x23), `MOD` (0x24) respectively. The expectation is that the two top values on the stack are taken, the operation applied, and the result pushed. The type of the result follows usual rules (two ints give an int, two floats give a float, etc.). Mixed-type arithmetic might require explicit casts – the compiler does have conversion rules (widening, etc.) defined in `ValidateImplicitCast` and `ValidateExplicitCast`, but automatic promotion is not fully implemented. So currently, you should operate on matching types.
* **Negation (Unary `-`):** This uses the `NEG` opcode (0x27), which negates the top-of-stack number (two’s complement for integers, arithmetic negation for float). You write `-x` in source. The parser will typically treat the `-` in front of a literal or variable as a unary operator and generate a `NEG` after pushing the operand.
* **Increment `++` and Decrement `--`:** These exist as tokens (scopes `operator.increment.ubytec` and `operator.decrement.ubytec`). They would map to `INC` (0x25) and `DEC` (0x26) respectively in bytecode. However, their usage in source is tricky since the grammar does not explicitly have pre/post fix rules implemented. They are recognized if used in a statement like `++x;` or `x++` but the actual effect depends on parse. The current compiler likely only supports them in a simple statement context (and would just emit an INC/DEC opcode targeting that variable). Because variable reference handling is incomplete, `++x` might not properly increment a local variable at runtime (it would push x, increment the value, and push the incremented value to stack, but not store it back unless combined with a store). This is *WIP*. So, while `INC` and `DEC` opcodes exist, use of `++/--` is not reliably functioning on user variables yet.
* **Absolute value (`ABS`):** There is an `ABS` opcode (0x28) to get absolute value. There’s no high-level operator symbol for it; it would be used via a function or intrinsic call (perhaps a planned `abs()` function). If needed, one could directly use the opcode in inline assembly form. In code, you might not use `ABS` explicitly, but know it exists for generating absolute values of numbers (turning negative to positive).
* **Exponentiation (`**`):** The grammar defines an `operator.exponentiation.ubytec` for a power operator (perhaps `**` or `^` in some contexts). The opcode map does not list a dedicated opcode for exponentiation (it might be intended to be handled by a runtime library call or an Extended opcode in the future). Currently, using `**` in source might produce tokens but no direct handling – consider this feature *planned* but not implemented. For now, raising to a power would require calling a library function or using repeated multiplication.

### Bitwise and Logical Operators

* **Bitwise AND (`&`), OR (`|`), XOR (`^`), NOT (`~` or `not`):** These operate on integral types (and booleans for bitwise ops can serve as logical ops since true/false can be treated as 1/0). Opcodes: `AND` (0x30), `OR` (0x31), `XOR` (0x32), `NOT` (0x33). The parser actually treats the textual keywords `and`, `or`, `xor` as bitwise operators (scoped as `keyword.operator.bitwise.ubytec`) and symbols `&`, `|`, `^` likely as `operator.bitwise-and`, etc. Either form may be accepted. For example, `a & b` or `a and b` should both result in an `AND` opcode. Similarly `~x` or `not x` would result in `NOT` opcode (bitwise complement of all bits) on x.
* **Bit shifts:** Left shift `<<` and right shift `>>` are supported. `SHL` (0x34) is shift-left, `SHR` (0x35) is shift-right. It’s not explicitly specified, but likely `SHR` is an arithmetic right shift (preserving sign for signed numbers). The language also defines tokens for **unsigned shifts** (perhaps `<<<` and `>>>` or some syntax). Scope names `operator.unsigned-left-shift.ubytec` and `operator.unsigned-right-shift.ubytec` appear, but there are no distinct opcodes for them in 0x30-0x3F range. This suggests either a plan to combine a flag with `SHL/SHR` or to handle `>>>` as a special case of `SHR` for unsigned operands. As of now, using `>>>` in code might simply map to `SHR` as well. We mark unsigned shift as *WIP*. Use `<<` and `>>` as normal; if you need a logical (zero-fill) right shift on a signed number, ensure you cast to an unsigned type (e.g., a larger type) before shifting.
* **Logical AND (`&&`) and OR (`||`):** These are short-circuiting boolean operators. In the grammar, `&&` is recognized as `operator.logical-and.ubytec` and `||` as `operator.logical-or.ubytec`. There is **no specific opcode** for logical-and/or because short-circuit logic is typically implemented with jumps. The current compiler likely handles `&&` and `||` during condition compilation by branching:

  * `a && b` is compiled like: evaluate `a`; if false, skip evaluating `b` and result false; if true, then evaluate `b` and that result is the result.
  * `a || b` similarly: if `a` is true, result true immediately; otherwise evaluate `b`.

  In practice, the AST builder might translate `&&` into something like: if first operand is 0, skip second and push 0; else evaluate second. This would involve the `IF`, `BRANCH`, and `END` opcodes. Indeed, the presence of structured `IF` and `END` opcodes facilitates short-circuit implementation. So logically, `&&` and `||` do work in `if` conditions. For example, an `if (x && y)` might generate something akin to:

  ```ubytec
  IF x != 0 {
      IF y != 0 {
          ...body...
      }
  }
  ```

  with appropriate `else` to set condition false. This is not explicitly in code, but the design allows it.
  As an expression (for assignment), `&&`/`||` returning a boolean isn’t fully tested but should yield 1 or 0 as well.
* **Logical NOT (`!`):** The logical negation operator for booleans is `!`. It is recognized as `operator.negation.ubytec`. Likely, the compiler will implement `!expr` by comparing expr to 0 and pushing 1 if zero, 0 if nonzero. There is no single `NOT` opcode for logical not (since `NOT` is bitwise). So `!` might be implemented as a small sequence (e.g., `EQZ` if it existed, or using `== 0`). In fact, the grammar could treat `!x` as `x == false` and output an `EQ` (equality) opcode with 0. The simplest way is to use the comparison opcodes: `EQ` with operand 0. (An `EQZ` opcode could be an extended idea but not present.) For now, you can use `!` in conditions and it should produce the correct result.

### Comparison Operators

The comparison operators yield a boolean result (`t_bool`, represented as 1 or 0). They are:

* **Equality `==` and Inequality `!=`:** Map to opcodes `EQ` (0x40) and `NEQ` (0x41). These compare the two top stack values (after pushing operands) and push 1 if equal (`EQ`) or 1 if not equal (`NEQ`), otherwise 0. They work for numeric types, booleans, and also for pointers/references (where equality means same address or both null). For user-defined reference types, `==` currently just compares pointers (no deep equality override yet).

* **Less than `<`, Less or equal `<=`, Greater than `>`, Greater or equal `>=`:** Map to `LT` (0x42), `LE` (0x43), `GT` (0x44), `GE` (0x45). These perform signed comparisons for numeric types (and presumably work for char as numbers). The result is 1 if the comparison is true, 0 if false.

* All these comparison opcodes are designed to consume two values and push a boolean. In terms of short-circuit, they don’t short-circuit (they are binary operators that always evaluate both sides).

* The parser identifies these via tokens like `operator.less-than.ubytec`, etc. During parsing of a condition like `a < b`, it will likely produce: push `a`, push `b`, then an `LT` opcode. If combined in complex expressions, the order of evaluation and insertion of these is governed by operator precedence (which the grammar likely encodes in the regex patterns or via the AST builder’s logic). Precedence in Ubytec follows typical rules: arithmetic `* / + -` > comparisons > logical && > logical ||. The compiler’s internal `Parse` function uses a single-pass to create opcodes, and the existence of an `OpcodeMap` with e.g. `LT` etc. suggests it directly inserts the `LT` instruction when encountering `<`.

* **Example:** `if (x != 0 && y < 5) { ... }`. The condition involves `!=` and `<` and `&&`. The compiler will:

  1. Parse `x != 0` to a sequence: push x, push 0, `NEQ`.
  2. Parse `y < 5` to: push y, push 5, `LT`.
  3. Parse the `&&` between them to implement short-circuit. Likely it wraps these in an `IF` structure under the hood.
     The final bytecode might be something like:

  ```
  PUSH x; PUSH 0; NEQ        ; result of first condition
  IF (pop value as condition) 
      PUSH y; PUSH 5; LT
  ELSE 
      PUSH 0                 ; if first was false, second is skipped -> result false
  END
  ```

  and then an `IF` outside to decide the whole `if` statement. While this is not explicitly shown in code, the design using structured `IF/ELSE/END` opcodes supports this pattern.

* **Note:** There is currently no direct support for comparisons of strings or complex types – those would require user code (e.g., iterating or custom function). Enums are compared by their underlying values (so you can use `==` etc. on enums directly). Booleans compared with `==`/`!=` just compare 0/1.

### Other Operators

* **Assignment (`=`):** As mentioned earlier, the assignment operator is recognized (`operator.assign.ubytec`) but not fully implemented in code generation. Normally, `=` would not have its own opcode but rather translate to a store operation. The plan is that `a = b` results in evaluating `b` then storing it into `a`’s location. In bytecode, this would be done via a `STORE` instruction. Indeed, there are opcodes reserved: `LOAD` (0x50) and `STORE` (0x51) for memory access. The idea is:

  * `LOAD var` pushes the value of variable `var` onto the stack.
  * `STORE var` pops the top of stack and writes it into `var`.

  The compiler currently does not automatically emit `LOAD`/`STORE` for variables when you use them in expressions or assignments – this is a work in progress. If you try `x = y;` in code, the parser will catch it but the resulting opcodes may be incomplete. The implementation of the commented-out block in `ProcessOperand` hints at how it might work: they planned to use an `@` symbol to indicate a variable reference and replace it with the variable’s value, but that is not finalized. For now, think of `=` as a placeholder. In practice, to set a variable you would use a `STORE`: e.g., you might have to resort to inline assembly like:

  ```ubytec
  // hypothetical example
  PUSH 10
  STORE i
  ```

  to assign 10 to `i`. This low-level approach might be the only way until assignment is finished.
* **Member access (`.`) and scope resolution (`::`):** Ubytec uses `.` for accessing members of objects (like `obj.field` or `obj.method()`), and `::` is seen in the grammar mostly for enum underlying types and possibly in future for static accesses (`Type::Member`). The scope name `punctuation.scope.ubytec` is used for the `::` after enum name. Member access `.` is not explicitly shown in grammar scopes, but likely it’s handled contextually (as part of parsing an identifier or function call). At runtime, non-static field access would involve an offset from an object pointer – that support depends on the implementation of classes and is incomplete. Since inheritance and virtual dispatch are not there, and all fields in an object are at fixed offsets, the compiler could compute those offsets for field access. But currently, there is no codegen for `obj.field` beyond treating it as perhaps a `LOAD` from the object’s base pointer plus offset. This is *WIP*. Similarly `obj.method()` would require calling the method with `obj` as context (like passing `this`).
  In short, member access works for static references (like calling a global function, or accessing a global field via module name if multi-module support were there), but for actual object instances, there’s missing infrastructure (since allocating objects and calling methods on them isn’t fully implemented).
* **Conditional operator (`? :`):** There is no mention of a ternary conditional operator in the grammar or code. It’s likely not supported in this version of Ubytec.
* **Pipeline (`|>`), Pipe-In (`<|`), Pipe-Out (`|<`), Spread (`...`), Optional chaining (`?.`), Null coalescence (`??`), etc.:** These appear as tokens in the grammar (scopes like `operator.pipe.ubytec`, `operator.pipe-in.ubytec`, `operator.spread.ubytec`, `operator.optional-chaining.ubytec`, `operator.nullable-coalescence.ubytec`). They hint at higher-level language features (functional pipelining, variadic spread, safe navigation, etc.). At present, **these are not implemented** in the interpreter logic. They were likely reserved for planned features:

  * `|>` and `|<` could be for function composition or data piping (as seen in F# or Elixir).
  * `??` would return the left operand if it’s not null, otherwise the right operand.
  * `?.` for safe navigation if an object is null (to avoid NullReference, returning null instead).
  * Spread (`...`) for expanding arrays/tuples into arguments.

  None of these have corresponding opcodes or handling in ASTCompiler (they would require multiple steps or variadic handling). They are considered *planned/WIP*. Using them in code currently will not work (they might be tokenized but the compiler wouldn’t know how to compile them to assembly).
* **Exception handling and others:** The grammar lists `keyword.exception.ubytec`, `keyword.threading.ubytec`, `keyword.system.ubytec`, `keyword.ml.ubytec`, `keyword.quantum.ubytec`, `keyword.power.ubytec`, `keyword.audio.ubytec`, `keyword.security.ubytec`, `keyword.vector.ubytec` etc.. These suggest potential domains for future keywords (for example, `throw`/`try` for exceptions, threading operations, system calls, machine learning, quantum computing primitives, vector/SIMD operations, etc.). Currently, none of these keywords have concrete syntax defined or implemented semantics. They are placeholders in the grammar likely to reserve those words or categorize tokens if they appear. In the current state:

  * There is no `try/catch` or `throw`. The only “exception” we have is the `TRAP` opcode which causes a runtime trap (like an `ud2` illegal instruction).
  * No threading keywords are active; concurrency isn’t implemented.
  * `syscall` is a keyword recognized (for making system calls). In assembly output, the compiler uses `syscall` instruction to exit. It’s possible to invoke a system call in Ubytec by writing `syscall` in code – the grammar would recognize it (scope `keyword.syscall.ubytec`), and the ASTCompiler would treat it likely as a direct assembly instruction. In fact, `syscall` appears as just a word that would be passed through as an I/O operation. There is no higher-level API around it, so it’s essentially inline assembly. This is how the program exits (they literally output `mov eax, 60; xor edi, edi; syscall` for exit). Similarly, other raw instructions could be exposed via keywords in the future (like `interrupt` or privileged instructions under `keyword.system`).

  All these specialized areas are *planned* and currently inactive.

## Bytecode and Opcode Reference

Under the hood, Ubytec code is compiled into a sequence of **opcodes** (bytecode instructions), some of which correspond directly to high-level statements or operations, and others are used internally for structured control flow. The bytecode is designed such that it can be assembled to real machine code (as is done now targeting NASM x86-64) or potentially interpreted by a virtual machine. Each opcode is a 1-byte value, sometimes followed by operands (immediate data like constants or indices). The implemented opcodes and their functionality are listed below. (If an opcode is marked *WIP*, it is defined but not fully utilized in code generation yet.)

**Control flow opcodes (structured):**

* **0x00 `TRAP`:** Triggers a trap/interrupt. This is used to signal an unrecoverable situation. In assembly it compiles to an undefined instruction (`ud2`) which will crash the program if executed. (Think of it as a deliberate crash or breakpoint – e.g., can be used for debug or as a stub for “not implemented”.)
* **0x01 `NOP`:** No operation. Does nothing and continues execution. Can be used as a filler or placeholder.
* **0x02 `BLOCK`:** Starts a structured block. `BLOCK` may take a type operand indicating the block’s result type (or `t_void` if it yields nothing). It opens a new scope for control flow. In high-level terms, `block` is used to group a series of instructions (like a `{}` in high-level, but also used to implement things like switch-case or try-catch structures). In assembly output, a `BLOCK` might correspond to a label marking the start of a block.
* **0x03 `LOOP`:** Starts a loop block. This is like `BLOCK` but indicates a loop construct, typically used with `BREAK`/`CONTINUE`. In a `while` or `for` loop, the compiler might use `LOOP` to mark the point to jump back to. It also can have a type like BLOCK does.
* **0x04 `IF`:** Begins an `if` conditional block. It expects a condition value (boolean) on the stack – if the value is nonzero (true), the block executes; if zero (false), execution jumps to the corresponding `ELSE` or `END`. The `IF` opcode internally holds the condition expression parsed after it (the compiler sets up the condition before emitting IF). In assembly, `IF` will be implemented by a conditional jump past the block if false.
* **0x05 `ELSE`:** Begins the `else` portion of an `if` block. It is only valid after an `IF` (structured). When execution hits an `ELSE`, it jumps to after the `END` of the if-block (skipping the else-part) if coming from the `if` part. In assembly, `ELSE` corresponds to an unconditional jump that is taken if the `if` part was executed, and a label that marks the start of else-block. The interpreter tracks the matching IF for each ELSE.
* **0x06 `END`:** Closes a `BLOCK`, `LOOP`, `IF` or other block structure. Every structured block opener (BLOCK, LOOP, IF, ELSE, SWITCH, etc.) has a matching END. END may also end a `BRANCH` construct (see below). In assembly, `END` corresponds to a label that marks the exit of the structure.
* **0x07 `BREAK`:** Exits from a loop or switch. This causes an immediate jump to the instruction after the matching `END` of the nearest encosing `LOOP` or `SWITCH`. It’s the implementation of `break` in C-like languages. It will only function properly inside a `LOOP` or `SWITCH` block; if used elsewhere, it might be ignored or throw (the current compiler doesn’t explicitly check context before emitting, but logically it should be within a loop). *Status:* Implemented in opcode map and parser (it’s recognized), but no special compile-time check is done beyond structured control handling.
* **0x08 `CONTINUE`:** Jumps to the next iteration of the nearest loop (to the loop’s `LOOP` point). It causes execution to jump to just before the `END` of a `LOOP`, effectively. In a `while`, this means go to the condition check again. Like BREAK, it should be used inside a loop. *Status:* In opcode map and grammar; structured handling uses it similarly to break.
* **0x09 `RETURN`:** Returns from the current function, optionally with a value. Semantically, it breaks out of the entire function’s execution. In implementation, encountering a RETURN would generate a jump to the function’s end label (`func_name_end`). In the current assembly output, the compiler always appends a `ret` instruction at function end. A `RETURN` opcode encountered in bytecode should therefore jump to that ret. The interpreter’s design currently doesn’t automatically output a jump for RETURN opcode (no special compile in `CompileBlockNode` aside from grouping it) – this is an area to check. Likely, the function compiler should convert `RETURN` opcodes into actual `jmp` to end. At least conceptually, use `return expr;` in code to break out. *Status:* present in bytecode, works in simple cases (the sample main uses an implicit return).
* **0x0A `BRANCH`:** This is a general “branch table” construct for switches. It opens a block like a combination of `IF` and `LOOP` specifically for `SWITCH` handling. The idea is that `SWITCH` pushes a value, and then a series of `BRANCH` opcodes could be used to jump to the matching case. In practice, `BRANCH` likely holds an array of label offsets (`LabelIDxs` in the AST schema) for case labels. The first operand might be the number of cases or something. The compiler, upon a `SWITCH`, would generate one or more `BRANCH` instructions representing `case` labels to jump to. Each `BRANCH` acts like an `IF` on the switch value (or a jump table using the value as index). **However**, the current parser doesn’t explicitly handle a `case` keyword (there is none in grammar), so how `BRANCH` is used is not obvious. It might be that the compiler intended to use multiple `IF`/`ELSE` to implement switch, and `BRANCH` is reserved for a future jump table optimization. In the opcode handling, `BRANCH` is treated similarly to `IF` (it inherits variables to its scope, etc.). *Status:* Present but not triggered by any high-level syntax in current implementation (no `case` keyword), so effectively *WIP*.
* **0x0B `SWITCH`:** Marks the start of a switch-case structure. In source, `switch` would be followed by a value and a block of cases. The Ubytec grammar does have a `keyword.control.flow.ubytec` for `switch` and `default` and presumably would parse a `switch(cond) { ... }` into a `SWITCH` opcode and some internal structure for cases. The `SWITCH` opcode likely takes the switch condition as an input and maybe prepares for branch table. In the AST, a `SWITCH` node is a block node that will have children for each case (with `BRANCH` opcodes) and a child for `DEFAULT` if present, and then an `END`. The current compiler does put `SWITCH` in the opcode map and will push it to block stack like other blocks. But since `case` handling isn’t explicitly coded, using `switch` might not fully work. Possibly one could simulate a switch with if-else ladder for now. *Status:* Partially implemented; `switch` keyword is recognized and the structure exists, but case labels are *WIP*.
* **0x0C `WHILE`:** Opens a structured loop with a condition at the start (a typical `while` loop). In high-level code, a `while(cond) { body }` is handled by a single `WHILE` opcode that includes the condition expression, and an implicit loop-back. Internally, the compiler likely transforms a `while` into a combination of `LOOP` and `IF` opcodes, but it actually has a dedicated `WHILE` opcode for convenience. The `WHILE` opcode in the AST carries the loop condition (it has a `Condition` field). The typical lowering might be: `WHILE cond { ... }` becomes:

  ```
  LOOP (block)
    IF cond {
       ...body...
       BRANCH (back to LOOP start)
    }
  END
  ```

  However, they chose to treat `WHILE` as a first-class opcode, possibly simplifying codegen. The interpreter pushes `WHILE` on the block stack like an `IF`/`LOOP` combo, and on encountering the matching `END`, it will pop it. In assembly output, a `WHILE` might generate both the loop condition check and a jump back at `END`. The actual implementation of `WHILE` in assembly is not explicitly printed; presumably, they handle it in the Compile step by outputting a label at `WHILE` start and a conditional jump at end. *Status:* Implemented in parser and opcode map; should function for basic loops. For example,

  ```ubytec
  while x != 0 {
      ...body...
  }
  ```

  would compile to something logically like:

  ```
  start_loop:
    cmp [x], 0
    je end_loop
    ...body...
    jmp start_loop
  end_loop:
  ```

  The `WHILE` and `END` opcodes encapsulate that pattern.
* **0x0D `CLEAR`:** This opcode clears the evaluation stack. It’s a utility to discard any temporary values and reset the stack depth to what it was at block entry. In practice, the compiler might emit `CLEAR` at the end of a block that is supposed to have void type, to make sure nothing is left on the stack. Or it could be used by user to drop all runtime stack data (though typically not exposed directly). In the current code, `CLEAR` is listed in the map and treated as a neutral instruction (no stack effect besides clearing). In assembly, it would translate to adjusting RSP if needed. Since expression stack management is mostly static, `CLEAR` might rarely be needed; it’s likely *WIP* or used defensively. Use of `clear` in source is not documented, but one could imagine doing `clear` to abandon any computed results (like a stack reset).
* **0x0E `DEFAULT`:** Marks the default case in a switch. It would be used inside a `SWITCH` block to indicate the start of the default block (executed if none of the cases matched). The parser likely expects `default:` label and translates it to a `DEFAULT` opcode. Similar to `ELSE` for if, `DEFAULT` for switch does not take a condition but serves as a jump target. The OpcodeMap includes `DEFAULT`, and `CompileBlockNode` treats it like a neutral operation (likely just a label for the default section). *Status:* The keyword `default` is recognized and the structure exists, but since `switch`/`case` isn’t fully operational, `DEFAULT` is effectively *WIP* as well.
* **0x0F `NULL`:** Not actually a control-flow, but listed here in sequence. `NULL` is an opcode that pushes a null reference (zero) onto the stack. It’s used to implement the `null` literal. In assembly, it might be just `xor rax, rax; push rax` (or similar). It takes no operands. This opcode is fully implemented; using `null` in an expression will generate it.

**Stack and data opcodes:**

* **0x10 `VAR`:** Declares an inline local variable (already covered in Variables section). `VAR` opcode carries the variable’s type, name, and initial value (packed in a `VariableExpressionFragment`). At runtime, it doesn’t produce machine instructions except reserving stack space (which is handled in function prologue). It’s more like metadata. Multiple `VAR` in a row can appear to allocate multiple locals. As a result, `VAR` is primarily handled at compile time. *Status:* Implemented in parser and used for local declarations.
* **0x11 `PUSH`:** Pushes an immediate value onto the stack. The `PUSH` opcode takes a byte array operand (which can represent an arbitrary literal of any size). It is used for constants that aren’t handled by specific opcodes. For example, pushing a large constant or a pointer might use `PUSH`. In current usage, numeric literals are often enqueued as operands to other opcodes (like `ADD` or comparisons) rather than a standalone `PUSH`. But you can explicitly write `push 5` in Ubytec code to push the value 5 (though that’s more akin to assembly embedding). *Status:* Defined, but the code generation of expressions might inline pushes implicitly. The compile of a `VAR` with initial value uses `PUSH` internally on the value then stores it.
* **0x12 `POP`:** Pops the top of the stack, discarding a value. It’s used to remove unwanted results. For instance, if a function returns a value you don’t need, the compiler might emit a `POP` to remove it. Or at the end of a block returning void but with stack residue, it might pop. You can also explicitly call `pop` in code to drop one stack value. *Status:* Present (though `POP`’s `Compile` is `NotImplemented` stub, the assembly equivalent would be an actual `pop` from CPU stack).
* **0x13 `DUP`:** Duplicates the top stack value (pops one value and pushes it twice, effectively). Used when you need to use a value twice without reloading it. For example, computing `x + x` might push x then DUP it then ADD. *Status:* Implemented as opcode but compile logic not yet generating it automatically in any known case (since expressions are simple). It can be used manually.
* **0x14 `SWAP`:** Swaps the two topmost stack values. If the stack has `... A B` (A at lower address, B on top), after `SWAP` it will have `... B A`. Use case: to reorder arguments or results without using memory.
* **0x15 `ROT`:** Rotates the top three values: it takes the third value down and brings it to top, pushing the others down. Stack `... A B C` becomes `... B C A` (where A was at position 3, moved to top).
* **0x16 `OVER`:** Copies the second value to top. Stack `... A B` becomes `... A B A`. (This is like `DUP` of the second element down.)
* **0x17 `NIP`:** Removes the second value, leaving only the top. Stack `... A B` becomes `... B` (A is removed). Essentially it “nips out” the one below the top.
* **0x18 `DROP`:** Removes an element at a given stack index. In Ubytec, `DROP(byte index)` is defined. Likely `DROP 0` would drop the top (same as POP), `DROP 1` would drop the second-from-top (like NIP), `DROP 2` would drop the third, etc. This is a generalized NIP. If not needed, one can use POP or NIP macros, but `DROP n` gives flexibility.
* **0x19 `TwoDUP`:** Duplicates the top two values as a pair. Stack `... A B` -> `... A B A B`.
* **0x1A `TwoSWAP`:** Swaps the two top pairs. Stack `... A B C D` -> `... C D A B` (where A B is pair1, C D is pair2).
* **0x1B `TwoROT`:** Rotates the top three pairs (six values). For instance `... P Q A B C D` -> `... A B C D P Q` (assuming P Q is pair1, A B pair2, C D pair3).
* **0x1C `TwoOVER`:** Copies the second pair to top. Stack `... A B C D` -> `... A B C D A B`.
* **0x1D `PICK`:** Copies an arbitrary stack element to the top. `PICK n` takes the value at depth n (0 = top, 1 = second, etc.) and pushes a copy of it on top without removing the original. E.g., stack `... X Y Z`, `PICK 2` (assuming 0=Z,1=Y,2=X) will result in `... X Y Z X`. Commonly, Forth `pick` is 0-indexed from top or 1-indexed – here likely 0 means top (like duplicating top = `PICK 0` equals `DUP`).
* **0x1E `ROLL`:** Moves an arbitrary stack element to the top, removing it from its original place. `ROLL n` takes the value at depth n and lifts it to top, shifting down all values that were above it. E.g., stack `... A B C D`, `ROLL 2` (if 0=D,1=C,2=B,3=A) would take B out and push it on top -> `... A C D B`.

*(All the above stack ops are analogous to those in Forth/Stack VM terminology. These opcodes are implemented in the bytecode specification, but many are not yet utilized by high-level code generation – they are available for manual stack manipulation and will be used by the compiler as needed once expression optimization and more complex codegen is implemented. Currently, you mostly see simpler ones like POP or DUP in potential output.)*

**Arithmetic opcodes:**

* **0x20 `ADD`:** Pops two values, adds them, pushes result. Works on numeric types (integers, floats). If the operands are integer and there’s risk of overflow, that is not trapped (no overflow checking in bytecode). For pointer types, addition could be defined (e.g., pointer + int to offset), but that’s not explicitly supported now.
* **0x21 `SUB`:** Subtract second-from-top minus top, pushes result. (If stack was ... X Y, does X - Y.)
* **0x22 `MUL`:** Multiply two top values.
* **0x23 `DIV`:** Divide second-from-top by top, pushes quotient. For integers this is truncated division toward 0 (like C). Division by zero will cause a trap at runtime (currently not caught except it’ll likely produce a CPU exception or a later check could throw).
* **0x24 `MOD`:** Remainder of second-from-top divided by top (X mod Y). Sign of result follows C/C++ semantics (for positive divisors, remainder has sign of dividend; for negative divisors or negative dividend, behavior should mimic hardware idiv remainder).
* **0x25 `INC`:** Increment top of stack by 1 (pop, add one, push result). Or if implemented as an in-place op, it might just adjust memory if directly tied to a variable (but in stack machine, it’s easier to treat like a normal add of constant 1).
* **0x26 `DEC`:** Decrement top of stack by 1.
* **0x27 `NEG`:** Negate (arithmetic negation) of top of stack. If top is an int X, it pushes -X.
* **0x28 `ABS`:** Absolute value. If top is negative, negates it, otherwise leaves it. So result is non-negative.

*(These arithmetic ops, when used on floats vs ints, require knowing the type. The bytecode doesn’t carry type info in the opcode itself. The responsibility is on the compiler and eventually on the code generator to use the correct machine instruction. For example, `ADD` will produce either an integer add (`add`) or floating add (`adds-sd` etc.) depending on the types of the operands. The AST carries type info (UType of operands), so the code generator uses that. The validator ensures type compatibility – e.g., you can’t add an int32 and a float64 without a cast. Implicit numeric widening (e.g., int to float) might be allowed; the `CanConvert` logic in `Types` suggests it differentiates implicit vs explicit, but currently the parser does not insert conversion opcodes. Probably, if you add a float and int, the int would be up-cast to float by the parser inserting a type code in the operand (the operand queue can carry type bytes for a literal). In the future, an explicit `CAST` opcode may be introduced for runtime conversions. For now, ensure operands are of the same type to avoid issues.)*

**Bitwise opcodes:**

* **0x30 `AND`:** Bitwise AND of two top integers/booleans (pop two, push result bitwise AND).
* **0x31 `OR`:** Bitwise OR.
* **0x32 `XOR`:** Bitwise XOR (exclusive or).
* **0x33 `NOT`:** Bitwise NOT (ones' complement) of top value.
* **0x34 `SHL`:** Arithmetic left shift. Takes two top values: second is value, top is shift amount (this is likely the order). So if stack has X (value), Y (shift), after `SHL` it pushes (X << Y). Bits shifted out are discarded. Left shift of a signed int is same as unsigned (just bits moving left).
* **0x35 `SHR`:** Right shift. Probably arithmetic (preserve sign bit for signed values). If X is unsigned or considered as such, it’s logical. The distinction isn’t encoded in opcode, so presumably the compiler would choose to interpret based on type (if type is unsigned, do logical, if signed, do arithmetic).
* *(No direct opcodes for rotate or bit extraction; those could be done via combinations or extended opcodes if needed.)*

**Comparison opcodes:**

* **0x40 `EQ`:** Checks equality of two values. Pops two, pushes 1 if equal, 0 if not. For numeric types, does usual comparison. For reference types (pointers, object references), it checks if the addresses are equal. Note: to compare strings by content, one would need to loop or use a library function; `EQ` on two string references only tells if they point to the same string.
* **0x41 `NEQ`:** Inequality (not equal). Pushes 1 if the two values are not equal, else 0.
* **0x42 `LT`:** Less-than (signed). Pops two (X, Y) and pushes 1 if X < Y, else 0. The likely order is second-from-top < top? Actually, consider typical stack usage: if you push X then Y then do LT, you'd want to check X < Y. In assembly, one would do `cmp X, Y` and set if X\<Y. But on stack, if Y was pushed last, Y is at top, X below it. If the implementation does top as right operand, then it would do (second < top). So yes, it likely does (first\_pushed < second\_pushed). So the code should interpret that correctly.
* **0x43 `LE`:** Less-or-equal.
* **0x44 `GT`:** Greater-than.
* **0x45 `GE`:** Greater-or-equal.
* (There is no explicit opcode for unsigned comparisons. The approach might be: if comparing as unsigned, the compiler could adjust values or use a special instruction via extended opcode. Presently, all comparisons assume signed interpretation for integers. Floats are treated as their own category but `LT` etc. would be used for them too, using float compare instructions at machine level.)

**Memory access opcodes (planned):**

* **0x50 `LOAD`:** Load from memory. In context, likely `LOAD` takes an operand indicating what to load:

  * Could be an address on stack: perhaps the design is `LOAD` with no immediate will pop an address and push the value at that address (size depends on type info from context).
  * Or `LOAD varIndex` to load a local or global variable by index or reference.
    The AST schema shows `Operation` can have a `Variables` field referencing a `SyntaxExpression`, which could be how `LOAD`/`STORE` refer to variable addresses or names.
    The commented-out code in `ProcessOperand` for `@variable` suggests an intention that `@name` might get replaced with the actual value. Possibly they scrapped that in favor of explicit opcodes.
    In any case, `LOAD` is meant to push the value from a memory location. Example usage: if you have a pointer or array base and offset on stack, a future extended `LOAD` might pop both and push that memory content (like `LOAD` could handle both address and offset as multi-word operand).
    *Status:* Present in OpcodeMap but not actively used by compiler yet.
* **0x51 `STORE`:** Store to memory. Likely pops a value and an address and writes the value to that address. Alternatively, might use some immediate or context to know where to store. In typical stack machine, one might do `addr value STORE` (store value at addr). Or if it's oriented to variables, it might have an immediate reference. The AST `Operation` has an Extended form for opcodes 0xFF with `ExtensionGroup` and `ExtendedOpCode`. It’s possible that user-defined or external memory operations will use extended opcodes, whereas 0x50/0x51 might be reserved for simple pointer-based load/store.
  *Status:* In map, not used in high-level code generation yet.

*(The memory model of Ubytec is still evolving. Eventually, one can expect the ability to allocate memory blocks, access array elements, etc., using these opcodes. For now, memory access is mostly through global and local variables handled by the compiler directly, without explicit LOAD/STORE in the bytecode except possibly for unstructured pointer usage.)*

## Runtime Execution Model

When Ubytec bytecode is executed (either by the generated native code or a future VM), the following model applies:

* **Evaluation Stack:** There is a LIFO stack used for evaluating expressions and holding temporary values (distinct from the call stack). Most opcodes manipulate this stack – pushing or popping values. The stack has a defined size (the compiler can compute max depth needed). Overflowing it or underflowing it would be an error (in a VM, trap; in generated code, it would mean mis-managing CPU stack).

* **Call Stack & Frames:** Each function call creates a new frame (activation record). Parameters and local variables are allocated within that frame. In the generated assembly, the CPU stack is used for both the evaluation stack and locals (the implementation simply moves RSP for locals and uses it as evaluation area too). The `LocalContext` and function prologue manage RSP accordingly. A VM implementation might separate evaluation stack from call stack for simplicity.

* **Modules and Globals:** Global variables (module fields/properties) reside in a separate memory area (data segment). They are identified by labels and accessed directly by address in assembly. In a VM, one could assign each global an index or memory offset. The module’s `global` context, if present, is executed at program start (in the current code, the global context is output as a block of code labeled and referenced, but notice: the module compile doesn’t automatically call global context functions at startup except for using `_start` to call `Main`. If initialization code is needed, the user might call it in Main or it should be integrated – possibly *WIP* that global context code could be invoked before main).

* **Function Calls:** A function call in Ubytec (syntax `funcName(args...)`) is currently handled much like in C: the caller pushes arguments, then does a `call`. The generated assembly reserves stack space for arguments in the function prologue and then writes each argument into that space (for simplicity, they actually subtract space and move each argument into \[RSP+offset]). Then they jump to function code. On return, it’s the caller’s job to clean up (the function itself restores RSP). This is akin to cdecl calling convention (caller cleans stack).
  In the bytecode, a function call would ideally be an opcode like `CALL funcIndex` or so, but currently the compiler does not define a `CALL` opcode. Instead, a call is inlined as assembly `call`. They treat calls at a higher level rather than as an opcode in AST.
  There is a hint: `keyword.function.call.ubytec` scope exists which might correspond to encountering an identifier followed by `(` (so the grammar flags it as a call). The compiler likely handles it by outputting an assembly call to the function’s label. In a VM, one would implement calls by pushing a return address and jumping, or by a special opcode. For now, calls are not represented in the JSON AST explicitly except as part of the syntax tree for functions (the AST likely just has a `SyntaxNode` with an `Operation` that has `$type: "FuncCall"` or similar – though we haven’t seen that schema, it might be under ExpressionFragments).

* **Return Values:** Functions can return a value which is left on the evaluation stack by a `RETURN` opcode or by falling off the end with a value on stack. The calling code expects that on return, the result is available (in assembly, often in a register or at top of stack). In the current assembly output, they conventionally move returned values into the RAX register (if any) before `ret`. Actually, the compiled code does:

  ```nasm
  ... function body ...
  ; Function body end
  ret
  ```

  (They always put a `ret` and they don’t explicitly move anything to RAX, which implies that if a function is meant to return something, they probably ensure that value is in RAX at the end. The code that appends `ASTCompiler.CompileAST(new SyntaxTree(Definition))` inside the function compile will produce assembly for the function body. If the function’s Definition (SyntaxSentence) yields a value on the stack, they did not explicitly handle moving it to RAX or cleaning the stack. Possibly, by x86-64 calling convention, the responsibility is on function to place return in RAX. The simplest approach is if the last operation of the function leaves one value on top of stack, and then they do `ret`, in their calling convention that wouldn’t automatically return it. They would have needed a `pop rax` or similar.

  This is a discrepancy: possibly they rely on the fact that the value might be in RAX if it was computed last – for example, an arithmetic might naturally leave something in RAX if using certain instructions. But with many stack operations, one would need to ensure it. This might be a current limitation – we should mark that returning values from non-void functions might not be fully wired up (maybe the `RETURN` opcode would be used to move a value into RAX and jump).

  The `Func.Validate` enforces that if a function is not abstract, it must have a body (`Definition` not null), and presumably if a function is supposed to return non-void, the compiler should ensure a return is executed. If you omit a return in a non-void function, currently the code will fall off and do `ret` with whatever in RAX (likely whatever value from last expression or 0).

  So as of now, the convention is likely: to return a value, ensure the last operation leaves it in RAX or use an explicit `return value;`. The explicit `return` will compile to the necessary moves. If that is not done, it's a *WIP* area.

* **Program Startup and Termination:** The main module (the one compiled to an executable) will have an `_start` entry generated. This sets up any required sections and calls `Main` if present. After Main returns, or if no Main, it executes an OS exit system call (`mov eax, 60; xor edi, edi; syscall` in Linux to exit process with code 0). This means the program ends when main returns (or immediately if no main). Memory allocated on stack is freed by normal process teardown. There is no GC or heap unless the program explicitly invokes syscalls or library calls for allocation (future library support might come). Modules can be compiled as libraries too; in that case, `Main` would not be invoked.

* **Error handling:** If an invalid operation occurs (division by zero, trap, etc.), the current runtime will just crash (or yield a CPU exception). There’s no catch/throw yet. The `TRAP` opcode can be used to intentionally abort.

In summary, the runtime model currently is a straightforward stack machine executing in a single thread, with structured control flow mapping to labels and jumps in generated code. As the implementation matures, more safety checks and advanced features (like a garbage-collected heap for objects, multi-module linking, exceptions, etc.) will be added. This overview reflects the current state where features not fully implemented are marked as such, and the existing functionality can be used as a guide for compiler and toolchain authors targeting Ubytec.

**References:**

* Ubytec grammar and token scopes define the syntax for all constructs (e.g., `keyword.control.flow.ubytec` covers `if`, `else`, `while`, `switch`, etc., and `storage.type.single.ubytec` covers basic types).
* The interpreter’s parsing logic in `HighLevelParser.cs` shows how modules, contexts, and members are recognized and enforces certain rules (only one global/local context, etc.).
* The AST schema (`.ubc.ast.json`) documents the structure of the syntax tree, including how expressions and operations are represented (e.g., `ConditionExpressionFragment` for binary conditions with `Operand` like "==" or "<", and the presence of fields like `BlockType`, `Condition`, and `LabelIDxs` in structured opcodes).
* The bytecode mapping (`OpcodeFactory` and `ASTCompiler`) provides the opcode assignments and the intended behavior for each operation (for instance, mapping 0x04 to `IF`, 0x0C to `WHILE`, etc., and illustrating stack ops like `PUSH` 0x11, `POP` 0x12, etc.). Many opcodes are defined as placeholders and currently throw `NotImplementedException` if used (they exist so the design is visible, but not all produce assembly yet).
* The function compilation in `Func.Compile` demonstrates how local variables and the function body are compiled to assembly, including reserving stack space for locals and arguments and appending the assembled body instructions, with a final `ret`. Similarly, `Action.Compile` shows an approach for action (void function) which is simpler (no return value to handle, it just ensures a `ret`).
* Module compilation in `Module.Compile` shows how different sections are laid out: data (.data for fields and global context fields), BSS for uninitialized props, text (.text for code), followed by global label `_start` which calls `Main` and exits. This illustrates the overall program structure the compiler produces.

This overview should serve as a technical reference to the current Ubytec language implementation. It is intended for compiler and tool developers who need exact details on syntax and semantics actually supported. As Ubytec is under active development, some aspects marked as *WIP* will evolve – keep an eye on repository updates and the schema for changes. With this information, one can generate or analyze Ubytec code confident that it will reflect the real behavior of the interpreter/compiler in its current state.
