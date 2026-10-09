/-
  Theorems/HTSIEInequality.lean
  ==============================
  The HTSIE Inequality — Formal Definition and Analysis

  The HTSIE inequality is the central mathematical claim of the theory:
  Stronger constraints imply non-increasing accessible state count,
  leading to monotone behavior across information measures.

  [FORMAL_VERIFIED] — fully aligned with Lean 4 Foundations.
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import HTSIE.Foundations.StateSpace
import HTSIE.Foundations.Constraints
import HTSIE.Foundations.AccessibleStates
import HTSIE.Information.SII
import HTSIE.Information.DFFI
import HTSIE.Dimension.EDI

namespace HTSIE.Theorems

open HTSIE.Foundations
open HTSIE.Information
open HTSIE.Dimension

/-!
## Section 1: The Core HTSIE Inequality
-/

/--
  Core HTSIE Inequality (Weak Form / Monotonicity):
  For any constraint levels c₁ ≤ c₂:
    |A(c₂)| ≤ |A(c₁)|

  [FORMAL_VERIFIED]
-/
theorem htsie_inequality_card
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys) (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂) :
    accessibleCard sys c₂ ≤ accessibleCard sys c₁ :=
  accessibleCard_monotone sys hmono c₁ c₂ hc

/-!
## Section 2: Unified HTSIE Triple-Measure Monotonicity
-/

/--
  Full HTSIE Inequality:
  Stronger constraints simultaneously lead to:
  1. SII non-increasing (Structural Information)
  2. EDI non-increasing (Effective Dimension)
  3. DFFI non-decreasing (Degree-of-Freedom Freeze)

  [FORMAL_VERIFIED]
-/
theorem htsie_inequality_full
    {X : FinStateSpace} (sys : FinConstraintSystem X)
    (hmono : ConstraintMonotone sys) (c₁ c₂ : ℕ) (hc : c₁ ≤ c₂)
    (hacc₂ : accessibleCard sys c₂ ≥ 1) :
    SII sys c₂ ≤ SII sys c₁ ∧
    EDI sys c₂ ≤ EDI sys c₁ ∧
    DFFI sys c₁ ≤ DFFI sys c₂ := ⟨
  sii_monotone sys hmono c₁ c₂ hc hacc₂,
  edi_monotone sys hmono c₁ c₂ hc hacc₂,
  dffi_monotone sys hmono c₁ c₂ hc
⟩

end HTSIE.Theorems
