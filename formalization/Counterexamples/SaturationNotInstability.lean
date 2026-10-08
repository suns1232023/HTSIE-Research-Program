/-  Counterexamples/SaturationNotInstability.lean  [FORMAL_COUNTEREXAMPLE]-/
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.Real.Basic

open Real

def PositiveCapacity (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → C E > 0

def CapacitySaturation (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → E * deriv C E ≤ 1

def StrictSaturationAt (C : ℝ → ℝ) (E : ℝ) : Prop :=
  E > 0 ∧ E * deriv C E < 1

def InstabilityAt (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∃ E : ℝ, E > E₀ ∧ E * C E < E₀ * C E₀

noncomputable def constCapacity : ℝ → ℝ := fun _ => 1

lemma constCapacity_deriv (E : ℝ) : deriv constCapacity E = 0 := by
  have : constCapacity = fun _ => (1 : ℝ) := rfl
  simp only [this, deriv_const]

lemma constCapacity_saturation : CapacitySaturation constCapacity := by
  intro E _
  rw [constCapacity_deriv]
  simp

lemma constCapacity_strict_saturation (E : ℝ) (hE : E > 0) :
    StrictSaturationAt constCapacity E := by
  refine ⟨hE, ?_⟩
  rw [constCapacity_deriv]
  norm_num

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
    linarith
