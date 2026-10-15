using Ubytec.Language.HighLevel;
using Ubytec.Language.Syntax.Model;
using static Ubytec.Language.Syntax.TypeSystem.Types;
using Action = Ubytec.Language.HighLevel.Action;
using Enum = Ubytec.Language.HighLevel.Enum;

namespace Ubytec.Language.AST;
using static Ubytec.Language.Tools.SyntaxTokenScopeHelper;

public static partial class HighLevelParser
{
    // ──────────────────────────  private state  ──────────────────────────
    private static List<ParseError> _errors = [];

    /*──────────────────────────  PUBLIC  ──────────────────────────*/
    /// <summary>
    /// 
    /// </summary>
    /// <param name="tokens"></param>
    /// <returns></returns>
    public static (Module module, ParseError[] errors) ParseModule(SyntaxToken[] tokens)
    {
        _errors = [];
        var idx = 0;
        var mod = ParseModuleInternal(tokens, ref idx);
        return (mod, [.. _errors]);
    }

    private static Module ParseModuleInternal(SyntaxToken[] toks, ref int i)
    {
        /* 0 .  read optional modifiers (only “global” is legal) */
        var mods = ParseModifierFlags(toks, ref i);
        if ((mods & ~TypeModifiers.Global) != 0)
            _errors.Add(new ParseError(toks[i].Line, "module",
                "Only the 'global' modifier is allowed on a module."));

        /* 1 .  keyword “module” + header */
        Consume(toks, ref i, KeywordControl, "module");
        var header = ParseHeaderArguments(toks, ref i);

        var name = header["name"];
        var version = header["version"];
        var author = header["author"];
        var requires = header.TryGetValue("requires", out var rv)
                     ? rv.Trim('[', ']')
                         .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
                     : [];

        Consume(toks, ref i, MetaBlock, "{");

        /* containers */
        var fields = new List<Field>();
        var props = new List<Property>();
        var funcs = new List<Func>();
        var actions = new List<Action>();
        var ifaces = new List<Interface>();
        var classes = new List<Class>();
        var structs = new List<Struct>();
        var records = new List<Record>();
        var enums = new List<Enum>();
        var subMods = new List<Module>();

        LocalContext? localCtx = null;
        GlobalContext? globalCtx = null;

        /* duplicate-context flags */
        bool seenLocal = false;
        bool seenGlobal = false;

        /* scan until matching '}' */
        while (!LookAhead(toks, i, MetaBlock, "}"))
        {
            if (toks.Length <= i) throw new FormatException("Module body is missing its closing brace.");
            /* global { … } (max 1) */
            if (IsContextBlock(toks, i, "global"))
            {
                if (seenGlobal)
                    _errors.Add(new ParseError(toks[i].Line, "global",
                        "Only one global-context block is allowed per module."));
                globalCtx  = ParseGlobal(toks, ref i);
                seenGlobal = true;
                continue;
            }

            /* local { … } (max 1) */
            if (IsContextBlock(toks, i, "local"))
            {
                if (seenLocal)
                    _errors.Add(new ParseError(toks[i].Line, "local",
                        "Only one local-context block is allowed per module."));
                localCtx  = ParseLocal(toks, ref i);
                seenLocal = true;
                continue;
            }

            if (TryConsumeDeclarationPrefix(toks, ref i, "func", out var funcMods))
            { funcs.Add(ParseFunc(toks, ref i, funcMods)); continue; }

            if (TryConsumeDeclarationPrefix(toks, ref i, "action", out var actionMods))
            { actions.Add(ParseAction(toks, ref i, actionMods)); continue; }

            if (TryConsumeDeclarationPrefix(toks, ref i, "class", out var classMods))
            { classes.Add(ParseClass(toks, ref i, classMods)); continue; }

            if (TryConsumeDeclarationPrefix(toks, ref i, "struct", out var structMods))
            { structs.Add(ParseStruct(toks, ref i, structMods)); continue; }

            if (TryConsumeDeclarationPrefix(toks, ref i, "record", out var recordMods, allowTypePrefix: true))
            { records.Add(ParseRecord(toks, ref i, recordMods)); continue; }

            if (TryConsumeDeclarationPrefix(toks, ref i, "interface", out var interfaceMods))
            { ifaces.Add(ParseInterface(toks, ref i, interfaceMods)); continue; }

            if (TryConsumeDeclarationPrefix(toks, ref i, "enum", out var enumMods))
            { enums.Add(ParseEnum(toks, ref i, enumMods)); continue; }

            if (TryConsumeDeclarationPrefix(toks, ref i, "field", out var fieldMods))
            { fields.Add(ParseField(toks, ref i, fieldMods)); continue; }

            if (LookAhead(toks, i, KeywordControl, "module"))
            { subMods.Add(ParseModuleInternal(toks, ref i)); continue; }

            i++;   // skip comments / whitespace / unknown
        }

        Consume(toks, ref i, MetaBlock, "}");

        /* build & return */
        return new Module(
            name, version, requires, author,
            [.. fields], [.. props], [.. funcs], [.. actions],
            [.. ifaces], [.. classes], [.. structs], [.. records],
            [.. enums], [.. subMods],
            id: Guid.NewGuid(),
            localContext: localCtx,
            globalContext: globalCtx,
            modifiers: mods
        );
    }


