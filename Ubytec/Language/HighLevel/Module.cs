﻿using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.HighLevel.NASM;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Tools;
using static Ubytec.Language.Syntax.TypeSystem.Types;

namespace Ubytec.Language.HighLevel
{
    public readonly struct Module : IUbytecContextEntity
    {
        public string Name { get; }
        public string Version { get; }
        public string Author { get; }
        public string[]? Requires { get; }
        public Guid ID { get; }
        public TypeModifiers Modifiers { get; }
        public LocalContext? LocalContext { get; }
        public GlobalContext? GlobalContext { get; }
        public Field[] Fields { get; }
        public Property[] Properties { get; }
        public Func[] Functions { get; }
        public Action[] Actions { get; }
        public Interface[] Interfaces { get; }
        public Class[] Classes { get; }
        public Struct[] Structs { get; }
        public Record[] Records { get; }
        public Enum[] Enums { get; }
        public Module[] SubModules { get; }

        public Module(string name, string version, string[]? requires, string author, Field[] fields, Property[] properties, Func[] funcs, Action[] actions, Interface[] interfaces, Class[] classes, Struct[] structs, Record[] records, Enum[] enums, Module[] subModules, Guid id, LocalContext? localContext = null, GlobalContext? globalContext = null, TypeModifiers modifiers = TypeModifiers.None)
        {
            Name= name;
            Version= version;
            Author= author;
            Requires= requires;
            ID= id;
            Modifiers= modifiers;
            LocalContext= localContext;
            GlobalContext= globalContext;
            Fields= fields;
            Properties= properties;
            Functions= funcs;
            Actions= actions;
            Interfaces= interfaces;
            Classes= classes;
            Structs= structs;
            Records= records;
            Enums= enums;
            SubModules= subModules;
            Validate();
        }

        public void Validate()
        {
            if (string.IsNullOrWhiteSpace(Name))
                throw new Exception("Module name cannot be null or empty.");

            if (string.IsNullOrWhiteSpace(Version))
                throw new Exception($"Module '{Name}' must have a version.");

            if (string.IsNullOrWhiteSpace(Author))
                throw new Exception($"Module '{Name}' must have an author.");

            // Only allow 'global' as optional module-level modifier
            if ((Modifiers & ~TypeModifiers.Global) != 0)
                throw new Exception($"Module '{Name}' can only have the 'global' modifier.");

            // Ensure unique submodule names
            var subNames = new HashSet<string>();
            foreach (var sub in SubModules)
            {
                if (!subNames.Add(sub.Name))
                    throw new Exception($"Duplicate submodule name '{sub.Name}' in module '{Name}'.");
                sub.Validate(); // Recursive
            }

            if (Requires is { Length: > 0 })
            {
                foreach (var req in Requires)
                {
                    if (string.IsNullOrWhiteSpace(req))
                        throw new Exception($"Module '{Name}' has an invalid required module name.");
                }
            }

            // Ensure member names are unique across all top-level declarations
            var memberNames = new HashSet<string>();
            var tempName = Name;

            foreach (var f in Fields) Add(f.Name, "field");
            foreach (var p in Properties) Add(p.Name, "property");
            foreach (var fn in Functions) Add(fn.Name, "function");
            foreach (var a in Actions) Add(a.Name, "action");
            foreach (var i in Interfaces) Add(i.Name, "interface");
            foreach (var c in Classes) Add(c.Name, "class");
            foreach (var s in Structs) Add(s.Name, "struct");
            foreach (var r in Records) Add(r.Name, "record");
            foreach (var e in Enums) Add(e.Name, "enum");

            // Delegate validation to sub-entities
            foreach (var f in Fields) f.Validate();
            foreach (var p in Properties) p.Validate();
            foreach (var fn in Functions) fn.Validate();
            foreach (var a in Actions) a.Validate();
            foreach (var i in Interfaces) i.Validate();
            foreach (var c in Classes) c.Validate();
            foreach (var s in Structs) s.Validate();
            foreach (var r in Records) r.Validate();
            foreach (var e in Enums) e.Validate();

            LocalContext?.Validate();
            GlobalContext?.Validate();

            void Add(string memberName, string kind)
            {
                if (!memberNames.Add(memberName))
                    throw new Exception($"Duplicate {kind} name '{memberName}' in module '{tempName}'.");
            }
        }

        public string Compile(CompilationScopes scopes)
        {
            scopes.Push(new ScopeContext
            {
                StartLabel = $"module_{Name}_{ID}_{Utf64Codec.Encode(Version)}_{Utf64Codec.Encode(DateTime.UtcNow.ToString())}_{Author}_start",
                EndLabel = $"module_{Name}_{ID}_{Utf64Codec.Encode(Version)}_{Utf64Codec.Encode(DateTime.UtcNow.ToString())}_{Author}_end",
                DeclaredByKeyword = "module"
            });

            try
            {
                Validate();
                var sb = new StringBuilder();

                _ = new NASM_Header<Module>(scopes, sb, this);
                _ = new NASM_Data<Module>(scopes, sb, this, nullableGlobalContext: true);
                _ = new NASM_Metadata<Module>(scopes, sb, this, nullableRequires: true);
                _ = new NASM_Exports<Module>(scopes, sb, this);
                _ = new NASM_BSS<Module>(scopes, sb, this);
                _ = new NASM_Text<Module>(scopes, sb, this);
                _ = new NASM_Interfaces<Module>(scopes, sb, this);
                _ = new NASM_Types<Module>(scopes, sb, this);
                _ = new NASM_FunctionsAndActions<Module>(scopes, sb, this);
                _ = new NASM_LocalContext<Module>(scopes, sb, this, nullableLocalContext: true);
                _ = new NASM_SubModules<Module>(scopes, sb, this);
                _ = new NASM_EntryPoint<Module>(scopes, sb, this);

                sb.AppendLine($"{scopes.Peek().EndLabel}:");
                return sb.ToString();
            }
            finally
            {
                scopes.Pop();
            }
        }
    }
}
