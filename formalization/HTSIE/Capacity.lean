/-  HTSIE/Capacity.lean  [FORMAL_VERIFIED]-/
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import HTSIE.Basic

open Real Set

def PositiveCapacity (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → C E > 0

def CapacitySaturation (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → E * deriv C E ≤ 1

def InstabilityAt (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∃ E : ℝ, E > E₀ ∧ E * C E < E₀ * C E₀

def NegativeProductDerivAbove (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∀ E : ℝ, E > E₀ → C E + E * deriv C E < 0

theorem strictly_decreasing_of_neg_deriv
    (F : ℝ → ℝ) (E₀ : ℝ)
    (hF_cont : ContinuousOn F (Ici E₀))
    (hF_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ F E)
    (hF_neg  : ∀ E : ℝ, E > E₀ → deriv F E < 0) :
    StrictAntiOn F (Ici E₀) := by
  intro a ha b hb hab
  simp only [mem_Ici] at ha hb
  have hmvt : ∃ c ∈ Set.Ioo a b, deriv F c = (F b - F a) / (b - a) := by
    apply exists_deriv_eq_slope
    · exact hab
    · apply hF_cont.mono
      intro x hx
      simp only [mem_Ici]
      exact le_trans ha hx.1
    · intro x hx
      exact (hF_diff x (lt_of_le_of_lt ha hx.1)).differentiableWithinAt
  obtain ⟨c, hc, hc_eq⟩ := hmvt
  have hcE₀ : c > E₀ := lt_of_le_of_lt ha hc.1
  have hderiv_neg : deriv F c < 0 := hF_neg c hcE₀
  rw [hc_eq] at hderiv_neg
  have hba : b - a > 0 := sub_pos.mpr hab
  have hfba : F b - F a < 0 := by
    have hmul := mul_neg_of_neg_of_pos hderiv_neg hba
    rwa [div_mul_cancel₀ _ (ne_of_gt hba)] at hmul
  linarith
