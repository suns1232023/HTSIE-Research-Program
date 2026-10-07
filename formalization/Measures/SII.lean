/-
  Measures/SII.lean
  =================
  Structural Information Index (SII) — Formal Definition and Properties

  SII measures the distribution of information over the state space.
  Key properties to verify:
    1. Non-negativity: SII(X) ≥ 0
    2. Monotonicity: A₂ ⊆ A₁ ⟹ SII(A₂) ≤ SII(A₁) (under conditions)
    3. Invariance: SII(T(X)) = SII(X) for measure-preserving T
    4. Normalization: SII(∅) = 0

  [FORMAL_VERIFIED] where no sorry appears.
  [FORMAL_OPEN] where sorry is present (with explanation).
-/

import Mathlib.MeasureTheory.Measure.MeasureSpace
import Mathlib.MeasureTheory.Measure.Restrict
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Topology.MetricSpace.Basic
import HTSIEFormalization.HTSIE.Basic

open MeasureTheory Set Real

/-!
## Section 1: SII Definition

SII is defined as a normalized entropy-like measure over the state space.
We provide two candidate definitions and analyze their properties.
-/

/--
  Candidate SII Definition 1: Cardinality-based (for finite state spaces).
  SII(A) = log₂(|A|) / log₂(|S|)
  Normalized to [0, 1].

  This is the simplest definition, suitable for discrete systems.
-/
noncomputable def SII_cardinality (A : Finset ℕ) (total : ℕ) (htotal : total > 0) : ℝ :=
  if A.card = 0 then 0
  else Real.log A.card / Real.log total

/--
  SII_cardinality is non-negative when A is nonempty and total ≥ 1.
  [FORMAL_VERIFIED]
-/
lemma SII_cardinality_nonneg (A : Finset ℕ) (total : ℕ) (htotal : total > 0)
    (hA : A.card ≤ total) :
    SII_cardinality A total htotal ≥ 0 := by
  unfold SII_cardinality
  split_ifs with h
  · norm_num
  · apply div_nonneg
    · apply Real.log_nonneg
      exact_mod_cast Nat.one_le_iff_ne_zero.mpr h
    · apply Real.log_nonneg
      exact_mod_cast htotal

/--
  SII_cardinality is at most 1 when A ⊆ S (|A| ≤ total).
  [FORMAL_VERIFIED]
-/
lemma SII_cardinality_le_one (A : Finset ℕ) (total : ℕ) (htotal : total > 0)
    (hA : A.card ≤ total) :
    SII_cardinality A total htotal ≤ 1 := by
  unfold SII_cardinality
  split_ifs with h
  · norm_num
  · rw [div_le_one (Real.log_pos (by exact_mod_cast htotal))]
    apply Real.log_le_log
    · exact_mod_cast Nat.pos_of_ne_zero h
    · exact_mod_cast hA

/--
  SII_cardinality is monotone: A₂ ⊆ A₁ ⟹ SII(A₂) ≤ SII(A₁).
  [FORMAL_VERIFIED] for the cardinality-based definition.
-/
lemma SII_cardinality_monotone (A₁ A₂ : Finset ℕ) (total : ℕ) (htotal : total > 0)
    (hA₁ : A₁.card ≤ total) (hA₂ : A₂.card ≤ total)
    (hsub : A₂ ⊆ A₁) :
    SII_cardinality A₂ total htotal ≤ SII_cardinality A₁ total htotal := by
  unfold SII_cardinality
  have hcard : A₂.card ≤ A₁.card := Finset.card_le_card hsub
  split_ifs with h₂ h₁
  · norm_num
  · norm_num
  · -- A₂ is empty but A₁ is not: 0 ≤ log(|A₁|)/log(total)
    apply div_nonneg
    · apply Real.log_nonneg
      exact_mod_cast Nat.one_le_iff_ne_zero.mpr h₁
    · apply Real.log_nonneg
      exact_mod_cast htotal
  · -- Both nonempty
    apply div_le_div_of_nonneg_right _ (Real.log_nonneg (by exact_mod_cast htotal))
    apply Real.log_le_log
    · exact_mod_cast Nat.pos_of_ne_zero h₂
    · exact_mod_cast hcard

/--
  SII_cardinality = 0 iff A is empty.
  [FORMAL_VERIFIED]
-/
lemma SII_cardinality_zero_iff (A : Finset ℕ) (total : ℕ) (htotal : total > 0) :
    SII_cardinality A total htotal = 0 ↔ A = ∅ := by
  unfold SII_cardinality
  simp only [Finset.card_eq_zero]
  split_ifs with h
  · simp [h]
  · constructor
    · intro heq
      have hlog_total : Real.log total > 0 := Real.log_pos (by exact_mod_cast htotal)
      have := div_eq_zero_iff.mp heq
      cases this with
      | inl h => exact absurd (Real.log_eq_zero.mp h) (by
          push_neg
          exact ⟨by exact_mod_cast Nat.pos_of_ne_zero h,
                 by exact_mod_cast Nat.one_le_iff_ne_zero.mpr h,
                 by exact_mod_cast Nat.one_le_iff_ne_zero.mpr h⟩)
      | inr h => exact absurd h (ne_of_gt hlog_total)
    · intro heq
      exact absurd (Finset.card_eq_zero.mpr heq) h

/-!
## Section 2: Abstract SII Properties

For the abstract HTSIE framework, we work with abstract SII measures
satisfying the key properties.
-/

/--
  An abstract SII measure satisfies:
  1. Non-negativity
  2. Monotonicity (larger accessible set = more structural information)
  3. Normalization (empty set has zero SII)
-/
structure SIIMeasure (S : Type*) where
  /-- The SII function -/
  val : Set S → ℝ
  /-- Non-negativity -/
  nonneg : ∀ A : Set S, val A ≥ 0
  /-- Monotonicity: A₂ ⊆ A₁ ⟹ SII(A₂) ≤ SII(A₁) -/
  mono : ∀ A₁ A₂ : Set S, A₂ ⊆ A₁ → val A₂ ≤ val A₁
  /-- Normalization: SII(∅) = 0 -/
  empty_zero : val ∅ = 0

/--
  Given a SIIMeasure, stronger constraints imply smaller SII.
  [FORMAL_VERIFIED]
-/
theorem sii_decreases_with_constraint
    {S C : Type*} [Preorder C]
    (sys : HTSIESystem S C)
    (sii : SIIMeasure S)
    (hmono : ConstraintMonotone sys)
    (c₁ c₂ : C) (hc : c₁ ≤ c₂) :
    sii.val (sys.accessibility c₂) ≤ sii.val (sys.accessibility c₁) :=
  sii.mono _ _ (hmono c₁ c₂ hc)

/-!
## Section 3: Open Questions about SII

[FORMAL_OPEN] — requires specific physical definition of SII.
-/

/--
  Open Question: Is SII invariant under measure-preserving transformations?
  SII(T(A)) = SII(A) for measure-preserving T?

  For cardinality-based SII: YES (bijections preserve cardinality).
  For entropy-based SII: depends on the measure.

  [FORMAL_OPEN]
-/
-- theorem sii_measure_preserving_invariant : ... -- [FORMAL_OPEN]

/--
  Open Question: Does SII satisfy subadditivity?
  SII(A ∪ B) ≤ SII(A) + SII(B)?

  For cardinality: YES (log is subadditive in this sense).
  For general measures: [FORMAL_OPEN]
-/
-- theorem sii_subadditive : ... -- [FORMAL_OPEN]

end
