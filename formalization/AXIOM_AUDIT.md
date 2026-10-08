# AXIOM_AUDIT.md

## Purpose

Every substantive theorem should be accompanied by an explicit assumption audit.
For each theorem, this file records:
1. What is formally assumed?
2. What is actually proved?
3. Which definitions are model choices?
4. Which assumptions are physically motivated?
5. Which assumptions remain unverified?

## Standard Lean/Mathlib Axiom Basis

All [FORMAL_VERIFIED] theorems in this project depend only on:
- `propext` (propositional extensionality)
- `funext` (function extensionality)
- `Classical.choice` (classical logic)
- `Quot.sound` (quotient soundness)

No user-defined axioms are introduced anywhere in this formalization.

## Per-Theorem Audit

| Theorem | File | Compiles | Sorry | Custom Axioms | Status |
|---|---|---|---|---|---|
| `FinStateSpace.card_pos` | Foundations/StateSpace.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `constraint_monotone_can_fail` | Foundations/Constraints.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `accessibility_reduction` | Foundations/AccessibleStates.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `DFFI_bounds` | Information/DFFI.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `DFFI_monotone` | Information/DFFI.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `SII_nonneg` | Information/SII.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `SII_monotone` | Information/SII.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `EDI_nonneg` | Dimension/EDI.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `EDI_monotone` | Dimension/EDI.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `htsie_inequality_finite` | Inequalities/HTSIEInequality.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `spectral_flow_iff_folding_monotone` | SpectralFlow/SpectralDimension.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `htsie_instability_corrected` | Theorems/Instability.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `htsie_constraint_reduction` | Theorems/ConstraintReduction.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `saturation_not_instability` | Counterexamples/SaturationNotInstability.lean | YES | 0 | 0 | [FORMAL_COUNTEREXAMPLE] |
| `DFFI_SAE_bounds` | Applications/SAE/DFFI_SAE.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `chandrasekharMass_pos` | Applications/Chandrasekhar/MassLimit.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `chandrasekhar_limit_exists_and_positive` | Applications/Chandrasekhar/Main.lean | YES | 0 | 0 | [FORMAL_VERIFIED] |
| `laneEmden_n3_exists` | Applications/Chandrasekhar/Polytrope.lean | YES | 1 | 0 | [FORMAL_OPEN] |
| `n3_mass_independent_of_central_density` | Applications/Chandrasekhar/MassLimit.lean | YES | 1 | 0 | [FORMAL_OPEN] |

## Sorry Inventory

| File | Theorem | Sorry Reason | Status |
|---|---|---|---|
| Applications/Chandrasekhar/Polytrope.lean | `laneEmden_n3_exists` | Singular ODE at ξ=0; needs Mathlib ODE theory for singular equations | [FORMAL_OPEN] |
| Applications/Chandrasekhar/MassLimit.lean | `n3_mass_independent_of_central_density` | rpow arithmetic for ρ_c cancellation | [FORMAL_OPEN] |

## Key Distinction

[FORMAL_VERIFIED] ≠ [PHYSICALLY VERIFIED] [NUMERICAL] ≠ [FORMAL_VERIFIED]


A Lean-verified theorem establishes correctness under encoded assumptions only.
It does not establish that the physical model is complete or empirically correct.

## How to Verify

Run in any Lean file:
```lean
#print axioms htsie_instability_corrected
-- Expected: only propext, funext, Classical.choice, Quot.sound
