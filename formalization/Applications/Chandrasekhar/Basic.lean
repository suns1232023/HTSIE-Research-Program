/- Applications/Chandrasekhar/Basic.lean -/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

open Real

structure ChandrasekharParams where
  G        : ℝ
  hbar     : ℝ
  c        : ℝ
  m_e      : ℝ
  m_H      : ℝ
  mu_e     : ℝ
  G_pos    : G > 0
  hbar_pos : hbar > 0
  c_pos    : c > 0
  m_e_pos  : m_e > 0
  m_H_pos  : m_H > 0
  mu_e_pos : mu_e > 0

noncomputable def eosCoefficient (p : ChandrasekharParams) : ℝ :=
  (p.hbar * p.c / 4) * (3 / Real.pi) ^ (1 / 3 : ℝ) *
  (1 / (p.mu_e * p.m_H)) ^ (4 / 3 : ℝ)

theorem eosCoefficient_pos (p : ChandrasekharParams) : eosCoefficient p > 0 := by
  unfold eosCoefficient
  apply mul_pos
  · apply mul_pos
    · apply mul_pos
      · exact mul_pos p.hbar_pos p.c_pos
      · norm_num
    · apply rpow_pos_of_pos
      exact div_pos (by norm_num) Real.pi_pos
  · apply rpow_pos_of_pos
    exact div_pos one_pos (mul_pos p.mu_e_pos p.m_H_pos)
