using System.Collections.ObjectModel;
using static ubytec_interpreter.Operations.CoreOperations;
using System.Text.Json.Serialization;

namespace ubytec_interpreter.Operations
{
    public interface IOpCode
    {
        public byte OpCode { get; }
        public string Compile(params Stack<object>[]? stacks);
    }
}
