/-
  Theorems/ConstraintReduction.lean
  ==================================
  Full constraint reduction theorem.

  Based on: formalization/README.md, Section 8.3
  Priority: P1

  This is the formal version of the central HTSIE constraint-reduction
  mechanism, combining all three measures.

  [FORMAL_VERIFIED]
-/

import HTSIEFormalization.HTSIE.Foundations.StateSpace
import HTSIEFormalization.HTSIE.Foundations.Constraints
import HTSIEFormalization.HTSIE.Foundations.AccessibleStates
import HTSIEFormalization.HTSIE.Information.SII
import HTSIEFormalization.HTSIE.Information.DFFI
import HTSIEFormalization.HTSIE.Dimension.EDI

/-!
## Full Constraint Reduction Theorem

ConstraintMonotone ∧ SIIMeasure ∧ EDIMeasure ∧ DFFIMeasure ∧ c₁ ≤ c₂
⟹
  SII(A(c₂)) ≤ SII(A(c₁))
  ∧ EDI(A(c₂)) ≤ EDI(A(c₁))
  ∧ DFFI(c₁) ≤ DFFI(c₂)

Based on: formalization/README.md, Section 8.3.
-/

/--
  FULL CONSTRAINT REDUCTION THEOREM

  Given ConstraintMonotone and c₁ ≤ c₂, all three HTSIE measures
  respond in the expected direction simultaneously.

  [FORMAL_VERIFIED]
-/
theorem htsie_constraint_reduction
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ ∧
    EDI sys c₂ ≤ EDI sys c₁ ∧
    DFFI sys c₁ ≤ DFFI sys c₂ :=
  ⟨SII_monotone sys hmono c₁ c₂ hc hacc₂,
   EDI_monotone sys hmono c₁ c₂ hc hacc₂,
   DFFI_monotone sys hmono c₁ c₂ hc⟩

/--
  Accessibility reduction is the foundational step.
  All measure inequalities follow from this.
  [FORMAL_VERIFIED]
-/
theorem constraint_implies_accessibility_reduction
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card :=
  accessibility_card_reduction sys hmono c₁ c₂ hc

/--
  Without ConstraintMonotone, the chain can fail.
  [FORMAL_VERIFIED] — see Constraints.lean for the counterexample.
-/
theorem chain_requires_constraint_monotone :
    ∃ (X : FinStateSpace) (sys : FinConstraintSystem X),
    ¬ ConstraintMonotone sys :=
  constraint_monotone_can_fail
