/-
  HTSIE/SpectralFlow/SpectralDimension.lean
  [FORMAL_VERIFIED]
-/
 
import Mathlib.Order.Monotone.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
 
def SpectralDimFn := ℝ → ℝ
 
noncomputable def foldingParameter (D_s : SpectralDimFn) : ℝ → ℝ :=
  fun t => 3 - D_s t
 
def SpectralDimFlow (D_s : SpectralDimFn) : Prop := Antitone D_s
 
/-- D_s antitone iff lambda monotone. [FORMAL_VERIFIED] -/
theorem spectral_flow_iff_folding_monotone (D_s : SpectralDimFn) :
    SpectralDimFlow D_s ↔ Monotone (foldingParameter D_s) := by
  unfold SpectralDimFlow foldingParameter Antitone Monotone
  constructor
  · intro h t₁ t₂ ht
    have hds := h ht
    dsimp only
    linarith
  · intro h t₁ t₂ ht
    have hfold := h t₁ t₂ ht
    dsimp only at hfold
    linarith
 
theorem folding_monotone_of_spectral_flow
    (D_s : SpectralDimFn) (h : SpectralDimFlow D_s) :
    Monotone (foldingParameter D_s) :=
  (spectral_flow_iff_folding_monotone D_s).mp h
 
