using Ubytec.Language.Syntax.Model;

namespace Ubytec.Language.Tools
{
    /// <summary>
    /// Provides a strongly-typed helper for checking the scopes of a <see cref="SyntaxToken"/>.
    /// 
    /// This class wraps a <paramref name="token"/> and exposes boolean properties for each recognized
    /// scope in the Ubytec language (e.g., IsNumericInt, IsCommentLineDoubleSlash, IsArrayStructure),
    /// simplifying parsing and improving code readability by avoiding scattered string checks.
    /// </summary>
    /// <param name="token">
    /// The <see cref="SyntaxToken"/> to analyze. All scope checks will be performed on this token.
    /// </param>
    public class SyntaxTokenScopeHelper(SyntaxToken token)
    {
        #region Constants
        // ====================================================================
        // STORAGE TYPE PREFIX
        // ====================================================================

        /// <summary>
        /// Base prefix for all storage‑type scope names.
        /// Combine with specific qualifiers to build full scope strings.
        /// </summary>
        public const string StorageTypePrefix = "storage.type.";

        // ====================================================================
        // SOURCE
        // ====================================================================

        /// <summary>
        /// Root scope for a file containing Ubytec source code.
        /// </summary>
        public const string Source = "source.ubytec";

        // ====================================================================
        // STORAGE TYPES
        // ====================================================================

        /// <summary>
        /// Array type where both the array reference and its items may be <c>null</c>.
        /// </summary>
        public const string StorageTypeArrayNullableBoth = "storage.type.array.nullable-both.ubytec";

        /// <summary>
        /// Array reference may be <c>null</c>; items are guaranteed non‑null.
        /// </summary>
        public const string StorageTypeArrayNullableArray = "storage.type.array.nullable-array.ubytec";

        /// <summary>
        /// Non‑null array, but its items may each be <c>null</c>.
        /// </summary>
        public const string StorageTypeArrayNullableItems = "storage.type.array.nullable-items.ubytec";

        /// <summary>
        /// Single scalar value that may be <c>null</c>.
        /// </summary>
        public const string StorageTypeSingleNullable = "storage.type.single.nullable.ubytec";

        /// <summary>
        /// Single scalar value that cannot be <c>null</c>.
        /// </summary>
        public const string StorageTypeSingle = "storage.type.single.ubytec";

        /// <summary>
        /// Non‑null array of non‑null items.
        /// </summary>
        public const string StorageTypeArray = "storage.type.array.ubytec";

        // ====================================================================
        // COMMENTS
        // ====================================================================

        /// <summary>
        /// Single‑line comment introduced by <c>//</c>.
        /// </summary>
        public const string CommentLineDoubleSlash = "comment.line.double-slash.ubytec";

        /// <summary>
        /// Block comment delimited by <c>/* */</c>.
        /// </summary>
        public const string CommentBlock = "comment.block.ubytec";

        // ====================================================================
        // MODIFIERS
        // ====================================================================

        /// <summary>
        /// Storage modifier keyword (e.g., <c>const</c>, <c>mutable</c>).
        /// </summary>
        public const string StorageModifier = "storage.modifier.ubytec";

        // ====================================================================
        // CONSTANTS
        // ====================================================================

        /// <summary>Boolean literals <c>true</c> / <c>false</c>.</summary>
        public const string ConstantBoolean = "constant.boolean.ubytec";

        /// <summary>Single‑precision floating‑point numeric literal.</summary>
        public const string ConstantNumericFloat = "constant.numeric.float.ubytec";

        /// <summary>Double‑precision floating‑point numeric literal.</summary>
        public const string ConstantNumericDouble = "constant.numeric.double.ubytec";

        /// <summary>Integer literal in decimal notation.</summary>
        public const string ConstantNumericInt = "constant.numeric.int.ubytec";

        /// <summary>Integer literal in hexadecimal notation (prefix <c>0x</c>).</summary>
        public const string ConstantNumericHex = "constant.numeric.hex.ubytec";

        /// <summary>Integer literal in binary notation (prefix <c>0b</c>).</summary>
        public const string ConstantNumericBinary = "constant.numeric.binary.ubytec";

        // ====================================================================
        // CODE STRUCTURES
        // ====================================================================

        /// <summary>Meta scope for array literals and indexing operations.</summary>
        public const string MetaArray = "meta.array.ubytec";

