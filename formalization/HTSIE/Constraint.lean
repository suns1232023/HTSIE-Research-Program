/- HTSIE/Constraint.lean -/
import Mathlib.Order.Basic
import Mathlib.Data.Set.Basic
import HTSIE.Basic

open Set

def ConstraintSet (α : Type*) := Set α

def StrictConstraintMonotone (C : ℝ → ℝ) : Prop :=
  ∀ x y, x < y → C x < C y

/-- Non-empty constraint property. -/
theorem constraint_nonempty_of_exists {α : Type*} (s : ConstraintSet α) (h : ∃ x, x ∈ s) : s.Nonempty :=
  h
