# HTSIE Lean 4 Formalization Layer

**Version:** v0.3  
**Status:** Active Research / Formal Verification  
**Framework:** Lean 4 + Mathlib  
**Purpose:** Mathematical formalization, pressure testing, falsification, and assumption auditing

---

## 1. Purpose

The HTSIE Lean 4 Formalization Layer provides a **machine-checkable mathematical framework for testing, proving, and refuting selected propositions arising from the HTSIE research programme**.

It is not intended to serve as a confirmation mechanism for the HTSIE hypothesis.

### Core principle

> **Lean is a pressure-test and audit tool, not a confirmation tool.**

A successful formal proof is useful when the encoded assumptions are sufficient to establish the proposition.

A formally verified counterexample is equally valuable: it identifies an insufficient assumption, exposes a logical gap, or forces refinement of the underlying theory.

Therefore:

```text
Proof       → establishes the encoded proposition under its assumptions
Counterexample → falsifies the encoded implication
Formalization → exposes assumptions that may otherwise remain implicit
```

The current development should therefore be interpreted as a **formal mathematical research layer**, not as a claim that HTSIE has been established as a universal physical law.

---

## 2. Research Architecture

The intended direction of the formalization programme is:

```text
HTSIE Mathematical Core
        │
        ▼
Formal Specification
        │
        ▼
Lean Verification / Falsification
        │
        ▼
Computational Validation
        │
        ▼
Physical Instantiations
```

This direction is deliberate.

The programme does **not** assume:

```text
Chandrasekhar Limit
        ↓
HTSIE
```

Instead, physical systems are treated as possible **instantiations or test cases** of a mathematical framework whose assumptions and consequences must first be made explicit.

---

## 3. Scope

The formalization layer currently covers four distinct classes of objects:

| Class | Purpose | Typical Status |
|---|---|---|
| Definitions | Encode HTSIE mathematical objects | `[FORMALIZED]` |
| Theorems | Prove consequences of the definitions and assumptions | `[FORMAL_VERIFIED]` / `[FORMAL_OPEN]` |
| Counterexamples | Formally refute insufficient implications | `[FORMAL_COUNTEREXAMPLE]` |
| Physical interpretations | Connect formal mathematics with physical systems | `[PHYSICAL_OPEN]` |

This distinction is important because these four classes have different epistemic meanings.

### Formalization does not imply physical validation

A Lean-verified theorem establishes the correctness of the **formal statement under the assumptions encoded in Lean**.

It does not, by itself, establish that:

- the formal model is physically complete;
- the assumptions describe a real physical system;
- the selected variables are experimentally measurable;
- the model is empirically correct;
- HTSIE is universally applicable.

---

## 4. Directory Structure

```text
formalization/
├── HTSIE/                              # Core mathematical framework
│   ├── Basic.lean                      # HTSIESystem, core structures
│   ├── Constraint.lean                 # Constraint ordering and failure cases
│   └── Accessibility.lean              # Accessible-state-space results
│
├── Measures/                           # HTSIE measures
│   ├── SII.lean                        # Structural Information Index
│   ├── DFFI.lean                       # Degree of Freedom Freezing Index
│   └── EDI.lean                        # Effective Dimensionality Index
│
├── Theorems/                           # Core mathematical propositions
│   ├── ConstraintReduction.lean        # Constraint → measure relations
│   ├── HTSIEInequality.lean            # HTSIE inequality formulations
│   ├── Instability.lean                # Corrected instability theorem
│   └── CapacitySaturation.lean         # Capacity-saturation properties
│
├── Counterexamples/                    # Formal refutations
│   └── SaturationNotInstability.lean   # Formal counterexample
│
├── Applications/                       # Physical instantiations
│   └── Chandrasekhar.lean              # Chandrasekhar application
│
├── formalization_registry.yaml         # External/internal status registry
├── FORMALIZATION_STATUS.md             # Current proof status
├── AXIOM_AUDIT.md                      # Assumption and axiom audit
├── FORMALIZATION_MAP.md                 # Mapping of propositions to files
├── README.md                            # This document
├── lakefile.toml                        # Lean project configuration
└── lean-toolchain                       # Pinned Lean toolchain
```

