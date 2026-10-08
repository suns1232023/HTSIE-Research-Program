---

## 文件16：`formalization/FORMALIZATION_STATUS.md`（完整最终版）

```markdown
# FORMALIZATION_STATUS.md

## Build Environment

| Item | Value |
|---|---|
| Lean version | leanprover/lean4:v4.14.0 |
| Mathlib version | v4.14.0 (pinned in lakefile.toml) |
| Build command | `lake build HTSIEFormalization` |
| CI | `.github/workflows/lean.yml` |
| Sorry count (FORMAL_VERIFIED files) | 0 (target) |
| Sorry count (FORMAL_OPEN files) | 2 (documented in AXIOM_AUDIT.md) |
| Custom axioms | 0 |

## Complete Proposition Status

| Proposition | Mathematical Status | Lean Status | Computational / Physical Status |
|---|---|---|---|
| `FinStateSpace` | Defined | [FORMALIZED] | — |
| `FinConstraintSystem` | Defined | [FORMALIZED] | — |
| `ConstraintMonotone` | Defined | [FORMALIZED] | — |
| `DFFI` | Defined | [FORMALIZED] | — |
| `SII` | Defined | [FORMALIZED] | — |
| `EDI` | Defined | [FORMALIZED] | — |
| `SpectralDimFn` | Defined | [FORMALIZED] | — |
| `foldingParameter` | Defined | [FORMALIZED] | — |
| `NegativeProductDerivAbove` | Defined | [FORMALIZED] | — |
| `card_pos` | Theorem | [FORMAL_VERIFIED] | — |
| `constraint_monotone_can_fail` | Theorem | [FORMAL_VERIFIED] | — |
| `accessibility_reduction` | Theorem | [FORMAL_VERIFIED] | — |
| `DFFI_bounds` (0 ≤ DFFI ≤ 1) | Theorem | [FORMAL_VERIFIED] | — |
| `DFFI_monotone` | Theorem | [FORMAL_VERIFIED] | — |
| `SII_nonneg` | Theorem | [FORMAL_VERIFIED] | — |
| `SII_monotone` | Theorem | [FORMAL_VERIFIED] | — |
| `EDI_nonneg` | Theorem | [FORMAL_VERIFIED] | — |
| `EDI_monotone` | Theorem | [FORMAL_VERIFIED] | — |
| `htsie_inequality_finite` | Theorem | [FORMAL_VERIFIED] | — |
| `spectral_flow_iff_folding_monotone` | Theorem | [FORMAL_VERIFIED] | — |
| `htsie_instability_corrected` | Theorem | [FORMAL_VERIFIED] | — |
| `htsie_constraint_reduction` | Theorem | [FORMAL_VERIFIED] | — |
| `saturation_not_instability` | **REFUTED** | [FORMAL_COUNTEREXAMPLE] | — |
| `DFFI_SAE_bounds` | Theorem | [FORMAL_VERIFIED] | — |
| `chandrasekharMass_pos` | Theorem | [FORMAL_VERIFIED] | — |
| `chandrasekhar_limit_exists_and_positive` | Theorem | [FORMAL_VERIFIED] | — |
| `laneEmden_n3_exists` | Open | [FORMAL_OPEN] | [ESTABLISHED] |
| `n3_mass_independent` | Open | [FORMAL_OPEN] | [ESTABLISHED] |
| Spectral dim from heat kernel | Open | [FORMAL_OPEN] | [NUMERICAL] |
| HTSIE inequality (lattice) | Open | [FORMAL_OPEN] | — |
| HTSIE inequality (continuous) | Open | [FORMAL_OPEN] | — |
| Universal HTSIE principle | Conjecture | [CONJECTURE] | [OPEN] |
| LLM scaling follows HTSIE | Conjecture | [CONJECTURE] | [NUMERICAL] |
| 5-7% dead latents | Empirical | [EMPIRICAL] | [NUMERICAL] |
| T ~ n^(0.60-0.65) scaling | Empirical | [EMPIRICAL] | [NUMERICAL] |

## Formalization Level

**Current level: Level 3** — Mathematical derivation formalized.

| Level | Description | Achieved |
|---|---|---|
| 1 | Numerical verification | YES |
| 2 | Algebraic formalization | YES |
| 3 | Mathematical derivation | YES (partial) |
| 4 | Physical assumptions → full derivation | NO (Lane-Emden ODE open) |
