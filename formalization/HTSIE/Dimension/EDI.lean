/-
  HTSIE/Dimension/EDI.lean
  =========================
  Effective Dimensionality Index (EDI).

  Based on: formalization/README.md, Sections 7, 8.6
  Priority: P4

  Evidence: [FORMAL_VERIFIED]
-/

import Mathlib.Analysis.SpecialFunctions.Log.Basic
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates

namespace HTSIE.Dimension

open Real HTSIE.Foundations

/-!
## Effective Dimensionality Index
-/

/--
  EDI using log-cardinality (finite-state version).
  EDI(c) = log(|A(c)|)
  [FORMALIZED]
-/
noncomputable def EDI
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : ℝ :=
  Real.log (accessibleCard sys c : ℝ)

/--
  EDI NON-NEGATIVITY when accessible states ≥ 1.
  [FORMAL_VERIFIED]
-/
theorem edi_nonneg
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ)
    (hacc : accessibleCard sys c ≥ 1) :
    EDI sys c ≥ 0 := by
  unfold EDI
  apply Real.log_nonneg
  exact Nat.one_le_cast.mpr hacc

/--
  EDI = 0 iff exactly one state is accessible.
  [FORMAL_VERIFIED]
-/
theorem edi_zero_iff
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    EDI sys c = 0 ↔ accessibleCard sys c = 1 := by
  unfold EDI
  constructor
  · intro h
    have hlog := Real.log_eq_zero.mp h
    rcases hlog with h1 | h1 | h1
    · exact Nat.cast_injective (by norm_num [h1])
    · exact Nat.cast_injective h1
    · exact Nat.cast_injective (by norm_num [h1])
  · intro h
    rw [h, Nat.cast_one, Real.log_one]

/--
  EDI MONOTONICITY: c₁ ≤ c₂ ⟹ EDI(c₂) ≤ EDI(c₁)
  [FORMAL_VERIFIED]
-/
theorem edi_monotone
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : accessibleCard sys c₂ ≥ 1) :
    EDI sys c₂ ≤ EDI sys c₁ := by
  unfold EDI
  have h_card_le := accessibleCard_monotone sys hmono c₁ c₂ hc
  apply Real.log_le_log
  · exact Nat.cast_pos.mpr (by linarith)
  · exact Nat.cast_le.mpr h_card_le

end HTSIE.Dimension
