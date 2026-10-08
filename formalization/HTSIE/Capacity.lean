/- HTSIE/Capacity.lean -/
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.Real.Basic
import HTSIE.Basic

open Real

def StrictSaturationAt (C : ℝ → ℝ) (E : ℝ) : Prop :=
  E * deriv C E = 1

def CapacitySaturation (C : ℝ → ℝ) (E : ℝ) : Prop :=
  E * deriv C E ≤ 1

theorem saturation_bound_holds (C : ℝ → ℝ) (E : ℝ) (h : StrictSaturationAt C E) : CapacitySaturation C E := by
  unfold CapacitySaturation StrictSaturationAt at *
  exact le_of_eq h
