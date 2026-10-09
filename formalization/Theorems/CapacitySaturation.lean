/- Theorems/CapacitySaturation.lean -/
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

open Real

theorem capacity_saturation_bound
    (C : ℝ → ℝ) (E : ℝ) (_hE : E > 0)
    (hsat_E : E * deriv C E ≤ 1) :
    deriv C E * E ≤ 1 := by
  have h_comm : E * deriv C E = deriv C E * E := mul_comm E (deriv C E)
  rwa [← h_comm]
