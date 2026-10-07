/-
  Chandrasekhar/EquationOfState.lean
  ===================================
  Equation of state for the relativistically degenerate electron gas.

  Key result: the ultra-relativistic EOS P = K·ρ^(4/3)
  corresponds to a polytrope with index n = 3.

  Evidence: [FORMAL_VERIFIED] for the algebraic identification.
-/

import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Real.Basic
import HTSIEChandrasekhar.Chandrasekhar.Basic

open Real

/-!
## Polytropic Equation of State

A polytropic EOS has the form P = K · ρ^(1 + 1/n).
For the ultra-relativistic degenerate electron gas: n = 3.
-/

/--
  General polytropic EOS: P = K · ρ^(1 + 1/n)
  [FORMAL_DEF]
-/
noncomputable def polytropicEOS (K n rho : ℝ) : ℝ :=
  K * rho ^ (1 + 1 / n)

/--
  Ultra-relativistic EOS: P = K · ρ^(4/3)
  [FORMAL_DEF]
-/
noncomputable def ultraRelativisticEOS (K rho : ℝ) : ℝ :=
  K * rho ^ (4 / 3 : ℝ)

/--
  The ultra-relativistic EOS equals the polytropic EOS with n = 3.
  Proof: 1 + 1/3 = 4/3.
  [FORMAL_VERIFIED]
-/
theorem ultraRelativistic_is_polytrope_n3 (K rho : ℝ) :
    ultraRelativisticEOS K rho = polytropicEOS K 3 rho := by
  unfold ultraRelativisticEOS polytropicEOS
  norm_num

/--
  The polytropic index for the ultra-relativistic EOS is n = 3.
  Algebraic fact: 1 + 1/3 = 4/3.
  [FORMAL_VERIFIED]
-/
theorem ultraRelativistic_polytrope_index :
    (1 : ℝ) + 1 / 3 = 4 / 3 := by norm_num

/--
  For n = 3, the exponent 1 - 1/n = 2/3.
  [FORMAL_VERIFIED]
-/
theorem n3_exponent : (1 : ℝ) - 1 / 3 = 2 / 3 := by norm_num
