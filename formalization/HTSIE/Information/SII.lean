/-  HTSIE/Information/SII.lean  [FORMAL_VERIFIED]-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates

open Real

noncomputable def SII
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : ℝ :=
  if (accessibleStates sys c).card = 0 then 0
  else Real.log (accessibleStates sys c).card / Real.log X.card

theorem SII_nonneg
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ)
    (hacc : (accessibleStates sys c).card ≥ 1) :
    SII sys c ≥ 0 := by
  unfold SII
  simp only [show (accessibleStates sys c).card ≠ 0 from
    Nat.not_eq_zero_of_lt (by linarith)]
  apply div_nonneg
  · apply Real.log_nonneg; exact_mod_cast hacc
  · apply Real.log_nonneg; exact_mod_cast X.card_pos

theorem SII_monotone
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ := by
  unfold SII
  have hcard : (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card :=
    accessibility_card_reduction sys hmono c₁ c₂ hc
  have hacc₁ : (accessibleStates sys c₁).card ≥ 1 := le_trans hacc₂ hcard
  simp only [
    show (accessibleStates sys c₂).card ≠ 0 from Nat.not_eq_zero_of_lt (by linarith),
    show (accessibleStates sys c₁).card ≠ 0 from Nat.not_eq_zero_of_lt (by linarith)]
  apply div_le_div_of_nonneg_right _ (Real.log_nonneg (by exact_mod_cast X.card_pos))
  apply Real.log_le_log (by exact_mod_cast hacc₂)
  exact_mod_cast hcard