        /// <summary>Meta scope for grouping parentheses <c>( )</c>.</summary>
        public const string MetaGrouping = "meta.grouping.ubytec";

        /// <summary>Meta scope for code blocks delimited by braces <c>{ }</c>.</summary>
        public const string MetaBlock = "meta.block.ubytec";

        /// <summary>Meta scope for angle‑bracket grouping <c>&lt; &gt;</c>.</summary>
        public const string MetaAngleGrouping = "meta.angle.grouping.ubytec";

        // ====================================================================
        // STRINGS
        // ====================================================================

        /// <summary>Double‑quoted string literal.</summary>
        public const string StringQuotedDouble = "string.quoted.double.ubytec";

        /// <summary>Single‑quoted string literal.</summary>
        public const string StringQuotedSingle = "string.quoted.single.ubytec";

        // ====================================================================
        // KEYWORDS
        // ====================================================================

        /// <summary>Control‑flow keyword used in declarations (e.g., <c>let</c>, <c>fn</c>).</summary>
        public const string KeywordControlDeclaration = "keyword.control.declaration.ubytec";

        /// <summary>General control keyword (<c>if</c>, <c>while</c>, etc.).</summary>
        public const string KeywordControl = "keyword.control.ubytec";

        /// <summary>Control‑flow keyword (<c>break</c>, <c>continue</c>, <c>return</c>).</summary>
        public const string KeywordControlFlow = "keyword.control.flow.ubytec";

        /// <summary>Boolean storage keyword (<c>bool</c>).</summary>
        public const string KeywordStorageBool = "keyword.storage.bool.ubytec";

        /// <summary>Stack‑related keyword (<c>push</c>, <c>pop</c>).</summary>
        public const string KeywordStack = "keyword.stack.ubytec";

        /// <summary>Arithmetic operator keyword (<c>add</c>, <c>sub</c>).</summary>
        public const string KeywordOperatorArithmetic = "keyword.operator.arithmetic.ubytec";

        /// <summary>Bitwise operator keyword (<c>and</c>, <c>or</c>, <c>xor</c>).</summary>
        public const string KeywordOperatorBitwIse = "keyword.operator.bitwIse.ubytec";

        /// <summary>Comparison operator keyword (<c>eq</c>, <c>lt</c>, <c>gt</c>).</summary>
        public const string KeywordOperatorComparison = "keyword.operator.comparison.ubytec";

        /// <summary>Memory management keyword (<c>alloc</c>, <c>free</c>).</summary>
        public const string KeywordMemory = "keyword.memory.ubytec";

        /// <summary>Jump/control‑transfer keyword (<c>goto</c>, <c>jmp</c>).</summary>
        public const string KeywordControlJump = "keyword.control.jump.ubytec";

        /// <summary>Function call keyword (<c>call</c>).</summary>
        public const string KeywordFunctionCall = "keyword.function.call.ubytec";

        /// <summary>System call keyword (<c>syscall</c>).</summary>
        public const string KeywordSyscall = "keyword.syscall.ubytec";

        /// <summary>Threading‑related keyword (<c>spawn</c>, <c>join</c>).</summary>
        public const string KeywordThreading = "keyword.threading.ubytec";

        /// <summary>Security‑related keyword (<c>seal</c>, <c>unseal</c>).</summary>
        public const string KeywordSecurity = "keyword.security.ubytec";

        /// <summary>Exception‑handling keyword (<c>try</c>, <c>catch</c>).</summary>
        public const string KeywordException = "keyword.exception.ubytec";

        /// <summary>Vector‑processing keyword (<c>vec</c>, <c>shuffle</c>).</summary>
        public const string KeywordVector = "keyword.vector.ubytec";

        /// <summary>Audio‑related keyword (<c>play</c>, <c>stop</c>).</summary>
        public const string KeywordAudio = "keyword.audio.ubytec";

        /// <summary>Low‑level system keyword (<c>intr</c>, <c>port</c>).</summary>
        public const string KeywordSystem = "keyword.system.ubytec";

        /// <summary>Machine‑learning keyword (<c>train</c>, <c>infer</c>).</summary>
        public const string KeywordMl = "keyword.ml.ubytec";

        /// <summary>Power‑management keyword (<c>sleep</c>, <c>wake</c>).</summary>
        public const string KeywordPower = "keyword.power.ubytec";

        /// <summary>Quantum‑computing keyword (<c>qbit</c>, <c>entangle</c>).</summary>
        public const string KeywordQuantum = "keyword.quantum.ubytec";

