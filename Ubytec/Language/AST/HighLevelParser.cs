﻿using Ubytec.Language.HighLevel;
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
            if (toks.Length <= i) return new Module(
                name, version, requires, author,
                [.. fields], [.. props], [.. funcs], [.. actions],
                [.. ifaces], [.. classes], [.. structs], [.. records],
                [.. enums], [.. subMods],
                id: Guid.NewGuid(),
                localContext: localCtx,
                globalContext: globalCtx,
                modifiers: mods
            );
            /* global { … } (max 1) */
            if (toks[i].Scopes.Helper.IsControl("global"))
            {
                if (seenGlobal)
                    _errors.Add(new ParseError(toks[i].Line, "global",
                        "Only one global-context block is allowed per module."));
                globalCtx  = ParseGlobal(toks, ref i);
                seenGlobal = true;
                continue;
            }

            /* local { … } (max 1) */
            if (toks[i].Scopes.Helper.IsControl("local"))
            {
                if (seenLocal)
                    _errors.Add(new ParseError(toks[i].Line, "local",
                        "Only one local-context block is allowed per module."));
                localCtx  = ParseLocal(toks, ref i);
                seenLocal = true;
                continue;
            }

            var tok = toks[i];

            /* regular members (unchanged) */
            if (tok.Scopes.Helper.IsClassLabel) { classes.Add(ParseClass(toks, ref i)); continue; }
            if (tok.Scopes.Helper.IsStructLabel) { structs.Add(ParseStruct(toks, ref i)); continue; }
            if (tok.Scopes.Helper.IsRecordLabel) { records.Add(ParseRecord(toks, ref i)); continue; }
            if (tok.Scopes.Helper.IsInterfaceLabel) { ifaces.Add(ParseInterface(toks, ref i)); continue; }
            if (tok.Scopes.Helper.IsEnumLabel) { enums.Add(ParseEnum(toks, ref i)); continue; }

            if (tok.Scopes.Helper.IsFieldLabel) { fields.Add(ParseField(toks, ref i)); continue; }
            if (tok.Scopes.Helper.IsFuncLabel) { funcs.Add(ParseFunc(toks, ref i)); continue; }
            if (tok.Scopes.Helper.IsActionLabel) { actions.Add(ParseAction(toks, ref i)); continue; }

            if (tok.Scopes.Helper.IsControl("module")) { subMods.Add(ParseModuleInternal(toks, ref i)); continue; }

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
            if (t[i].Scopes.Helper.IsControl("field")) { fields.Add(ParseField(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsStorageType) { props.Add(ParseProperty(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsControl("func")) { funcs.Add(ParseFunc(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsControl("action")) { actions.Add(ParseAction(t, ref i)); continue; }
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
            if (t[i].Scopes.Helper.IsStorageType) { vars.Add(ParseVariable(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsFuncLabel) { funcs.Add(ParseFunc(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsActionLabel) { acts.Add(ParseAction(t, ref i)); continue; }
            i++;
        }
        Consume(t, ref i, MetaBlock, "}");
        return new LocalContext([.. vars], [.. funcs], [.. acts], Guid.NewGuid());
    }

    /*──────────────────────  SINGLE-LINE DECLS  ───────────────────*/
    /* ─────────── FIELD ───────────────────────────────────────────── */
    private static Field ParseField(SyntaxToken[] t, ref int i)
    {
        var mods = ParseModifierFlags(t, ref i);
        Consume(t, ref i, KeywordControl, "field");

        _ = ConsumeType(t, ref i, out var ut);
        var nameTok = Consume(t, ref i, "entity.name.var.explicit.ubytec");
        var valTok = i < t.Length && t[i].Scopes.DataSource.Any(s => s.StartsWith("constant.")) ? t[i++] : default;

        return new Field(nameTok.Source, ut, Guid.NewGuid(),
                         valTok?.Source,
                         mods);
    }

    /* ─────────── VARIABLE (local) ───────────────────────────────── */
    private static Variable ParseVariable(SyntaxToken[] t, ref int i)
    {
        var mods = ParseModifierFlags(t, ref i);
        _ = ConsumeType(t, ref i, out var ut);

        var nameTok = Consume(t, ref i, "entity.name.var.explicit.ubytec");
        var valTok = i < t.Length && t[i].Scopes.DataSource.Any(s => s.StartsWith("constant.")) ? t[i++] : default;

        return new Variable(nameTok.Source, ut, Guid.NewGuid(), mods, valTok?.Source);
    }

    /* ─────────── PROPERTY ─────────────────────────────────────── */
    private static Property ParseProperty(SyntaxToken[] t, ref int i)
    {
        /* 0.  leading modifiers (public, readonly, …) */
        var mods = ParseModifierFlags(t, ref i);

        /* 1.  type  +  identifier */
        _ = ConsumeType(t, ref i, out var ut);
        var nameTok = Consume(t, ref i, "entity.name.var.explicit.ubytec");

        /* 2.  check for an accessor body “{ … }”  */
        var accessorFuncs = new List<Func>();

        if (LookAhead(t, i, MetaBlock, "{"))
        {
            Consume(t, ref i, MetaBlock, "{");

            while (!LookAhead(t, i, MetaBlock, "}"))
            {
                /* only ‘func …’ is allowed inside a property body
                   and the function name must be get / set / init           */
                if (t[i].Scopes.Helper.IsFuncLabel)
                {
                    var fn = ParseFunc(t, ref i);

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
    private static Func ParseFunc(SyntaxToken[] t, ref int i)
    {
        var mods = ParseModifierFlags(t, ref i);
        var nameTok = Consume(t, ref i, EntityNameTypeFunc, "func");
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
    private static Action ParseAction(SyntaxToken[] t, ref int i)
    {
        var mods = ParseModifierFlags(t, ref i);
        Consume(t, ref i, KeywordControl, "action");

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
    private static Class ParseClass(SyntaxToken[] t, ref int i)
    {
        /* 0.  modifiers in front of ‘class’  */
        var mods = ParseModifierFlags(t, ref i);              // may advance i

        /* 1.  keyword + name                                                      */
        Consume(t, ref i, KeywordControl, "class");
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

        if (LookAhead(t, i, KeywordControl, "local"))
            localCtx = ParseLocal(t, ref i);
        else if (LookAhead(t, i, KeywordControl, "global"))
            globalCtx = ParseGlobal(t, ref i);

        /* scan until ‘}’                                                           */
        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            if (t[i].Scopes.Helper.IsFieldLabel) { fields.Add(ParseField(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsStorageType) { props.Add(ParseProperty(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsFuncLabel) { funcs.Add(ParseFunc(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsActionLabel) { actions.Add(ParseAction(t, ref i)); continue; }

            /* nested types ------------------------------------------------------ */
            if (t[i].Scopes.Helper.IsClassLabel) { classes.Add(ParseClass(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsStructLabel) { structs.Add(ParseStruct(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsRecordLabel) { records.Add(ParseRecord(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsInterfaceLabel) { ifaces.Add(ParseInterface(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsEnumLabel) { enums.Add(ParseEnum(t, ref i)); continue; }

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
    private static Enum ParseEnum(SyntaxToken[] t, ref int i)
    {
        /* 0. leading modifiers (public, readonly, …) */
        var mods = ParseModifierFlags(t, ref i);

        /* 1. keyword “enum” + identifier */
        Consume(t, ref i, KeywordControl, "enum");
        var nameTok = Consume(t, ref i, EntityNameTypeEnum);

        /* 2. optional underlying primitive  ( :: t_uint16 ) */
        PrimitiveType underlying = PrimitiveType.Byte;              // language default
        if (LookAhead(t, i, PunctuationScope, "::"))
        {
            i++;                                                     // eat “::”
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
                                s => s.StartsWith("entity.name."),
                                "enum member");

            long value;
            if (LookAhead(t, i, OperatorAssign, "="))
            {
                i++;                                // eat '='
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
                i++;

            /* skip comments / whitespace tokens that might sneak in */
            while (i < t.Length && t[i].Scopes.Helper.IsCommentLineDoubleSlash)
                i++;
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
    private static Struct ParseStruct(SyntaxToken[] t, ref int i)
    {
        /* 0.  modifiers that precede “struct” */
        var mods = ParseModifierFlags(t, ref i);

        /* 1.  keyword + identifier */
        Consume(t, ref i, KeywordControl, "struct");
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
            if (!doneLocals && t[i].Scopes.Helper.IsControl("local"))
            { locals  = ParseLocal(t, ref i); doneLocals  = true; continue; }

            if (!doneGlobals && t[i].Scopes.Helper.IsControl("global"))
            { globals = ParseGlobal(t, ref i); doneGlobals = true; continue; }

            break;
        }

        /* 4.  scan members until ‘}’ */
        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            if (t[i].Scopes.Helper.IsControl("field")) { fields.Add(ParseField(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsStorageType) { props.Add(ParseProperty(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsControl("func")) { funcs.Add(ParseFunc(t, ref i)); continue; }
            if (t[i].Scopes.Helper.IsControl("action")) { actions.Add(ParseAction(t, ref i)); continue; }

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
    private static Interface ParseInterface(SyntaxToken[] t, ref int i)
    {
        /* 0.  any modifiers in front of the keyword */
        var mods = ParseModifierFlags(t, ref i);

        /* 1.  “interface”  keyword + identifier                                      */
        Consume(t, ref i, KeywordControl, "interface");
        var nameTok = Consume(t, ref i, EntityNameTypeInterface);

        /* 2.  body “{ … }”                                                           */
        Consume(t, ref i, MetaBlock, "{");

        var props = new List<Property>();
        var methods = new List<Func>();       // funcs without body
        var actions = new List<Action>();     // actions without body

        while (!LookAhead(t, i, MetaBlock, "}"))
        {
            /* ── a property signature (explicit-type) ───────────────────────────── */
            if (t[i].Scopes.Helper.IsStorageType)
            {
                props.Add(ParseProperty(t, ref i));
                continue;
            }

            /* ── function signature: must NOT have a body ───────────────────────── */
            if (t[i].Scopes.Helper.IsControl("func"))
            {
                var f = ParseFunc(t, ref i);
                if (f.Definition is not null)
                    _errors.Add(new ParseError(
                        t[i].Line, "interface",
                        $"Interface function '{f.Name}' cannot have a body."));
                methods.Add(f);
                continue;
            }

            /* ── action signature: same rule ────────────────────────────────────── */
            if (t[i].Scopes.Helper.IsControl("action"))
            {
                var a = ParseAction(t, ref i);
                if (a.Definition is not null)
                    _errors.Add(new ParseError(
                        t[i].Line, "interface",
                        $"Interface action '{a.Name}' cannot have a body."));
                actions.Add(a);
                continue;
            }

            /* interface must NOT contain fields or nested type definitions          */
            if (t[i].Scopes.Helper.IsControl("field"))
                _errors.Add(new ParseError(
                    t[i].Line, "interface",
                    "Interfaces cannot declare fields. Use properties instead."));

            if (t[i].Scopes.Helper.IsControl("class") || t[i].Scopes.Helper.IsControl("struct") ||
                t[i].Scopes.Helper.IsControl("record") || t[i].Scopes.Helper.IsControl("interface") ||
                t[i].Scopes.Helper.IsControl("enum"))
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
    private static Record ParseRecord(SyntaxToken[] t, ref int i)
    {
        /* 0.  modifiers */
        var mods = ParseModifierFlags(t, ref i);      // may advance i

        /* 1.  optional “type” keyword (module-level alias) */
        if (LookAhead(t, i, KeywordControl, "type"))
            i++;                                      // just consume it

        /* 2.  “record” keyword + identifier */
        Consume(t, ref i, KeywordControl, "record");
        var nameTok = Consume(t, ref i, EntityNameTypeRecord);

        /* 3.  optional positional list “( t_int32 X , … )”  → auto-properties */
        var positionalProps = new List<Property>();
        if (LookAhead(t, i, MetaGrouping, "("))
        {
            Consume(t, ref i, MetaGrouping, "(");
            while (!LookAhead(t, i, MetaGrouping, ")"))
            {
                _ = ConsumeType(t, ref i, out var ut);
                var idTok = Consume(t, ref i, EntityNameArgument);

                positionalProps.Add(
                    new Property(idTok.Source, ut,
                                 new AccessorContext([], Guid.NewGuid(), ut),
                                 Guid.NewGuid(), TypeModifiers.None));

                if (LookAhead(t, i, PunctuationComma, ",")) i++;
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
            if (LookAhead(t, i, KeywordControl, "local"))
                localCtx = ParseLocal(t, ref i);
            else if (LookAhead(t, i, KeywordControl, "global"))
                globalCtx = ParseGlobal(t, ref i);

            var propsList = new List<Property>();
            var funcsList = new List<Func>();
            var actsList = new List<Action>();

            while (!LookAhead(t, i, MetaBlock, "}"))
            {
                if (t[i].Scopes.Helper.IsStorageType) { propsList.Add(ParseProperty(t, ref i)); continue; }
                if (t[i].Scopes.Helper.IsFuncCallKeyword) { funcsList.Add(ParseFunc(t, ref i)); continue; }
                if (t[i].Scopes.Helper.IsActionLabel) { actsList.Add(ParseAction(t, ref i)); continue; }

                /* fields are NOT allowed in records */
                if (t[i].Scopes.Helper.IsFieldLabel)
                    _errors.Add(new ParseError(t[i].Line, "record", $"Fields are not permitted inside record '{nameTok.Source}'."));

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
        if (i < t.Length && t[i].Source.Equals("local", StringComparison.OrdinalIgnoreCase))
        {
            extractedLocals = ParseLocal(t, ref i);

            /* optional semicolon after the local block                       */
            if (LookAhead(t, i, PunctuationSemicolon, ";"))
                i++;

            SkipTrivia(t, ref i);                           // skip EOL / spaces
            bodyStart = i;                                  // real body starts here
        }

        /* 2. seek the matching ‘}’ of the outer body                         */
        int depth = 1;
        while (i < t.Length && depth > 0)
        {
            if (t[i].Scopes.Helper.IsBlockStructure)
                depth += t[i].Source != "}" ? 1 : -1;
            i++;
        }

        var bodyTokens = t[bodyStart..(i - 2)];

        /* 3. statement layer → SyntaxSentence                               */
        var opCodes = ASTCompiler.Parse(bodyTokens);
        var (tree, compileErrors) = ASTCompiler.CompileSyntax(opCodes, bodyTokens);
        if (compileErrors.Count > 0)
            _errors.Add(new ParseError(compileErrors[0].Row, "body", $"Body contains {compileErrors.Count} statement-level error(s)."));
        foreach (var error in compileErrors)
            _errors.Add(new ParseError(error.Row, error.OpCode.OpCode.ToString(format: "x4"), error.Message));

        return tree.RootSentence.Sentences.FirstOrDefault();
    }

    /*──────────────────────────  TOKEN UTILS  ─────────────────────*/
    private static void SkipTrivia(SyntaxToken[] t, ref int i)
    {
        while (i < t.Length &&
               (string.IsNullOrWhiteSpace(t[i].Source) ||
                t[i].Scopes.Length == 0 ||
                (t[i].Scopes.Length == 1 && t[i].Scopes.Helper.IsSource)))
                    i++; // step over whitespace / comments / blank
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
        SkipTrivia(t, ref i);
        if (i >= t.Length)
            _errors.Add(new(t[^1].Line, src ?? "<unknown>", "Unexpected end of tokens"));
        var tk = t[i];
        if (!tk.Scopes.DataSource.Any(scopePred) || (src != null && tk.Source != src))
            _errors.Add(new(tk.Line, src ?? "unknown", $"Expected {src ?? "<token>"} but found '{tk.Source}'"));

        return t[i++];
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
            var val = t[i++].Source.Trim('"');
            dict[key]=val;
            if (LookAhead(t, i, PunctuationComma, ",")) i++;
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
            var nameTok = Consume(t, ref i, EntityNameArgument);
            argObjs.Add(new Argument(nameTok.Source, ut, Guid.NewGuid()));
            if (LookAhead(t, i, PunctuationComma, ",")) i++;
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

        while (i < t.Length && t[i].Scopes.Helper.IsModifier)
        {
            if (_modMap.TryGetValue(t[i].Source, out var m)) mods |= m;
            i++; // consume the modifier token
        }
        return mods;
    }
}