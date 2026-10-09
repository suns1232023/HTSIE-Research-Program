/-
  Applications/Chandrasekhar.lean
  ================================
  The Chandrasekhar Limit as a Physical Application of HTSIE

  Architecture (from memo):
    HTSIE Formal Core → Compact-Star Model → Chandrasekhar Application

  NOT: Chandrasekhar → HTSIE (this direction is physically unmotivated)

  This file:
  1. Models the compact-star system as an HTSIE instance
  2. Identifies which HTSIE hypotheses hold in this model
  3. Derives the Chandrasekhar limit as a consequence
  4. Clearly separates mathematical results from physical interpretations

  Key finding: The capacity instability theorem (from Instability.lean)
  applies here, but requires the CORRECTED hypothesis (NegativeProductDerivAbove),
  NOT merely CapacitySaturation.

  [FORMAL_VERIFIED] where no sorry appears.
  [PHYSICAL_OPEN] for physical interpretations.
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import HTSIE.Constraint
import Theorems.Instability

open Real Set

/-!
## Section 1: The Compact-Star HTSIE Model

Physical setup:
  - State space S = ℝ (energy states of degenerate electrons)
  - Constraint C = ℝ (total mass/energy of the star)
  - A(E) = {ε : ℝ | ε ≤ E} (states accessible at energy E)
  - C(E) = information capacity at energy E

  The Chandrasekhar limit corresponds to the energy E_Ch where
  the information-energy product E * C(E) reaches its maximum
  and begins to decrease — i.e., InstabilityAt C E_Ch.
-/

/--
  The compact-star HTSIE system:
  - State space: ℝ (energy values)
  - Constraint: ℝ with natural order
  - Accessibility: threshold model A(E) = (-∞, E]
-/
noncomputable def compactStarSystem : HTSIESystem ℝ ℝ where
  accessibility := fun E => {ε : ℝ | ε ≤ E}

/--
  The compact-star system satisfies ConstraintMonotone
  (with the REVERSED order: higher E = weaker constraint = more accessible).

  NOTE: For HTSIE, we need "stronger constraint → smaller accessible set".
  In the compact-star model, HIGHER energy threshold means MORE accessible states.
  So we use the REVERSE order on C = ℝ.

  [FORMAL_VERIFIED]
-/
theorem compact_star_constraint_monotone :
    ConstraintMonotone compactStarSystem := by
  intro c₁ c₂ hc
  intro x hx
  simp only [compactStarSystem, Set.mem_setOf_eq] at *
  linarith

/-!
## Section 2: Information Capacity in the Compact-Star Model

The information capacity C(E) represents the number of distinguishable
quantum states accessible at energy E.

Physical model: C(E) ∝ E^(3/2) / (1 + (E/E_rel)^(1/2))
where E_rel is the relativistic energy scale.

For the mathematical analysis, we work with an abstract C satisfying
the corrected instability hypothesis.
-/

/--
  The Chandrasekhar instability theorem (as an HTSIE application):

  If the information capacity C satisfies:
  - C is C¹ above E₀
  - C(E) > 0 for all E > 0
  - C(E) + E·C'(E) < 0 for all E > E₀ (CORRECTED condition)

  Then there exists E > E₀ where E·C(E) < E₀·C(E₀).
  This is the mathematical analog of the Chandrasekhar instability.

  [FORMAL_VERIFIED] — follows from htsie_instability_corrected.
-/
theorem chandrasekhar_instability_mathematical
    (C : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hC_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ C E)
    (hC_cont : ContinuousOn C (Set.Ici E₀))
    (hC_pos : PositiveCapacity C)
    (hneg : NegativeProductDerivAbove C E₀) :
    InstabilityAt C E₀ :=
  htsie_instability_corrected C E₀ hE₀ hC_diff hC_cont hC_pos hneg

/--
  The CORRECTED sufficient condition for Chandrasekhar instability:
  C(E) + E·C'(E) < 0

  This is STRICTLY STRONGER than the original (incorrect) condition:
  C'(E) ≤ 1/E (CapacitySaturation)

  [FORMAL_VERIFIED] — see Counterexamples/SaturationNotInstability.lean
  for the proof that CapacitySaturation alone is insufficient.
-/

/-!
## Section 3: Physical Interpretation (NOT formalized)

The following are PHYSICAL INTERPRETATIONS, not mathematical theorems.
They are documented here for completeness but remain [PHYSICAL_OPEN].

1. "The Chandrasekhar limit is the energy E_Ch where
   NegativeProductDerivAbove first holds."
   [PHYSICAL_OPEN] — requires connecting C(E) to actual quantum statistics.

2. "Degeneracy pressure is an information gradient."
   [PHYSICAL_OPEN] — requires defining "information gradient" precisely.

3. "Three-dimensional phase-space capacity is the physical origin
   of the Chandrasekhar limit."
   [PHYSICAL_OPEN] — requires connecting phase-space volume to C(E).

4. "The Chandrasekhar limit is fundamentally information-capacity saturation."
   [PHYSICAL_OPEN] — CapacitySaturation alone is INSUFFICIENT (see counterexample).
   The correct statement would be: "The Chandrasekhar limit corresponds to
   NegativeProductDerivAbove first holding."
-/

/-!
## Section 4: What This Application Establishes

| Claim | Mathematical Status | Lean Status |
|-------|---------------------|-------------|
| Compact-star system satisfies ConstraintMonotone | Theorem | [FORMAL_VERIFIED] |
| NegativeProductDerivAbove ⟹ InstabilityAt | Theorem | [FORMAL_VERIFIED] |
| CapacitySaturation ⟹ InstabilityAt | REFUTED | [FORMAL_COUNTEREXAMPLE] |
| C(E) = specific physical capacity function | [PHYSICAL_OPEN] | [FORMAL_OPEN] |
| Chandrasekhar limit = E_Ch where instability begins | [PHYSICAL_OPEN] | [FORMAL_OPEN] |
| HTSIE explains Chandrasekhar limit | [CONJECTURE] | [CONJECTURE] |
-/

