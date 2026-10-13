# Recursive opcode namespaces

Ubytec reserves `0xFF` as a recursive opcode escape byte.

Core instructions remain one byte in `0x00..0xFE`. Extended instructions are identified by one or more consecutive `0xFF` bytes followed by an extension group and an opcode:

```text
FF...FF <ExtensionGroup> <ExtendedOpCode>
└ n>=1 ┘
```

The number of leading escapes is the opcode's `EscapeDepth` and is part of its identity:

```text
FF 10 11          depth 1
FF FF 10 11       depth 2
FF FF FF 10 11    depth 3
```

These are three different opcode namespaces.

`ExtensionGroup` and `ExtendedOpCode` are both restricted to `0x00..0xFE`. `0xFF` remains reserved and cannot be allocated in either field. A byte sequence containing only escapes is incomplete and is rejected.

The Ubytec specification does not place a finite upper bound on escape depth. This interpreter imposes `MAX_SUPPORTED_ESCAPE_DEPTH = 16` as a defensive resource limit. A deeper valid namespace is reported as unsupported; it is never normalized or reinterpreted at a shallower depth.

The current extended stack instructions remain byte-for-byte compatible at depth 1:

```text
FF 10 11    PUSH16
FF 10 18    DROP16
FF 10 1D    PICK16
FF 10 1E    ROLL16
```

Canonical family allocations live in the `Universal-Byte-Code/schema` opcode registry. The interpreter should implement registered assignments rather than becoming an independent allocation authority.
