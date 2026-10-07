# PREPRINT_CLAIMS.md

## Preprint Claim Verification

This file ensures every formalization-related claim in the preprint
is supported by actual Lean evidence.

| Claim | Evidence | Safe Wording |
|---|---|---|
| "We formalized the Chandrasekhar mass limit." | Depends on actual theorem coverage (see FORMALIZATION_MAP.md) | "We formalized the mathematical statements listed in FORMALIZATION_MAP.md, achieving Level 3 coverage." |
| "Lean verifies our result." | chandrasekhar_limit_exists_and_positive compiles with no sorry | "Lean formally verifies the mathematical implication: model assumptions → M_Ch > 0." |
| "The EOS corresponds to n=3 polytrope." | ultraRelativistic_is_polytrope_n3 [FORMAL_VERIFIED] | "Lean formally verifies that 1 + 1/3 = 4/3, establishing the polytropic index." |
| "The mass is independent of central density." | n3_mass_exponent_on_rho_c [FORMAL_VERIFIED] | "Lean formally verifies the algebraic step: 1 - 3·(1/3) = 0." |
| "This is the first Lean formalization of Chandrasekhar." | Literature search found no prior peer-reviewed example | "To the best of our knowledge, no peer-reviewed publication provides a machine-checked formalization of the standard Chandrasekhar derivation chain." |
| "HTSIE explains the Chandrasekhar limit." | No formal evidence | DO NOT USE — remains [CONJECTURE] |
| "Lean proves the physical Chandrasekhar limit." | Physical assumptions not fully formalized | DO NOT USE — use "Lean formally verifies the mathematical implication under stated assumptions." |

## Claims That Must NOT Appear in the Preprint

- "HTSIE is formally proven."
- "Lean proves the physical theory of white dwarfs."
- "This proves the Chandrasekhar limit is caused by information saturation."
- Any claim that upgrades [FORMAL_OPEN] results to [FORMAL_VERIFIED].
