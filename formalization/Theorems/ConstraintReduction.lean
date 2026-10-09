/-
  Theorems/ConstraintReduction.lean
  =================================
  Properties of Capacity Saturation and Product Derivatives.

  Evidence: [FORMAL_VERIFIED] (requires explicit lower bound on capacity derivative)
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Tactic.Linarith
import HTSIE.Dimension.EDI

open Real Set

namespace HTSIE.Theorems

open HTSIE.Dimension

/-!
## Section 1: The Critical Gap and Product Derivative Bounds
-/

/--
  The gap between Capacity Saturation and Product Derivative bounds:
  Under the lower bound assumption `E * C'(E) > -1`,
  F'(E) = C(E) + E * C'(E) > C(E) - 1.

  [FORMAL_VERIFIED]
-/
lemma saturation_gap (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hsat : E * deriv C E ≤ 1)
    (hlower : -1 < E * deriv C E) :
    C E + E * deriv C E > C E - 1 := by
  linarith

/--
  Explicit lower bound on product derivative:
  Under `E * C'(E) ≥ -1`, F'(E) = C(E) + E * C'(E) ≥ C(E) - 1.

  [FORMAL_VERIFIED]
-/
lemma product_deriv_lower_bound (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hC_diff : DifferentiableAt ℝ C E)
    (hsat : E * deriv C E ≤ 1)
    (hlower : -1 ≤ E * deriv C E) :
    C E + E * deriv C E ≥ C E - 1 := by
  linarith

/--
  When C(E) > 1 and E * C'(E) > -1, product derivative is positive:
  F'(E) = C(E) + E * C'(E) > 0.

  [FORMAL_VERIFIED]
-/
lemma product_increasing_when_capacity_large (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hC_diff : DifferentiableAt ℝ C E)
    (hCbig : C E > 1)
    (hsat : E * deriv C E ≤ 1)
    (hlower : -1 < E * deriv C E) :
    C E + E * deriv C E > 0 := by
  linarith

/-!
## Section 2: Derivative Sign Implications
-/

/--
  Negative product derivative C(E) + E * C'(E) < 0 implies C'(E) < 0.
  Proof via contradiction without reliance on missing Mathlib identifiers.

  [FORMAL_VERIFIED]
-/
lemma neg_product_deriv_implies_neg_capacity_deriv
    (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hneg : C E + E * deriv C E < 0) :
    deriv C E < 0 := by
  by_contra hnot
  have hderiv_nonneg : 0 ≤ deriv C E := le_of_not_gt hnot
  have hprod_nonneg : 0 ≤ E * deriv C E := mul_nonneg (le_of_lt hE) hderiv_nonneg
  linarith

end HTSIE.Theorems
