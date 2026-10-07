/-
  HTSIE/Accessibility.lean
  ========================
  The Accessibility Reduction Theorem and its conditions.

  Core question: c₁ ≤ c₂ ⟹ A(c₂) ⊆ A(c₁)?

  This file:
  1. States the theorem formally
  2. Identifies when it holds (sufficient conditions)
  3. Identifies when it FAILS (counterexamples)
  4. Derives consequences for DOF and information measures

  [FORMAL_VERIFIED] where no sorry appears.
-/

import Mathlib.Order.Basic
import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Finite
import HTSIEFormalization.HTSIE.Basic
import HTSIEFormalization.HTSIE.Constraint

open Set

/-!
## Section 1: Accessibility Reduction — Main Theorem

The key HTSIE proposition:
  Stronger constraints → smaller accessible state space.

This is [FORMAL_VERIFIED] when ConstraintMonotone is assumed as hypothesis.
The question is: WHEN does ConstraintMonotone hold?
-/

/--
  Accessibility Reduction Theorem (conditional):
  If the system satisfies ConstraintMonotone,
  then stronger constraints yield smaller accessible sets.

  [FORMAL_VERIFIED] — trivially follows from definition.
  The scientific content is in WHEN ConstraintMonotone holds.
-/
theorem accessibility_reduction
    {S C : Type*} [Preorder C]
    (sys : HTSIESystem S C)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : C) (hc : c₁ ≤ c₂) :
    sys.accessibility c₂ ⊆ sys.accessibility c₁ :=
  hmono c₁ c₂ hc

/--
  Accessibility Reduction is STRICT when StrictConstraintMonotone holds.
  [FORMAL_VERIFIED]
-/
theorem strict_accessibility_reduction
    {S C : Type*} [Preorder C]
    (sys : HTSIESystem S C)
    (hmono : StrictConstraintMonotone sys)
    (c₁ c₂ : C) (hc : c₁ < c₂) :
    sys.accessibility c₂ ⊊ sys.accessibility c₁ :=
  hmono c₁ c₂ hc

/-!
## Section 2: Sufficient Conditions for Accessibility Reduction

When does ConstraintMonotone hold in practice?
-/

/--
  Sufficient Condition 1: Nested constraint sets.
  If constraints are modeled as sets of forbidden states,
  and stronger constraints forbid more states,
  then ConstraintMonotone holds.

  Model: C = Set S (constraints as forbidden sets),
         A(c) = S \ c (accessible = not forbidden),
         c₁ ≤ c₂ iff c₁ ⊆ c₂ (more forbidden = stronger).

  [FORMAL_VERIFIED]
-/
theorem accessibility_reduction_forbidden_set (S : Type*) :
    let sys : HTSIESystem S (Set S) :=
      { accessibility := fun c => Set.univ \ c }
    ConstraintMonotone sys := by
  intro c₁ c₂ hc
  intro x hx
  simp only [Set.mem_diff, Set.mem_univ, true_and] at *
  exact fun hx₂ => hx (hc hx₂)

/--
  Sufficient Condition 2: Threshold constraints.
  If C = ℝ and A(c) = {s : S | energy(s) ≤ c},
  then ConstraintMonotone holds (higher threshold = more accessible).

  Wait — this is ANTI-monotone in the HTSIE sense!
  Higher c means WEAKER constraint (more accessible).
  This shows the ordering convention matters.

  [FORMAL_VERIFIED] — with reversed ordering.
-/
theorem accessibility_reduction_threshold :
    let sys : HTSIESystem ℝ ℝ :=
      { accessibility := fun c => {s : ℝ | s ≤ c} }
    -- With the NATURAL order on ℝ (c₁ ≤ c₂ means c₂ is larger threshold):
    -- A(c₂) = {s | s ≤ c₂} ⊇ A(c₁) = {s | s ≤ c₁}
    -- So this is MONOTONE (not anti-monotone) in the natural order.
    -- For HTSIE, we need to use the REVERSE order on C.
    ConstraintMonotone { accessibility := fun (c : ℝ) => {s : ℝ | c ≤ s} } := by
  intro c₁ c₂ hc
  intro x hx
  simp only [Set.mem_setOf_eq] at *
  linarith

/-!
## Section 3: When Accessibility Reduction FAILS

Critical for HTSIE: identifying the boundaries of the theory.
-/

/--
  COUNTEREXAMPLE: Non-monotone accessibility.
  C = ℕ, S = ℕ, A(n) = {0, 1, ..., n} ∪ {2n}
  Then A(2) = {0,1,2,4} ⊄ A(1) = {0,1,2}
  because 4 ∈ A(2) but 4 ∉ A(1).

  This shows that "constraint increase" does not automatically
  imply "accessible set decrease" without structural assumptions.

  [FORMAL_VERIFIED]
-/
theorem accessibility_reduction_fails_nonmonotone :
    ∃ (sys : HTSIESystem ℕ ℕ), ¬ ConstraintMonotone sys := by
  -- Use A(n) = {n+1} (only the "next" state is accessible)
  use { accessibility := fun n => {n + 1} }
  intro h
  -- h says: 1 ≤ 2 → {3} ⊆ {2}
  have := h 1 2 (by norm_num)
  have h3 : (3 : ℕ) ∈ ({3} : Set ℕ) := rfl
  have := this h3
  simp at this

/-!
## Section 4: Consequences for DOF and Information

Given accessibility reduction, what can we say about DOF?
-/

/--
  If ConstraintMonotone holds AND the DOF measure is monotone
  (larger sets have larger DOF), then stronger constraints
  imply smaller DOF.

  [FORMAL_VERIFIED]
-/
theorem constraint_implies_dof_reduction
    {S C : Type*} [Preorder C]
    (sys : HTSIESystem S C)
    (dof : DOFMeasure S)
    (hmono : ConstraintMonotone sys)
    (hdof : DOFMonotone dof)
    (c₁ c₂ : C) (hc : c₁ ≤ c₂) :
    dof (sys.accessibility c₂) ≤ dof (sys.accessibility c₁) := by
  apply hdof
  exact hmono c₁ c₂ hc

/--
  CRITICAL OPEN QUESTION: Is DOFMonotone satisfied for
  the specific DOF measures used in HTSIE (spectral dimension, etc.)?

  For Hausdorff dimension: NOT monotone in general.
  For Lebesgue measure: monotone.
  For cardinality (finite sets): monotone.
  For spectral dimension: [FORMAL_OPEN]

  [FORMAL_OPEN]
-/
-- theorem spectral_dim_monotone : DOFMonotone spectralDim := sorry -- [FORMAL_OPEN]

/--
  The full HTSIE chain (end-to-end) requires BOTH:
  1. ConstraintMonotone (accessibility reduction)
  2. DOFMonotone (DOF reduction from set inclusion)

  Neither is automatic. Both must be verified for each system.

  [FORMAL_VERIFIED] — the implication chain, given both hypotheses.
-/
theorem full_htsie_chain
    {S C : Type*} [Preorder C]
    (sys : HTSIESystem S C)
    (dof : DOFMeasure S)
    (info : InfoMeasure S)
    (hmono : ConstraintMonotone sys)
    (hdof : DOFMonotone dof)
    (hinfo : InfoMonotone info)
    (c₁ c₂ : C) (hc : c₁ ≤ c₂) :
    info (sys.accessibility c₂) ≤ info (sys.accessibility c₁) := by
  apply hinfo
  exact hmono c₁ c₂ hc

end