        // ====================================================================
        // OPERATORS
        // ====================================================================

        /// <summary>Equality comparison operator <c>==</c>.</summary>
        public const string OperatorEquality = "operator.equality.ubytec";

        /// <summary>Inequality comparison operator <c>!=</c>.</summary>
        public const string OperatorInequality = "operator.inequality.ubytec";

        /// <summary>Less‑than‑or‑equal operator <c>&lt;=</c>.</summary>
        public const string OperatorLessThanEquals = "operator.less-than-equals.ubytec";

        /// <summary>Greater‑than‑or‑equal operator <c>&gt;=</c>.</summary>
        public const string OperatorGreaterThanEquals = "operator.greater-than-equals.ubytec";

        /// <summary>Strict less‑than operator <c>&lt;</c>.</summary>
        public const string OperatorLessThan = "operator.less-than.ubytec";

        /// <summary>Strict greater‑than operator <c>&gt;</c>.</summary>
        public const string OperatorGreaterThan = "operator.greater-than.ubytec";

        /// <summary>Logical negation operator <c>!</c>.</summary>
        public const string OperatorNegation = "operator.negation.ubytec";

        /// <summary>Unsigned right‑shift operator <c>>>></c>.</summary>
        public const string OperatorUnsignedRightShift = "operator.unsigned-right-shift.ubytec";

        /// <summary>Unsigned left‑shift operator <c>&lt;&lt;&lt;</c>.</summary>
        public const string OperatorUnsignedLeftShift = "operator.unsigned-left-shift.ubytec";

        /// <summary>Signed left‑shift operator <c>&lt;&lt;</c>.</summary>
        public const string OperatorLeftShift = "operator.left-shift.ubytec";

        /// <summary>Signed right‑shift operator <c>>>></c>.</summary>
        public const string OperatorRightShift = "operator.right-shift.ubytec";

        /// <summary>Addition operator <c>+</c>.</summary>
        public const string OperatorAddition = "operator.addition.ubytec";

        /// <summary>Subtraction operator <c>-</c>.</summary>
        public const string OperatorSubtraction = "operator.subtraction.ubytec";

        /// <summary>Division operator <c>/</c>.</summary>
        public const string OperatorDivision = "operator.division.ubytec";

        /// <summary>Multiplication operator <c>*</c>.</summary>
        public const string OperatorMultiplication = "operator.multiplication.ubytec";

        /// <summary>Exponentiation operator <c>**</c>.</summary>
        public const string OperatorExponentiation = "operator.exponentiation.ubytec";

        /// <summary>Modulo operator <c>%</c>.</summary>
        public const string OperatorModulo = "operator.modulo.ubytec";

        /// <summary>Bitwise AND operator <c>&amp;</c>.</summary>
        public const string OperatorBitwiseAnd = "operator.bitwise-and.ubytec";

        /// <summary>Hash operator <c>#</c> (compiler or meta‑operation).</summary>
        public const string OperatorHash = "operator.hash.ubytec";

        /// <summary>Increment operator <c>++</c>.</summary>
        public const string OperatorIncrement = "operator.increment.ubytec";

        /// <summary>Decrement operator <c>--</c>.</summary>
        public const string OperatorDecrement = "operator.decrement.ubytec";

        /// <summary>Logical AND operator <c>&amp;&amp;</c>.</summary>
        public const string OperatorLogicalAnd = "operator.logical-and.ubytec";

        /// <summary>Logical OR operator <c>||</c>.</summary>
        public const string OperatorLogicalOr = "operator.logical-or.ubytec";

        /// <summary>Optional chaining operator <c>?.</c>.</summary>
        public const string OperatorOptionalChaining = "operator.optional-chaining.ubytec";

        /// <summary>Pipe operator <c>&gt;|</c>.</summary>
        public const string OperatorPipe = "operator.pipe.ubytec";

        /// <summary>Input pipe operator <c>|&lt;</c>.</summary>
        public const string OperatorPipeIn = "operator.pipe-in.ubytec";

        /// <summary>Output pipe operator <c>|&gt;</c>.</summary>
        public const string OperatorPipeOut = "operator.pipe-out.ubytec";

        /// <summary>Null‑coalescing operator <c>??</c>.</summary>
        public const string OperatorNullableCoalescence = "operator.nullable-coalescence.ubytec";