The directory structure deliberately separates:

```text
Core mathematics
      ↓
Measures
      ↓
Theorems
      ↓
Counterexamples
      ↓
Applications
```

This prevents physical examples from silently becoming assumptions of the mathematical core.

---

## 5. Formalization Priorities

| Priority | Research Area | Current Role |
|---|---|---|
| **P0** | Constraint, accessibility, effective DOF, SII, DFFI, EDI | Mathematical foundation |
| **P1** | Monotonicity, counterexamples, spectral dimension | Core theorem development |
| **P2** | Chandrasekhar and other physical applications | Physical instantiation |
| **P3** | Black holes, SAE, representation learning | Extended applications |
| **P4** | LLM scaling and cross-system universality | Exploratory / conjectural |

Priority does not indicate mathematical truth.

It indicates the **research value and formalization order** within the HTSIE programme.

---

# 6. Formalization Philosophy

The project follows five principles.

### 6.1 Definitions before interpretation

A physical concept should not be treated as a mathematical theorem until its mathematical definition has been made explicit.

### 6.2 Assumptions before conclusions

Every non-trivial theorem should make its assumptions visible.

### 6.3 Counterexamples are first-class results

A failed conjecture is retained in the formalization repository when the failure provides information about the required assumptions.

### 6.4 Physical interpretation remains separate

A mathematically valid theorem should not automatically be interpreted as a physical law.

### 6.5 Formal verification is stronger than numerical consistency, but narrower than physical validation

```text
Numerical observation
        ↓
Formal mathematical statement
        ↓
Machine-checked proof
        ↓
Physical / empirical validation
```

These are distinct evidentiary levels.

---

# 7. Core Mathematical Definitions

## Layer 0 — Abstract Framework

| Definition | Lean Name | Mathematical Content | Status |
|---|---|---|---|
| HTSIE System | `HTSIESystem` | State space, constraints, accessibility map | `[FORMALIZED]` |
| Constraint Monotonicity | `ConstraintMonotone` | Ordered constraints imply nested accessibility | `[FORMALIZED]` |
| DOF Measure | `DOFMeasure` | Abstract measure of accessible-state-space size | `[FORMALIZED]` |
| Information Measure | `InfoMeasure` | Abstract information measure | `[FORMALIZED]` |
| HTSIE Chain | `HTSIEChain` | Formal conjunction of required links | `[FORMALIZED]` |

Here `[FORMALIZED]` means that the mathematical object has been encoded in Lean.

It does **not** mean that every desired theorem about that object has been proved.

---

## Layer 1 — HTSIE Measures

| Measure | Lean Representation | Current Mathematical Form | Status |
|---|---|---|---|
| SII | `SIIMeasure` | Log-cardinality / entropy-based form | `[FORMALIZED]` |
| DFFI | `DFFIMeasure` | `1 - \|A(c)\| / \|S\|` in finite setting | `[FORMALIZED]` |
| EDI | `EDIMeasure` | Log-cardinality / dimensional form | `[FORMALIZED]` |

The current formalization should not be interpreted as establishing that these mathematical forms are the unique or physically correct definitions of the corresponding HTSIE concepts.

---

# 8. Verified Mathematical Results

## 8.1 HTSIE Chain

**File:** `HTSIE/Basic.lean`  
**Theorem:** `htsie_chain_end_to_end`

```text
HTSIEChain ∧ c₁ ≤ c₂
    ⟹
info(A(c₂)) ≤ info(A(c₁))
```

**Status:** `[FORMAL_VERIFIED]`

Interpretation:

The encoded HTSIE chain is sufficient to establish the corresponding information monotonicity result.

---

## 8.2 Accessibility Reduction

**File:** `HTSIE/Accessibility.lean`  
**Theorem:** `accessibility_reduction`

```text
ConstraintMonotone ∧ c₁ ≤ c₂
    ⟹
A(c₂) ⊆ A(c₁)
```

**Status:** `[FORMAL_VERIFIED]`

