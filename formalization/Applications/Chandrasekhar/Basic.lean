import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Real.Basic

theorem eosCoefficient_pos (p : ChandrasekharParams) : eosCoefficient p > 0 := by
  unfold eosCoefficient
  apply mul_pos
  apply mul_pos
  · apply mul_pos
    · exact mul_pos p.hbar_pos p.c_pos
    · norm_num
  · apply Real.rpow_pos_of_pos
    norm_num
  · apply Real.rpow_pos_of_pos
    exact div_pos one_pos (mul_pos p.mu_e_pos p.m_H_pos)
