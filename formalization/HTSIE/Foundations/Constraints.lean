/-
  HTSIE/Foundations/Constraints.lean
  ====================================
  Definition of structural constraints and their ordering.

  Based on: formalization/README.md, Sections 7, 12
  Priority: P0

  Key result: ConstraintMonotone can FAIL (Section 12).
  This is a [FORMAL_VERIFIED] result, not just a warning.
-/

import Mathlib.Order.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Tactic.SplitIfs
import Mathlib.Tactic.NormNum
import HTSIE.Foundations.StateSpace

namespace HTSIE.Foundations

/-!
## Structural Constraints

A constraint C on a state space X restricts which states are accessible.
Constraints are ordered: c₁ ≤ c₂ means c₂ is "stronger" (more restrictive).
-/

/--
  FinConstraintSystem: a constraint system over a finite state space.
  - constraints: the constraint type (here ℕ for simplicity)
  - accessibility: maps each constraint to its accessible states
  [FORMALIZED]
-/
structure FinConstraintSystem (X : FinStateSpace) where
  accessibility : ℕ → Finset ℕ
  accessible_subset : ∀ c, accessibility c ⊆ X.states

/--
  ConstraintMonotone: stronger constraints yield smaller accessible sets.
  c₁ ≤ c₂ ⟹ accessibility(c₂) ⊆ accessibility(c₁)

  NOTE: This is an ASSUMPTION, not automatic.
  See constraint_monotone_can_fail below.
  [FORMALIZED]
-/
def ConstraintMonotone {X : FinStateSpace} (sys : FinConstraintSystem X) : Prop :=
  ∀ c₁ c₂ : ℕ, c₁ ≤ c₂ → sys.accessibility c₂ ⊆ sys.accessibility c₁

/--
  FORMAL COUNTEREXAMPLE: ConstraintMonotone can fail.

  Example: accessibility(n) = {n+1}
  Then accessibility(2) = {3} ⊄ accessibility(1) = {2}.

  This demonstrates that nested accessible-state spaces cannot
  simply be assumed from the existence of a constraint parameter.

  Based on: formalization/README.md, Section 12.
  [FORMAL_VERIFIED]
-/
theorem constraint_monotone_can_fail :
    ∃ (X : FinStateSpace) (sys : FinConstraintSystem X),
    ¬ ConstraintMonotone sys := by
  have h_nonempty : ({1, 2, 3, 4, 5} : Finset ℕ).Nonempty := ⟨1, by decide⟩
  let X : FinStateSpace := ⟨{1, 2, 3, 4, 5}, h_nonempty⟩
  let sys : FinConstraintSystem X := {
    accessibility := fun n => if n + 1 ∈ ({1, 2, 3, 4, 5} : Finset ℕ) then {n + 1} else ∅
    accessible_subset := by
      intro c
      dsimp
      split_ifs with h
      · exact Finset.singleton_subset_iff.mpr h
      · exact Finset.empty_subset _
  }
  refine ⟨X, sys, ?_⟩
  intro h
  have h12 : (1 : ℕ) ≤ 2 := by norm_num
  have hsub := h 1 2 h12
  dsimp [sys] at hsub
  have h3_in : (3 : ℕ) ∈ ({3} : Finset ℕ) := Finset.mem_singleton_self 3
  have h3_in_2 : (3 : ℕ) ∈ ({2} : Finset ℕ) := hsub h3_in
  revert h3_in_2
  decide

/--
  When ConstraintMonotone holds, stronger constraints
  give strictly fewer or equal accessible states.
  [FORMAL_VERIFIED]
-/
theorem constraint_monotone_card_le
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    (sys.accessibility c₂).card ≤ (sys.accessibility c₁).card :=
  Finset.card_le_card (hmono c₁ c₂ hc)

end HTSIE.Foundations