This is a foundational result because the subsequent measure inequalities depend on the accessibility-space relation.

---

## 8.3 Full Constraint Reduction

**File:** `Theorems/ConstraintReduction.lean`  
**Theorem:** `htsie_constraint_reduction`

```text
ConstraintMonotone
∧ SIIMeasure
∧ EDIMeasure
∧ DFFIMeasure
∧ c₁ ≤ c₂

⟹

SII(A(c₂)) ≤ SII(A(c₁))
∧ EDI(A(c₂)) ≤ EDI(A(c₁))
∧ DFFI(c₁) ≤ DFFI(c₂)
```

**Status:** `[FORMAL_VERIFIED]`

This represents the current formal version of the central constraint-reduction mechanism.

---

## 8.4 SII Monotonicity

**File:** `Measures/SII.lean`  
**Theorem:** `SII_cardinality_monotone`

```text
A₂ ⊆ A₁
    ⟹
SII_logcard(A₂) ≤ SII_logcard(A₁)
```

**Status:** `[FORMAL_VERIFIED]`

---

## 8.5 DFFI Bounds

**File:** `Measures/DFFI.lean`  
**Theorem:** `DFFI_finite_bounds`

```text
accessible ≤ total
    ⟹
0 ≤ DFFI ≤ 1
```

**Status:** `[FORMAL_VERIFIED]`

---

## 8.6 EDI Monotonicity

**File:** `Measures/EDI.lean`  
**Theorem:** `EDI_logcard_monotone`

```text
A₂ ⊆ A₁
    ⟹
EDI_logcard(A₂) ≤ EDI_logcard(A₁)
```

**Status:** `[FORMAL_VERIFIED]`

---

# 9. Capacity / Instability Subprogramme

The capacity-instability branch is treated as a **special mathematical case**, not as the definition of HTSIE itself.

| Definition | Lean Name | Mathematical Content | Status |
|---|---|---|---|
| Positive capacity | `PositiveCapacity` | `∀ E > 0, C(E) > 0` | `[FORMAL_VERIFIED]` |
| Capacity saturation | `CapacitySaturation` | `∀ E > 0, E·C'(E) ≤ 1` | `[FORMAL_VERIFIED]` |
| Instability | `InstabilityAt` | Existence of a decreasing product regime | `[FORMAL_VERIFIED]` |
| Negative product derivative | `NegativeProductDerivAbove` | `C(E)+E·C'(E)<0` | `[FORMAL_VERIFIED]` |

---

# 10. Corrected Instability Theorem

**File:** `Theorems/Instability.lean`  
**Theorem:** `htsie_instability_corrected`

```text
C ∈ C¹(E₀,∞)
∧ C(E) > 0
∧ ∀ E > E₀,
    C(E) + E·C'(E) < 0

⟹
InstabilityAt C E₀
```

**Status:** `[FORMAL_VERIFIED]`

The important point is that the sufficient condition involves the derivative of the **product**

```text
F(E) = E · C(E)
```

rather than a bound on `C'(E)` alone.

---

# 11. Formal Counterexample: Saturation Does Not Imply Instability

**File:** `Counterexamples/SaturationNotInstability.lean`  
**Theorem:** `saturation_not_instability`

### Counterexample

Consider:

```text
C(E) = 1
```

Then:

| Property | Result |
|---|---|
| PositiveCapacity | ✓ |
| CapacitySaturation | ✓ |
| StrictSaturationAt | ✓ |
| InstabilityAt | ✗ |

Because:

```text
F(E) = E · C(E) = E
```

and therefore `F(E)` is increasing.

### Logical failure

The original implication

```text
C'(E) ≤ 1/E
    ⟹
F'(E) < 0
```

is false when `C(E) > 0`.

The product rule gives:

```text
F'(E) = C(E) + E·C'(E)
```

and the positive term `C(E)` cannot simply be discarded.

### Research significance

This is not merely a failed proof attempt.

It identifies a **missing mathematical condition** and motivates the corrected quantity:

```text
C(E) + E·C'(E)
```

Accordingly, the counterexample is retained as a formal research result.

---