        /// <summary>Spread (unpack) operator <c>..</c>.</summary>
        public const string OperatorSpread = "operator.spread.ubytec";

        /// <summary>Schematize (structure‑building) operator <c>@</c>.</summary>
        public const string OperatorSchematize = "operator.schematize.ubytec";

        /// <summary>Assignment operator <c>=</c>.</summary>
        public const string OperatorAssign = "operator.assign.ubytec";

        /// <summary>Inline return operator <c>=></c>.</summary>
        public const string OperatorInlineReturn = "operator.inline-return.ubytec";

        // ====================================================================
        // PUNCTUATION
        // ====================================================================

        /// <summary>Comma punctuation <c>,</c>.</summary>
        public const string PunctuationComma = "punctuation.comma.ubytec";

        /// <summary>Key‑value separator <c>:</c>.</summary>
        public const string PunctuationSeparatorKeyValue = "punctuation.separator.key-value.ubytec";

        /// <summary>Scope delimiter (::).</summary>
        public const string PunctuationScope = "punctuation.scope.ubytec";

        /// <summary>Parent‑child separator <c>.</c>.</summary>
        public const string PunctuationSeparatorParentChild = "punctuation.separator.parent-child.ubytec";

        /// <summary>Semicolon terminator <c>;</c>.</summary>
        public const string PunctuationSemicolon = "punctuation.semicolon.ubytec";

        /// <summary>Arrow punctuation <c>-></c>.</summary>
        public const string PunctuationArrow = "punctuation.arrow.ubytec";

        // ====================================================================
        // ARGUMENTS
        // ====================================================================

        /// <summary>Name of a function or macro argument.</summary>
        public const string EntityNameArgument = "entity.name.argument.ubytec";

        // ====================================================================
        // LABELS / ENTITY NAMES
        // ====================================================================

        /// <summary>Class type name.</summary>
        public const string EntityNameTypeClass = "entity.name.type.class.ubytec";

        /// <summary>Record type name.</summary>
        public const string EntityNameTypeRecord = "entity.name.type.record.ubytec";

        /// <summary>Struct type name.</summary>
        public const string EntityNameTypeStruct = "entity.name.type.struct.ubytec";

        /// <summary>Enum type name.</summary>
        public const string EntityNameTypeEnum = "entity.name.type.enum.ubytec";

        /// <summary>Interface type name.</summary>
        public const string EntityNameTypeInterface = "entity.name.type.interface.ubytec";

        /// <summary>Action (void delegate) type name.</summary>
        public const string EntityNameTypeAction = "entity.name.type.action.ubytec";

        /// <summary>Function (non‑void delegate) type name.</summary>
        public const string EntityNameTypeFunc = "entity.name.type.func.ubytec";

        /// <summary>Implicit Boolean name (auto‑generated).</summary>
        public const string EntityNameBoolImplicit = "entity.name.bool.implicit.ubytec";

        /// <summary>Field name within a struct or class.</summary>
        public const string EntityNameField = "entity.name.field.ubytec";

        /// <summary>Explicit Boolean name.</summary>
        public const string EntityNameBoolExplicit = "entity.name.bool.explicit.ubytec";

        /// <summary>Implicit variable name.</summary>
        public const string EntityNameVarImplicit = "entity.name.var.implicit.ubytec";

        /// <summary>Explicit variable name.</summary>
        public const string EntityNameVarExplicit = "entity.name.var.explicit.ubytec";

        // ====================================================================
        // INVALID
        // ====================================================================

        /// <summary>Marks illegal or unrecognized syntax.</summary>
        public const string InvalidIllegal = "invalid.illegal.ubytec";
        #endregion


        /// <summary>
        /// Checks if the token is a control keyword (e.g., <c>if</c>, <c>while</c>, etc.).
        /// </summary>
        /// <param name="kw">The keyword to validate.</param>
        /// <returns>True if is a control keyword and the source coincides with the <paramref name="kw"/>. Otherwhise false.</returns>
        public bool IsControl(string kw) => IsControlKeyword && token.Source.Equals(kw, StringComparison.OrdinalIgnoreCase);
        /// <summary>True if the token is ubytec source code. Most</summary>
        public bool IsSource => token.Scopes.DataSource.Contains(Source);
        // === STORAGE TYPES ===

        /// <summary>True if the token represents an array with both the array itself and its elements nullable (e.g., <c>[Type?]?</c>).</summary>
        public bool IsArrayNullableBoth => token.Scopes.DataSource.Contains(StorageTypeArrayNullableBoth);

