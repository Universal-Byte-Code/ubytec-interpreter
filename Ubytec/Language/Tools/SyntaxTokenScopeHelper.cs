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
        // === PREFIJOS ========================================================
        public const string StorageTypePrefix = "storage.type.";

        // === FUENTE ==========================================================
        public const string Source = "source.ubytec";

        // === STORAGE TYPES ===================================================
        public const string StorageTypeArrayNullableBoth = "storage.type.array.nullable-both.ubytec";
        public const string StorageTypeArrayNullableArray = "storage.type.array.nullable-array.ubytec";
        public const string StorageTypeArrayNullableItems = "storage.type.array.nullable-items.ubytec";
        public const string StorageTypeSingleNullable = "storage.type.single.nullable.ubytec";
        public const string StorageTypeSingle = "storage.type.single.ubytec";
        public const string StorageTypeArray = "storage.type.array.ubytec";

        // === COMMENTS ========================================================
        public const string CommentLineDoubleSlash = "comment.line.double-slash.ubytec";
        public const string CommentBlock = "comment.block.ubytec";

        // === MODIFIERS =======================================================
        public const string StorageModifier = "storage.modifier.ubytec";

        // === CONSTANTS =======================================================
        public const string ConstantBoolean = "constant.boolean.ubytec";
        public const string ConstantNumericFloat = "constant.numeric.float.ubytec";
        public const string ConstantNumericDouble = "constant.numeric.double.ubytec";
        public const string ConstantNumericInt = "constant.numeric.int.ubytec";
        public const string ConstantNumericHex = "constant.numeric.hex.ubytec";
        public const string ConstantNumericBinary = "constant.numeric.binary.ubytec";

        // === CODE STRUCTURES ==================================================
        public const string MetaArray = "meta.array.ubytec";
        public const string MetaGrouping = "meta.grouping.ubytec";
        public const string MetaBlock = "meta.block.ubytec";
        public const string MetaAngleGrouping = "meta.angle.grouping.ubytec";

        // === STRINGS ==========================================================
        public const string StringQuotedDouble = "string.quoted.double.ubytec";
        public const string StringQuotedSingle = "string.quoted.single.ubytec";

        // === KEYWORDS =========================================================
        public const string KeywordControlDeclaration = "keyword.control.declaration.ubytec";
        public const string KeywordControl = "keyword.control.ubytec";
        public const string KeywordControlFlow = "keyword.control.flow.ubytec";
        public const string KeywordStorageBool = "keyword.storage.bool.ubytec";
        public const string KeywordStack = "keyword.stack.ubytec";
        public const string KeywordOperatorArithmetic = "keyword.operator.arithmetic.ubytec";
        public const string KeywordOperatorBitwIse = "keyword.operator.bitwIse.ubytec";
        public const string KeywordOperatorComparison = "keyword.operator.comparison.ubytec";
        public const string KeywordMemory = "keyword.memory.ubytec";
        public const string KeywordControlJump = "keyword.control.jump.ubytec";
        public const string KeywordFunctionCall = "keyword.function.call.ubytec";
        public const string KeywordSyscall = "keyword.syscall.ubytec";
        public const string KeywordThreading = "keyword.threading.ubytec";
        public const string KeywordSecurity = "keyword.security.ubytec";
        public const string KeywordException = "keyword.exception.ubytec";
        public const string KeywordVector = "keyword.vector.ubytec";
        public const string KeywordAudio = "keyword.audio.ubytec";
        public const string KeywordSystem = "keyword.system.ubytec";
        public const string KeywordMl = "keyword.ml.ubytec";
        public const string KeywordPower = "keyword.power.ubytec";
        public const string KeywordQuantum = "keyword.quantum.ubytec";

        // === OPERATORS ========================================================
        public const string OperatorEquality = "operator.equality.ubytec";
        public const string OperatorInequality = "operator.inequality.ubytec";
        public const string OperatorLessThanEquals = "operator.less-than-equals.ubytec";
        public const string OperatorGreaterThanEquals = "operator.greater-than-equals.ubytec";
        public const string OperatorLessThan = "operator.less-than.ubytec";
        public const string OperatorGreaterThan = "operator.greater-than.ubytec";
        public const string OperatorNegation = "operator.negation.ubytec";
        public const string OperatorUnsignedRightShift = "operator.unsigned-right-shift.ubytec";
        public const string OperatorUnsignedLeftShift = "operator.unsigned-left-shift.ubytec";
        public const string OperatorLeftShift = "operator.left-shift.ubytec";
        public const string OperatorRightShift = "operator.right-shift.ubytec";
        public const string OperatorAddition = "operator.addition.ubytec";
        public const string OperatorSubtraction = "operator.subtraction.ubytec";
        public const string OperatorDivision = "operator.division.ubytec";
        public const string OperatorMultiplication = "operator.multiplication.ubytec";
        public const string OperatorExponentiation = "operator.exponentiation.ubytec";
        public const string OperatorModulo = "operator.modulo.ubytec";
        public const string OperatorBitwiseAnd = "operator.bitwise-and.ubytec";
        public const string OperatorHash = "operator.hash.ubytec";
        public const string OperatorIncrement = "operator.increment.ubytec";
        public const string OperatorDecrement = "operator.decrement.ubytec";
        public const string OperatorLogicalAnd = "operator.logical-and.ubytec";
        public const string OperatorLogicalOr = "operator.logical-or.ubytec";
        public const string OperatorOptionalChaining = "operator.optional-chaining.ubytec";
        public const string OperatorPipe = "operator.pipe.ubytec";
        public const string OperatorPipeIn = "operator.pipe-in.ubytec";
        public const string OperatorPipeOut = "operator.pipe-out.ubytec";
        public const string OperatorNullableCoalescence = "operator.nullable-coalescence.ubytec";
        public const string OperatorSpread = "operator.spread.ubytec";
        public const string OperatorSchematize = "operator.schematize.ubytec";
        public const string OperatorAssign = "operator.assign.ubytec";
        public const string OperatorInlineReturn = "operator.inline-return.ubytec";

        // === PUNCTUATION ======================================================
        public const string PunctuationComma = "punctuation.comma.ubytec";
        public const string PunctuationSeparatorKeyValue = "punctuation.separator.key-value.ubytec";
        public const string PunctuationScope = "punctuation.scope.ubytec";
        public const string PunctuationSeparatorParentChild = "punctuation.separator.parent-child.ubytec";
        public const string PunctuationSemicolon = "punctuation.semicolon.ubytec";
        public const string PunctuationArrow = "punctuation.arrow.ubytec";

        // === ARGUMENTS ========================================================
        public const string EntityNameArgument = "entity.name.argument.ubytec";

        // === LABELS ===========================================================
        public const string EntityNameTypeClass = "entity.name.type.class.ubytec";
        public const string EntityNameTypeRecord = "entity.name.type.record.ubytec";
        public const string EntityNameTypeStruct = "entity.name.type.struct.ubytec";
        public const string EntityNameTypeEnum = "entity.name.type.enum.ubytec";
        public const string EntityNameTypeInterface = "entity.name.type.interface.ubytec";
        public const string EntityNameTypeAction = "entity.name.type.action.ubytec";
        public const string EntityNameTypeFunc = "entity.name.type.func.ubytec";
        public const string EntityNameBoolImplicit = "entity.name.bool.implicit.ubytec";
        public const string EntityNameField = "entity.name.field.ubytec";
        public const string EntityNameBoolExplicit = "entity.name.bool.explicit.ubytec";
        public const string EntityNameVarImplicit = "entity.name.var.implicit.ubytec";
        public const string EntityNameVarExplicit = "entity.name.var.explicit.ubytec";
        // === INVALID ==========================================================
        public const string InvalidIllegal = "invalid.illegal.ubytec";
        #endregion

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

        /// <summary>True if the token is a less-than-or-equal operator (<=).</summary>
        public bool IsLessThanEqualsOperator => token.Scopes.DataSource.Contains(OperatorLessThanEquals);

        /// <summary>True if the token is a greater-than-or-equal operator (>=).</summary>
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

        /// <summary>True if the token is a logical AND operator (&&).</summary>
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

        /// <summary>True if the token is a spread operator (...).</summary>
        public bool IsSpreadOperator => token.Scopes.DataSource.Contains(OperatorSpread);

        /// <summary>True if the token is a schematize operator (=> for schemas, etc.).</summary>
        public bool IsSchematizeOperator => token.Scopes.DataSource.Contains(OperatorSchematize);

        /// <summary>True if the token is an assignment operator (=).</summary>
        public bool IsAssignOperator => token.Scopes.DataSource.Contains(OperatorAssign);

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