# 12. Formal Counterexample: Constraint Monotonicity Can Fail

**File:** `HTSIE/Constraint.lean`  
**Theorem:** `constraint_monotone_can_fail`

```text
∃ sys : HTSIESystem ℕ ℕ,
    ¬ ConstraintMonotone sys
```

Example accessibility map:

```text
A(n) = {n + 1}
```

This demonstrates that nested accessible-state spaces cannot simply be assumed from the existence of a constraint parameter.

Therefore the relation

```text
c₁ ≤ c₂
    ⟹
A(c₂) ⊆ A(c₁)
```

must be treated as an explicit assumption, theorem, or separately justified property.

---

# 13. Open Mathematical Problems

| Problem | Status | Required Development |
|---|---|---|
| Spectral dimension as EDI | `[FORMAL_OPEN]` | Heat-kernel / random-walk formalization |
| DFFI ↑ ⟹ DOF ↓ in general | `[FORMAL_OPEN]` | Compatibility conditions |
| Quantitative HTSIE inequality | `[FORMAL_OPEN]` | Specific mathematical model |
| Differential HTSIE inequality | `[FORMAL_OPEN]` | Differentiability of SII |
| Chandrasekhar limit = HTSIE instability | `[FORMAL_OPEN]` | Explicit physical capacity function |
| Capacity-saturation scaling | `[FORMAL_OPEN]` | Additional hypotheses |
| Cross-system universality | `[CONJECTURE]` | Mathematical formulation required |

---

# 14. Physical Interpretations Not Yet Established

The following statements are **research hypotheses or physical interpretations**, not mathematical axioms:

- "Chandrasekhar limit is fundamentally information-capacity saturation"  
  → `[PHYSICAL_OPEN]`

- "Degeneracy pressure is exactly an information gradient"  
  → `[PHYSICAL_OPEN]`

- "Three-dimensional phase-space capacity is the physical origin of the Chandrasekhar limit"  
  → `[PHYSICAL_OPEN]`

- "HTSIE is universal across condensed matter, compact stars, black holes, SAE, and LLMs"  
  → `[CONJECTURE]`

- "LLM scaling follows HTSIE"  
  → `[CONJECTURE]`

These statements should not be promoted to theorem status merely because related mathematical structures can be formalized.

---

# 15. Chandrasekhar Application

The Chandrasekhar branch is treated as a **physical instantiation of the formal framework**, rather than as evidence that HTSIE is universally valid.

```text
HTSIE Mathematical Structure
            ↓
Explicit Physical Mapping
            ↓
Chandrasekhar Model
            ↓
Formal Verification
            ↓
Physical Interpretation
```

The current status is:

```text
Chandrasekhar formalization
        → [FORMAL_VERIFIED]
```

while the stronger statement

```text
Chandrasekhar limit = HTSIE instability
```

remains:

```text
[FORMAL_OPEN] + [PHYSICAL_OPEN]
```

This distinction should be preserved.

---

# 16. Evidence Classification

The repository uses the following evidence labels.

| Label | Meaning |
|---|---|
| `[FORMALIZED]` | Mathematical object or proposition has been encoded in Lean |
| `[FORMAL_VERIFIED]` | Lean verifies the stated proposition under its encoded assumptions |
| `[FORMAL_COUNTEREXAMPLE]` | Lean verifies a counterexample to the proposed implication |
| `[FORMAL_OPEN]` | Proposition is encoded, but the proof remains incomplete |
| `[CONJECTURE]` | Mathematical claim remains unestablished |
| `[PHYSICAL_OPEN]` | Physical interpretation remains unestablished |
| `[NUMERICAL]` | Computational observation; not a formal proof |
| `[EMPIRICAL]` | Supported by empirical or experimental evidence |
| `[EXTERNAL]` | Result established outside the current formalization |

### Important distinction

```text
[FORMAL_VERIFIED]
        ≠
[PHYSICALLY VERIFIED]
```

and:

```text
[NUMERICAL]
        ≠
[FORMAL_VERIFIED]
```

The labels are intentionally conservative.

---

# 17. Complete HTSIE Proposition Status

