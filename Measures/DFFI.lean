/-
  Measures/DFFI.lean
  ==================
  Degree-of-Freedom Freeze Index (DFFI).

  Based on: formalization/README.md, Sections 7, 8.5
  Priority: P2

  Key results:
    - DFFI_bounds: 0 ≤ DFFI ≤ 1  [FORMAL_VERIFIED]
    - DFFI_monotone               [FORMAL_VERIFIED]

  Evidence: [FORMAL_VERIFIED] — no sorry in this file.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates

/-!
## Degree-of-Freedom Freeze Index

DFFI(c) = 1 - |A(c)| / |S|

Measures the proportion of states that are "frozen"
(inaccessible) under constraint c.

Physical interpretation: higher DFFI means more degrees
of freedom are locked by the structural constraint.
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
  · linarith [div_le_one_of_le
      (by exact_mod_cast hcard : (accessibleStates sys c).card ≤ X.card)
      (le_of_lt htotal_pos)]
  · linarith [div_nonneg
      (by exact_mod_cast Nat.zero_le (accessibleStates sys c).card)
      (le_of_lt htotal_pos)]

/--
  DFFI MONOTONICITY: stronger constraints ⟹ higher DFFI.
  c₁ ≤ c₂ ⟹ DFFI(c₁) ≤ DFFI(c₂)

  Based on: formalization/README.md, Section 8.5.
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
  linarith [div_le_div_of_nonneg_right
    (by exact_mod_cast hcard :
        (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card)
    htotal_pos]

/--
  DFFI = 0 iff all states are accessible.
  [FORMAL_VERIFIED]
-/
theorem DFFI_zero_iff_full_access
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    DFFI sys c = 0 ↔ (accessibleStates sys c).card = X.card := by
  unfold DFFI
  have htotal_pos : (0 : ℝ) < X.card := by exact_mod_cast X.card_pos
  constructor
  · intro h
    have heq : (accessibleStates sys c).card / (X.card : ℝ) = 1 := by linarith
    rw [div_eq_one_iff_eq (ne_of_gt htotal_pos)] at heq
    exact_mod_cast heq
  · intro h
    have : (accessibleStates sys c).card / (X.card : ℝ) = 1 := by
      rw [div_eq_one_iff_eq (ne_of_gt htotal_pos)]
      exact_mod_cast h
    linarith

/--
  DFFI = 1 iff no states are accessible (complete freezing).
  [FORMAL_VERIFIED]
-/
theorem DFFI_one_iff_no_access
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    DFFI sys c = 1 ↔ (accessibleStates sys c).card = 0 := by
  unfold DFFI
  have htotal_pos : (0 : ℝ) < X.card := by exact_mod_cast X.card_pos
  constructor
  · intro h
    have hzero : (accessibleStates sys c).card / (X.card : ℝ) = 0 := by linarith
    rw [div_eq_zero_iff] at hzero
    cases hzero with
    | inl h => exact_mod_cast h
    | inr h => exact absurd h (ne_of_gt htotal_pos)
  · intro h
    simp only [h, Nat.cast_zero, zero_div, sub_zero]
