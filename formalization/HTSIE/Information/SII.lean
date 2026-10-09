/-
  HTSIE/Information/SII.lean
  ==========================
  Structural Information Index (SII).

  Evidence: [FORMAL_VERIFIED]
-/

import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Linarith
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates

namespace HTSIE.Information

open Real HTSIE.Foundations

/--
  Structural Information Index (SII).
-/
noncomputable def SII
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : ℝ :=
  if accessibleCard sys c = 0 then 0
  else Real.log (accessibleCard sys c : ℝ) / Real.log (X.card : ℝ)

/--
  SII Non-negativity.
  [FORMAL_VERIFIED]
-/
theorem sii_nonneg
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ)
    (hacc : accessibleCard sys c ≥ 1) :
    SII sys c ≥ 0 := by
  unfold SII
  have hnz : accessibleCard sys c ≠ 0 := by linarith
  rw [if_neg hnz]
  apply div_nonneg
  · apply Real.log_nonneg
    exact Nat.one_le_cast.mpr hacc
  · apply Real.log_nonneg
    exact Nat.one_le_cast.mpr X.card_pos

/--
  SII Monotonicity.
  [FORMAL_VERIFIED]
-/
theorem sii_monotone
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : accessibleCard sys c₂ ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ := by
  unfold SII
  have h_card_le := accessibleCard_monotone sys hmono c₁ c₂ hc
  have hacc₁ : accessibleCard sys c₁ ≥ 1 := le_trans hacc₂ h_card_le
  have hnz1 : accessibleCard sys c₁ ≠ 0 := by linarith
  have hnz2 : accessibleCard sys c₂ ≠ 0 := by linarith
  rw [if_neg hnz1, if_neg hnz2]
  have hX_pos : 0 < (X.card : ℝ) := Nat.cast_pos.mpr X.card_pos
  by_cases hX1 : X.card = 1
  · have h_card1 : (X.card : ℝ) = 1 := Nat.cast_inj.mpr hX1
    rw [h_card1, Real.log_one, div_zero, div_zero]
  · have hX_gt1 : 1 < (X.card : ℝ) := Nat.one_lt_cast.mpr (lt_of_le_of_ne X.card_pos (Ne.symm hX1))
    have hlogX : 0 < Real.log (X.card : ℝ) := Real.log_pos hX_gt1
    have hlog_le : Real.log (accessibleCard sys c₂ : ℝ) ≤ Real.log (accessibleCard sys c₁ : ℝ) := by
      apply Real.log_le_log
      · exact Nat.cast_pos.mpr (by linarith)
      · exact Nat.cast_le.mpr h_card_le
    exact div_le_div_of_nonneg_right hlog_le (le_of_lt hlogX)

end HTSIE.Information
