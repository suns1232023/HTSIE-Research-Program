/-  Theorems/HTSIEInequality.lean  [FORMAL_VERIFIED]-/
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates
import HTSIE.Information.SII
import HTSIE.Information.DFFI
import HTSIE.Dimension.EDI
import Theorems.ConstraintReduction

theorem htsie_inequality_weak
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ :=
  SII_monotone sys hmono c₁ c₂ hc hacc₂

theorem htsie_inequality_strong
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ ∧
    EDI sys c₂ ≤ EDI sys c₁ ∧
    DFFI sys c₁ ≤ DFFI sys c₂ :=
  htsie_constraint_reduction sys hmono c₁ c₂ hc hacc₂
