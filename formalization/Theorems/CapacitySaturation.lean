/-  Theorems/CapacitySaturation.lean  [FORMAL_OPEN] — 1 sorry with documented reason-/
import Mathlib.Analysis.Calculus.Deriv.Basic
import HTSIE.Basic
import HTSIE.Capacity

open Real Set

lemma capacity_saturation_iff (C : ℝ → ℝ) :
    CapacitySaturation C ↔ ∀ E : ℝ, E > 0 → E * deriv C E ≤ 1 := Iff.rfl

lemma const_capacity_saturation (c : ℝ) (hc : c > 0) :
    CapacitySaturation (fun _ => c) := by
  intro E _
  simp [deriv_const]

lemma neg_product_deriv_implies_strict_saturation
    (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hneg : C E + E * deriv C E < 0) :
    E * deriv C E < 1 := by
  have h1 : E * deriv C E < -C E := by linarith
  have h2 : -C E < 0 := by linarith
  linarith

lemma capacity_saturation_scale (C : ℝ → ℝ) (α : ℝ) (hα : α > 0) (hα1 : α ≤ 1)
    (hsat : CapacitySaturation C)
    (hC_diff : ∀ E : ℝ, E > 0 → DifferentiableAt ℝ C E) :
    CapacitySaturation (fun E => α * C E) := by
  intro E hE
  have hCd := hC_diff E hE
  have : deriv (fun E => α * C E) E = α * deriv C E := by
    rw [deriv_const_mul α hCd]
  rw [this]
  have hsat_E := hsat E hE
  nlinarith [mul_pos hα (mul_comm E (deriv C E) ▸ hsat_E)]
