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

        private struct NASM_Header
        {
            public NASM_Header(CompilationScopes scopes, StringBuilder sb, Module thisModule)
            {
                sb.Append(FormatCompiledLines($"{scopes.Peek().StartLabel}:", scopes.GetDepth(-1)));
                sb.AppendLine(FormatCompiledLines($"; Module: {thisModule.Name} v{thisModule.Version} by {thisModule.Author}", scopes.GetDepth(-1)));
            }
        }

        private struct NASM_Metadata
        {
            public NASM_Metadata(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                sb.Append(FormatCompiledLines("; ---------------- Metadata ----------------", scopes.GetDepth()));
                sb.Append(FormatCompiledLines($"; Compilation UTC Time: {DateTime.UtcNow:yyyy-MM-dd HH:mm:ss}Z", scopes.GetDepth()));
                sb.Append(FormatCompiledLines($"; Module UUID: {module.ID}", scopes.GetDepth()));
                if (module.Requires is { Length: > 0 })
                {
                    sb.Append(FormatCompiledLines("; Requires:", scopes.GetDepth()));
                    foreach (var req in module.Requires)
                        sb.Append(FormatCompiledLines($"; - {req}", scopes.GetDepth()));
                }
                sb.AppendLine();
            }
        }

        private struct NASM_Exports
        {
            public NASM_Exports(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                foreach (var fn in module.Functions.Where(f => f.Modifiers.HasFlag(TypeModifiers.Global)))
                {
                    sb.Append(FormatCompiledLines($"global {nameof(Func).ToLower()}_{fn.Name}_{fn.ID}_start", scopes.GetDepth()));
                }
                sb.AppendLine();
            }
        }

        private struct NASM_Data
        {
            public NASM_Data(CompilationScopes scopes, StringBuilder sb, Module thisModule)
            {
                sb.Append(FormatCompiledLines("section .data", scopes.GetDepth()));
                foreach (var fld in thisModule.Fields)
                    sb.Append(FormatCompiledLines(fld.Compile(scopes), scopes.GetDepth()));
                if (thisModule.GlobalContext != null)
                    sb.Append(FormatCompiledLines(thisModule.GlobalContext.Value.Compile(scopes), scopes.GetDepth()));
                sb.AppendLine();
            }
        }

        private struct NASM_BSS
        {
            public NASM_BSS(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                sb.Append(FormatCompiledLines("section .bss", scopes.GetDepth()));
                foreach (var prop in module.Properties)
                    sb.Append(FormatCompiledLines(prop.Compile(scopes), scopes.GetDepth()));
                sb.AppendLine();
            }
        }

        private struct NASM_Text
        {
            public NASM_Text(CompilationScopes scopes, StringBuilder sb)
            {
                sb.Append(FormatCompiledLines("section .text", scopes.GetDepth()));
                sb.Append(FormatCompiledLines("global _start", scopes.GetDepth()));
                sb.AppendLine();
            }
        }

        private struct NASM_Interfaces
        {
            public NASM_Interfaces(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                foreach (var iface in module.Interfaces)
                    sb.Append(FormatCompiledLines(iface.Compile(scopes), scopes.GetDepth()));
            }
        }

        private struct NASM_Types
        {
            public NASM_Types(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                foreach (var cls in module.Classes)
                    sb.Append(FormatCompiledLines(cls.Compile(scopes), scopes.GetDepth()));
                foreach (var st in module.Structs)
                    sb.Append(FormatCompiledLines(st.Compile(scopes), scopes.GetDepth()));
                foreach (var rec in module.Records)
                    sb.Append(FormatCompiledLines(rec.Compile(scopes), scopes.GetDepth()));
                foreach (var en in module.Enums)
                    sb.Append(FormatCompiledLines(en.Compile(scopes), scopes.GetDepth()));
            }
        }

        private struct NASM_FunctionsAndActions
        {
            public NASM_FunctionsAndActions(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                foreach (var fn in module.Functions)
                    sb.Append(FormatCompiledLines(fn.Compile(scopes), scopes.GetDepth()));
                foreach (var ac in module.Actions)
                    sb.Append(FormatCompiledLines(ac.Compile(scopes), scopes.GetDepth()));
            }
        }

        private struct NASM_LocalContext
        {
            public NASM_LocalContext(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                if (module.LocalContext != null)
                    sb.Append(FormatCompiledLines(module.LocalContext.Value.Compile(scopes), scopes.GetDepth()));
            }
        }

        private struct NASM_SubModules
        {
            public NASM_SubModules(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                foreach (var sub in module.SubModules)
                {
                    sb.Append(FormatCompiledLines($"; ===== sub-module: {sub.Name} =====", scopes.GetDepth()));
                    sb.Append(FormatCompiledLines(sub.Compile(scopes), scopes.GetDepth()));
                }
            }
        }

        private struct NASM_EntryPoint
        {
            public NASM_EntryPoint(CompilationScopes scopes, StringBuilder sb, Module module)
            {
                sb.AppendLine();
                var mainFunc = module.Functions.FirstOrDefault(f => f.Name == "Main");
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

                _ = new NASM_Header(scopes, sb, this);
                _ = new NASM_Data(scopes, sb, this);
                _ = new NASM_Metadata(scopes, sb, this);
                _ = new NASM_Exports(scopes, sb, this);
                _ = new NASM_BSS(scopes, sb, this);
                _ = new NASM_Text(scopes, sb);
                _ = new NASM_Interfaces(scopes, sb, this);
                _ = new NASM_Types(scopes, sb, this);
                _ = new NASM_FunctionsAndActions(scopes, sb, this);
                _ = new NASM_LocalContext(scopes, sb, this);
                _ = new NASM_SubModules(scopes, sb, this);
                _ = new NASM_EntryPoint(scopes, sb, this);

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