| Proposition | Mathematical Status | Lean Status | Computational / Physical Status |
|---|---|---|---|
| `HTSIESystem` | Defined | `[FORMALIZED]` | — |
| `ConstraintMonotone` | Defined | `[FORMALIZED]` | — |
| `SIIMeasure` | Defined | `[FORMALIZED]` | — |
| `DFFIMeasure` | Defined | `[FORMALIZED]` | — |
| `EDIMeasure` | Defined | `[FORMALIZED]` | — |
| HTSIE chain | Theorem | `[FORMAL_VERIFIED]` | — |
| Accessibility reduction | Theorem | `[FORMAL_VERIFIED]` | — |
| Full constraint reduction | Theorem | `[FORMAL_VERIFIED]` | — |
| SII monotonicity | Theorem | `[FORMAL_VERIFIED]` | — |
| DFFI bounds | Theorem | `[FORMAL_VERIFIED]` | — |
| EDI monotonicity | Theorem | `[FORMAL_VERIFIED]` | — |
| Constraint monotonicity can fail | Theorem | `[FORMAL_VERIFIED]` | — |
| Saturation ⟹ Instability | **Refuted** | `[FORMAL_COUNTEREXAMPLE]` | — |
| Negative product derivative ⟹ Instability | Theorem | `[FORMAL_VERIFIED]` | — |
| Spectral dimension = EDI | Open | `[FORMAL_OPEN]` | `[NUMERICAL]` |
| DFFI ↑ ⟹ DOF ↓ generally | Open | `[FORMAL_OPEN]` | `[NUMERICAL]` |
| Chandrasekhar = HTSIE instability | Open | `[FORMAL_OPEN]` | `[NUMERICAL]` |
| Effective-dimensional accessibility reduction | Open | `[FORMAL_OPEN]` | `[NUMERICAL]` |
| Universal HTSIE principle | Conjecture | `[CONJECTURE]` | `[OPEN]` |
| LLM scaling follows HTSIE | Conjecture | `[CONJECTURE]` | `[NUMERICAL]` |

---

# 18. Assumption Audit

Every substantive theorem should eventually be accompanied by an explicit assumption audit.

For each theorem, the project asks:

```text
1. What is formally assumed?
2. What is actually proved?
3. Which definitions are model choices?
4. Which assumptions are physically motivated?
5. Which assumptions remain unverified?
6. Can a counterexample be constructed if an assumption is removed?
```

The purpose of `AXIOM_AUDIT.md` is therefore not merely to count axioms.

It is to identify **where mathematical necessity ends and modelling choice begins**.

---

# 19. Formalization Registry

`formalization_registry.yaml` is the central registry for preventing duplicated or unnecessarily repeated formalization work.

Each proposition should record, where applicable:

```yaml
id:
name:
category:
statement:
source:
lean_file:
lean_status:
proof_status:
axiom_status:
external_formalization:
priority:
notes:
```

Recommended status values:

```text
EXTERNAL
INTERNAL_COMPLETED
FORMALIZED_OPEN
FORMAL_VERIFIED
FORMAL_COUNTEREXAMPLE
NUMERICAL
CONJECTURE
PHYSICAL_OPEN
```

The registry should be updated before beginning a substantial new formalization task.

---

# 20. Reproducibility

From the repository root:

```bash
git clone https://github.com/suns1232023/HTSIE-Research-Program
cd HTSIE-Research-Program/formalization
```

Install the pinned Lean toolchain according to `lean-toolchain`, then obtain the required Mathlib cache:

```bash
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh
lake exe cache get
```

Build the project:

```bash
lake build HTSIEFormalization
```

Check for unfinished proofs:

```bash
grep -rn "^[[:space:]]*sorry" \
  HTSIE/ Measures/ Theorems/ Counterexamples/ Applications/
```

A clean build should be considered a necessary reproducibility condition, not by itself a sufficient scientific validation condition.

---

# 21. Lean / Mathlib Environment

| Component | Current Target |
|---|---|
| Lean 4 | v4.14.0 |
| Mathlib | Project-pinned version |
| Build system | Lake |
| Formalization language | Lean 4 |

