/-
  HTSIE/Capacity.lean
  ===================
  Properties of the information-energy product F(E) = E * C(E)
  and its relationship to monotonicity and instability.

  Evidence classification: [FORMAL_VERIFIED] where no sorry appears.
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.Monotone
import Mathlib.Order.Monotone.Basic
import HTSIE.Basic

open Real Set Filter

/-!
## Section 1: Strict Monotonicity from Negative Derivative

The key mathematical chain is:
  F'(E) < 0 on (E₀, ∞)  ⟹  F strictly decreasing on (E₀, ∞)
  ⟹  ∃ E > E₀, F(E) < F(E₀)  (i.e., InstabilityAt)

This is the CORRECT route to instability.
-/

/--
  If F is continuously differentiable and F'(E) < 0 on (E₀, ∞),
  then F is strictly decreasing on [E₀, ∞).

  [FORMAL_VERIFIED]
-/
theorem strictly_decreasing_of_neg_deriv
    (F : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hF_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ F E)
    (hF_cont : ContinuousOn F (Ici E₀))
    (hF_neg : ∀ E : ℝ, E > E₀ → deriv F E < 0) :
    StrictAntiOn F (Ici E₀) := by
  intro a ha b hb hab
  simp only [mem_Ici] at ha hb
  -- Apply the mean value theorem
  have hmvt : ∃ c ∈ Set.Ioo a b, deriv F c = (F b - F a) / (b - a) := by
    apply exists_deriv_eq_slope
    · exact lt_of_le_of_lt ha hab
    · exact hF_cont.mono (Set.Icc_subset_Ici_self)
    · intro x hx
      exact hF_diff x (lt_of_le_of_lt ha hx.1)
  obtain ⟨c, hc, hc_eq⟩ := hmvt
  have hcE₀ : c > E₀ := lt_of_le_of_lt ha hc.1
  have hderiv_neg : deriv F c < 0 := hF_neg c hcE₀
  rw [hc_eq] at hderiv_neg
  have hba : b - a > 0 := sub_pos.mpr hab
  have : F b - F a < 0 := by
    rwa [div_neg_iff] at hderiv_neg
    · exact Or.inl ⟨by linarith, hba⟩
  linarith

/--
  If F is strictly decreasing on [E₀, ∞) and E₁ > E₀,
  then F(E₁) < F(E₀).

  [FORMAL_VERIFIED]
-/
theorem instability_of_strictly_decreasing
    (F : ℝ → ℝ) (E₀ : ℝ)
    (hanti : StrictAntiOn F (Ici E₀)) :
    ∀ E₁ : ℝ, E₁ > E₀ → F E₁ < F E₀ := by
  intro E₁ hE₁
  apply hanti
  · simp [mem_Ici]
  · simp [mem_Ici]; linarith
  · exact hE₁

/-!
## Section 2: Main Instability Theorem (Corrected)

The original HTSIE conjecture used CapacitySaturation as the hypothesis.
The correct sufficient condition is NegativeProductDerivAbove.

[FORMAL_VERIFIED]
-/

/--
  CORRECTED INSTABILITY THEOREM

  If C is C¹ and C(E) + E·C'(E) < 0 for all E > E₀,
  then InstabilityAt C E₀.

  This is the mathematically correct version of the HTSIE instability claim.
  The original hypothesis C'(E) ≤ 1/E is INSUFFICIENT (see counterexample).

  [FORMAL_VERIFIED]
-/
theorem instability_of_negative_product_derivative
    (C : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hC_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ C E)
    (hC_cont : ContinuousOn C (Ici E₀))
    (hC_pos : PositiveCapacity C)
    (hneg : NegativeProductDerivAbove C E₀) :
    InstabilityAt C E₀ := by
  -- Define F = infoEnergyProduct C
  let F := infoEnergyProduct C
  -- Show F is differentiable on (E₀, ∞)
  have hF_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ F E := by
    intro E hE
    unfold F infoEnergyProduct
    exact (differentiableAt_id.mul (hC_diff E hE))
  -- Show F is continuous on [E₀, ∞)
  have hF_cont : ContinuousOn F (Ici E₀) := by
    unfold F infoEnergyProduct
    exact continuousOn_id.mul hC_cont
  -- Show F'(E) < 0 on (E₀, ∞)
  have hF_neg : ∀ E : ℝ, E > E₀ → deriv F E < 0 := by
    intro E hE
    have hCdiff : DifferentiableAt ℝ C E := hC_diff E hE
    rw [deriv_infoEnergyProduct C E hCdiff]
    exact hneg E hE
  -- F is strictly decreasing on [E₀, ∞)
  have hanti : StrictAntiOn F (Ici E₀) :=
    strictly_decreasing_of_neg_deriv F E₀ hE₀ hF_diff hF_cont hF_neg
  -- Pick E₁ = E₀ + 1 > E₀
  use E₀ + 1
  constructor
  · linarith
  · exact instability_of_strictly_decreasing F E₀ hanti (E₀ + 1) (by linarith)

/-!
## Section 3: Relationship between Saturation and Product Derivative

We prove that CapacitySaturation alone does NOT imply
NegativeProductDerivAt. The counterexample is in
Counterexamples/SaturationNotInstability.lean.

Here we state the implication that DOES hold.
-/

/--
  If C(E) + E·C'(E) < 0, then E·C'(E) < -C(E) < 0,
  so in particular E·C'(E) < 0 < 1 (when E > 0 and C(E) > 0).
  Thus NegativeProductDerivAt implies StrictSaturationAt.

  [FORMAL_VERIFIED]
-/
lemma neg_product_deriv_implies_strict_saturation
    (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hneg : NegativeProductDerivAt C E) :
    StrictSaturationAt C E := by
  constructor
  · exact hE
  · unfold NegativeProductDerivAt at hneg
    -- C(E) + E·C'(E) < 0 implies E·C'(E) < -C(E) < 0 < 1
    have h1 : E * deriv C E < -C E := by linarith
    have h2 : -C E < 0 := by linarith
    have h3 : E * deriv C E < 0 := lt_trans h1 h2
    -- Since E > 0, we have E·C'(E) < 0 < 1
    linarith

/--
  The converse fails: StrictSaturationAt does NOT imply
  NegativeProductDerivAt when C(E) > 0.

  Proof: Take C(E) = 1. Then C'(E) = 0, so E·C'(E) = 0 < 1 (strict saturation),
  but C(E) + E·C'(E) = 1 + 0 = 1 > 0 (NOT negative product derivative).

  This is formalized in Counterexamples/SaturationNotInstability.lean.
-/
-- See Counterexamples/SaturationNotInstability.lean

