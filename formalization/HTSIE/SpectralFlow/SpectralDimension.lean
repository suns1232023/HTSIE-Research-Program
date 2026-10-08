/-
  HTSIE/SpectralFlow/SpectralDimension.lean
  [FORMAL_VERIFIED] for monotonicity equivalence.
-/

import Mathlib.Order.Monotone.Basic
import Mathlib.Data.Real.Basic

def SpectralDimFn := ℝ → ℝ

noncomputable def foldingParameter (D_s : SpectralDimFn) : ℝ → ℝ :=
  fun t => 3 - D_s t

def SpectralDimFlow (D_s : SpectralDimFn) : Prop := Antitone D_s

/-- D_s antitone ⟺ λ monotone. [FORMAL_VERIFIED] -/
theorem spectral_flow_iff_folding_monotone (D_s : SpectralDimFn) :
    SpectralDimFlow D_s ↔ Monotone (foldingParameter D_s) := by
  unfold SpectralDimFlow foldingParameter Antitone Monotone
  constructor
  · intro h t₁ t₂ ht
    have hds := h ht
    dsimp only
    linarith
  · intro h t₁ t₂ ht
    have hfold := h ht
    dsimp only at hfold
    linarith

/-- If D_s is antitone, then λ is monotone. [FORMAL_VERIFIED] -/
theorem folding_monotone_of_spectral_flow
    (D_s : SpectralDimFn) (h : SpectralDimFlow D_s) :
    Monotone (foldingParameter D_s) :=
  (spectral_flow_iff_folding_monotone D_s).mp h
