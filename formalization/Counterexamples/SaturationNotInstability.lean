/- Counterexamples/SaturationNotInstability.lean -/
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Data.Real.Basic

open Real

theorem saturation_does_not_imply_instability :
    ∃ (C : ℝ → ℝ) (E : ℝ), E > 0 ∧ E * deriv C E ≤ 1 ∧ ¬ (C E + E * deriv C E < 0) := by
  use (fun _ => 1), 1
  refine ⟨by norm_num, ?_, ?_⟩
  · have h : deriv (fun _ : ℝ => (1 : ℝ)) 1 = 0 := deriv_const 1 1
    rw [h]
    norm_num
  · have h : deriv (fun _ : ℝ => (1 : ℝ)) 1 = 0 := deriv_const 1 1
    rw [h]
    intro hneg
    linarith
