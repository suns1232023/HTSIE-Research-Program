/- HTSIE/Constraint.lean -/
import Mathlib.Order.Basic
import Mathlib.Data.Set.Basic
import HTSIE.Basic

open Set

/-- 使用 Set α 作为类型约束，确保 Membership 符号 (∈) 可自动合成 -/
def ConstraintSet (α : Type*) : Type * := Set α

def StrictConstraintMonotone (C : ℝ → ℝ) : Prop :=
  ∀ x y, x < y → C x < C y

/-- 显式给出 s 的类型 Set α 以帮助类型推导 -/
theorem constraint_nonempty_of_exists {α : Type*} (s : Set α) (h : ∃ x, x ∈ s) : s.Nonempty :=
  h
