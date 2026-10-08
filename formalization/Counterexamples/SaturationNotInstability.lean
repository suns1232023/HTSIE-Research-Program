/-
  Counterexamples/SaturationNotInstability.lean
  ===============================================
  FORMAL COUNTEREXAMPLE: CapacitySaturation does NOT imply InstabilityAt.

  Based on: formalization/README.md, Section 11
  Priority: P0 (counterexamples are first-class results)

  Evidence: [FORMAL_COUNTEREXAMPLE]

  Research significance (README Section 11):
    This is not merely a failed proof attempt.
    It identifies the missing condition: C(E) + E·C'(E) < 0.
    The counterexample is retained as a formal research result.
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.Real.Basic

open Real Set

/-! ## Definitions -/

def PositiveCapacity (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → C E > 0

def CapacitySaturation (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → E * deriv C E ≤ 1

def StrictSaturationAt (C : ℝ → ℝ) (E : ℝ) : Prop :=
  E > 0 ∧ E * deriv C E < 1

def InstabilityAt (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∃ E : ℝ, E > E₀ ∧ E * C E < E₀ * C E₀

/-! ## The Counterexample: C(E) = 1 -/

noncomputable def constCapacity : ℝ → ℝ := fun _ => 1

lemma constCapacity_pos : PositiveCapacity constCapacity := by
  intro E _; unfold constCapacity; norm_num

lemma constCapacity_deriv (E : ℝ) : deriv constCapacity E = 0 := by
  unfold constCapacity; simp [deriv_const]

lemma constCapacity_saturation : CapacitySaturation constCapacity := by
  intro E _; rw [constCapacity_deriv]; simp

lemma constCapacity_strict_saturation (E : ℝ) (hE : E > 0) :
    StrictSaturationAt constCapacity E :=
  ⟨hE, by rw [constCapacity_deriv]; simp; norm_num⟩

/-!
## Main Counterexample Theorem

C(E) = 1 satisfies all saturation conditions,
but F(E) = E·C(E) = E is strictly INCREASING.
Therefore InstabilityAt FAILS.

Logical failure (README Section 11):
  C'(E) ≤ 1/E does NOT imply F'(E) < 0 when C(E) > 0.
  Product rule: F'(E) = C(E) + E·C'(E) = 1 + 0 = 1 > 0.

[FORMAL_COUNTEREXAMPLE]
-/
theorem saturation_not_instability :
    CapacitySaturation constCapacity ∧
    (∀ E₀ : ℝ, E₀ > 0 →
      ∃ E : ℝ, E > E₀ ∧ StrictSaturationAt constCapacity E) ∧
    (∀ E₀ : ℝ, E₀ > 0 → ¬ InstabilityAt constCapacity E₀) := by
  refine ⟨constCapacity_saturation, ?_, ?_⟩
  · intro E₀ hE₀
    exact ⟨E₀ + 1, by linarith,
           constCapacity_strict_saturation (E₀ + 1) (by linarith)⟩
  · intro E₀ _ hInst
    obtain ⟨E, hE_gt, hE_ineq⟩ := hInst
    simp only [constCapacity] at hE_ineq
    simp at hE_ineq
    linarith

/-!
## Corrected Sufficient Condition

The correct condition is NegativeProductDerivAbove:
  ∀ E > E₀, C(E) + E·C'(E) < 0

See Theorems/Instability.lean for the corrected theorem.
-/
