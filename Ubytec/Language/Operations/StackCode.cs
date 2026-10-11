using System.Buffers.Binary;
using System.Numerics;
using Ubytec.Language.Exceptions;
using Ubytec.Language.Syntax.ExpressionFragments;

namespace Ubytec.Language.Operations
{
    /// <summary>Shared validation and NASM emission for the untyped, 64-bit evaluation stack.</summary>
    internal static class StackCode
    {
        internal static void Validate(string name, VariableExpressionFragment[] variables, ValueType[] operands, int count)
        {
            if (variables.Length != 0 || operands.Length != count)
                throw new SyntaxException(0xBAD011, $"{name} expects {count} operand(s) and no variable references.");
        }

        internal static int Index(string name, ValueType[] operands, int maximum)
        {
            if (operands.Length != 1)
                throw new SyntaxException(0xBAD012, $"{name} expects one stack index.");
            var value = Integer(name, operands[0]);
            if (value < 0 || value > maximum)
                throw new SyntaxException(0xBAD013, $"{name} index must be between 0 and {maximum}.");
            return (int)value;
        }

        private static BigInteger Integer(string name, ValueType value) => value switch
        {
            byte x => x, sbyte x => x, short x => x, ushort x => x,
            int x => x, uint x => x, long x => x, ulong x => x,
            BigInteger x => x,
            _ => throw new SyntaxException(0xBAD014, $"{name} requires an integer operand.")
        };

        internal static byte[] Immediate(ValueType[] operands)
        {
            if (operands.Length == 0)
                throw new SyntaxException(0xBAD015, "PUSH requires a literal.");
            // Multiple byte operands represent the original little-endian wire payload.
            if (operands.Length > 1)
            {
                if (operands.Length > 8 || operands.Any(x => x is not byte))
                    throw new SyntaxException(0xBAD016, "PUSH accepts one integer or up to eight payload bytes.");
                return operands.Cast<byte>().ToArray();
            }
            var value = Integer("PUSH", operands[0]);
            if (value < long.MinValue || value > ulong.MaxValue)
                throw new SyntaxException(0xBAD017, "PUSH literal does not fit a 64-bit stack cell.");
            var bytes = new byte[8];
            BinaryPrimitives.WriteUInt64LittleEndian(bytes, value < 0 ? unchecked((ulong)(long)value) : (ulong)value);
            return bytes;
        }

        internal static string Push(byte[] payload)
        {
            if (payload is null || payload.Length is < 1 or > 8)
                throw new SyntaxException(0xBAD018, "PUSH payload must contain one to eight little-endian bytes.");
            ulong value = 0;
            for (int i = 0; i < payload.Length; i++) value |= (ulong)payload[i] << (8 * i);
            // x86-64 push imm32 sign-extends: use a register to preserve all 64 bits.
            return $"mov rax, 0x{value:X16}\n  push rax";
        }

        internal static string Binary(string instruction) =>
            $"pop rcx\n  pop rax\n  {instruction} rax, rcx\n  push rax";

        internal static string Unary(string instruction) => $"pop rax\n  {instruction} rax\n  push rax";
        internal static string Compare(string condition) =>
            $"pop rcx\n  pop rax\n  cmp rax, rcx\n  set{condition} al\n  movzx eax, al\n  push rax";

        internal static string Pick(int index) => $"push qword [rsp + {index * 8}]";

        internal static string Remove(int index, bool roll)
        {
            if (index == 0) return roll ? "nop ; ROLL 0" : "add rsp, 8";
            var label = $"stack_shift_{Guid.NewGuid():N}";
            return (roll ? $"mov rax, [rsp + {index * 8}]\n  " : "") +
                $"mov ecx, {index * 8}\n{label}:\n  mov rdx, [rsp + rcx - 8]\n  mov [rsp + rcx], rdx\n  sub rcx, 8\n  jnz {label}\n  " +
                (roll ? "mov [rsp], rax" : "add rsp, 8");
        }

        internal static string DuplicatePair(int depth) =>
            $"mov rax, [rsp + {depth * 8 + 8}]\n  mov rcx, [rsp + {depth * 8}]\n  push rax\n  push rcx";
    }
}
