using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using ubytec_interpreter.Operations;
using static ubytec_interpreter.Operations.Primitives;

namespace ubytec_interpreter
{
    public readonly record struct Variable(PrimitiveType BlockType, bool Nullable, string Name, object? Value, SyntaxToken[] SyntaxTokens);
    public readonly record struct Condition(object? Left, string? Operand, object? Right);
}
