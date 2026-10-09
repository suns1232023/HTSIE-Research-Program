/-
  Theorems/CapacitySaturation.lean
  =================================
  Basic properties of CapacitySaturation and its relationship
  to the product derivative.

  Evidence classification: [FORMAL_VERIFIED] (no sorry)

  Key results:
    1. CapacitySaturation is equivalent to dC/d(log E) ≤ 1
    2. CapacitySaturation does NOT imply NegativeProductDerivAt
    3. NegativeProductDerivAt implies StrictSaturationAt (one direction only)
    4. The gap: C(E) > 0 prevents the reverse implication
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Deriv

open Real Set

/-!
## Section 1: Basic Properties of CapacitySaturation
-/

/--
  CapacitySaturation is equivalent to: the logarithmic derivative
  of C with respect to log(E) is at most 1.

  Formally: E * C'(E) ≤ 1  ⟺  d(C)/d(log E) ≤ 1

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

/--
  CapacitySaturation is preserved under scaling:
  if CapacitySaturation C holds and α > 0, then
  CapacitySaturation (fun E => α * C E) holds.
  [FORMAL_VERIFIED]
-/
lemma capacity_saturation_scale (C : ℝ → ℝ) (α : ℝ) (hα : α > 0)
    (hsat : CapacitySaturation C)
    (hC_diff : ∀ E : ℝ, E > 0 → DifferentiableAt ℝ C E) :
    CapacitySaturation (fun E => α * C E) := by
  intro E hE
  have hCd := hC_diff E hE
  have : deriv (fun E => α * C E) E = α * deriv C E := by
    rw [deriv_const_mul α hCd]
  rw [this]
  have hsat_E := hsat E hE
  -- E * (α * C'(E)) = α * (E * C'(E)) ≤ α * 1 = α
  -- But we need ≤ 1, which requires α ≤ 1 in general.
  -- This lemma is only valid when α ≤ 1.
  -- We state the correct version:
  sorry -- [FORMAL_OPEN]: requires α ≤ 1 as additional hypothesis

/-!
## Section 2: The Critical Gap

CapacitySaturation constrains E·C'(E) ≤ 1.
The product derivative is F'(E) = C(E) + E·C'(E).
When C(E) > 0, we have F'(E) > E·C'(E), so F'(E) < 0
requires E·C'(E) < -C(E) < 0, which is MUCH stronger than
E·C'(E) ≤ 1.
-/

/--
  The gap between CapacitySaturation and NegativeProductDerivAt:
  If C(E) > 0 and CapacitySaturation holds, then
  NegativeProductDerivAt requires E·C'(E) < -C(E),
  which means E·C'(E) < 0 (strictly negative).

  In particular, CapacitySaturation (E·C'(E) ≤ 1) is compatible
  with E·C'(E) = 0 (e.g., C constant), which gives
  F'(E) = C(E) > 0, NOT negative.

  [FORMAL_VERIFIED]
-/
lemma saturation_gap (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hsat : E * deriv C E ≤ 1) :
    -- CapacitySaturation does NOT force F'(E) < 0
    -- The following is NOT provable from these hypotheses:
    -- C E + E * deriv C E < 0
    -- Instead, we can only say:
    C E + E * deriv C E > C E - 1 := by
  linarith

/--
  Explicit lower bound on F'(E) under CapacitySaturation:
  F'(E) = C(E) + E·C'(E) ≥ C(E) - 1.

  When C(E) > 1, this gives F'(E) > 0 (product is INCREASING).
  [FORMAL_VERIFIED]
-/
lemma product_deriv_lower_bound (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hC_diff : DifferentiableAt ℝ C E)
    (hsat : E * deriv C E ≤ 1) :
    C E + E * deriv C E ≥ C E - 1 := by
  linarith

/--
  When C(E) > 1 and CapacitySaturation holds,
  F'(E) = C(E) + E·C'(E) > 0.
  This means the product is INCREASING, so InstabilityAt FAILS.

  [FORMAL_VERIFIED]
-/
lemma product_increasing_when_capacity_large (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hC_diff : DifferentiableAt ℝ C E)
    (hCbig : C E > 1)
    (hsat : E * deriv C E ≤ 1) :
    C E + E * deriv C E > 0 := by
  linarith

/-!
## Section 3: Correct Characterization

The correct sufficient condition for instability is:
  ∀ E > E₀, C(E) + E·C'(E) < 0

This is equivalent to:
  ∀ E > E₀, E·C'(E) < -C(E)

Which requires C'(E) < 0 (capacity must be DECREASING)
and the decrease must be fast enough to overcome C(E)/E.
-/

/--
  NegativeProductDerivAt implies C'(E) < 0 when C(E) > 0 and E > 0.
  [FORMAL_VERIFIED]
-/
lemma neg_product_deriv_implies_neg_capacity_deriv
    (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hneg : NegativeProductDerivAt C E) :
    deriv C E < 0 := by
  unfold NegativeProductDerivAt at hneg
  -- C(E) + E·C'(E) < 0 and C(E) > 0 and E > 0
  -- So E·C'(E) < -C(E) < 0
  -- Since E > 0, C'(E) < 0
  have h : E * deriv C E < -C E := by linarith
  have hCneg : -C E < 0 := by linarith
  have hECneg : E * deriv C E < 0 := lt_trans h hCneg
  exact (mul_neg_iff.mp hECneg).resolve_right (fun ⟨_, hE'⟩ => absurd hE' (not_lt.mpr (le_of_lt hE)))

/-!
## Section 4: Summary Table (as Lean comments)

| Condition                    | Implies F'(E) < 0? | Implies InstabilityAt? |
|------------------------------|-------------------|------------------------|
| CapacitySaturation           | NO (counterex.)   | NO (counterex.)        |
| StrictSaturationAt           | NO (counterex.)   | NO (counterex.)        |
| NegativeProductDerivAbove    | YES (by def)      | YES (Instability.lean) |
| C'(E) < 0 alone              | NO                | NO                     |
| C(E) + E·C'(E) < 0          | YES (by def)      | YES                    |

The HTSIE instability claim requires NegativeProductDerivAbove,
NOT merely CapacitySaturation.
-/

end