        /// <summary>True if the token represents an array that can be null as a whole (e.g., <c>[Type]?</c>).</summary>
        public bool IsArrayNullableArray => token.Scopes.DataSource.Contains(StorageTypeArrayNullableArray);

        /// <summary>True if the token represents an array where the elements can be null (e.g., <c>[Type?]</c>).</summary>
        public bool IsArrayNullableItems => token.Scopes.DataSource.Contains(StorageTypeArrayNullableItems);

        /// <summary>True if the token represents a nullable single value type (e.g., <c>int?</c>).</summary>
        public bool IsSingleNullable => token.Scopes.DataSource.Contains(StorageTypeSingleNullable);

        /// <summary>True if the token represents a non-nullable single value type.</summary>
        public bool IsSingle => token.Scopes.DataSource.Contains(StorageTypeSingle);

        /// <summary>True if the token represents an array type without nullability.</summary>
        public bool IsArray => token.Scopes.DataSource.Contains(StorageTypeArray);

        // === COMMENTS ===

        /// <summary>True if the token represents a line comment starting with double slashes (//).</summary>
        public bool IsCommentLineDoubleSlash => token.Scopes.DataSource.Contains(CommentLineDoubleSlash);

        /// <summary>True if the token represents a block comment (e.g., /* ... */).</summary>
        public bool IsCommentBlock => token.Scopes.DataSource.Contains(CommentBlock);

        // === MODIFIERS ===

        /// <summary>True if the token represents a modifier keyword (e.g., <c>public</c>, <c>private</c>, <c>const</c>).</summary>
        public bool IsModifier => token.Scopes.DataSource.Contains(StorageModifier);
        /// <summary>True if the token represents a storage keyword (e.g., <c>Type</c>, <c>Type?</c>, <c>[Type]</c>, <c>[Type?]</c>, <c>[Type]?</c>, <c>[Type?]?</c> ).</summary>
        public bool IsStorageType => token.Scopes.DataSource.Any(s => s.StartsWith(StorageTypePrefix));

        // === CONSTANTS ===

        /// <summary>True if the token represents a boolean constant literal (<c>true</c> or <c>false</c>).</summary>
        public bool IsBooleanConstant => token.Scopes.DataSource.Contains(ConstantBoolean);

        /// <summary>True if the token represents a floating-point constant.</summary>
        public bool IsNumericFloat => token.Scopes.DataSource.Contains(ConstantNumericFloat);

        /// <summary>True if the token represents a double-precision floating-point constant.</summary>
        public bool IsNumericDouble => token.Scopes.DataSource.Contains(ConstantNumericDouble);

        /// <summary>True if the token represents an integer constant.</summary>
        public bool IsNumericInt => token.Scopes.DataSource.Contains(ConstantNumericInt);

        /// <summary>True if the token represents a hexadecimal numeric constant.</summary>
        public bool IsNumericHex => token.Scopes.DataSource.Contains(ConstantNumericHex);

        /// <summary>True if the token represents a binary numeric constant.</summary>
        public bool IsNumericBinary => token.Scopes.DataSource.Contains(ConstantNumericBinary);

        // === CODE STRUCTURES ===

        /// <summary>True if the token represents an array structure or literal (e.g., <c>[ "hello", "world" ]</c>).</summary>
        public bool IsArrayStructure => token.Scopes.DataSource.Contains(MetaArray);

        /// <summary>True if the token represents a grouping structure with parentheses (e.g., <c>( 10 )</c>).</summary>
        public bool IsGroupingStructure => token.Scopes.DataSource.Contains(MetaGrouping);

        /// <summary>True if the token represents a block structure with curly braces (e.g., <c>{ ... }</c>).</summary>
        public bool IsBlockStructure => token.Scopes.DataSource.Contains(MetaBlock);

        /// <summary>True if the token represents an angle bracket grouping (e.g., <c>&lt;T&gt;</c>).</summary>
        public bool IsAngleGrouping => token.Scopes.DataSource.Contains(MetaAngleGrouping);

        // === STRINGS ===

        /// <summary>True if the token represents a double-quoted string literal (e.g., <c>"text"</c>).</summary>
        public bool IsDoubleQuotedString => token.Scopes.DataSource.Contains(StringQuotedDouble);

