/-  Theorems/ConstraintReduction.lean  [FORMAL_VERIFIED]-/
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates
import HTSIE.Information.SII
import HTSIE.Information.DFFI
import HTSIE.Dimension.EDI

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

theorem constraint_implies_accessibility_reduction
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card :=
  accessibility_card_reduction sys hmono c₁ c₂ hc

theorem chain_requires_constraint_monotone :
    ∃ (X : FinStateSpace) (sys : FinConstraintSystem X),
    ¬ ConstraintMonotone sys :=
  constraint_monotone_can_fail
