/-
  HTSIE/Dimension/EDI.lean
  =========================
  Effective Dimensionality Index (EDI).

  Based on: formalization/README.md, Sections 7, 8.6
  Priority: P4

  Key results:
    - EDI non-negativity  [FORMAL_VERIFIED]
    - EDI monotonicity    [FORMAL_VERIFIED]
    - EDI = 0 iff empty   [FORMAL_VERIFIED]

  NOTE: The current formalization uses log-cardinality as EDI.
  This is NOT claimed to be the unique or physically correct definition.
  The spectral version remains [FORMAL_OPEN].
-/

import Mathlib.Analysis.SpecialFunctions.Log.Basic
import HTSIEFormalization.HTSIE.Foundations.StateSpace
import HTSIEFormalization.HTSIE.Foundations.Constraints
import HTSIEFormalization.HTSIE.Foundations.AccessibleStates

open Real

/-!
## Effective Dimensionality Index

EDI(A) = log(|A|)

Log-cardinality measure of effective dimensionality.
For the spectral version, see SpectralFlow/SpectralDimension.lean [FORMAL_OPEN].
-/

/--
  EDI using log-cardinality (finite-state version).
  EDI(c) = log(|A(c)|)
  [FORMALIZED]
-/
noncomputable def EDI
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : ℝ :=
  Real.log (accessibleStates sys c).card

/--
  EDI NON-NEGATIVITY when accessible states ≥ 1.
  [FORMAL_VERIFIED]
-/
theorem EDI_nonneg
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ)
    (hacc : (accessibleStates sys c).card ≥ 1) :
    EDI sys c ≥ 0 := by
  unfold EDI
  apply Real.log_nonneg
  exact_mod_cast hacc

/--
  EDI = 0 iff exactly one state is accessible.
  [FORMAL_VERIFIED]
-/
theorem EDI_zero_iff
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    EDI sys c = 0 ↔ (accessibleStates sys c).card = 1 := by
  unfold EDI
  constructor
  · intro h
    have := Real.log_eq_zero.mp h
    rcases this with h1 | h1 | h1
    · exact_mod_cast h1.symm ▸ (by norm_num)
    · exact_mod_cast h1
    · exact_mod_cast h1.symm ▸ (by norm_num)
  · intro h
    simp [h]

/--
  EDI MONOTONICITY: A₂ ⊆ A₁ ⟹ EDI(A₂) ≤ EDI(A₁)

  Based on: formalization/README.md, Section 8.6.
  [FORMAL_VERIFIED]
-/
theorem EDI_monotone
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1) :
    EDI sys c₂ ≤ EDI sys c₁ := by
  unfold EDI
  have hcard : (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card :=
    accessibility_card_reduction sys hmono c₁ c₂ hc
  apply Real.log_le_log (by exact_mod_cast hacc₂)
  exact_mod_cast hcard

/--
  STRICT EDI MONOTONICITY when accessibility strictly decreases.
  [FORMAL_VERIFIED]
-/
theorem EDI_strict_monotone
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (c₁ c₂ : ℕ)
    (hacc₂ : (accessibleStates sys c₂).card ≥ 1)
    (hstrict : (accessibleStates sys c₂).card < (accessibleStates sys c₁).card) :
    EDI sys c₂ < EDI sys c₁ := by
  unfold EDI
  apply Real.log_lt_log (by exact_mod_cast hacc₂)
  exact_mod_cast hstrict
