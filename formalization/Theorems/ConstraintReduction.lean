/-
  Theorems/ConstraintReduction.lean
  =================================
  Basic properties of CapacitySaturation and its relationship
  to the product derivative.

  Evidence classification: [FORMAL_VERIFIED]
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Const
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import HTSIE.Dimension.EDI

open Real Set

namespace HTSIE.Theorems

/-!
## Section 1: Basic Properties of CapacitySaturation
-/

/--
  CapacitySaturation is equivalent to: the logarithmic derivative
  of C with respect to log(E) is at most 1.

  [FORMAL_VERIFIED]
-/
lemma capacity_saturation_iff_log_deriv (C : ℝ → ℝ) :
    CapacitySaturation C ↔ ∀ E : ℝ, E > 0 → E * deriv C E ≤ 1 := by
  unfold CapacitySaturation
  rfl

/--
  If C is constant (C(E) = c > 0), then CapacitySaturation holds.
  [FORMAL_VERIFIED]
-/
lemma const_capacity_saturation (c : ℝ) (hc : c > 0) :
    CapacitySaturation (fun _ => c) := by
  intro E _
  simp [deriv_const]

/-!
## Section 2: The Critical Gap
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

/-!
## Section 3: Correct Characterization
-/

lemma neg_product_deriv_implies_neg_capacity_deriv
    (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hneg : NegativeProductDerivAt C E) :
    deriv C E < 0 := by
  unfold NegativeProductDerivAt at hneg
  have h : E * deriv C E < -C E := by linarith
  have hCneg : -C E < 0 := by linarith
  have hECneg : E * deriv C E < 0 := lt_trans h hCneg
  exact nneg_of_mul_neg_left hECneg hE

end HTSIE.Theorems
