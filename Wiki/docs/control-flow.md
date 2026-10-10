# Structured control flow: verified scalar core

Ubytec is a common intermediate representation and execution format. These
checks establish the behavior of its existing structured opcodes in the current
integer-cell backend; they do not establish completeness of every declared type,
extension family, architecture or module-linking feature.

## Loop and condition behavior

- LOOP repeats its body. BREAK leaves the nearest enclosing loop or switch;
  CONTINUE restarts the nearest loop.
- WHILE with an explicit condition reevaluates that condition at its start on
  every iteration, including after CONTINUE. Named operands such as @counter
  load their current frame value, rather than their declaration initializer.
- WHILE without an explicit condition consumes a stack condition at each entry.
  Its body must produce the next condition before END or CONTINUE. BREAK exits
  with the evaluation depth after consuming the condition.
- IF without an explicit condition consumes one cell: zero is false.
  Explicit IF/WHILE conditions accept integer/boolean literals and named frame
  symbols with ==, !=, <, <=, > or >=. Relational comparisons use unsigned ordering for an explicit unsigned type
  or uniformly unsigned named numeric operands; otherwise they use signed
  ordering. Mixed signed/unsigned symbols require an explicit comparison type.
- BLOCK without a declared type preserves its body stack effects. A typed BLOCK
  must produce one additional result cell, or no additional cell for t_void.
  Supported scalar results are canonicalized to their declared width.

Loop back edges, CONTINUE targets, BREAK targets and branch merges are checked
for compatible evaluation depths. Invalid targets, missing conditions and
growing stacks are rejected before native execution. RETURN uses the function
epilogue, restoring the complete frame even from nested control structures.

## Switch behavior

SWITCH consumes one selector and saves it in a private function-frame slot.
BRANCH compares a case literal against that snapshot. Only the first matching
branch executes; reaching its END skips remaining cases. An optional DEFAULT
marker introduces the unmatched path, ending at the SWITCH's END.

Each BRANCH has its own END. BRANCH must be directly nested in SWITCH, before
DEFAULT. BREAK inside a branch exits the switch without modifying compiler
scope nesting. CONTINUE inside a switch within a loop targets that loop.
Nested switches have independent selector slots; calls cannot overwrite them.
Numeric switch/branch label identifiers can be targeted by BREAK.

DEFAULT outside a direct SWITCH retains its existing value opcode behavior
(pushes 1). Source jump syntax and arbitrary addresses are not added.

## Complete example and verification

[control-flow.ubc](../../examples/control-flow.ubc) increments a counter, skips
its first iteration with CONTINUE, terminates with BREAK, selects a SWITCH branch,
calls Twice, and returns 42. The result is checked by executing generated x64
instructions, rather than comparing assembly text.

The CI configuration runs the same native source tests on Windows and Linux
x64. Linux additionally assembles, links and runs both answer.ubc and
control-flow.ubc as ELF executables. A configured workflow is not evidence of a
successful remote run; these changes must be published before GitHub runs them.

Native executable startup still targets Linux x64. The Windows test harness
executes function machine code in an allocated memory region; it does not prove
that the compiler emits standalone Windows executables. ARM/RISC-V execution,
the portable binary container, cross-module linking, typed float/128-bit
arithmetic and schema interoperability remain separate milestones.
