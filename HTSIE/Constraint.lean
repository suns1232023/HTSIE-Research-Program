import Mathlib.Order.Basic
import Mathlib.Data.Set.Basic
import HTSIE.Basic

open Set

/-- 使用 Set α 显式定义 ConstraintSet，确保 Membership 实例 (∈) 能被 Lean 自动推导 -/
def ConstraintSet (α : Type*) : Type * := Set α

def StrictConstraintMonotone (C : ℝ → ℝ) : Prop :=
  ∀ x y, x < y → C x < C y

/-- 显式指定参数类型 Set α -/
theorem constraint_nonempty_of_exists {α : Type*} (s : Set α) (h : ∃ x, x ∈ s) : s.Nonempty :=
  h
