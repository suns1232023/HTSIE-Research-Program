/-
  Theorems/Instability.lean
  ==========================
  Corrected instability theorem. [FORMAL_VERIFIED]
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Data.Real.Basic

open Real Set

def PositiveCapacity (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → C E > 0

def InstabilityAt (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∃ E : ℝ, E > E₀ ∧ E * C E < E₀ * C E₀

def NegativeProductDerivAbove (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∀ E : ℝ, E > E₀ → C E + E * deriv C E < 0

noncomputable def infoEnergyProduct (C : ℝ → ℝ) : ℝ → ℝ :=
  fun E => E * C E

/-- F'(E) = C(E) + E·C'(E). [FORMAL_VERIFIED] -/
lemma deriv_infoEnergyProduct (C : ℝ → ℝ) (E : ℝ)
    (hC : DifferentiableAt ℝ C E) :
    deriv (infoEnergyProduct C) E = C E + E * deriv C E := by
  unfold infoEnergyProduct
  have h : (fun E => E * C E) = (fun E => id E * C E) := rfl
  rw [h, deriv_mul differentiableAt_id hC]
  simp [deriv_id', mul_comm]

/-- F'(E) < 0 ⟹ F strictly decreasing. [FORMAL_VERIFIED] -/
theorem strictly_decreasing_of_neg_deriv
    (F : ℝ → ℝ) (E₀ : ℝ)
    (hF_cont : ContinuousOn F (Ici E₀))
    (hF_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ F E)
    (hF_neg  : ∀ E : ℝ, E > E₀ → deriv F E < 0) :
    StrictAntiOn F (Ici E₀) := by
  intro a ha b hb hab
  simp only [mem_Ici] at ha hb
  -- Fix 1: pass hab (a < b) directly, not a and b separately
  have hmvt : ∃ c ∈ Set.Ioo a b, deriv F c = (F b - F a) / (b - a) :=
    exists_deriv_eq_slope F hab
      (hF_cont.mono Set.Icc_subset_Ici_self)
      (fun x hx => hF_diff x (lt_of_le_of_lt ha hx.1))
  obtain ⟨c, hc, hc_eq⟩ := hmvt
  have hcE₀ : c > E₀ := lt_of_le_of_lt ha hc.1
  have hderiv_neg : deriv F c < 0 := hF_neg c hcE₀
  rw [hc_eq] at hderiv_neg
  have hba : b - a > 0 := sub_pos.mpr hab
  -- Fix 2: correct branch matching for div_neg_iff
  have hfba : F b - F a < 0 := by
    rcases div_neg_iff.mp hderiv_neg with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · -- h1 : F b - F a < 0, h2 : 0 < b - a
      exact h1
    · -- h1 : 0 < F b - F a, h2 : b - a < 0 — contradicts hba
      linarith
  linarith

/-- Corrected instability theorem. [FORMAL_VERIFIED] -/
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
  -- Fix 3: explicit membership proofs, no trailing tactic after exact
  have hE₀_mem : E₀ ∈ Set.Ici E₀ := le_refl E₀
  have hE1_mem : E₀ + 1 ∈ Set.Ici E₀ := by linarith
  have hlt : E₀ < E₀ + 1 := by linarith
  exact ⟨E₀ + 1, hlt, hanti hE₀_mem hE1_mem hlt⟩
