/-
  HTSIE/Information/DFFI.lean
  ============================
  Degree-of-Freedom Freeze Index (DFFI).

  Based on: formalization/README.md, Sections 7, 8.5
  Priority: P2

  Key results:
    - DFFI_finite_bounds: 0 ≤ DFFI ≤ 1  [FORMAL_VERIFIED]
    - DFFI monotonicity under constraint increase  [FORMAL_VERIFIED]
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.Nat.Basic
import HTSIEFormalization.HTSIE.Foundations.StateSpace
import HTSIEFormalization.HTSIE.Foundations.Constraints
import HTSIEFormalization.HTSIE.Foundations.AccessibleStates

/-!
## Degree-of-Freedom Freeze Index

DFFI(c) = 1 - |A(c)| / |S|

Measures the proportion of states that are "frozen"
(inaccessible) under constraint c.
-/

/--
  DFFI for finite state spaces.
  DFFI(c) = 1 - |A(c)| / |S|
  [FORMALIZED]
-/
noncomputable def DFFI
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : ℝ :=
  1 - (accessibleStates sys c).card / X.card

/--
  DFFI BOUNDS: 0 ≤ DFFI ≤ 1

  Based on: formalization/README.md, Section 8.5.
  [FORMAL_VERIFIED]
-/
theorem DFFI_bounds
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    0 ≤ DFFI sys c ∧ DFFI sys c ≤ 1 := by
  unfold DFFI
  have hcard : (accessibleStates sys c).card ≤ X.card :=
    accessible_card_le_total sys c
  have htotal_pos : (0 : ℝ) < X.card := by
    exact_mod_cast X.card_pos
  constructor
  · linarith [div_le_one_of_le (by exact_mod_cast hcard) (le_of_lt htotal_pos)]
  · linarith [div_nonneg (by exact_mod_cast Nat.zero_le _) (le_of_lt htotal_pos)]

/--
  DFFI = 0 iff all states are accessible (no freezing).
  [FORMAL_VERIFIED]
-/
theorem DFFI_zero_iff_full_access
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    DFFI sys c = 0 ↔ (accessibleStates sys c).card = X.card := by
  unfold DFFI
  constructor
  · intro h
    have htotal_pos : (0 : ℝ) < X.card := by exact_mod_cast X.card_pos
    have : (accessibleStates sys c).card / X.card = 1 := by linarith
    rw [div_eq_one_iff_eq (ne_of_gt htotal_pos)] at this
    exact_mod_cast this
  · intro h
    simp [h, div_self (ne_of_gt (show (0:ℝ) < X.card by exact_mod_cast X.card_pos))]

/--
  DFFI MONOTONICITY: stronger constraints ⟹ higher DFFI.
  c₁ ≤ c₂ ⟹ DFFI(c₁) ≤ DFFI(c₂)
  [FORMAL_VERIFIED]
-/
theorem DFFI_monotone
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    DFFI sys c₁ ≤ DFFI sys c₂ := by
  unfold DFFI
  have hcard : (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card :=
    accessibility_card_reduction sys hmono c₁ c₂ hc
  have htotal_pos : (0 : ℝ) < X.card := by exact_mod_cast X.card_pos
  linarith [div_le_div_of_nonneg_right (by exact_mod_cast hcard) htotal_pos]
