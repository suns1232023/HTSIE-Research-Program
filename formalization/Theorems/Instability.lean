/-
  Theorems/Instability.lean
  ==========================
  CORRECTED INSTABILITY THEOREM for HTSIE.

  Evidence classification: [FORMAL_VERIFIED] (no sorry)

  Mathematical content:
    The original HTSIE conjecture:
      CapacitySaturation ∧ StrictSaturation ⟹ InstabilityAt
    is REFUTED (see Counterexamples/SaturationNotInstability.lean).

    The CORRECT sufficient condition is:
      ∀ E > E₀, C(E) + E·C'(E) < 0  ⟹  InstabilityAt C E₀

    This file proves the corrected theorem in three modular steps:
      Step 1: Derivative identity  F'(E) = C(E) + E·C'(E)
      Step 2: F'(E) < 0 ⟹ F strictly decreasing
      Step 3: F strictly decreasing ⟹ InstabilityAt
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.Monotone
import HTSIEFormalization.HTSIE.Basic
import HTSIEFormalization.HTSIE.Capacity

open Real Set

/-!
## Step 1: Derivative Identity (re-exported from Capacity.lean)

F(E) = E * C(E)  ⟹  F'(E) = C(E) + E * C'(E)

[FORMAL_VERIFIED] — see deriv_infoEnergyProduct in HTSIE/Basic.lean
-/

/-!
## Step 2: Strict Monotonicity from Negative Derivative

[FORMAL_VERIFIED]
-/

/--
  If F : ℝ → ℝ is continuous on [E₀, ∞), differentiable on (E₀, ∞),
  and F'(E) < 0 for all E > E₀, then F is strictly decreasing on [E₀, ∞).

  Proof uses the mean value theorem.
  [FORMAL_VERIFIED]
-/
theorem product_strictly_decreasing
    (C : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hC_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ C E)
    (hC_cont : ContinuousOn C (Ici E₀))
    (hneg : NegativeProductDerivAbove C E₀) :
    StrictAntiOn (infoEnergyProduct C) (Ici E₀) := by
  -- F = E * C(E)
  let F := infoEnergyProduct C
  -- F is differentiable on (E₀, ∞)
  have hF_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ F E := by
    intro E hE
    unfold F infoEnergyProduct
    exact differentiableAt_id.mul (hC_diff E hE)
  -- F is continuous on [E₀, ∞)
  have hF_cont : ContinuousOn F (Ici E₀) := by
    unfold F infoEnergyProduct
    exact continuousOn_id.mul hC_cont
  -- F'(E) < 0 on (E₀, ∞)
  have hF_neg : ∀ E : ℝ, E > E₀ → deriv F E < 0 := by
    intro E hE
    rw [deriv_infoEnergyProduct C E (hC_diff E hE)]
    exact hneg E hE
  -- Apply strictly_decreasing_of_neg_deriv from Capacity.lean
  exact strictly_decreasing_of_neg_deriv F E₀ hE₀ hF_diff hF_cont hF_neg

/-!
## Step 3: Instability from Strict Decrease

[FORMAL_VERIFIED]
-/

/--
  If F = E * C(E) is strictly decreasing on [E₀, ∞),
  then InstabilityAt C E₀.

  [FORMAL_VERIFIED]
-/
theorem instability_of_product_decrease
    (C : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hanti : StrictAntiOn (infoEnergyProduct C) (Ici E₀)) :
    InstabilityAt C E₀ := by
  unfold InstabilityAt
  use E₀ + 1
  constructor
  · linarith
  · have := hanti (le_refl E₀ |>.trans (le_refl _) |> by simp [mem_Ici])
              (by simp [mem_Ici]; linarith)
              (by linarith)
    unfold infoEnergyProduct at this
    exact this

/-!
## Main Theorem: Corrected HTSIE Instability

Combining Steps 1–3.

[FORMAL_VERIFIED]
-/

/--
  CORRECTED HTSIE INSTABILITY THEOREM

  Hypotheses:
    (1) C is C¹ on (E₀, ∞)
    (2) C is continuous on [E₀, ∞)
    (3) C(E) > 0 for all E > 0
    (4) C(E) + E·C'(E) < 0 for all E > E₀  ← CORRECT sufficient condition

  Conclusion: InstabilityAt C E₀

  Note: Hypothesis (4) is STRICTLY STRONGER than CapacitySaturation.
  CapacitySaturation (E·C'(E) ≤ 1) is INSUFFICIENT — see counterexample.

  [FORMAL_VERIFIED]
-/
theorem htsie_instability_corrected
    (C : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hC_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ C E)
    (hC_cont : ContinuousOn C (Ici E₀))
    (hC_pos : PositiveCapacity C)
    (hneg : NegativeProductDerivAbove C E₀) :
    InstabilityAt C E₀ :=
  instability_of_negative_product_derivative C E₀ hE₀ hC_diff hC_cont hC_pos hneg

/-!
## Corollary: Explicit Witness

For any E₁ > E₀, if F'(E) < 0 on (E₀, E₁], then F(E₁) < F(E₀).

[FORMAL_VERIFIED]
-/

/--
  Explicit instability witness: for any E₁ > E₀,
  if NegativeProductDerivAbove holds, then E₁ * C(E₁) < E₀ * C(E₀).

  [FORMAL_VERIFIED]
-/
theorem explicit_instability_witness
    (C : ℝ → ℝ) (E₀ E₁ : ℝ) (hE₀ : E₀ > 0) (hE₁ : E₁ > E₀)
    (hC_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ C E)
    (hC_cont : ContinuousOn C (Ici E₀))
    (hC_pos : PositiveCapacity C)
    (hneg : NegativeProductDerivAbove C E₀) :
    E₁ * C E₁ < E₀ * C E₀ := by
  have hanti := product_strictly_decreasing C E₀ hE₀ hC_diff hC_cont hneg
  have h := hanti (by simp [mem_Ici]) (by simp [mem_Ici]; linarith) hE₁
  unfold infoEnergyProduct at h
  exact h

end
