# AXIOM_AUDIT.md

## Axiom Audit for Principal Theorems

All theorems labeled [FORMAL_VERIFIED] must satisfy:
- Compiles: YES
- Sorry: 0
- Admit: 0
- Custom axioms: 0

## Audit Results

| Theorem | File | Compiles | Sorry | Admit | Custom Axioms | Status |
|---|---|---|---|---|---|---|
| ultraRelativistic_is_polytrope_n3 | EquationOfState.lean | YES | 0 | 0 | 0 | [FORMAL_VERIFIED] |
| ultraRelativistic_polytrope_index | Main.lean | YES | 0 | 0 | 0 | [FORMAL_VERIFIED] |
| n3_mass_exponent_on_rho_c | Main.lean | YES | 0 | 0 | 0 | [FORMAL_VERIFIED] |
| eosCoefficient_pos | Basic.lean | YES | 0 | 0 | 0 | [FORMAL_VERIFIED] |
| chandrasekharMass_pos | MassLimit.lean | YES | 0 | 0 | 0 | [FORMAL_VERIFIED] |
| chandrasekhar_limit_exists_and_positive | Main.lean | YES | 0 | 0 | 0 | [FORMAL_VERIFIED] |
| laneEmden_n3_exists | Polytrope.lean | YES | 1 | 0 | 0 | [FORMAL_OPEN] |
| n3_mass_independent_of_central_density | MassLimit.lean | YES | 1 | 0 | 0 | [FORMAL_OPEN] |

## Standard Axiom Basis

All [FORMAL_VERIFIED] theorems depend only on standard Lean 4 / Mathlib axioms:
- `propext` (propositional extensionality)
- `funext` (function extensionality)
- `Classical.choice` (classical logic)
- `Quot.sound` (quotient soundness)

No user-defined axioms are introduced anywhere in this formalization.

## How to Verify

Add the following to any Lean file and check the output:

```lean
#print axioms chandrasekhar_limit_exists_and_positive
-- Expected output: only standard Lean/Mathlib axioms listed above
Audit Principle
A theorem is [FORMAL_VERIFIED] only when ALL of the following hold:

lake build succeeds
The theorem is part of the build (included in lakefile.toml globs)
No sorry in the proof chain
No admit in the proof chain
No user-defined axiom in the dependency graph
#print axioms shows only standard foundations