    /*──────────────────────  GLOBAL / LOCAL  ─────────────────────*/

    private static GlobalContext ParseGlobal(SyntaxToken[] t, ref int i)
    {
        Consume(t, ref i, StorageModifier, "global");
        Consume(t, ref i, MetaBlock, "{");

        var fields = new List<Field>();
        var props = new List<Property>();
        var funcs = new List<Func>();
        var actions = new List<Action>();

        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            if (TryConsumeDeclarationPrefix(t, ref i, "field", out var fieldMods))
            { fields.Add(ParseField(t, ref i, fieldMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "func", out var funcMods))
            { funcs.Add(ParseFunc(t, ref i, funcMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "action", out var actionMods))
            { actions.Add(ParseAction(t, ref i, actionMods)); continue; }

            if (TryBeginTypedDeclaration(t, ref i, out var propertyMods))
            { props.Add(ParseProperty(t, ref i, propertyMods)); continue; }

            i++;
        }
        Consume(t, ref i, MetaBlock, "}");
        return new GlobalContext([.. fields], [.. props], [.. funcs], [.. actions], Guid.NewGuid());
    }

    private static LocalContext ParseLocal(SyntaxToken[] t, ref int i)
    {
        Consume(t, ref i, StorageModifier, "local");
        Consume(t, ref i, MetaBlock, "{");

        var vars = new List<Variable>();
        var funcs = new List<Func>();
        var acts = new List<Action>();

        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            if (i >= t.Length) throw new FormatException("Local context has no closing brace.");

            if (TryConsumeDeclarationPrefix(t, ref i, "func", out var funcMods))
            { funcs.Add(ParseFunc(t, ref i, funcMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "action", out var actionMods))
            { acts.Add(ParseAction(t, ref i, actionMods)); continue; }

            if (TryBeginTypedDeclaration(t, ref i, out var variableMods))
            { vars.Add(ParseVariable(t, ref i, variableMods)); continue; }

            i++;
        }
        Consume(t, ref i, MetaBlock, "}");
        return new LocalContext([.. vars], [.. funcs], [.. acts], Guid.NewGuid());
    }

    /*──────────────────────  SINGLE-LINE DECLS  ───────────────────*/
    /* ─────────── FIELD ───────────────────────────────────────────── */
    // Contract: the caller consumed modifiers + "field"; i points at the field type.
    private static Field ParseField(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        _ = ConsumeType(t, ref i, out var ut);
        var nameTok = Consume(t, ref i, EntityNameField);
        SkipTrivia(t, ref i);
        var valTok = i < t.Length && t[i].Scopes.DataSource.Any(s => s.StartsWith("constant.")) ? t[i++] : default;

        return new Field(nameTok.Source, ut, Guid.NewGuid(),
                         valTok?.Source,
                         mods);
    }

    /* ─────────── VARIABLE (local) ───────────────────────────────── */
    // Contract: the caller consumed modifiers; i points at the variable type.
    private static Variable ParseVariable(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        _ = ConsumeType(t, ref i, out var ut);

        var nameTok = Consume(t, ref i, EntityNameVarExplicit);
        SkipTrivia(t, ref i);
        var valTok = i < t.Length && t[i].Scopes.DataSource.Any(s => s.StartsWith("constant.")) ? t[i++] : default;

        return new Variable(nameTok.Source, ut, Guid.NewGuid(), mods, valTok?.Source);
    }

    /* ─────────── PROPERTY ─────────────────────────────────────── */
    // Contract: the caller consumed modifiers; i points at the property type.
    private static Property ParseProperty(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        /* 1.  type  +  identifier */
        _ = ConsumeType(t, ref i, out var ut);
        var nameTok = Consume(t, ref i, EntityNameVarExplicit);

        /* 2.  check for an accessor body “{ … }”  */
        var accessorFuncs = new List<Func>();

        if (LookAhead(t, i, MetaBlock, "{"))
        {
            Consume(t, ref i, MetaBlock, "{");

            while (!LookAhead(t, i, MetaBlock, "}"))
            {
                /* only ‘func …’ is allowed inside a property body
                   and the function name must be get / set / init           */
                if (TryConsumeDeclarationPrefix(t, ref i, "func", out var accessorMods))
                {
                    var fn = ParseFunc(t, ref i, accessorMods);

                    var n = fn.Name.ToLowerInvariant();
                    if (n is not ("get" or "set" or "init"))
                        _errors.Add(new ParseError(
                            t[i].Line, "property",
                            $"Invalid accessor '{fn.Name}' inside property '{nameTok.Source}'. " +
                            "Expected 'get', 'set', or 'init'."));

                    accessorFuncs.Add(fn);
                    continue;
                }

                /* anything else (comment/whitespace) */
                i++;
            }

            Consume(t, ref i, MetaBlock, "}");   // closing brace
        }

        /* 3.  build AccessorContext (will self-validate) */
        var accCtx = new AccessorContext(
                         [.. accessorFuncs],
                         Guid.NewGuid(),
                         ut);

        /* 4.  final Property */
        return new Property(
                   nameTok.Source,
                   ut,
                   accCtx,
                   Guid.NewGuid(),
                   mods);
    }

    /* ─────────── FUNC ──────────────────────────────────────────── */
    // Contract: the caller consumed modifiers + "func"; i points at the function name.
    private static Func ParseFunc(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        var nameTok = Consume(t, ref i, EntityNameTypeFunc);
        ParseParamList(t, ref i, out var args);

        UType ret = new UType(PrimitiveType.Void);
        if (LookAhead(t, i, PunctuationArrow, "->"))
        {
            Consume(t, ref i, PunctuationArrow, "->");
            ConsumeType(t, ref i, out ret);       // return type
        }

        var body = ParseOptionalBody(t, ref i, out var innerLocals);

        return new Func(
            nameTok.Source,
            ret,
            Guid.NewGuid(),
            [.. args],
            locals: innerLocals,
            modifiers: mods,
            definitionSentence: body);
    }

    /* ─────────── ACTION ───────────────────────────────────────── */
    // Contract: the caller consumed modifiers + "action"; i points at the action name.
    private static Action ParseAction(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        var nameTok = Consume(t, ref i, EntityNameTypeAction);
        ParseParamList(t, ref i, out var args);

        var body = ParseOptionalBody(t, ref i, out var innerLocals);
        return new Action(
            nameTok.Source,
            Guid.NewGuid(),
            [.. args],
            locals: innerLocals,
            modifiers: mods,
            definitionSentence: body);
    }
    /*──────────────────────  ParseClass  ──────────────────────*/
    // Contract: the caller consumed modifiers + "class"; i points at the class name.
    private static Class ParseClass(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        var nameTok = Consume(t, ref i, EntityNameTypeClass);

        /* 2.  body “{ … }”                                                        */
        Consume(t, ref i, MetaBlock, "{");

        var fields = new List<Field>();
        var props = new List<Property>();
        var funcs = new List<Func>();
        var actions = new List<Action>();
        var ifaces = new List<Interface>();
        var classes = new List<Class>();
        var structs = new List<Struct>();
        var records = new List<Record>();
        var enums = new List<Enum>();

        /* optional leading local / global contexts */
        LocalContext? localCtx = null;
        GlobalContext? globalCtx = null;

        if (IsContextBlock(t, i, "local"))
            localCtx = ParseLocal(t, ref i);
        else if (IsContextBlock(t, i, "global"))
            globalCtx = ParseGlobal(t, ref i);

        /* scan until ‘}’                                                           */
        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            if (TryConsumeDeclarationPrefix(t, ref i, "field", out var fieldMods))
            { fields.Add(ParseField(t, ref i, fieldMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "func", out var funcMods))
            { funcs.Add(ParseFunc(t, ref i, funcMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "action", out var actionMods))
            { actions.Add(ParseAction(t, ref i, actionMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "class", out var classMods))
            { classes.Add(ParseClass(t, ref i, classMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "struct", out var structMods))
            { structs.Add(ParseStruct(t, ref i, structMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "record", out var recordMods, allowTypePrefix: true))
            { records.Add(ParseRecord(t, ref i, recordMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "interface", out var interfaceMods))
            { ifaces.Add(ParseInterface(t, ref i, interfaceMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "enum", out var enumMods))
            { enums.Add(ParseEnum(t, ref i, enumMods)); continue; }

            if (TryBeginTypedDeclaration(t, ref i, out var propertyMods))
            { props.Add(ParseProperty(t, ref i, propertyMods)); continue; }

            i++;   // comment / whitespace / unknown → skip
        }

        Consume(t, ref i, MetaBlock, "}");          // closing brace

        /* 3.  build & return                                                      */
        return new Class(
            nameTok.Source,
            [.. fields], [.. props], [.. funcs], [.. actions],
            [.. ifaces], [.. classes], [.. structs], [.. records], [.. enums],
            Guid.NewGuid(),
            locals: localCtx,
            globals: globalCtx,
            modifiers: mods);
    }
    /*──────────────────────  ParseEnum  ──────────────────────*/
    // Contract: the caller consumed modifiers + "enum"; i points at the enum name.
    private static Enum ParseEnum(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        var nameTok = Consume(t, ref i, EntityNameTypeEnum);

        /* 2. optional underlying primitive  ( :: t_uint16 ) */
        PrimitiveType underlying = PrimitiveType.Byte;              // language default
        if (LookAhead(t, i, PunctuationScope, "::"))
        {
            Consume(t, ref i, PunctuationScope, "::");
            ConsumeType(t, ref i, out var ut);                       // t_int32 / [t_int32]?
            underlying = ut.Type;                                    // only primitive part
        }

        /* 3. body “{ … }”  – members ( NAME [= constant] ) */
        Consume(t, ref i, MetaBlock, "{");

        var members = new List<(string Name, long Value)>();
        long autoVal = 0;

        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            /* identifier token – grammar labels each as entity.name… */
            var idTok = Consume(t, ref i,
                                s => s.StartsWith("entity.name."));

            long value;
            if (LookAhead(t, i, OperatorAssign, "="))
            {
                Consume(t, ref i, OperatorAssign, "=");
                SkipTrivia(t, ref i);
                if (i >= t.Length)
                    throw new FormatException($"Enum member '{idTok.Source}' is missing its assigned value.");
                var valTok = t[i++];
                value      = ParseEnumConstant(valTok);
                autoVal    = value + 1;             // next implicit value
            }
            else
            {
                value = autoVal++;
            }

            members.Add((idTok.Source, value));

            /* optional trailing comma */
            if (LookAhead(t, i, PunctuationComma, ","))
                Consume(t, ref i, PunctuationComma, ",");

            SkipTrivia(t, ref i);
        }

        Consume(t, ref i, MetaBlock, "}");        // closing brace

        /* 4. determine bit-field property */
        bool isBitfield = members.All(m =>
            m.Value == 0 || (m.Value & (m.Value - 1)) == 0);

        /* 5. build Enum HL-entity */
        return new Enum(
            nameTok.Source,
            [.. members],
            Guid.NewGuid(),
            typeSize: underlying,
            isBitField: isBitfield,
            modifiers: mods);
    }
    /*──────────────────────  ParseStruct  ──────────────────────*/
    // Contract: the caller consumed modifiers + "struct"; i points at the struct name.
    private static Struct ParseStruct(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        var nameTok = Consume(t, ref i, EntityNameTypeStruct);

        /* 2.  opening brace */
        Consume(t, ref i, MetaBlock, "{");

        /* 3.  member containers */
        var fields = new List<Field>();
        var props = new List<Property>();
        var funcs = new List<Func>();
        var actions = new List<Action>();

        /* optional leading local / global blocks (may appear in any order, once each) */
        LocalContext? locals = null;
        GlobalContext? globals = null;

        bool doneLocals = false;
        bool doneGlobals = false;
        while (true)
        {
            if (!doneLocals && IsContextBlock(t, i, "local"))
            { locals  = ParseLocal(t, ref i); doneLocals  = true; continue; }

            if (!doneGlobals && IsContextBlock(t, i, "global"))
            { globals = ParseGlobal(t, ref i); doneGlobals = true; continue; }

            break;
        }

        /* 4.  scan members until ‘}’ */
        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            if (TryConsumeDeclarationPrefix(t, ref i, "field", out var fieldMods))
            { fields.Add(ParseField(t, ref i, fieldMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "func", out var funcMods))
            { funcs.Add(ParseFunc(t, ref i, funcMods)); continue; }

            if (TryConsumeDeclarationPrefix(t, ref i, "action", out var actionMods))
            { actions.Add(ParseAction(t, ref i, actionMods)); continue; }

            if (TryBeginTypedDeclaration(t, ref i, out var propertyMods))
            { props.Add(ParseProperty(t, ref i, propertyMods)); continue; }

            /* comments / whitespace / unknown → skip */
            i++;
        }

        Consume(t, ref i, MetaBlock, "}");  // closing brace

        /* 5.  build HL-Struct entity */
        return new Struct(
            nameTok.Source,
            [.. fields], [.. props], [.. funcs], [.. actions],
            Guid.NewGuid(),
            locals,
            globals,
            mods);
    }
    /*──────────────────────  ParseInterface  ──────────────────────*/
    // Contract: the caller consumed modifiers + "interface"; i points at the interface name.
    private static Interface ParseInterface(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        var nameTok = Consume(t, ref i, EntityNameTypeInterface);

        /* 2.  body “{ … }”                                                           */
        Consume(t, ref i, MetaBlock, "{");

        var props = new List<Property>();
        var methods = new List<Func>();       // funcs without body
        var actions = new List<Action>();     // actions without body

        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            /* ── function signature: must NOT have a body ───────────────────────── */
            if (TryConsumeDeclarationPrefix(t, ref i, "func", out var funcMods))
            {
                var f = ParseFunc(t, ref i, funcMods);
                if (f.Definition is not null)
                    _errors.Add(new ParseError(
                        t[Math.Min(i, t.Length - 1)].Line, "interface",
                        $"Interface function '{f.Name}' cannot have a body."));
                methods.Add(f);
                continue;
            }

            /* ── action signature: same rule ────────────────────────────────────── */
            if (TryConsumeDeclarationPrefix(t, ref i, "action", out var actionMods))
            {
                var a = ParseAction(t, ref i, actionMods);
                if (a.Definition is not null)
                    _errors.Add(new ParseError(
                        t[Math.Min(i, t.Length - 1)].Line, "interface",
                        $"Interface action '{a.Name}' cannot have a body."));
                actions.Add(a);
                continue;
            }

            /* ── a property signature (explicit-type) ───────────────────────────── */
            if (TryBeginTypedDeclaration(t, ref i, out var propertyMods))
            {
                props.Add(ParseProperty(t, ref i, propertyMods));
                continue;
            }

            /* interface must NOT contain fields or nested type definitions          */
            if (LookAhead(t, i, KeywordControl, "field"))
                _errors.Add(new ParseError(
                    t[i].Line, "interface",
                    "Interfaces cannot declare fields. Use properties instead."));

            if (LookAhead(t, i, KeywordControl, "class") || LookAhead(t, i, KeywordControl, "struct") ||
                LookAhead(t, i, KeywordControl, "record") || LookAhead(t, i, KeywordControl, "interface") ||
                LookAhead(t, i, KeywordControl, "enum"))
                _errors.Add(new ParseError(
                    t[i].Line, "interface",
                    "Interfaces cannot contain nested type declarations."));

            /* skip comments / whitespace / unknown tokens                           */
            i++;
        }

        Consume(t, ref i, MetaBlock, "}");  // closing brace

        /* 3.  build HL-Interface entity                                              */
        return new Interface(
            nameTok.Source,
            [.. props], [.. methods], [.. actions],
            Guid.NewGuid(),
            modifiers: mods);
    }
    /*──────────────────────  ParseRecord  ──────────────────────*/
    // Contract: the caller consumed modifiers + optional "type" + "record"; i points at the record name.
    private static Record ParseRecord(SyntaxToken[] t, ref int i, TypeModifiers mods)
    {
        var nameTok = Consume(t, ref i, EntityNameTypeRecord);

        /* 3.  optional positional list “( t_int32 X , … )”  → auto-properties */
        var positionalProps = new List<Property>();
        if (LookAhead(t, i, MetaGrouping, "("))
        {
            Consume(t, ref i, MetaGrouping, "(");
            while (!LookAhead(t, i, MetaGrouping, ")"))
            {
                _ = ConsumeType(t, ref i, out var ut);
                var idTok = Consume(t, ref i, s => s == EntityNameArgument || s == EntityNameVarExplicit);

                positionalProps.Add(
                    new Property(idTok.Source, ut,
                                 new AccessorContext([], Guid.NewGuid(), ut),
                                 Guid.NewGuid(), TypeModifiers.None));

                if (LookAhead(t, i, PunctuationComma, ",")) Consume(t, ref i, PunctuationComma, ",");
            }
            Consume(t, ref i, MetaGrouping, ")");
        }

        /* 4.  check for a body “{ … }”  — optional */
        Property[] extraProps = [];
        Func[] funcs = [];
        Action[] acts = [];
        LocalContext? localCtx = null;
        GlobalContext? globalCtx = null;

        if (LookAhead(t, i, MetaBlock, "{"))
        {
            Consume(t, ref i, MetaBlock, "{");

            /* optional leading local / global ctx inside the record */
            if (IsContextBlock(t, i, "local"))
                localCtx = ParseLocal(t, ref i);
            else if (IsContextBlock(t, i, "global"))
                globalCtx = ParseGlobal(t, ref i);

            var propsList = new List<Property>();
            var funcsList = new List<Func>();
            var actsList = new List<Action>();

            while (!LookAhead(t, i, MetaBlock, "}"))
            {
                if (TryConsumeDeclarationPrefix(t, ref i, "func", out var funcMods))
                { funcsList.Add(ParseFunc(t, ref i, funcMods)); continue; }

                if (TryConsumeDeclarationPrefix(t, ref i, "action", out var actionMods))
                { actsList.Add(ParseAction(t, ref i, actionMods)); continue; }

                if (TryConsumeDeclarationPrefix(t, ref i, "field", out var fieldMods))
                {
                    _ = ParseField(t, ref i, fieldMods);
                    _errors.Add(new ParseError(
                        t[Math.Min(i, t.Length - 1)].Line,
                        "record",
                        $"Fields are not permitted inside record '{nameTok.Source}'."));
                    continue;
                }

                if (TryBeginTypedDeclaration(t, ref i, out var propertyMods))
                { propsList.Add(ParseProperty(t, ref i, propertyMods)); continue; }

                i++;   // comment / whitespace
            }
            Consume(t, ref i, MetaBlock, "}");   // closing brace

            extraProps = [.. propsList];
            funcs      = [.. funcsList];
            acts       = [.. actsList];
        }

        /* 5.  compose final property array (positional first) */
        var allProps = positionalProps.Concat(extraProps).ToArray();

        /* 6.  build & return Record */
        return new Record(
            nameTok.Source,
            allProps,
            funcs,
            acts,
            id: Guid.NewGuid(),
            locals: localCtx,
            globals: globalCtx,
            modifiers: mods);
    }
    /*──────────────────────────  HELPERS  ─────────────────────────*/

    /// <summary>
    /// Returns true only for a local/global context introducer followed by a block.
    /// This keeps <c>global func ...</c> and <c>local field ...</c> available as
    /// declaration modifiers instead of misclassifying them as context blocks.
    /// </summary>
    private static bool IsContextBlock(SyntaxToken[] t, int i, string keyword)
    {
        var cursor = i;
        SkipTrivia(t, ref cursor);
        if (cursor >= t.Length ||
            !t[cursor].Scopes.DataSource.Contains(StorageModifier) ||
            !t[cursor].Source.Equals(keyword, StringComparison.OrdinalIgnoreCase))
            return false;

        cursor++;
        return LookAhead(t, cursor, MetaBlock, "{");
    }

    /// <summary>
    /// Tries to consume a declaration prefix without mutating the caller cursor on failure.
    /// On success, modifiers and the declaration keyword are consumed and <paramref name="i"/>
    /// points at the first token owned by the declaration-specific parser.
    /// </summary>
    private static bool TryConsumeDeclarationPrefix(
        SyntaxToken[] t,
        ref int i,
        string keyword,
        out TypeModifiers modifiers,
        bool allowTypePrefix = false)
    {
        var cursor = i;
        SkipTrivia(t, ref cursor);
        modifiers = ParseModifierFlags(t, ref cursor);
        SkipTrivia(t, ref cursor);

        if (allowTypePrefix && LookAhead(t, cursor, KeywordControl, "type"))
        {
            Consume(t, ref cursor, KeywordControl, "type");
            SkipTrivia(t, ref cursor);
        }

        if (!LookAhead(t, cursor, KeywordControl, keyword))
        {
            modifiers = TypeModifiers.None;
            return false;
        }

        Consume(t, ref cursor, KeywordControl, keyword);
        i = cursor;
        return true;
    }

    /// <summary>
    /// Tries to consume declaration modifiers for a declaration that begins directly with a type.
    /// On success <paramref name="i"/> points at that type.
    /// </summary>
    private static bool TryBeginTypedDeclaration(
        SyntaxToken[] t,
        ref int i,
        out TypeModifiers modifiers)
    {
        var cursor = i;
        SkipTrivia(t, ref cursor);
        modifiers = ParseModifierFlags(t, ref cursor);
        SkipTrivia(t, ref cursor);

        if (cursor >= t.Length || !t[cursor].Scopes.Helper.IsStorageType)
        {
            modifiers = TypeModifiers.None;
            return false;
        }

        i = cursor;
        return true;
    }

    /* numeric literal → long   (supports  decimal / 0xHEX / 0bBIN) */
    private static long ParseEnumConstant(SyntaxToken tok)
    {
        if (tok.Scopes.Helper.IsNumericHex)
            return Convert.ToInt64(tok.Source[2..], 16);

        if (tok.Scopes.Helper.IsNumericBinary)
            return Convert.ToInt64(tok.Source[2..], 2);

        // decimal int literal
        return long.Parse(tok.Source, System.Globalization.NumberStyles.Integer);
    }
    /*──────────────────────  ParseOptionalBody  ──────────────────────*/
    private static SyntaxSentence? ParseOptionalBody(SyntaxToken[] t, ref int i, out LocalContext? extractedLocals)
    {
        extractedLocals = null;

        if (LookAhead(t, i, OperatorInlineReturn, "=>"))
        {
            Consume(t, ref i, OperatorInlineReturn, "=>");
            SkipTrivia(t, ref i);                               // ← NEW
        }
        else if (!LookAhead(t, i, MetaBlock, "{")) /* 0. body absent → declaration‑only */
            return null;

        /* 1. “{”                                                            */
        Consume(t, ref i, MetaBlock, "{");
        SkipTrivia(t, ref i);                               // ← NEW

        int bodyStart = i;

        /* ── optional  local { … }  right after the opening brace ───────── */
        if (IsContextBlock(t, i, "local"))
        {
            extractedLocals = ParseLocal(t, ref i);

            /* optional semicolon after the local block                       */
            if (LookAhead(t, i, PunctuationSemicolon, ";"))
                Consume(t, ref i, PunctuationSemicolon, ";");

            SkipTrivia(t, ref i);                           // skip EOL / spaces
            bodyStart = i;                                  // real body starts here
        }

        /* 2. seek the matching ‘}’ of the outer body                         */
        int depth = 1;
        while (i < t.Length && depth > 0)
        {
            if (t[i].Source == "{") depth++;
            else if (t[i].Source == "}") depth--;
            i++;
        }

        if (depth != 0) throw new FormatException("Function body has no closing brace.");
        var bodyTokens = t[bodyStart..(i - 1)];

        /* 3. statement layer → SyntaxSentence                               */
        var opCodes = ASTCompiler.Parse(bodyTokens);
        var (tree, compileErrors) = ASTCompiler.CompileSyntax(opCodes, bodyTokens);
        if (compileErrors.Count > 0)
            _errors.Add(new ParseError(compileErrors[0].Row, "body", $"Body contains {compileErrors.Count} statement-level error(s)."));
        foreach (var error in compileErrors)
            _errors.Add(new ParseError(error.Row, error.OpCode.OpCode.ToString(format: "x4"), error.Message));

        return tree.RootSentence;
    }

    /*──────────────────────────  TOKEN UTILS  ─────────────────────*/
    private static void SkipTrivia(SyntaxToken[] t, ref int i)
    {
        while (i < t.Length &&
               (string.IsNullOrWhiteSpace(t[i].Source) ||
                t[i].Scopes.Length == 0 ||
                (t[i].Scopes.Length == 1 && t[i].Scopes.Helper.IsSource) ||
                t[i].Scopes.Helper.IsCommentLineDoubleSlash ||
                t[i].Scopes.Helper.IsCommentBlock))
            i++;
    }

    private static SyntaxToken ConsumeType(SyntaxToken[] t, ref int i, out UType ut)
    {
        var tk = Consume(t, ref i, s => s.StartsWith(StorageTypePrefix), src: null);
        ut = ParseUType(tk);
        return tk;
    }

    private static SyntaxToken Consume(SyntaxToken[] t, ref int i, string scope, string? src = null)
        => Consume(t, ref i, s => s == scope, src);

    private static SyntaxToken Consume(SyntaxToken[] t, ref int i, Func<string, bool> scopePred, string? src = null)
    {
        var cursor = i;
        SkipTrivia(t, ref cursor);

        if (cursor >= t.Length)
            throw new FormatException($"Unexpected end of tokens while reading {src ?? "<token>"}.");

        var tk = t[cursor];
        if (!tk.Scopes.DataSource.Any(scopePred) || (src != null && tk.Source != src))
            throw new FormatException($"Expected {src ?? "<token>"} but found '{tk.Source}' at line {tk.Line + 1}.");

        i = cursor + 1;
        return tk;
    }

    /// <summary>
    /// Looks ahead in the token stream starting from index i,
    /// skipping over any trivia tokens (e.g., whitespace, comments),
    /// and checks if the next significant token matches a specific scope and source text.
    /// </summary>
    /// <param name="t">Array of tokens to search.</param>
    /// <param name="i">Current index to start looking ahead from.</param>
    /// <param name="scope">Scope string to match in the lookahead token.</param>
    /// <param name="src">Source text to match exactly in the lookahead token.</param>
    /// <returns>
    /// True if a non-trivia token is found after i that matches both the scope and the exact source text;
    /// otherwise, false.
    /// </returns>
    private static bool LookAhead(SyntaxToken[] t, int i, string scope, string src)
    {
        var j = i; // Start from the given index

        // Advance j forward skipping any trivia (whitespace/comments/etc.)
        SkipTrivia(t, ref j);

        // Return true if we didn't run off the end of the array,
        // and the next non-trivia token matches both the specified scope and source text exactly.
        return j < t.Length &&
               t[j].Scopes.DataSource.Contains(scope) &&
               t[j].Source == src;
    }

    private static Dictionary<string, string> ParseHeaderArguments(SyntaxToken[] t, ref int i)
    {
        var dict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        Consume(t, ref i, MetaGrouping, "(");
        while (!LookAhead(t, i, MetaGrouping, ")"))
        {
            SkipTrivia(t, ref i);
            var key = Consume(t, ref i, EntityNameArgument).Source;
            Consume(t, ref i, PunctuationSeparatorKeyValue, ":");
            SkipTrivia(t, ref i);
            var val = t[i++].Source.Trim('"');
            dict[key]=val;
            if (LookAhead(t, i, PunctuationComma, ",")) Consume(t, ref i, PunctuationComma, ",");
        }
        Consume(t, ref i, MetaGrouping, ")");
        return dict;
    }

    private static SyntaxToken[] ParseParamList(SyntaxToken[] t, ref int i, out List<Argument> argObjs)
    {
        argObjs = [];
        if (!LookAhead(t, i, MetaGrouping, "(")) return [];

        var start = i;
        Consume(t, ref i, MetaGrouping, "(");
        while (!LookAhead(t, i, MetaGrouping, ")"))
        {
            SkipTrivia(t, ref i);
            _ = ConsumeType(t, ref i, out var ut);
            var nameTok = Consume(t, ref i, s => s == EntityNameArgument || s == EntityNameVarExplicit);
            argObjs.Add(new Argument(nameTok.Source, ut, Guid.NewGuid()));
            if (LookAhead(t, i, PunctuationComma, ",")) Consume(t, ref i, PunctuationComma, ",");
        }
        Consume(t, ref i, MetaGrouping, ")");
        return t[start..i];
    }

    private static UType ParseUType(SyntaxToken tk)
    {
        /* ───────────────────────────── 1.  base primitive ────────────────────────── */
        // Quitamos los adornos [, ], ?, t_  para intentar resolver un PrimitiveType nativo
        string raw = tk.Source
                    .TrimEnd('?')
                    .TrimStart('[', ' ')          // posible '[' al inicio
                    .TrimEnd(']', ' ')            //   y ']' al final
                    .TrimStart('t', '_')          // prefijo   t_
                    .TrimEnd('?');                // nullable  ?

        bool ok = System.Enum.TryParse(raw, ignoreCase: true, out PrimitiveType prim);

        if (!ok) prim = PrimitiveType.CustomType;   // todo lo no-nativo ⇒ custom

        /* ───────────────────────────── 2.  modifiers  ────────────────────────────── */
        TypeModifiers mods = TypeModifiers.None;
        var s = tk.Scopes;

        if (s.Helper.IsArray) mods |= TypeModifiers.IsArray;
        if (s.Helper.IsArrayNullableArray || s.Helper.IsArrayNullableBoth) mods |= TypeModifiers.NullableArray;
        if (s.Helper.IsArrayNullableItems || s.Helper.IsArrayNullableBoth) mods |= TypeModifiers.NullableItems;
        if (s.Helper.IsSingleNullable) mods |= TypeModifiers.Nullable;

        if (prim == PrimitiveType.CustomType)
        {
            string customName = raw;
            return new UType(
                PrimitiveType.CustomType,
                mods,
                id: UType.TypeIDLUT[customName],
                name: customName
            );
        }

        return new UType(prim, mods, FromPrimitive(prim), prim.ToString());
    }

    private static readonly Dictionary<string, TypeModifiers> _modMap = new(StringComparer.OrdinalIgnoreCase)
    {
        [nameof(TypeModifiers.Public)]    = TypeModifiers.Public,
        [nameof(TypeModifiers.Private)]   = TypeModifiers.Private,
        [nameof(TypeModifiers.Protected)] = TypeModifiers.Protected,
        [nameof(TypeModifiers.Internal)]  = TypeModifiers.Internal,
        [nameof(TypeModifiers.Secret)]    = TypeModifiers.Secret,

        [nameof(TypeModifiers.Abstract)]  = TypeModifiers.Abstract,
        [nameof(TypeModifiers.Virtual)]   = TypeModifiers.Virtual,
        [nameof(TypeModifiers.Override)]  = TypeModifiers.Override,
        [nameof(TypeModifiers.Sealed)]    = TypeModifiers.Sealed,
        [nameof(TypeModifiers.ReadOnly)]  = TypeModifiers.ReadOnly,
        [nameof(TypeModifiers.Const)]     = TypeModifiers.Const,

        [nameof(TypeModifiers.Local)]     = TypeModifiers.Local,
        [nameof(TypeModifiers.Global)]    = TypeModifiers.Global
    };

    /// <summary>
    /// Reads every consecutive <c>storage.modifier.ubytec</c> token that starts at
    /// <paramref name="i"/> and converts them to flags.
    /// </summary>
    private static TypeModifiers ParseModifierFlags(SyntaxToken[] t, ref int i)
    {
        TypeModifiers mods = TypeModifiers.None;

        while (true)
        {
            SkipTrivia(t, ref i);
            if (i >= t.Length || !t[i].Scopes.Helper.IsModifier)
                break;

            if (_modMap.TryGetValue(t[i].Source, out var m)) mods |= m;
            i++; // consume the modifier token
        }
        return mods;
    }
}