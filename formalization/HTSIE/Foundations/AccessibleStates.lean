/-
  HTSIE/Foundations/AccessibleStates.lean
  ========================================
  Definition and properties of accessible state spaces.

  Based on: formalization/README.md, Section 7
  Priority: P0
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints

namespace HTSIE.Foundations

open HTSIE.Foundations

/--
  Accessible state space given a constraint parameter `c`.
-/
def accessibleStateSet {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : Finset ℕ :=
  sys.accessibility c

/--
  The number of accessible states under constraint `c`.
-/
def accessibleCard {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) : ℕ :=
  (accessibleStateSet sys c).card

/--
  Monotonicity of accessible state count under ConstraintMonotone.
-/
theorem accessibleCard_monotone {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys) (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    accessibleCard sys c₂ ≤ accessibleCard sys c₁ :=
  constraint_monotone_card_le sys hmono c₁ c₂ hc

end HTSIE.Foundations
