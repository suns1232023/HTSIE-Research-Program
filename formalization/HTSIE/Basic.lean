/-
  HTSIE/Basic.lean
  ================
  Core mathematical definitions for the HTSIE formalization layer.

  Evidence classification:
    [FORMAL_VERIFIED] — Lean compiles with no sorry
    [FORMAL_OPEN]     — Formalized but proof incomplete
    [CONJECTURE]      — Not yet established mathematically

  Purpose: Pressure-test HTSIE propositions, NOT confirm them.
  First objective: identify counterexamples and missing assumptions.
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Topology.Algebra.Order.LiminfLimsup
import Mathlib.Analysis.SpecialFunctions.Log.Basic

open Real Set Filter

/-!
## Section 1: Core Definitions

We formalize the abstract information-capacity model underlying HTSIE.
C : ℝ → ℝ represents an abstract information capacity function.
E represents an energy/constraint parameter (E > 0).
F(E) = E * C(E) is the "information-energy product".
-/

/-- A capacity function is positive on (0, ∞). -/
def PositiveCapacity (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → C E > 0

/--
  Capacity Saturation: the logarithmic derivative of C is at most 1.
  Equivalently: E * C'(E) ≤ 1 for all E > 0.
  This is the condition dC/d(log E) ≤ 1.

  NOTE: This does NOT imply d(E·C(E))/dE < 0.
  The product rule gives F'(E) = C(E) + E·C'(E),
  and C(E) > 0 prevents the conclusion F'(E) < 0
  from C'(E) ≤ 1/E alone.
-/
def CapacitySaturation (C : ℝ → ℝ) : Prop :=
  ∀ E : ℝ, E > 0 → E * deriv C E ≤ 1

/--
  Strict saturation at a point E₀:
  E₀ * C'(E₀) < 1 (strict inequality).
-/
def StrictSaturationAt (C : ℝ → ℝ) (E : ℝ) : Prop :=
  E > 0 ∧ E * deriv C E < 1

/--
  Instability at E₀: there exists E > E₀ such that
  the information-energy product E·C(E) is strictly smaller
  than E₀·C(E₀).

  This is the HTSIE "instability" condition.
-/
def InstabilityAt (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∃ E : ℝ, E > E₀ ∧ E * C E < E₀ * C E₀

/--
  The information-energy product function F(E) = E * C(E).
-/
noncomputable def infoEnergyProduct (C : ℝ → ℝ) : ℝ → ℝ :=
  fun E => E * C E

/--
  Negative product derivative condition:
  F'(E) = C(E) + E·C'(E) < 0.
  This is the CORRECT sufficient condition for instability,
  as opposed to the weaker C'(E) ≤ 1/E.
-/
def NegativeProductDerivAt (C : ℝ → ℝ) (E : ℝ) : Prop :=
  C E + E * deriv C E < 0

/--
  The negative product derivative condition holds on (E₀, ∞).
-/
def NegativeProductDerivAbove (C : ℝ → ℝ) (E₀ : ℝ) : Prop :=
  ∀ E : ℝ, E > E₀ → NegativeProductDerivAt C E

/-!
## Section 2: Basic Lemmas about the Product Function

[FORMAL_VERIFIED] — derivative identity for F(E) = E * C(E)
-/

/--
  The derivative of F(E) = E * C(E) satisfies
  F'(E) = C(E) + E * C'(E).

  This is the product rule. We state it as a lemma
  to make the structure explicit.
-/
lemma deriv_infoEnergyProduct (C : ℝ → ℝ) (E : ℝ)
    (hC : DifferentiableAt ℝ C E) :
    deriv (infoEnergyProduct C) E = C E + E * deriv C E := by
  unfold infoEnergyProduct
  have hid : DifferentiableAt ℝ id E := differentiableAt_id
  rw [deriv_mul hid hC]
  simp
  ring
