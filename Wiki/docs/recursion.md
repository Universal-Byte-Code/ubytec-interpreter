# Recursion and tail calls

The Linux x64 backend can opt in to frame reuse for an immediate CALL followed by
RETURN:

    dotnet run --project Ubytec/Ubytec.csproj -- examples/recursion.ubc --tail-calls -o recursion.nasm

The API equivalent is SourceCompiler.Compile(source, optimizeTailCalls: true).
CompilationScopes.OptimizeTailCalls applies the same policy to direct module
compilation. The default is false: Ubytec permits raw native pointers, so changing
frame lifetime requires a program-level assumption, not just a syntactic test.

## Implemented transformation

A tail transfer is eligible when CALL and RETURN are adjacent leaf nodes in the
same ordered statement sequence, the target has exactly the same argument count
as the current function/action, and the complete declared return types match.
Explicit RETURN type validation remains in effect. Branch bodies are processed
as well as the top-level body. No new opcode or source syntax is added.

All arguments are evaluated on the ordinary evaluation stack first. The emitter
pops them into the incoming argument slots, preserving order and allowing swaps
without overwriting unevaluated arguments. It then discards locals/evaluation
cells, restores the caller's RBP and jumps to the target's normal entry.
The original return address is retained. Re-entering the normal prologue
reinitializes locals and allocates the target's own frame. The original caller
still removes exactly the argument area it created.

Self recursion and mutual recursion with compatible signatures therefore use
bounded stack space: the maximum active target frame, rather than the sum of
all eliminated frames. Calls with work after CALL, incompatible argument counts
or different result types retain the normal CALL and RETURN sequence.
Tail position across an intervening END/NOP or more general control-flow joins
is not inferred in this first implementation.

The opt-in promise is that execution does not depend on the discarded frame:
do not pass pointers to its locals or incoming argument cells and then use those
pointers in the target, and do not rely on inspecting its physical stack layout.
An ordinary call can keep its parent frame alive while the target uses such a
pointer; a tail transfer cannot. Keep --tail-calls off for programs requiring
that behavior. Pointers to separately owned live regions, including a loan
that remains active for the whole invocation, keep their normal lifetime.

## Recursion with pending state

[examples/recursion.ubc](../../examples/recursion.ubc) contains three equivalent
factorial implementations for nonnegative inputs within the signed 64-bit
result range:

- Factorial retains the current n while the recursive result is computed.
  Its multiplication after CALL prevents tail elimination.
- FactorialTail carries the partial product as an accumulator. Its recursive
  CALL is terminal and can reuse the frame when the opt-in is enabled.
- FactorialExplicit stores each pending n as one eight-byte cell in a
  caller-owned buffer, then unwinds those cells with a loop. It uses no recursive
  machine calls but still stores a number of states proportional to n.

FactorialExplicit rejects negative n and insufficient capacity before writing.
The caller supplies a valid writable buffer of at least capacity * 8 bytes;
the function's logical capacity check does not allocate or authorize memory.
Tests compare all three results for n=0..20, verify neighboring canaries, and
verify that insufficient capacity returns -1 without modifying the buffer.

An explicit stack can omit unused locals, saved registers and call bookkeeping,
and a continuation can store just the live values and the next operation.
It moves and can shrink state; it does not make unbounded pending state fit into
finite memory. This example is a manual source-level transformation, not an
automatic compiler conversion of arbitrary non-tail recursion.

Other algorithm-specific choices include memoization to avoid repeated subproblems,
iterative dynamic programming, recomputation to trade time for memory, or an
explicit traversal frontier. Some problems admit an accumulator; others still
need retained states. A general automatic liveness/continuation pass, heap-backed
frame allocator and memoization system have not been implemented here.

## Verification

Compiler/native tests cover argument permutations, reinitialized mutated locals,
mutual recursion, zero/typed results, explicit RETURN mismatch, incompatible
arity/result fallback, ordinary pending-work recursion, default frame preservation,
and the bounded explicit stack example.

The separate-module Linux suite enables --tail-calls and completes 200,000 self
steps and 200,000 mutual-recursion decrements (with intervening mutual calls)
on its guarded 64 KiB stack. The infinite tail-recursion fixture reaches the
one-second watchdog, not a stack-overflow fault. A fresh invocation succeeds
after it. Deliberate non-tail recursion still faults on stack overflow, retaining
the containment check. GCC and Clang supervisor builds pass; ARM remains native
MPU fixtures and has no Ubytec compiler backend.

See [module evidence](../../prototypes/isolation/evidence/modules/modules-report.json).
Infinite tail recursion can run with bounded memory, but it still consumes CPU
and remains subject to the protected invocation's time limit.
