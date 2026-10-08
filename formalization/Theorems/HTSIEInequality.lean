/-
  Theorems/HTSIEInequality.lean
  ==============================
  HTSIE Inequality — multiple formulations and open problems.

  Based on: formalization/README.md, Sections 8.3, 13
  Priority: P5 — Flagship

  Current status:
    Finite-state version: [FORMAL_VERIFIED]
    Graph/lattice version: [FORMAL_OPEN]
    Continuous version:    [FORMAL_OPEN]
-/

import HTSIEFormalization.HTSIE.Foundations.StateSpace
import HTSIEFormalization.HTSIE.Foundations.Constraints
import HTSIEFormalization.HTSIE.Foundations.AccessibleStates
import HTSIEFormalization.HTSIE.Information.SII
import HTSIEFormalization.HTSIE.Information.DFFI
import HTSIEFormalization.HTSIE.Dimension.EDI
import HTSIEFormalization.Theorems.ConstraintReduction

/-!
## HTSIE Inequality — Weak Form (Finite State)

The weak form states that all three measures respond correctly
under ConstraintMonotone. This is [FORMAL_VERIFIED].
-/

/--
  HTSIE INEQUALITY — WEAK FORM (FINITE STATE)
  [FORMAL_VERIFIED]
-/
theorem htsie_inequality_weak
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ :=
  SII_monotone sys hmono c₁ c₂ hc hacc₂

/--
  HTSIE INEQUALITY — STRONG FORM (FINITE STATE)
  All three measures simultaneously.
  [FORMAL_VERIFIED]
-/
theorem htsie_inequality_strong
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ ∧
    EDI sys c₂ ≤ EDI sys c₁ ∧
    DFFI sys c₁ ≤ DFFI sys c₂ :=
  htsie_constraint_reduction sys hmono c₁ c₂ hc hacc₂

/-!
## Open Problems (README Section 13)
-/

/--
  OPEN: Quantitative HTSIE inequality with explicit bounds.
  [FORMAL_OPEN]
-/
-- theorem htsie_inequality_quantitative : ... -- [FORMAL_OPEN]

/--
  OPEN: Differential HTSIE inequality (dSII/dc ≤ 0).
  [FORMAL_OPEN] — requires differentiability of SII in c.
-/
-- theorem htsie_inequality_differential : ... -- [FORMAL_OPEN]

/--
  OPEN: Graph/lattice version.
  [FORMAL_OPEN]
-/
-- theorem htsie_inequality_lattice : ... -- [FORMAL_OPEN]

/--
  OPEN: Continuous/geometric version.
  [FORMAL_OPEN]
-/
-- theorem htsie_inequality_continuous : ... -- [FORMAL_OPEN]
