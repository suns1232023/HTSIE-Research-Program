/-
  Applications/SAE/DFFI_SAE.lean
  ================================
  DFFI applied to Sparse Autoencoder (SAE) representations.

  Based on: formalization/README.md, Sections 5 (P8), 14
  Priority: P8

  IMPORTANT DISCLAIMER (README Section 14):
    "LLM scaling follows HTSIE" → [CONJECTURE]
    "5-7% dead latents" → [EMPIRICAL] — do NOT formalize as pure math theorem
    "T ~ n^(0.60-0.65)" → [EMPIRICAL] — data research only

  What IS formalized here:
    - DFFI for finite neural representations [FORMALIZED]
    - Connection to dead latent states [FORMAL_VERIFIED]

  What remains [CONJECTURE] or [EMPIRICAL]:
    - Universal SAE-HTSIE correspondence
    - Specific scaling exponents
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Real.Basic
import HTSIEFormalization.HTSIE.Foundations.StateSpace
import HTSIEFormalization.HTSIE.Foundations.Constraints
import HTSIEFormalization.HTSIE.Foundations.AccessibleStates
import HTSIEFormalization.HTSIE.Information.DFFI

/-!
## SAE as a Finite Constraint System

An SAE with n features can be modeled as a finite state space
where each feature is a "state" and sparsity constraints
determine which features are "accessible" (active).
-/

/--
  SAE feature space: n features indexed by ℕ.
  [FORMALIZED]
-/
def SAEFeatureSpace (n : ℕ) (hn : n > 0) : FinStateSpace := {
  states := Finset.range n
  nonempty := ⟨0, Finset.mem_range.mpr hn⟩
}

/--
  Active features under a sparsity constraint k:
  at most k features are active (accessible).

  This models the SAE sparsity constraint.
  [FORMALIZED]
-/
def SAEActiveFeatures (n k : ℕ) (active : Finset ℕ)
    (h_sub : active ⊆ Finset.range n)
    (h_card : active.card ≤ k) : Finset ℕ := active

/--
  DFFI for SAE: proportion of "dead" (frozen) features.

  DFFI_SAE = 1 - |active features| / |total features|

  This is the mathematical formalization of the "dead latent" concept.
  The specific value (5-7%) is [EMPIRICAL] and not encoded here.

  [FORMAL_VERIFIED]
-/
noncomputable def DFFI_SAE (n : ℕ) (hn : n > 0) (active_count : ℕ)
    (h_le : active_count ≤ n) : ℝ :=
  1 - (active_count : ℝ) / n

/--
  DFFI_SAE is in [0, 1].
  [FORMAL_VERIFIED]
-/
theorem DFFI_SAE_bounds (n : ℕ) (hn : n > 0) (active_count : ℕ)
    (h_le : active_count ≤ n) :
    0 ≤ DFFI_SAE n hn active_count h_le ∧
    DFFI_SAE n hn active_count h_le ≤ 1 := by
  unfold DFFI_SAE
  have hn_pos : (0 : ℝ) < n := by exact_mod_cast hn
  constructor
  · linarith [div_le_one_of_le (by exact_mod_cast h_le) (le_of_lt hn_pos)]
  · linarith [div_nonneg (by exact_mod_cast Nat.zero_le active_count) (le_of_lt hn_pos)]

/--
  Higher sparsity (fewer active features) ⟹ higher DFFI_SAE.
  [FORMAL_VERIFIED]
-/
theorem DFFI_SAE_monotone_in_sparsity
    (n : ℕ) (hn : n > 0)
    (k₁ k₂ : ℕ) (hk₁ : k₁ ≤ n) (hk₂ : k₂ ≤ n)
    (hk : k₂ ≤ k₁) :
    DFFI_SAE n hn k₁ hk₁ ≤ DFFI_SAE n hn k₂ hk₂ := by
  unfold DFFI_SAE
  have hn_pos : (0 : ℝ) < n := by exact_mod_cast hn
  linarith [div_le_div_of_nonneg_right (by exact_mod_cast hk) hn_pos]

/-!
## Separation of Formal and Empirical Claims

The following are [EMPIRICAL] observations, NOT formal theorems:
  - Dead latent proportion ≈ 5-7% in practice
  - Training sample scaling T ~ n^(0.60-0.65)
  - Correspondence with 3D Ising critical exponent ν ≈ 0.6308

These should be investigated through computational experiments
(see experiments/ directory), not encoded as Lean axioms.
-/