        /// <summary>True if the token represents a single-quoted string or character literal (e.g., <c>'c'</c>).</summary>
        public bool IsSingleQuotedString => token.Scopes.DataSource.Contains(StringQuotedSingle);

        // === KEYWORDS ===

        /// <summary>True if the token is a declaration keyword (e.g., <c>let</c>, <c>var</c>).</summary>
        public bool IsDeclarationKeyword => token.Scopes.DataSource.Contains(KeywordControlDeclaration);

        /// <summary>True if the token is a general control keyword.</summary>
        public bool IsControlKeyword => token.Scopes.DataSource.Contains(KeywordControl);

        /// <summary>True if the token is a control flow keyword (e.g., <c>if</c>, <c>while</c>).</summary>
        public bool IsFlowKeyword => token.Scopes.DataSource.Contains(KeywordControlFlow);

        /// <summary>True if the token is a boolean type keyword.</summary>
        public bool IsboolKeyword => token.Scopes.DataSource.Contains(KeywordStorageBool);

        /// <summary>True if the token is a stack operation keyword.</summary>
        public bool IsStackKeyword => token.Scopes.DataSource.Contains(KeywordStack);

        /// <summary>True if the token is an arithmetic operator keyword.</summary>
        public bool IsArithmeticKeyword => token.Scopes.DataSource.Contains(KeywordOperatorArithmetic);

        /// <summary>True if the token is a bitwise operator keyword.</summary>
        public bool IsBitwIseKeyword => token.Scopes.DataSource.Contains(KeywordOperatorBitwIse);

        /// <summary>True if the token is a comparison operator keyword.</summary>
        public bool IsComparIsonKeyword => token.Scopes.DataSource.Contains(KeywordOperatorComparison);

        /// <summary>True if the token is a memory operation keyword.</summary>
        public bool IsMemoryKeyword => token.Scopes.DataSource.Contains(KeywordMemory);

        /// <summary>True if the token is a jump control keyword (e.g., <c>goto</c>).</summary>
        public bool IsJumpKeyword => token.Scopes.DataSource.Contains(KeywordControlJump);

        /// <summary>True if the token is a function call keyword.</summary>
        public bool IsFuncCallKeyword => token.Scopes.DataSource.Contains(KeywordFunctionCall);

        /// <summary>True if the token is a system call keyword.</summary>
        public bool IsSyscallKeyword => token.Scopes.DataSource.Contains(KeywordSyscall);

        /// <summary>True if the token is a threading operation keyword.</summary>
        public bool IsThreadingKeyword => token.Scopes.DataSource.Contains(KeywordThreading);

        /// <summary>True if the token is a security-related keyword.</summary>
        public bool IsSecurityKeyword => token.Scopes.DataSource.Contains(KeywordSecurity);

        /// <summary>True if the token is an exception handling keyword.</summary>
        public bool IsExceptionKeyword => token.Scopes.DataSource.Contains(KeywordException);

        /// <summary>True if the token is a vector operation keyword.</summary>
        public bool IsVectorKeyword => token.Scopes.DataSource.Contains(KeywordVector);

        /// <summary>True if the token is an audio operation keyword.</summary>
        public bool IsAudioKeyword => token.Scopes.DataSource.Contains(KeywordAudio);

        /// <summary>True if the token is a system operation keyword.</summary>
        public bool IsSystemKeyword => token.Scopes.DataSource.Contains(KeywordSystem);

        /// <summary>True if the token is a machine learning keyword.</summary>
        public bool IsMLKeyword => token.Scopes.DataSource.Contains(KeywordMl);

        /// <summary>True if the token is a power or energy-related keyword.</summary>
        public bool IsPowerKeyword => token.Scopes.DataSource.Contains(KeywordPower);

        /// <summary>True if the token is a quantum computing keyword.</summary>
        public bool IsQuantumKeyword => token.Scopes.DataSource.Contains(KeywordQuantum);


        // === OPERATORS ===

        /// <summary>True if the token is an equality operator (==).</summary>
        public bool IsEqualityOperator => token.Scopes.DataSource.Contains(OperatorEquality);

        /// <summary>True if the token is an inequality operator (!=).</summary>
        public bool IsInequalityOperator => token.Scopes.DataSource.Contains(OperatorInequality);

        /// <summary>True if the token is a less-than-or-equal operator (&lt;=).</summary>
        public bool IsLessThanEqualsOperator => token.Scopes.DataSource.Contains(OperatorLessThanEquals);

