/-
  HTSIE/Foundations/AccessibleStates.lean
  =========================================
  Accessible state space and its properties.

  Based on: formalization/README.md, Sections 7, 8.2
  Priority: P0

  Key theorem: accessibility_reduction (Section 8.2)
  [FORMAL_VERIFIED]
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints

/-!
## Accessible State Space

The accessible state space A(c) is the set of states
satisfying constraint c.

Key theorem (README Section 8.2):
  ConstraintMonotone ∧ c₁ ≤ c₂ ⟹ A(c₂) ⊆ A(c₁)
-/

/--
  The accessible state space under constraint c.
  [FORMALIZED]
-/
def accessibleStates (sys : FinConstraintSystem X) (c : ℕ) : Finset ℕ :=
  sys.accessibility c

/--
  ACCESSIBILITY REDUCTION THEOREM

  ConstraintMonotone ∧ c₁ ≤ c₂ ⟹ A(c₂) ⊆ A(c₁)

  This is the foundational result because subsequent measure
  inequalities depend on this accessibility-space relation.

  Based on: formalization/README.md, Section 8.2.
  [FORMAL_VERIFIED]
-/
theorem accessibility_reduction
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    accessibleStates sys c₂ ⊆ accessibleStates sys c₁ :=
  hmono c₁ c₂ hc

/--
  Accessibility reduction implies cardinality reduction.
  [FORMAL_VERIFIED]
-/
theorem accessibility_card_reduction
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    (accessibleStates sys c₂).card ≤ (accessibleStates sys c₁).card :=
  Finset.card_le_card (accessibility_reduction sys hmono c₁ c₂ hc)

/--
  The accessible state space is always a subset of the full state space.
  [FORMAL_VERIFIED]
-/
theorem accessible_subset_total
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    accessibleStates sys c ⊆ X.states :=
  sys.accessible_subset c

/--
  The accessible state count never exceeds the total state count.
  [FORMAL_VERIFIED]
-/
theorem accessible_card_le_total
    {X : FinStateSpace} (sys : FinConstraintSystem X) (c : ℕ) :
    (accessibleStates sys c).card ≤ X.card :=
  Finset.card_le_card (accessible_subset_total sys c)
