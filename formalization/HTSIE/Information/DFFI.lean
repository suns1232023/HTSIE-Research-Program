/-
  HTSIE/Information/DFFI.lean
  ============================
  Degree-of-Freedom Freeze Index (DFFI).

  Based on: formalization/README.md, Sections 7, 8.5
  Priority: P2

  Evidence: [FORMAL_VERIFIED]
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Linarith
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates

namespace HTSIE.Information

open HTSIE.Foundations

/-!
## Degree-of-Freedom Freeze Index

DFFI(c) = 1 - |A(c)| / |S|
-/

/--
  DFFI for finite state spaces.
  [FORMALIZED]
-/
noncomputable def DFFI
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : ℝ :=
  1 - ((accessibleCard sys c : ℝ) / (X.card : ℝ))

/--
  DFFI BOUNDS: 0 ≤ DFFI ≤ 1
  [FORMAL_VERIFIED]
-/
theorem dffi_bounds
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    0 ≤ DFFI sys c ∧ DFFI sys c ≤ 1 := by
  unfold DFFI
  have hcard_le : accessibleCard sys c ≤ X.card := Finset.card_le_card (sys.accessible_subset c)
  have hpos : 0 < (X.card : ℝ) := by exact_mod_cast X.card_pos
  have hcard_real : (accessibleCard sys c : ℝ) ≤ (X.card : ℝ) := by exact_mod_cast hcard_le
  constructor
  · have hdiv : (accessibleCard sys c : ℝ) / (X.card : ℝ) ≤ 1 := by
      rw [div_le_iff₀ hpos]
      linarith
    linarith
  · have hdiv : 0 ≤ (accessibleCard sys c : ℝ) / (X.card : ℝ) := by
      exact div_nonneg (Nat.cast_nonneg _) (le_of_lt hpos)
    linarith

/--
  DFFI MONOTONICITY: c₁ ≤ c₂ ⟹ DFFI(c₁) ≤ DFFI(c₂)
  [FORMAL_VERIFIED]
-/
theorem dffi_monotone
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    DFFI sys c₁ ≤ DFFI sys c₂ := by
  unfold DFFI
  have h_card_le := accessibleCard_monotone sys hmono c₁ c₂ hc
  have hpos : 0 < (X.card : ℝ) := by exact_mod_cast X.card_pos
  have hcard_real : (accessibleCard sys c₂ : ℝ) ≤ (accessibleCard sys c₁ : ℝ) := by exact_mod_cast h_card_le
  have hdiv : (accessibleCard sys c₂ : ℝ) / (X.card : ℝ) ≤ (accessibleCard sys c₁ : ℝ) / (X.card : ℝ) := by
    exact div_le_div_of_nonneg_right hcard_real (le_of_lt hpos)
  linarith

/--
  DFFI = 0 iff all states are accessible.
  [FORMAL_VERIFIED]
-/
theorem dffi_zero_iff_full_access
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    DFFI sys c = 0 ↔ accessibleCard sys c = X.card := by
  unfold DFFI
  have hpos : 0 < (X.card : ℝ) := by exact_mod_cast X.card_pos
  constructor
  · intro h
    have hdiv : (accessibleCard sys c : ℝ) / (X.card : ℝ) = 1 := by linarith
    rw [div_eq_one_iff_eq (ne_of_gt hpos)] at hdiv
    exact_mod_cast hdiv
  · intro h
    have hdiv : (accessibleCard sys c : ℝ) / (X.card : ℝ) = 1 := by
      rw [div_eq_one_iff_eq (ne_of_gt hpos)]
      exact_mod_cast h
    linarith

end HTSIE.Information
