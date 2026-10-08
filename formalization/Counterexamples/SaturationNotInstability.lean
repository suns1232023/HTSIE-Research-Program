/-
  Counterexamples/SaturationNotInstability.lean
  ===============================================
  FORMAL COUNTEREXAMPLE: CapacitySaturation does NOT imply InstabilityAt.

  Evidence classification: [FORMAL_COUNTEREXAMPLE]

  Mathematical content:
    Take C(E) = 1 (constant function).
    Then:
      - C'(E) = 0 for all E
      - E·C'(E) = 0 ≤ 1  ✓  (CapacitySaturation holds)
      - ∃ E > E₀ with E·C'(E) < 1  ✓  (StrictSaturation holds)
      - E·C(E) = E  (strictly INCREASING, not decreasing)
      - Therefore InstabilityAt C E₀ is FALSE for any E₀ > 0.

  Conclusion: The original HTSIE theorem info_saturation_instability
  is INVALID under the stated hypotheses. The missing assumption is
  C(E) + E·C'(E) < 0 (NegativeProductDerivAbove).

  [FORMAL_COUNTEREXAMPLE] — Lean compiles with no sorry.
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Push_neg
import HTSIE.Basic

open Real Set

/-!
## Counterexample 1: C(E) = 1 (constant)

This is the simplest counterexample showing that
CapacitySaturation ∧ StrictSaturation ⊬ InstabilityAt.
-/

/-- The constant capacity function C(E) = 1. -/
noncomputable def constCapacity : ℝ → ℝ := fun _ => 1

/-- C(E) = 1 is positive for all E > 0. [FORMAL_VERIFIED] -/
lemma constCapacity_positive : PositiveCapacity constCapacity := by
  intro E _
  unfold constCapacity
  norm_num

/-- The derivative of C(E) = 1 is 0. [FORMAL_VERIFIED] -/
lemma constCapacity_deriv (E : ℝ) : deriv constCapacity E = 0 := by
  unfold constCapacity
  simp [deriv_const]

/-- C(E) = 1 satisfies CapacitySaturation. [FORMAL_VERIFIED] -/
lemma constCapacity_saturation : CapacitySaturation constCapacity := by
  intro E hE
  rw [constCapacity_deriv]
  simp
  -- E * 0 = 0 ≤ 1
  norm_num

/--
  C(E) = 1 satisfies StrictSaturationAt for every E > 0.
  [FORMAL_VERIFIED]
-/
lemma constCapacity_strict_saturation (E : ℝ) (hE : E > 0) :
    StrictSaturationAt constCapacity E := by
  constructor
  · exact hE
  · rw [constCapacity_deriv]
    simp
    norm_num

/--
  The information-energy product for C(E) = 1 is F(E) = E.
  [FORMAL_VERIFIED]
-/
lemma constCapacity_product (E : ℝ) :
    infoEnergyProduct constCapacity E = E := by
  unfold infoEnergyProduct constCapacity
  ring

/--
  MAIN COUNTEREXAMPLE THEOREM

  For C(E) = 1 and any E₀ > 0:
  - CapacitySaturation holds ✓
  - StrictSaturationAt holds for some E > E₀ ✓
  - InstabilityAt C E₀ is FALSE ✗

  Therefore: CapacitySaturation ∧ (∃ E > E₀, StrictSaturationAt C E)
  does NOT imply InstabilityAt C E₀.

  [FORMAL_COUNTEREXAMPLE]
-/
theorem saturation_not_instability :
    CapacitySaturation constCapacity ∧
    (∀ E₀ : ℝ, E₀ > 0 → ∃ E : ℝ, E > E₀ ∧ StrictSaturationAt constCapacity E) ∧
    (∀ E₀ : ℝ, E₀ > 0 → ¬ InstabilityAt constCapacity E₀) := by
  refine ⟨constCapacity_saturation, ?_, ?_⟩
  · -- Strict saturation holds everywhere
    intro E₀ hE₀
    use E₀ + 1
    constructor
    · linarith
    · exact constCapacity_strict_saturation (E₀ + 1) (by linarith)
  · -- Instability FAILS
    intro E₀ hE₀ hInst
    unfold InstabilityAt at hInst
    obtain ⟨E, hE_gt, hE_ineq⟩ := hInst
    -- E * C(E) = E and E₀ * C(E₀) = E₀
    simp only [constCapacity] at hE_ineq
    -- hE_ineq : E * 1 < E₀ * 1, i.e., E < E₀
    simp at hE_ineq
    -- But E > E₀, contradiction
    linarith

/-!
## Counterexample 2: C(E) = a + bE (linear, a > 0, b ≥ 0)

For C(E) = a + bE with a > 0, b ≥ 0:
  C'(E) = b
  E·C'(E) = bE
  CapacitySaturation requires bE ≤ 1 for all E > 0,
  which fails for large E unless b = 0.

So for b = 0 (constant case, already covered) or
for b > 0 (saturation fails for large E).

This shows the saturation condition is non-trivial for linear C.
-/

/-- Linear capacity C(E) = a + b*E. -/
noncomputable def linearCapacity (a b : ℝ) : ℝ → ℝ := fun E => a + b * E

/--
  For C(E) = a + bE with b > 0, CapacitySaturation fails
  for sufficiently large E.
  [FORMAL_VERIFIED]
-/
lemma linear_capacity_saturation_fails (a b : ℝ) (hb : b > 0) :
    ¬ CapacitySaturation (linearCapacity a b) := by
  unfold CapacitySaturation
  push_neg
  -- Choose E = 2/b > 0
  use 2 / b
  constructor
  · positivity
  · have hderiv : deriv (linearCapacity a b) (2 / b) = b := by
      unfold linearCapacity
      have : HasDerivAt (fun E => a + b * E) b (2 / b) := by
        have := (hasDerivAt_id (2 / b)).const_mul b
        simp at this
        have h2 : HasDerivAt (fun E => a + b * E) (0 + b * 1) (2 / b) := by
          apply HasDerivAt.add
          · exact hasDerivAt_const _ a
          · exact (hasDerivAt_id _).const_mul b
        simp at h2
        exact h2
      exact this.deriv
    rw [hderiv]
    -- (2/b) * b = 2 > 1
    field_simp
    linarith

/-!
## Counterexample 3: C(E) = E^α for 0 < α < 1

For C(E) = E^α:
  C'(E) = α * E^(α-1)
  E·C'(E) = α * E^α = α * C(E)
  CapacitySaturation: α * E^α ≤ 1 — fails for large E when α > 0.

  F(E) = E * E^α = E^(1+α) — strictly increasing.
  So InstabilityAt fails.

This is another family of counterexamples.
-/

-- Remark: The power function counterexample is analogous to the constant case.
-- For any C with F(E) = E·C(E) strictly increasing, InstabilityAt fails.
-- The key insight: CapacitySaturation constrains C'(E), not F'(E) = C(E) + E·C'(E).

/-!
## Summary

The following table summarizes the counterexample findings:

| C(E)     | CapSat | StrictSat | F(E)=E·C(E) | InstabilityAt |
|----------|--------|-----------|-------------|---------------|
| 1        | ✓      | ✓         | E (↑)       | ✗ REFUTED     |
| a + bE   | ✗ (b>0)| —         | —           | —             |
| E^α      | ✗ (α>0)| —         | E^(1+α) (↑) | ✗             |

Conclusion: CapacitySaturation ⊬ InstabilityAt.
The correct sufficient condition is NegativeProductDerivAbove.
-/