        /// <summary>True if the token is a greater-than-or-equal operator (&gt;=).</summary>
        public bool IsGreaterThanEqualsOperator => token.Scopes.DataSource.Contains(OperatorGreaterThanEquals);

        /// <summary>True if the token is a less-than operator (&lt;).</summary>
        public bool IsLessThanOperator => token.Scopes.DataSource.Contains(OperatorLessThan);

        /// <summary>True if the token is a greater-than operator (&gt;).</summary>
        public bool IsGreaterThanOperator => token.Scopes.DataSource.Contains(OperatorGreaterThan);

        /// <summary>True if the token is a negation operator (!).</summary>
        public bool IsNegationOperator => token.Scopes.DataSource.Contains(OperatorNegation);

        /// <summary>True if the token is an unsigned right shift operator (>>>).</summary>
        public bool IsUnsignedRightShift => token.Scopes.DataSource.Contains(OperatorUnsignedRightShift);

        /// <summary>True if the token is an unsigned left shift operator (&lt;&lt;&lt;).</summary>
        public bool IsUnsignedLeftShift => token.Scopes.DataSource.Contains(OperatorUnsignedLeftShift);

        /// <summary>True if the token is a left shift operator (&lt;&lt;).</summary>
        public bool IsLeftShift => token.Scopes.DataSource.Contains(OperatorLeftShift);

        /// <summary>True if the token is a right shift operator (&gt;&gt;).</summary>
        public bool IsRightShift => token.Scopes.DataSource.Contains(OperatorRightShift);

        /// <summary>True if the token is an addition operator (+).</summary>
        public bool IsAdditionOperator => token.Scopes.DataSource.Contains(OperatorAddition);

        /// <summary>True if the token is a subtraction operator (-).</summary>
        public bool IsSubtractionOperator => token.Scopes.DataSource.Contains(OperatorSubtraction);

        /// <summary>True if the token is a division operator (/).</summary>
        public bool IsDivisionOperator => token.Scopes.DataSource.Contains(OperatorDivision);

        /// <summary>True if the token is a multiplication operator (*).</summary>
        public bool IsMultiplicationOperator => token.Scopes.DataSource.Contains(OperatorMultiplication);

        /// <summary>True if the token is an exponentiation operator (**).</summary>
        public bool IsExponentiationOperator => token.Scopes.DataSource.Contains(OperatorExponentiation);

        /// <summary>True if the token is a modulo operator (%).</summary>
        public bool IsModuloOperator => token.Scopes.DataSource.Contains(OperatorModulo);

        /// <summary>True if the token is a bitwise AND operator (&amp;).</summary>
        public bool IsBitwiseAndOperator => token.Scopes.DataSource.Contains(OperatorBitwiseAnd);

        /// <summary>True if the token is a hash operator (#).</summary>
        public bool IsHashOperator => token.Scopes.DataSource.Contains(OperatorHash);

        /// <summary>True if the token is an increment operator (++) .</summary>
        public bool IsIncrementOperator => token.Scopes.DataSource.Contains(OperatorIncrement);

        /// <summary>True if the token is a decrement operator (--).</summary>
        public bool IsDecrementOperator => token.Scopes.DataSource.Contains(OperatorDecrement);

        /// <summary>True if the token is a logical AND operator (&amp;&amp;).</summary>
        public bool IsLogicalAndOperator => token.Scopes.DataSource.Contains(OperatorLogicalAnd);

        /// <summary>True if the token is a logical OR operator (||).</summary>
        public bool IsLogicalOrOperator => token.Scopes.DataSource.Contains(OperatorLogicalOr);

        /// <summary>True if the token is an optional chaining operator (?.).</summary>
        public bool IsOptionalChaining => token.Scopes.DataSource.Contains(OperatorOptionalChaining);

        /// <summary>True if the token is a pipe operator (|>).</summary>
        public bool IsPipeOperator => token.Scopes.DataSource.Contains(OperatorPipe);

        /// <summary>True if the token is a pipe-in operator (&lt;|).</summary>
        public bool IsPipeInOperator => token.Scopes.DataSource.Contains(OperatorPipeIn);

        /// <summary>True if the token is a pipe-out operator (|&gt;).</summary>
        public bool IsPipeOutOperator => token.Scopes.DataSource.Contains(OperatorPipeOut);

        /// <summary>True if the token is a null-coalescence operator (??).</summary>
        public bool IsNullableCoalescence => token.Scopes.DataSource.Contains(OperatorNullableCoalescence);

