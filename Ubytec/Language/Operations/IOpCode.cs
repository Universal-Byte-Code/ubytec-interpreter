using System.Collections.ObjectModel;
using static Ubytec.Language.Operations.CoreOperations;
using System.Text.Json.Serialization;

namespace Ubytec.Language.Operations
{
    public interface IOpCode
    {
        public byte OpCode { get; }
        public string Compile(params Stack<object>[]? stacks);
    }
}
