using System.Text;
using Ubytec.Language.HighLevel.Interfaces;
using Ubytec.Language.Syntax.Scopes;
using Ubytec.Language.Syntax.Scopes.Contexts;
using Ubytec.Language.Tools;
using static Ubytec.Language.Syntax.TypeSystem.Types;
using static Ubytec.Language.Tools.FormattingHelper;

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
            if ((Modifiers & ~(TypeModifiers.Global)) != 0)
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
            // ------------------------------------------------------------------
            // 1. push a scope frame for the module
            // ------------------------------------------------------------------
            scopes.Push(new ScopeContext
            {
                StartLabel        = $"module_{Name}_{ID}_{Utf64Codec.Encode(Version)}_{Utf64Codec.Encode(DateTime.UtcNow.ToString())}_{Author}_start",
                EndLabel          = $"module_{Name}_{ID}_{Utf64Codec.Encode(Version)}_{Utf64Codec.Encode(DateTime.UtcNow.ToString())}_{Author}_end",
                DeclaredByKeyword = "module"
            });

            try
            {
                Validate();
                var sb = new StringBuilder();

                // ───────────────────── header ─────────────────────
                sb.Append(FormatCompiledLines($"{scopes.Peek().StartLabel}:", GetDepth(scopes, -1)));
                sb.AppendLine(FormatCompiledLines($"; Module: {Name} v{Version} by {Author}", GetDepth(scopes, -1)));

                // ───────────────────── .data ──────────────────────
                sb.Append(FormatCompiledLines("section .data", GetDepth(scopes)));
                foreach (var fld in Fields)
                    sb.Append(FormatCompiledLines(fld.Compile(scopes), GetDepth(scopes)));
                if (GlobalContext != null)
                    sb.Append(FormatCompiledLines(GlobalContext.Value.Compile(scopes), GetDepth(scopes)));
                sb.AppendLine();

                // ───────────────────── .bss  (zero-init)───────────
                sb.Append(FormatCompiledLines("section .bss", GetDepth(scopes)));
                foreach (var prop in Properties)
                    sb.Append(FormatCompiledLines(prop.Compile(scopes), GetDepth(scopes)));
                sb.AppendLine();

                // ───────────────────── .text ──────────────────────
                sb.Append(FormatCompiledLines("section .text", GetDepth(scopes)));
                sb.Append(FormatCompiledLines("global _start", GetDepth(scopes)));
                sb.AppendLine();

                // interfaces first (just signatures)
                foreach (var iface in Interfaces)
                    sb.Append(FormatCompiledLines(iface.Compile(scopes), GetDepth(scopes)));

                // user types
                foreach (var cls in Classes)
                    sb.Append(FormatCompiledLines(cls.Compile(scopes), GetDepth(scopes)));
                foreach (var st in Structs)
                    sb.Append(FormatCompiledLines(st.Compile(scopes), GetDepth(scopes)));
                foreach (var rec in Records)
                    sb.Append(FormatCompiledLines(rec.Compile(scopes), GetDepth(scopes)));
                foreach (var en in Enums)
                    sb.Append(FormatCompiledLines(en.Compile(scopes), GetDepth(scopes)));

                // functions & actions (now they DO contain the body)
                foreach (var fn in Functions)
                    sb.Append(FormatCompiledLines(fn.Compile(scopes), GetDepth(scopes)));
                foreach (var ac in Actions)
                    sb.Append(FormatCompiledLines(ac.Compile(scopes), GetDepth(scopes)));

                // local context (after funcs because it may emit helpers)
                if (LocalContext != null)
                    sb.Append(FormatCompiledLines(LocalContext.Value.Compile(scopes), GetDepth(scopes)));

                // sub-modules (recursively compiled)
                foreach (var sub in SubModules)
                {
                    sb.Append(FormatCompiledLines($"; ===== sub-module: {sub.Name} =====", GetDepth(scopes)));
                    sb.Append(FormatCompiledLines(sub.Compile(scopes), GetDepth(scopes)));
                }

                // ───────────────────── entry point ────────────────
                sb.AppendLine();
                var mainFunc = Functions.FirstOrDefault(f => f.Name == "Main");
                sb.Append(FormatCompiledLines("_start:", GetDepth(scopes)));
                if (!string.IsNullOrEmpty(mainFunc.Name) && mainFunc.Definition is not null)
                    sb.Append(FormatCompiledLines(
                        $"call {nameof(Func).ToLower()}_{mainFunc.Name}_{mainFunc.ID}_start",
                        GetDepth(scopes, 1)
                    ));
                sb.Append(FormatCompiledLines("mov eax, 60", GetDepth(scopes, 1)));
                sb.Append(FormatCompiledLines("xor edi, edi", GetDepth(scopes, 1)));
                sb.Append(FormatCompiledLines("syscall", GetDepth(scopes, 1)));


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
