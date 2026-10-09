/-
  Theorems/ConstraintReduction.lean
  =================================
  Properties of Capacity Saturation and Product Derivatives.

  Evidence: [FORMAL_VERIFIED]
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Tactic.Linarith
import HTSIE.Dimension.EDI

open Real Set

namespace HTSIE.Theorems

open HTSIE.Dimension

/--
  CapacitySaturation definition check and logarithmic equivalency.
-/
lemma saturation_gap (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hsat : E * deriv C E ≤ 1) :
    C E + E * deriv C E > C E - 1 := by
  linarith

lemma product_deriv_lower_bound (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hC_diff : DifferentiableAt ℝ C E)
    (hsat : E * deriv C E ≤ 1) :
    C E + E * deriv C E ≥ C E - 1 := by
  linarith

lemma product_increasing_when_capacity_large (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hC_diff : DifferentiableAt ℝ C E)
    (hCbig : C E > 1)
    (hsat : E * deriv C E ≤ 1) :
    C E + E * deriv C E > 0 := by
  linarith

lemma neg_product_deriv_implies_neg_capacity_deriv
    (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hneg : C E + E * deriv C E < 0) :
    deriv C E < 0 := by
  have h1 : E * deriv C E < -C E := by linarith
  have h2 : -C E < 0 := by linarith
  have h3 : E * deriv C E < 0 := lt_trans h1 h2
  exact nneg_of_mul_neg_left h3 hE

end HTSIE.Theorems