The exact dependency versions should be determined by the repository's `lean-toolchain` and `lakefile.toml`.

---

# 22. Research Workflow

The formalization layer is integrated into the broader HTSIE research workflow:

```text
Research Question
        ↓
Hypothesis
        ↓
Mathematical Formulation
        ↓
Explicit Assumptions
        ↓
Formal Specification
        ↓
Lean Verification / Falsification
        ↓
Computational Experiment
        ↓
Numerical Audit
        ↓
Reproducibility
        ↓
Physical Interpretation
        ↓
External Review
```

This workflow intentionally allows the process to terminate at:

```text
Formal Counterexample
```

rather than forcing every research hypothesis toward confirmation.

---

# 23. Current Research Status

| Area | Status |
|---|---|
| Abstract HTSIE framework | Active |
| Constraint / accessibility formalization | Active |
| SII formalization | Active |
| DFFI formalization | Active |
| EDI formalization | Active |
| Core monotonicity results | Formalized / verified |
| Capacity-instability branch | Formalized / partially corrected |
| Formal counterexamples | Active |
| Chandrasekhar formalization | `[FORMAL_VERIFIED]` |
| Spectral-dimension formalization | `[FORMAL_OPEN]` |
| General HTSIE inequality | `[FORMAL_OPEN]` |
| Cross-system universality | `[CONJECTURE]` |
| LLM interpretation | `[CONJECTURE]` |

---

# 24. Methodological Position

The formalization programme is deliberately **falsification-oriented**.

Its purpose is not to maximize the number of propositions labelled `[FORMAL_VERIFIED]`.

A stronger outcome may be:

```text
Original conjecture
        ↓
Formal specification
        ↓
Counterexample
        ↓
Missing assumption identified
        ↓
Corrected theorem
        ↓
Formal verification
```

The CapacitySaturation example illustrates this workflow.

The original implication was not accepted merely because it appeared intuitively compatible with the HTSIE framework. Formal analysis exposed a counterexample and led to a stronger and more precise sufficient condition.

This is the intended role of Lean within HTSIE.

---

# 25. Non-Claims

This repository does **not** claim that:

1. HTSIE has been established as a universal physical law.
2. Every HTSIE physical interpretation has been formally verified.
3. Numerical agreement constitutes mathematical proof.
4. A Lean proof establishes empirical validity.
5. The current definitions of SII, DFFI, or EDI are unique.
6. Chandrasekhar physics proves HTSIE universality.
7. LLM scaling observations constitute a theorem of HTSIE.
8. Formalization of one physical system establishes cross-domain universality.

These limitations are part of the research result, not disclaimers added after the fact.

---

# 26. Next Formalization Targets

The next development sequence is:

```text
P0
Constraint
   ↓
Accessibility
   ↓
Effective DOF
   ↓
SII / DFFI / EDI
        ↓
P1
General monotonicity
   ↓
Counterexample catalogue
   ↓
HTSIE inequality
        ↓
P2
Spectral dimension
   ↓
Physical instantiations
        ↓
P3+
Black holes / SAE / LLMs
```

Priority should be given to propositions that:

- have clear mathematical statements;
- expose important assumptions;
- can generate meaningful counterexamples;
- connect multiple HTSIE components;
- reduce ambiguity in later physical applications.

---

# 27. Final Position

The HTSIE Lean layer should be understood as a **formal mathematical laboratory**.

Its primary value is not that it makes the HTSIE hypothesis appear more certain.

Its value is that it makes the hypothesis **more precise, more auditable, and more falsifiable**.

The central methodological principle is therefore:

> **Formalize the claim before defending the claim.**

And, where possible:

> **Try to break the theorem before trying to generalize it.**

A successful proof establishes a formal result.

A successful counterexample identifies a missing assumption.

Both advance the research programme.

---

**Current status:** Active research  
**Formal verification:** Active  
**Chandrasekhar branch:** `[FORMAL_VERIFIED]`  
**Core HTSIE generalization:** `[FORMAL_OPEN]`  
**Universal physical interpretation:** `[CONJECTURE]`
