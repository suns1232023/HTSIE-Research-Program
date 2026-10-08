/-  Applications/SAE/DFFI_SAE.lean  [FORMAL_VERIFIED]-/
import Mathlib.Data.Real.Basic
import Mathlib.Data.Finset.Basic
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates
import HTSIE.Information.DFFI

noncomputable def DFFI_SAE (n : ℕ) (hn : n > 0) (active_count : ℕ)
    (h_le : active_count ≤ n) : ℝ :=
  (active_count : ℝ) / n

theorem DFFI_SAE_bounds (n : ℕ) (hn : n > 0) (active_count : ℕ)
    (h_le : active_count ≤ n) :
    0 ≤ DFFI_SAE n hn active_count h_le ∧
    DFFI_SAE n hn active_count h_le ≤ 1 := by
  unfold DFFI_SAE
  have hn_pos : (0 : ℝ) < n := by exact_mod_cast hn
  constructor
  · apply div_nonneg (by exact_mod_cast Nat.zero_le active_count) (le_of_lt hn_pos)
  · exact div_le_one_of_le (by exact_mod_cast h_le) (le_of_lt hn_pos)

theorem DFFI_SAE_monotone_in_sparsity
    (n : ℕ) (hn : n > 0)
    (k₁ k₂ : ℕ) (hk₁ : k₁ ≤ n) (hk₂ : k₂ ≤ n)
    (hk : k₂ ≤ k₁) :
    DFFI_SAE n hn k₁ hk₁ ≤ DFFI_SAE n hn k₂ hk₂ := by
  unfold DFFI_SAE
  have hn_pos : (0 : ℝ) < n := by exact_mod_cast hn
  exact div_le_div_of_nonneg_right (by exact_mod_cast hk) (le_of_lt hn_pos)
