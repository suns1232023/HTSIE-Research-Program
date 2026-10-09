/-
  HTSIE/Inequalities/HTSIEInequality.lean
  =========================================
  HTSIE Inequality — finite-state formulation.

  Based on: formalization/README.md, Sections 8.3, 13
  Priority: P5 — Flagship Theorem

  This is the central mathematical claim of the HTSIE programme.
  Current status: finite-state version [FORMAL_VERIFIED].
  Graph/lattice and continuous versions remain [FORMAL_OPEN].

  The theorem states: under ConstraintMonotone,
  stronger constraints simultaneously imply:
    - SII decreases
    - EDI decreases
    - DFFI increases
-/

import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates
import HTSIE.Information.SII
import HTSIE.Information.DFFI
import HTSIE.Dimension.EDI

/-!
## HTSIE Inequality (Finite-State Version)

The full constraint-reduction theorem:
  ConstraintMonotone ∧ c₁ ≤ c₂ ⟹
    SII(c₂) ≤ SII(c₁) ∧ EDI(c₂) ≤ EDI(c₁) ∧ DFFI(c₁) ≤ DFFI(c₂)

Based on: formalization/README.md, Section 8.3.
-/

/--
  HTSIE INEQUALITY — FINITE-STATE VERSION

  Given ConstraintMonotone and c₁ ≤ c₂:
  - SII decreases (less structural information)
  - EDI decreases (lower effective dimension)
  - DFFI increases (more degrees of freedom frozen)

  This is the formal version of the central HTSIE hypothesis.

  [FORMAL_VERIFIED]
-/
theorem htsie_inequality_finite
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    -- SII decreases
    SII sys c₂ ≤ SII sys c₁ ∧
    -- EDI decreases
    EDI sys c₂ ≤ EDI sys c₁ ∧
    -- DFFI increases
    DFFI sys c₁ ≤ DFFI sys c₂ := by
  refine ⟨?_, ?_, ?_⟩
  · exact SII_monotone sys hmono c₁ c₂ hc hacc₂
  · exact EDI_monotone sys hmono c₁ c₂ hc hacc₂
  · exact DFFI_monotone sys hmono c₁ c₂ hc

/--
  HTSIE INEQUALITY — COROLLARY: information-dimension change.

  The accessible state count decreases monotonically.
  [FORMAL_VERIFIED]
-/
theorem htsie_accessible_reduction
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card :=
  accessibility_card_reduction sys hmono c₁ c₂ hc

/--
  OPEN: Graph/lattice version of HTSIE inequality.
  [FORMAL_OPEN]

  The finite-state version above uses ℕ as the constraint type.
  A more general version would use an arbitrary lattice.
  This requires additional Mathlib infrastructure.
-/
-- theorem htsie_inequality_lattice : ... -- [FORMAL_OPEN]

/--
  OPEN: Continuous/geometric version of HTSIE inequality.
  [FORMAL_OPEN]

  Requires measure-theoretic formulation of accessible state spaces.
-/
-- theorem htsie_inequality_continuous : ... -- [FORMAL_OPEN]

/--
  IMPORTANT DISCLAIMER (README Section 14):

  The following are research hypotheses, NOT theorems:
  - "HTSIE is universal across all physical systems" → [CONJECTURE]
  - "LLM scaling follows HTSIE" → [CONJECTURE]
  - "Chandrasekhar limit = HTSIE instability" → [PHYSICAL_OPEN]

  The finite-state theorem above establishes the mathematical
  implication under its encoded assumptions only.
-/
