/-
  HTSIE/Foundations/StateSpace.lean
  ==================================
  Definition of finite structural state spaces.

  Based on: formalization/README.md, Section 7 (Layer 0)
  Priority: P0 — Mathematical Foundation

  Evidence: [FORMALIZED]
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.Set.Basic

/-!
## Finite Structural State Space

A structural state space is a finite type S representing
all possible states of a system.
-/

/--
  FinStateSpace: a finite structural state space.
  Wraps a Finset of states.
  [FORMALIZED]
-/
structure FinStateSpace where
  states : Finset ℕ
  nonempty : states.Nonempty

/--
  The total number of states.
  [FORMALIZED]
-/
def FinStateSpace.card (X : FinStateSpace) : ℕ := X.states.card

/--
  A state is accessible if it belongs to the state space.
  [FORMALIZED]
-/
def FinStateSpace.contains (X : FinStateSpace) (s : ℕ) : Prop :=
  s ∈ X.states

/--
  The total state count is positive (state space is nonempty).
  [FORMAL_VERIFIED]
-/
theorem FinStateSpace.card_pos (X : FinStateSpace) : X.card > 0 :=
  Finset.Nonempty.card_pos X.nonempty