        /// <summary>True if the token is a spread operator (..).</summary>
        public bool IsSpreadOperator => token.Scopes.DataSource.Contains(OperatorSpread);

        /// <summary>True if the token is a schematize operator (~~) (for schemas, etc.).</summary>
        public bool IsSchematizeOperator => token.Scopes.DataSource.Contains(OperatorSchematize);

        /// <summary>True if the token is an assignment operator (=).</summary>
        public bool IsAssignOperator => token.Scopes.DataSource.Contains(OperatorAssign);

        /// <summary>
        /// True if the token is an inline return operator (=>) (e.g., used in arrow functions or inline expressions).
        /// </summary>
        public bool IsInlineReturn => token.Scopes.DataSource.Contains(OperatorInlineReturn);

        // === PUNCTUATION ===

        /// <summary>True if the token is a comma (,).</summary>
        public bool IsComma => token.Scopes.DataSource.Contains(PunctuationComma);

        /// <summary>True if the token is a key-value separator (e.g., colon ':').</summary>
        public bool IsKeyValueSeparator => token.Scopes.DataSource.Contains(PunctuationSeparatorKeyValue);

        /// <summary>True if the token is a scope separator (e.g., dot '.').</summary>
        public bool IsScopeSeparator => token.Scopes.DataSource.Contains(PunctuationScope);

        /// <summary>True if the token is a parent-child separator (e.g., slash '/').</summary>
        public bool IsParentChildSeparator => token.Scopes.DataSource.Contains(PunctuationSeparatorParentChild);

        /// <summary>True if the token is a semicolon (;).</summary>
        public bool IsSemicolon => token.Scopes.DataSource.Contains(PunctuationSemicolon);

        /// <summary>True if the token is an arrow (->).</summary>
        public bool IsArrow => token.Scopes.DataSource.Contains(PunctuationArrow);

        // === ARGUMENTS ===

        /// <summary>True if the token is an argument name in a function or method declaration.</summary>
        public bool IsArgumentName => token.Scopes.DataSource.Contains(EntityNameArgument);

        // === LABELS ===

        /// <summary>True if the token is a class label.</summary>
        public bool IsClassLabel => token.Scopes.DataSource.Contains(EntityNameTypeClass);

        /// <summary>True if the token is a record label.</summary>
        public bool IsRecordLabel => token.Scopes.DataSource.Contains(EntityNameTypeRecord);

        /// <summary>True if the token is a struct label.</summary>
        public bool IsStructLabel => token.Scopes.DataSource.Contains(EntityNameTypeStruct);

        /// <summary>True if the token is an enum label.</summary>
        public bool IsEnumLabel => token.Scopes.DataSource.Contains(EntityNameTypeEnum);

        /// <summary>True if the token is an interface label.</summary>
        public bool IsInterfaceLabel => token.Scopes.DataSource.Contains(EntityNameTypeInterface);

        /// <summary>True if the token is an action label (e.g., Ubytec action declaration).</summary>
        public bool IsActionLabel => token.Scopes.DataSource.Contains(EntityNameTypeAction);

        /// <summary>True if the token is a function label.</summary>
        public bool IsFuncLabel => token.Scopes.DataSource.Contains(EntityNameTypeFunc);

        /// <summary>True if the token is an implicitly declared boolean variable label.</summary>
        public bool IsImplicitboolLabel => token.Scopes.DataSource.Contains(EntityNameBoolImplicit);

        /// <summary>True if the token is a field label.</summary>
        public bool IsFieldLabel => token.Scopes.DataSource.Contains(EntityNameField);

        /// <summary>True if the token is an explicitly declared boolean variable label.</summary>
        public bool IsExplicitboolLabel => token.Scopes.DataSource.Contains(EntityNameBoolExplicit);

        /// <summary>True if the token is an implicitly declared variable label.</summary>
        public bool IsImplicitVarLabel => token.Scopes.DataSource.Contains(EntityNameVarImplicit);
        /// <summary>True if the token is an explicitly declared variable label.</summary>
        public bool IsExplicitVarLabel => token.Scopes.DataSource.Contains(EntityNameVarExplicit);

        // === INVALID TOKENS ===

        /// <summary>True if the token represents an illegal or invalid token.</summary>
        public bool IsInvalid => token.Scopes.DataSource.Contains(InvalidIllegal);

    }
}
