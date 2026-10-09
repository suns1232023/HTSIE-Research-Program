/-
  Applications/SAE/DFFI_SAE.lean
  ================================
  DFFI Application to Sparse Autoencoders (SAE).

  Evidence: [FORMAL_VERIFIED]
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates

namespace Applications.SAE

open HTSIE.Foundations

/--
  SAE Top-K DFFI measure representation.
  DFFI(k) = 1 - k / N
-/
noncomputable def sae_dffi (N k : ℕ) : ℝ :=
  1 - ((k : ℝ) / (N : ℝ))

theorem sae_dffi_bounds (N k : ℕ) (hN : N > 0) (hk : k ≤ N) :
    0 ≤ sae_dffi N k ∧ sae_dffi N k ≤ 1 := by
  unfold sae_dffi
  have hN_real : 0 < (N : ℝ) := Nat.cast_pos.mpr hN
  have hk_real : (k : ℝ) ≤ (N : ℝ) := Nat.cast_le.mpr hk
  constructor
  · have hdiv : (k : ℝ) / (N : ℝ) ≤ 1 := by
      exact div_le_one_of_le₀ hk_real (le_of_lt hN_real)
    linarith
  · have hdiv : 0 ≤ (k : ℝ) / (N : ℝ) := div_nonneg (Nat.cast_nonneg _) (le_of_lt hN_real)
    linarith

/--
  SAE Sparsity Monotonicity: Smaller k (stronger constraint) leads to higher DFFI.
  If k₁ ≤ k₂, then sae_dffi N k₂ ≤ sae_dffi N k₁.
-/
theorem sae_dffi_monotone (N k₁ k₂ : ℕ) (hN : N > 0) (hk : k₁ ≤ k₂) :
    sae_dffi N k₂ ≤ sae_dffi N k₁ := by
  unfold sae_dffi
  have hN_real : 0 < (N : ℝ) := Nat.cast_pos.mpr hN
  have hk_real : (k₁ : ℝ) ≤ (k₂ : ℝ) := Nat.cast_le.mpr hk
  have hdiv : (k₁ : ℝ) / (N : ℝ) ≤ (k₂ : ℝ) / (N : ℝ) :=
    div_le_div_of_nonneg_right hk_real (le_of_lt hN_real)
  linarith

end Applications.SAE
