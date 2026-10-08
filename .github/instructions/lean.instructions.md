---
applyTo: "formalization/**/*.lean"
---

# Lean Formalization Instructions

Treat every theorem as a mathematical research claim.

Before editing:

1. inspect imports;
2. inspect related definitions;
3. inspect existing lemmas;
4. check whether the theorem already exists;
5. identify all assumptions.

Never:

- use `sorry` to claim completion;
- weaken theorem statements without documenting why;
- convert a counterexample into a theorem;
- hide assumptions.

After editing:

```bash
lake build
