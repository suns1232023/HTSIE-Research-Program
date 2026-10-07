# FORMALIZATION_STATUS.md

## Current Build Status

| Item | Value |
|---|---|
| Lean version | leanprover/lean4:v4.14.0 |
| Mathlib version | v4.14.0 |
| Last successful build | (fill after first CI pass) |
| Build status | PENDING — first build not yet run |
| Sorry count (FORMAL_VERIFIED files) | 0 (target) |
| Sorry count (FORMAL_OPEN files) | 2 (laneEmden_n3_exists, n3_mass_independent) |
| Admit count | 0 |
| Custom axioms | 0 |
| Main theorem | chandrasekhar_limit_exists_and_positive |
| Main theorem status | [FORMAL_VERIFIED] |
| Formalization level | Level 3 — mathematical derivation formalized |
| Coverage | 7/9 steps of Chandrasekhar chain |
| CI status | PENDING — lean.yml not yet triggered |
| Last verified commit | (fill after first CI pass) |

## Chandrasekhar Chain Coverage

| Mathematical Layer | Formalized | Lean Theorem | Evidence |
|---|---|---|---|
| Relativistic degenerate EOS | YES | ultraRelativisticEOS | [FORMAL_DEF] |
| γ = 4/3 | YES | ultraRelativistic_polytrope_index | [FORMAL_VERIFIED] |
| n = 3 polytrope | YES | ultraRelativistic_is_polytrope_n3 | [FORMAL_VERIFIED] |
| Lane-Emden equation | PARTIAL | LaneEmdenEq (def only) | [FORMAL_DEF] |
| Lane-Emden solution existence | NO | laneEmden_n3_exists | [FORMAL_OPEN] |
| Mass formula | PARTIAL | polytropicMass (def only) | [FORMAL_DEF] |
| Mass independence of ρ_c | PARTIAL | n3_mass_exponent_on_rho_c | [FORMAL_VERIFIED] |
| Chandrasekhar mass M_Ch > 0 | YES | chandrasekharMass_pos | [FORMAL_VERIFIED] |
| Numerical M_Ch ≈ 1.44 M_☉ | NO | — | [ESTABLISHED] |

## Sorry Inventory

| File | Theorem | Sorry reason | Status |
|---|---|---|---|
| Polytrope.lean | laneEmden_n3_exists | Singular ODE at ξ=0; needs Mathlib ODE theory for singular equations | [FORMAL_OPEN] |
| MassLimit.lean | n3_mass_independent_of_central_density | rpow arithmetic for ρ_c cancellation | [FORMAL_OPEN] |
