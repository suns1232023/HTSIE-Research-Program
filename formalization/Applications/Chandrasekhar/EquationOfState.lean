/-
  Applications/Chandrasekhar/EquationOfState.lean
  [FORMAL_VERIFIED]
-/

import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Real.Basic
import Applications.Chandrasekhar.Basic

open Real

noncomputable def polytropicEOS (K n rho : ℝ) : ℝ :=
  K * rho ^ (1 + 1 / n)

noncomputable def ultraRelativisticEOS (K rho : ℝ) : ℝ :=
  K * rho ^ (4 / 3 : ℝ)

/-- Ultra-relativistic EOS equals n=3 polytrope. [FORMAL_VERIFIED] -/
theorem ultraRelativistic_is_polytrope_n3 (K rho : ℝ) :
    ultraRelativisticEOS K rho = polytropicEOS K 3 rho := by
  unfold ultraRelativisticEOS polytropicEOS
  norm_num

/-- 1 + 1/3 = 4/3. [FORMAL_VERIFIED] -/
theorem ultraRelativistic_polytrope_index :
    (1 : ℝ) + 1 / 3 = 4 / 3 := by norm_num

/-- 1 - 3 * (1 / 3) = 0. [FORMAL_VERIFIED] -/
theorem n3_mass_exponent_on_rho_c :
    (1 : ℝ) - 3 * (1 / 3) = 0 := by norm_num
