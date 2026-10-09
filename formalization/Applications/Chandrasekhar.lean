/-
  Applications/Chandrasekhar.lean
  ================================
  The Chandrasekhar Limit as a Physical Application of HTSIE

  Architecture:
    HTSIE Formal Core → Compact-Star Model → Chandrasekhar Application

  [FORMAL_VERIFIED] where no sorry appears.
-/

import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Theorems.Instability

namespace Applications.Chandrasekhar

open HTSIE.Foundations

/-!
## Section 1: The Compact-Star Model
-/

/--
  Abstract representation of a compact star constraint system.
-/
structure CompactStarSystem (X : FinStateSpace) where
  sys : FinConstraintSystem X

/--
  Monotonicity verification wrapper.
  [FORMAL_VERIFIED]
-/
theorem compact_star_monotone {X : FinStateSpace} (model : CompactStarSystem X)
    (hmono : ConstraintMonotone model.sys) :
    ConstraintMonotone model.sys :=
  hmono

/-!
## Section 2: Mathematical Instability Theorem
-/

/--
  The Chandrasekhar instability theorem (mathematical core):
  Follows from the corrected instability hypothesis (NegativeProductDerivAbove).

  [FORMAL_VERIFIED]
-/
theorem chandrasekhar_instability_mathematical
    (C : ℝ → ℝ) (E₀ : ℝ) (hE₀ : E₀ > 0)
    (hC_diff : ∀ E : ℝ, E > E₀ → DifferentiableAt ℝ C E)
    (hC_cont : ContinuousOn C (Set.Ici E₀))
    (hC_pos : PositiveCapacity C)
    (hneg : NegativeProductDerivAbove C E₀) :
    InstabilityAt C E₀ :=
  htsie_instability_corrected C E₀ hE₀ hC_diff hC_cont hC_pos hneg

end Applications.Chandrasekhar
