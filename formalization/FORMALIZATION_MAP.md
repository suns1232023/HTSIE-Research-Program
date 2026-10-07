# FORMALIZATION_MAP.md

## Mathematical-to-Lean Mapping

This table maps every mathematical statement in the preprint
to its corresponding Lean declaration.

| ID | Mathematical Statement | Lean Declaration | File | Evidence |
|---|---|---|---|---|
| CH-DEF-01 | Physical parameters (G, ħ, c, m_e, m_H, μ_e > 0) | `ChandrasekharParams` | Basic.lean | [FORMAL_DEF] |
| CH-DEF-02 | EOS coefficient K = f(ħ, c, μ_e, m_H) | `eosCoefficient` | Basic.lean | [FORMAL_DEF] |
| CH-DEF-03 | Polytropic EOS: P = K·ρ^(1+1/n) | `polytropicEOS` | EquationOfState.lean | [FORMAL_DEF] |
| CH-DEF-04 | Ultra-relativistic EOS: P = K·ρ^(4/3) | `ultraRelativisticEOS` | EquationOfState.lean | [FORMAL_DEF] |
| CH-DEF-05 | Lane-Emden equation (pointwise) | `LaneEmdenEq` | Polytrope.lean | [FORMAL_DEF] |
| CH-DEF-06 | Lane-Emden boundary conditions | `LaneEmdenBC` | Polytrope.lean | [FORMAL_DEF] |
| CH-DEF-07 | Lane-Emden solution | `IsLaneEmdenSolution` | Polytrope.lean | [FORMAL_DEF] |
| CH-DEF-08 | Stellar surface (first zero ξ₁) | `StellarSurface` | Polytrope.lean | [FORMAL_DEF] |
| CH-DEF-09 | Lane-Emden constant ξ₁²\|θ'(ξ₁)\| | `laneEmdenConstant` | Polytrope.lean | [FORMAL_DEF] |
| CH-DEF-10 | Chandrasekhar mass formula | `chandrasekharMassFormula` | MassLimit.lean | [FORMAL_DEF] |
| CH-DEF-11 | Chandrasekhar mass (physical) | `chandrasekharMass` | MassLimit.lean | [FORMAL_DEF] |
| CH-DEF-12 | Chandrasekhar model structure | `ChandrasekharModel` | Main.lean | [FORMAL_DEF] |
| CH-THM-01 | K > 0 | `eosCoefficient_pos` | Basic.lean | [FORMAL_VERIFIED] |
| CH-THM-02 | Ultra-relativistic EOS = n=3 polytrope | `ultraRelativistic_is_polytrope_n3` | EquationOfState.lean | [FORMAL_VERIFIED] |
| CH-THM-03 | 1 + 1/3 = 4/3 | `ultraRelativistic_polytrope_index` | EquationOfState.lean | [FORMAL_VERIFIED] |
| CH-THM-04 | 1 - 3·(1/3) = 0 (density independence) | `n3_mass_exponent_on_rho_c` | MassLimit.lean | [FORMAL_VERIFIED] |
| CH-THM-05 | M_Ch > 0 | `chandrasekharMass_pos` | MassLimit.lean | [FORMAL_VERIFIED] |
| CH-THM-06 | M_Ch exists and is positive (main theorem) | `chandrasekhar_limit_exists_and_positive` | Main.lean | [FORMAL_VERIFIED] |
| CH-OPN-01 | Lane-Emden solution exists for n=3 | `laneEmden_n3_exists` | Polytrope.lean | [FORMAL_OPEN] |
| CH-OPN-02 | Full mass formula derivation | `n3_mass_independent_of_central_density` | MassLimit.lean | [FORMAL_OPEN] |
| CH-PHY-01 | Physical interpretation of M_Ch | — | — | [PHYSICAL_OPEN] |
| CH-CON-01 | HTSIE interpretation of Chandrasekhar limit | — | — | [CONJECTURE] |
| CH-EST-01 | Classical Chandrasekhar derivation (1931) | — | Literature | [ESTABLISHED] |
| CH-EST-02 | M_Ch ≈ 1.44 M_☉ for μ_e = 2 | — | Literature | [ESTABLISHED] |

## Formalization Level

**Current level: Level 3** — Mathematical derivation formalized.

| Level | Description | Achieved |
|---|---|---|
| 1 | Numerical verification of known formula | YES |
| 2 | Algebraic formalization of formula | YES |
| 3 | Formalization of mathematical derivation | YES (partial) |
| 4 | Physical assumptions → full derivation | NO (Lane-Emden ODE open) |
