/-
  HTSIE/Constraint.lean
  =====================
  Formal treatment of constraints and their ordering.

  Key question: c₁ ≤ c₂ ⟹ A(c₂) ⊆ A(c₁)?
  This is the FIRST link in the HTSIE chain.
  Lean forces us to identify when this fails.

  [FORMAL_VERIFIED] where no sorry appears.
-/

import Mathlib.Order.Basic
import Mathlib.Data.Set.Basic
import HTSIE.Basic

open Set

/-!
## Section 1: Constraint Preorder Properties
-/

/--
  A constraint system is a preorder (C, ≤) where
  c₁ ≤ c₂ means "c₂ is at least as strong as c₁".

  We use Mathlib's built-in Preorder typeclass.
-/

/--
  The trivial constraint system: only one constraint level.
  ConstraintMonotone holds trivially.
  [FORMAL_VERIFIED]
-/
example : ∃ (S C : Type*) (_ : Preorder C) (sys : HTSIESystem S C),
    ConstraintMonotone sys := by
  exact ⟨Unit, Unit, inferInstance,
    { accessibility := fun _ => Set.univ },
    fun _ _ _ => Set.subset_univ _⟩

/--
  ConstraintMonotone is preserved under composition:
  if sys₁ and sys₂ both satisfy ConstraintMonotone,
  and we take the intersection of their accessible sets,
  the result also satisfies ConstraintMonotone.
  [FORMAL_VERIFIED]
-/
theorem constraint_monotone_inter
    {S C : Type*} [Preorder C]
    (sys₁ sys₂ : HTSIESystem S C)
    (h₁ : ConstraintMonotone sys₁)
    (h₂ : ConstraintMonotone sys₂) :
    ConstraintMonotone { accessibility := fun c =>
      sys₁.accessibility c ∩ sys₂.accessibility c } := by
  intro c₁ c₂ hc
  intro x ⟨hx₁, hx₂⟩
  exact ⟨h₁ c₁ c₂ hc hx₁, h₂ c₁ c₂ hc hx₂⟩

/--
  ConstraintMonotone is preserved under union:
  if sys₁ and sys₂ both satisfy ConstraintMonotone,
  the union of their accessible sets also satisfies it.
  [FORMAL_VERIFIED]
-/
theorem constraint_monotone_union
    {S C : Type*} [Preorder C]
    (sys₁ sys₂ : HTSIESystem S C)
    (h₁ : ConstraintMonotone sys₁)
    (h₂ : ConstraintMonotone sys₂) :
    ConstraintMonotone { accessibility := fun c =>
      sys₁.accessibility c ∪ sys₂.accessibility c } := by
  intro c₁ c₂ hc
  intro x hx
  cases hx with
  | inl h => exact Or.inl (h₁ c₁ c₂ hc h)
  | inr h => exact Or.inr (h₂ c₁ c₂ hc h)

/-!
## Section 2: When Does ConstraintMonotone FAIL?

This is the most important section for HTSIE.
We identify conditions under which the core hypothesis fails.
-/

/--
  COUNTEREXAMPLE TEMPLATE: ConstraintMonotone can fail
  when the accessibility function is not "well-behaved".

  Example: C = ℕ with natural order, S = ℕ,
  A(n) = {n} (only state n is accessible under constraint n).
  Then A(2) = {2} ⊄ A(1) = {1}, so ConstraintMonotone FAILS.

  [FORMAL_VERIFIED]
-/
theorem constraint_monotone_can_fail :
    ∃ (sys : HTSIESystem ℕ ℕ), ¬ ConstraintMonotone sys := by
  use { accessibility := fun n => {n} }
  intro h
  -- h : ∀ c₁ c₂, c₁ ≤ c₂ → {c₂} ⊆ {c₁}
  have := h 1 2 (by norm_num)
  -- {2} ⊆ {1} is false
  have h2 : (2 : ℕ) ∈ ({2} : Set ℕ) := rfl
  have h1 := this h2
  simp at h1

/--
  ConstraintMonotone holds when A is a decreasing family
  (in the sense of set inclusion indexed by C).

  Sufficient condition: A is antitone as a function C → Set S.
  [FORMAL_VERIFIED]
-/
theorem constraint_monotone_of_antitone
    {S C : Type*} [Preorder C]
    (sys : HTSIESystem S C)
    (h : Antitone sys.accessibility) :
    ConstraintMonotone sys := h

/-!
## Section 3: Strict Constraint Monotonicity
-/

/--
  StrictConstraintMonotone implies ConstraintMonotone
  (under the assumption that the preorder is a partial order).
  [FORMAL_VERIFIED]
-/
theorem strict_implies_weak_constraint_monotone
    {S C : Type*} [PartialOrder C]
    (sys : HTSIESystem S C)
    (h : StrictConstraintMonotone sys) :
    ConstraintMonotone sys := by
  intro c₁ c₂ hc
  rcases eq_or_lt_of_le hc with rfl | hlt
  · exact subset_refl _
  · exact (h c₁ c₂ hlt).1

/-!
## Section 4: Constraint Composition

When multiple constraints are applied simultaneously,
how does the accessible state space change?
-/

/--
  If constraints c₁ and c₂ are applied simultaneously
  (modeled as their join in a lattice), the accessible set
  is the intersection of A(c₁) and A(c₂).

  This is a MODELING CHOICE, not a theorem.
  Different physical systems may model constraint composition differently.
-/
-- Note: This requires C to be a lattice (join/meet operations).
-- [FORMAL_OPEN] — depends on specific constraint algebra.

/--
  Key open question: Is the HTSIE constraint model
  compatible with a lattice structure on C?

  [FORMAL_OPEN]
-/
-- theorem constraint_lattice_compatibility : ... -- [FORMAL_OPEN]

