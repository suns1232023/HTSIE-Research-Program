/-
  Chandrasekhar/Basic.lean
  ========================
  Physical parameters for the Chandrasekhar white-dwarf model.

  Evidence classification:
    [FORMAL_DEF]      — Definition formalized
    [FORMAL_VERIFIED] — Proved with no sorry

  This file defines the physical parameter structure.
  It does NOT encode HTSIE assumptions.
  The Chandrasekhar result is treated as an independent
  mathematical case study.
-/

import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Real.Basic

open Real

/-!
## Physical Parameters

The Chandrasekhar model depends on fundamental constants:
  G  : gravitational constant
  ħ  : reduced Planck constant
  c  : speed of light
  m_e: electron mass
  m_H: baryon mass (hydrogen mass proxy)
  μ_e: mean molecular weight per electron
-/

/--
  Physical parameters of the Chandrasekhar model.
  All parameters are positive real numbers.
  [FORMAL_DEF]
-/
structure ChandrasekharParams where
  G     : ℝ
  hbar  : ℝ
  c     : ℝ
  m_e   : ℝ
  m_H   : ℝ
  mu_e  : ℝ
  G_pos    : G > 0
  hbar_pos : hbar > 0
  c_pos    : c > 0
  m_e_pos  : m_e > 0
  m_H_pos  : m_H > 0
  mu_e_pos : mu_e > 0

/--
  The EOS coefficient K for the ultra-relativistic degenerate electron gas.
  K = (ħc/4) · (3/π)^(1/3) · (1/(μ_e · m_H))^(4/3)
  [FORMAL_DEF]
-/
noncomputable def eosCoefficient (p : ChandrasekharParams) : ℝ :=
  (p.hbar * p.c / 4) * (3 / Real.pi) ^ (1 / 3 : ℝ) *
  (1 / (p.mu_e * p.m_H)) ^ (4 / 3 : ℝ)

/--
  The EOS coefficient K is positive.
  [FORMAL_VERIFIED]
-/
theorem eosCoefficient_pos (p : ChandrasekharParams) : eosCoefficient p > 0 := by
  unfold eosCoefficient
  apply mul_pos
  apply mul_pos
  · apply mul_pos
    · exact mul_pos p.hbar_pos p.c_pos
    · norm_num
  · apply rpow_pos_of_pos; norm_num
  · apply rpow_pos_of_pos
    exact div_pos one_pos (mul_pos p.mu_e_pos p.m_H_pos)
