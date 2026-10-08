/-  HTSIE/Basic.lean  [FORMAL_VERIFIED]-/
import Mathlib.Order.Basic
import Mathlib.Data.Set.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Mul

open Set

structure HTSIESystem (S C : Type*) [Preorder C] where
  accessibility : C → Set S

def ConstraintMonotone {S C : Type*} [Preorder C]
    (sys : HTSIESystem S C) : Prop :=
  ∀ c₁ c₂ : C, c₁ ≤ c₂ → sys.accessibility c₂ ⊆ sys.accessibility c₁

def DOFMeasure (S : Type*) := Set S → ℝ
def DOFMonotone {S : Type*} (dof : DOFMeasure S) : Prop :=
  ∀ A B : Set S, A ⊆ B → dof A ≤ dof B

def InfoMeasure (S : Type*) := Set S → ℝ
def InfoMonotone {S : Type*} (f : InfoMeasure S) : Prop :=
  ∀ A₁ A₂ : Set S, A₂ ⊆ A₁ → f A₂ ≤ f A₁

structure HTSIEChain (S C : Type*) [Preorder C]
    (sys : HTSIESystem S C)
    (dof : DOFMeasure S)
    (info : InfoMeasure S) : Prop where
  constraint_mono : ConstraintMonotone sys
  dof_mono        : DOFMonotone dof
  info_mono       : InfoMonotone info

theorem htsie_chain_end_to_end
    {S C : Type*} [Preorder C]
    {sys : HTSIESystem S C}
    {dof : DOFMeasure S}
    {info : InfoMeasure S}
    (chain : HTSIEChain S C sys dof info)
    (c₁ c₂ : C) (hc : c₁ ≤ c₂) :
    info (sys.accessibility c₂) ≤ info (sys.accessibility c₁) :=
  chain.info_mono _ _ (chain.constraint_mono c₁ c₂ hc)

noncomputable def infoEnergyProduct (C : ℝ → ℝ) : ℝ → ℝ := fun E => E * C E

/-- F'(E) = C(E) + E·C'(E). [FORMAL_VERIFIED] -/
lemma deriv_infoEnergyProduct (C : ℝ → ℝ) (E : ℝ)
    (hC : DifferentiableAt ℝ C E) :
    deriv (infoEnergyProduct C) E = C E + E * deriv C E := by
  unfold infoEnergyProduct
  have hd : HasDerivAt (fun E => E * C E) (1 * C E + E * deriv C E) E :=
    (hasDerivAt_id' E).mul hC.hasDerivAt
  rw [hd.deriv]
  ring
