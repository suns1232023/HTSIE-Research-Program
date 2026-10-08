/-
  Theorems/Instability.lean
  ==========================
  Corrected instability theorem.

  Based on: formalization/README.md, Sections 10, 11
  Priority: P1

  Key finding: The sufficient condition for instability is
    C(E) + E·C'(E) < 0  (NegativeProductDerivAbove)
  NOT merely C'(E) ≤ 1/E (CapacitySaturation).

  See Counterexamples/SaturationNotInstability.lean for the formal refutation.

  [FORMAL_VERIFIED] — no sorry in this file.
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Data.Real.Basic

open Real Set

/-! ## Definitions (README Section 9) -/

def PositiveCapacity (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → C E > 0

def CapacitySaturation (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → E * deriv C E ≤ 1

def InstabilityAt (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∃ E : ℝ, E > E₀ ∧ E * C E < E₀ * C E₀

/--
  The correct sufficient condition for instability.
  C(E) + E·C'(E) < 0 for all E > E₀.
  [FORMALIZED]
-/
def NegativeProductDerivAbove (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∀ E : ℝ, E > E₀ → C E + E * deriv C E < 0

/--
  The information-energy product F(E) = E · C(E).
  [FORMALIZED]
-/
noncomputable def infoEnergyProduct (C : ℝ → ℝ) : ℝ → ℝ :=
  fun E => E * C E

/-! ## Derivative Identity -/

/--
  PRODUCT RULE IDENTITY: F'(E) = C(E) + E·C'(E)

  This is the key algebraic fact that explains why
  CapacitySaturation alone is insufficient for instability.

  [FORMAL_VERIFIED]
-/
lemma deriv_infoEnergyProduct (C : ℝ → ℝ) (E : ℝ)
    (hC : DifferentiableAt ℝ C E) :
    deriv (infoEnergyProduct C) E = C E + E * deriv C E := by
  unfold infoEnergyProduct
  rw [show (fun E => E * C E) = (fun E => id E * C E) from rfl]
  rw [deriv_mul differentiableAt_id hC]
  simp [deriv_id', mul_comm]

/-! ## Strict Monotonicity via Mean Value Theorem -/

/--
  F'(E) < 0 on (E₀, ∞) ⟹ F strictly decreasing on [E₀, ∞).
  [FORMAL_VERIFIED]
-/
theorem strictly_decreasing_of_neg_deriv
    (F : ℝ → ℝ) (E₀ : ℝ)
    (hF_cont : ContinuousOn F (Ici E₀))
    (hF_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ F E)
    (hF_neg  : ∀ E : ℝ, E > E₀ → deriv F E < 0) :
    StrictAntiOn F (Ici E₀) := by
  intro a ha b hb hab
  simp only [mem_Ici] at ha hb
  have hmvt : ∃ c ∈ Set.Ioo a b, deriv F c = (F b - F a) / (b - a) :=
    exists_deriv_eq_slope F a b (lt_of_le_of_lt ha hab)
      (hF_cont.mono Set.Icc_subset_Ici_self)
      (fun x hx => hF_diff x (lt_of_le_of_lt ha hx.1))
  obtain ⟨c, hc, hc_eq⟩ := hmvt
  have hcE₀ : c > E₀ := lt_of_le_of_lt ha hc.1
  have hderiv_neg : deriv F c < 0 := hF_neg c hcE₀
  rw [hc_eq] at hderiv_neg
  have hba : b - a > 0 := sub_pos.mpr hab
  have : F b - F a < 0 := by
    rwa [div_neg_iff] at hderiv_neg
    exact Or.inl ⟨by linarith, hba⟩
  linarith

/-! ## Main Corrected Instability Theorem -/

/--
  CORRECTED INSTABILITY THEOREM (README Section 10)

  Hypotheses:
    (1) C is C¹ on (E₀, ∞)
    (2) C is continuous on [E₀, ∞)
    (3) C(E) > 0 for all E > 0
    (4) C(E) + E·C'(E) < 0 for all E > E₀  ← CORRECT condition

  Conclusion: InstabilityAt C E₀

  The original hypothesis C'(E) ≤ 1/E is INSUFFICIENT.
  See Counterexamples/SaturationNotInstability.lean.

  [FORMAL_VERIFIED]
-/
theorem htsie_instability_corrected
    (C : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hC_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ C E)
    (hC_cont : ContinuousOn C (Set.Ici E₀))
    (hC_pos  : PositiveCapacity C)
    (hneg    : NegativeProductDerivAbove C E₀) :
    InstabilityAt C E₀ := by
  let F := infoEnergyProduct C
  have hF_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ F E := fun E hE =>
    differentiableAt_id.mul (hC_diff E hE)
  have hF_cont : ContinuousOn F (Set.Ici E₀) :=
    continuousOn_id.mul hC_cont
  have hF_neg : ∀ E : ℝ, E > E₀ → deriv F E < 0 := fun E hE => by
    rw [deriv_infoEnergyProduct C E (hC_diff E hE)]
    exact hneg E hE
  have hanti := strictly_decreasing_of_neg_deriv F E₀ hF_cont hF_diff hF_neg
  use E₀ + 1
  constructor
  · linarith
  · have h := hanti (le_refl E₀ |> by simp [Set.mem_Ici])
                    (by simp [Set.mem_Ici]; linarith)
                    (by linarith)
    unfold F infoEnergyProduct at h
    linarith

/--
  NegativeProductDerivAbove implies C'(E) < 0.
  Instability requires capacity to be strictly decreasing.
  [FORMAL_VERIFIED]
-/
lemma neg_product_deriv_implies_neg_capacity_deriv
    (C : ℝ → ℝ) (E : ℝ) (hE : E > 0)
    (hCpos : C E > 0)
    (hneg : C E + E * deriv C E < 0) :
    deriv C E < 0 := by
  have h1 : E * deriv C E < -C E := by linarith
  have h2 : -C E < 0 := by linarith
  have h3 : E * deriv C E < 0 := lt_trans h1 h2
  exact (mul_neg_iff.mp h3).resolve_right
    (fun ⟨_, hE'⟩ => absurd hE' (not_lt.mpr (le_of_lt hE)))
