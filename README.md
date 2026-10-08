# HTSIE Research Programme

[![Research Programme](https://img.shields.io/badge/Research-HTSIE-2f6f9f)](https://suns1232023.github.io/HTSIE-Research-Program/)
[![GitHub Repository](https://img.shields.io/badge/GitHub-HTSIE--Research--Program-181717?logo=github)](https://github.com/suns1232023/HTSIE-Research-Program)
[![OpenXLab Dataset](https://img.shields.io/badge/OpenXLab-HTSIE--Dataset-168AAD)](https://openxlab.org.cn/datasets/suns1232026/HTSIE)
[![ORCID](https://img.shields.io/badge/ORCID-Scott%20Sun-a6ce39?logo=orcid)](https://orcid.org/0009-0002-1095-6228)
[![Google Scholar](https://img.shields.io/badge/Google%20Scholar-Scott%20Sun-4285F4?logo=googlescholar)](https://scholar.google.com/citations?user=bmVEc3wAAAAJ)
[![ResearchGate](https://img.shields.io/badge/ResearchGate-Scott__Sun-00CCBB?logo=researchgate)](https://www.researchgate.net/profile/Scott-Sun-3)

**Structural Information Evolution (HTSIE)** is an ongoing independent research programme investigating whether structural information can provide a useful framework for describing the evolution of complex systems across physical, mathematical, and computational scales.

**Current Research Status: Active — 2026**

---

# 📌 Overview

HTSIE studies relationships among:

**information · entropy · structure · geometry · dimensionality · complexity**

The programme investigates whether structural information can provide a common language for studying the emergence and evolution of organized complexity across otherwise different physical and computational systems.

Current research domains include:

- Condensed matter
- Quantum plasma
- Compact stars
- Black-hole systems
- Computational systems
- Neural-network representations
- Sparse Autoencoders (SAEs)
- Large language models

The programme is exploratory and research-oriented.

Individual mathematical constructions, computational results, and physical interpretations are treated as separate research components and should be evaluated according to their own evidence.

---

# 🔬 Current Research Programme

## HTSIE — Structural Information Evolution

The central research direction investigates how structural information may change across scales and dynamical regimes.

Current concepts include:

- Structural information
- Information evolution
- Entropy and information organization
- Complexity
- Emergence
- Scale-dependent structure
- Information concentration
- Effective dimensionality

---

## HTSIE-SAE — Sparse Representation Geometry

Application of structural-information concepts to **Sparse Autoencoders (SAEs)** and learned representations.

Current research includes:

- SAE feature structure
- Activation covariance
- Representation geometry
- Information concentration
- Feature emergence
- Effective dimensionality
- Interpretability of learned representations

---

## Knowledge Entropy

Investigation of entropy-like quantities intended to characterize the organization, concentration, and evolution of structured information.

The objective is to determine whether such quantities can be defined mathematically and tested computationally rather than assuming universal significance in advance.

---

## Spectral Dimension & Effective Dimensionality

Investigation of spectral observables and effective dimensionality as possible indicators of structural change across scales.

Current topics include:

- Spectral dimension
- Spectral dimension flow
- Effective dimensionality
- Spectral structure
- Scale-dependent geometric behaviour
- Numerical spectral analysis

---

## Cross-System Structural Comparison

Comparative investigation of structural information across systems with substantially different physical or computational characteristics.

The purpose is **not** to assume that these systems obey identical dynamics.

Instead, the research asks whether particular structural signatures can be:

1. identified;
2. mathematically formalized;
3. computationally measured;
4. independently tested.

---

# 🧭 Core Research Hypothesis

A recurring research direction within HTSIE is the proposed relationship:

```text
Structural Constraints
        ↓
Effective Degrees of Freedom
        ↓
Accessible State Space
        ↓
Information Representation
        ↓
Structural Information Evolution
```

A more specific working hypothesis is:

$$
\boxed{
\text{Constraint Increase}
\rightarrow
\text{Effective Freedom Reduction}
\rightarrow
\text{Accessible State-Space Reduction}
\rightarrow
\text{Information-Dimension Change}
}
$$

This relationship is treated as a **research hypothesis**, not as an established universal law.

The programme therefore emphasizes mathematical formulation, computational testing, numerical auditing, reproducibility, and falsification-oriented analysis.

---

# 📊 Research Status

HTSIE uses an explicit distinction between different levels of evidence:

| Component | Status | Meaning |
|---|---|---|
| **Conceptual Framework** | Active | Research concepts and proposed structures |
| **Mathematical Formulation** | Developing | Explicit definitions, equations, and propositions |
| **Computational Observation** | Active | Results obtained from numerical experiments |
| **Validation** | Ongoing | Independent or reproducible checks |
| **Physical Interpretation** | Open | Interpretation requiring further assessment |
| **Lean Formal Verification** | Active | Machine-checkable formalization of selected HTSIE mathematical propositions |

A computational observation is therefore **not automatically treated as an established theoretical or physical conclusion**.

---

# 🔬 Research Methodology

The programme follows a reproducibility-oriented research cycle:

```text
Research Question
        ↓
Hypothesis
        ↓
Mathematical Formulation
        ↓
Formal Specification
        ↓
Lean Verification / Falsification
        ↓
Computational Experiment
        ↓
Numerical Audit
        ↓
Reproducibility Check
        ↓
Cross-System Comparison
        ↓
Refinement / Falsification
        ↓
Updated Research Hypothesis
```

Negative results, failed tests, boundary cases, and reproducibility checks are retained as part of the research record.

---

# 🔧 Lean Formal Verification Layer

[![Lean CI](https://github.com/suns1232023/HTSIE-Research-Program/actions/workflows/lean.yml/badge.svg)](https://github.com/suns1232023/HTSIE-Research-Program/actions/workflows/lean.yml)

## Strategic Principle

> **The current Lean development provides a machine-checkable formalization of selected HTSIE mathematical propositions.**

The Lean layer is intended to formalize **HTSIE-specific mathematical definitions, lemmas, and propositions**.

It is **not** intended to re-formalize established mathematics or physics that is already available in suitable external Lean libraries.

The formalization strategy is therefore:

```text
Established Mathematics / Physics
            │
            │  external formalization
            ▼
     Mathlib / Physlib / Other
       Formal Libraries
            │
            │ import / reuse
            ▼
   HTSIE Mathematical Definitions
            │
            ├── Structural Information
            ├── Effective Degrees of Freedom
            ├── Accessible State Space
            ├── SII
            ├── DFFI
            └── EDI
            │
            ▼
      Constraint Lemmas
            │
            ▼
 Accessible-State Lemmas
            │
            ▼
      HTSIE Inequality
            │
            ▼
   Spectral-Dimension Flow
            │
            ▼
       Applications
```

---

## Evidence Classification

HTSIE uses the following epistemic labels for formal and computational results:

| Label | Meaning |
|---|---|
| `[FORMAL_VERIFIED]` | Lean 4 machine-checked proof with no `sorry`; relevant axioms are explicitly documented and audited |
| `[FORMAL_COUNTEREXAMPLE]` | Lean formally verifies a refutation or counterexample |
| `[FORMAL_OPEN]` | Formal specification exists but proof is incomplete or contains documented `sorry` |
| `[EXTERNAL]` | The relevant mathematical result is already formalized in an external Lean project and is reused rather than re-proved |
| `[NUMERICAL]` | Supported by computation or numerical experiment, but not a formal proof |
| `[CONJECTURE]` | Research hypothesis or conjectural mathematical statement |
| `[PHYSICAL_OPEN]` | Physical interpretation requires additional validation |
| `[EMPIRICAL]` | Empirical observation rather than a pure mathematical theorem |
| `[ESTABLISHED]` | Established result supported by the scientific literature |

These labels are intended to prevent conflation of:

**formal proof · numerical evidence · empirical observation · literature-supported result · research hypothesis.**

---

## Proof Architecture

The current formalization programme is organized into the following layers:

```text
┌─────────────────────────────────────────────┐
│ Mathlib / Physlib / External Lean Libraries │
│                  [EXTERNAL]                 │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│           HTSIE Core Definitions            │
│       SII · DFFI · EDI · State Space        │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│        Constraint & Accessibility           │
│      Constraint Lemmas / State Lemmas       │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│             HTSIE Inequality                │
│              [OPEN / FLAGSHIP]              │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│        Spectral-Dimension Flow              │
│                  [OPEN]                      │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│              Applications                   │
│ Chandrasekhar · Compact Stars · Black Holes │
│                    · SAE                     │
└─────────────────────────────────────────────┘
```

---

## Current Formalization Status

| Component | Status | Priority |
|---|---|---|
| **Chandrasekhar mass-limit formalization** | `[FORMAL_VERIFIED]` | P7 — Completed |
| **HTSIE Core Definitions: SII / DFFI / EDI** | `[OPEN]` | P0–P4 |
| **Constraint / Accessible-State Lemmas** | `[OPEN]` | P0–P2 |
| **HTSIE Inequality** | `[OPEN]` | P5 — Flagship |
| **Spectral-Dimension Flow** | `[OPEN]` | P6 |
| **SAE structural formalization** | `[OPEN]` | P8 |

### Chandrasekhar Formalization

The Chandrasekhar mass-limit formalization is currently the first completed machine-checkable physical application within the HTSIE formalization layer.

The result should be interpreted specifically as a **formalization of the selected mathematical derivation represented in the Lean development**, rather than as a claim that the entire astrophysical theory of compact stars has been formalized.

No prior complete, directly corresponding public Lean formalization of the standard Chandrasekhar derivation chain was identified during the current external formalization review.

---

## External Dependencies — Do Not Re-Prove Without Reason

The HTSIE project follows a **reuse-first** principle.

Where an appropriate machine-checked result already exists, HTSIE should import, reference, or build upon it rather than reproduce the same theorem independently.

Examples include:

| External Project / Library | Relevant Content | HTSIE Action |
|---|---|---|
| **Mathlib** | General mathematics, analysis, algebra, topology, geometry, etc. | Import / reuse |
| **Physlib / related physics formalizations** | Selected mathematical physics infrastructure | Import / evaluate for reuse |
| **Information-theory formalizations** | Entropy, mutual information, information inequalities | Reuse where applicable |
| **Statistical formalization libraries** | Fisher information, statistical inequalities | Reuse where applicable |
| **SAE / representation formalizations** | Selected SAE and representation-geometry results | Reuse / cite where applicable |

The complete project-specific external-formalization audit is maintained in:

```text
formalization/formalization_registry.yaml
```

This registry acts as a **duplicate-proof firewall**: a new theorem should be checked against existing formalizations before new proof development begins.

---

## Build

```bash
cd formalization

lake exe cache get

lake build HTSIEFormalization
```

Continuous integration is provided through:

```text
.github/workflows/lean.yml
```

---

# 📋 Formalization Roadmap

The Lean programme follows a dependency-first strategy rather than a publication-order strategy.

## P0 — Formal Foundations

- [ ] Define structural state spaces
- [ ] Define structural constraints
- [ ] Define accessible state spaces
- [ ] Prove basic constraint monotonicity

## P1 — Effective Degrees of Freedom

- [ ] Define effective degrees of freedom
- [ ] Establish boundedness
- [ ] Prove monotonicity under constraint inclusion

## P2 — DFFI

- [ ] Define Degree-of-Freedom Freeze Index
- [ ] Prove basic bounds
- [ ] Prove monotonicity
- [ ] Prove invariance under appropriate state relabeling

## P3 — SII

- [ ] Define Structural Information Index
- [ ] Prove well-definedness
- [ ] Prove non-negativity where applicable
- [ ] Establish normalization
- [ ] Establish invariance properties

## P4 — EDI

- [ ] Define Effective Dimensionality Index
- [ ] Establish finite-state formulation
- [ ] Establish spectral formulation
- [ ] Prove basic structural properties

## P5 — HTSIE Inequality

- [ ] Finite-state formulation
- [ ] Graph / lattice formulation
- [ ] Generalized formulation
- [ ] Establish exact assumptions and domain of validity

## P6 — Spectral-Dimension Flow

- [ ] Define spectral-dimension observable
- [ ] Define flow parameter
- [ ] Prove basic monotonicity results under explicit assumptions
- [ ] Formalize limiting-dimensionality framework

## P7 — Physical Applications

- [x] Chandrasekhar formalization
- [ ] Compact-star structural application
- [ ] Black-hole application
- [ ] Spectral-dimension application

## P8 — SAE / LLM Applications

- [ ] Formalize selected finite representation models
- [ ] Formalize DFFI for appropriate representation spaces
- [ ] Establish mathematically defined relationships with representation geometry
- [ ] Separate formal mathematical results from empirical SAE observations

---

# 🧪 Computational Research

Current computational work includes:

- Mathematical formulation of structural-information quantities
- Numerical analysis of information evolution
- SAE activation and covariance analysis
- Representation-geometry analysis
- Spectral analysis
- Effective-dimensionality analysis
- Cross-system comparison
- PyTorch-based experiments
- Statistical analysis
- Numerical auditing
- Falsification-oriented testing

Computational results are treated as observations requiring reproducibility and appropriate interpretation.

---

# 📚 Selected Research Publications

The following publications are associated with the broader HTSIE research programme.

Individual papers represent separate research outputs and may differ in scope, methodology, mathematical maturity, and evidentiary status.

## 2026

### 1. Why the Past May Be Physically Inaccessible: A Theoretical Review and Compatibility Framework for Evidence Classification

Scott Sun · 2026

[ResearchGate](https://www.researchgate.net/publication/414084644_Why_the_Past_May_Be_Physically_Inaccessible_A_Theoretical_Review_and_Compatibility_Framework_Evidence_Classification)

### 2. A Phenomenological Framework for Short-Range Gravitational Signatures from Spectral Dimension Flow

Scott Sun · August 2026

[ResearchGate](https://www.researchgate.net/publication/411800975_A_Phenomenological_Framework_for_Short-Range_Gravitational_Signatures_from_Spectral_Dimension_Flow)

### 3. Möbius–Lorentz Quotients and Null Pin Holonomy: Affine Normal Forms, Null-Displacement Loci, Mapping-Torus Topology, Pin Lifts, and Mirror-Residue Pairing

Scott Sun · August 2026

[ResearchGate](https://www.researchgate.net/publication/410989519_Mobius-Lorentz_Quotients_and_Null_Pin_Holonomy_Affine_Normal_Forms_Null-Displacement_Loci_Mapping-Torus_Topology_Pin_Lifts_and_Mirror-Residue_Pairing)

### 4. Particle Quintuple Descriptor Framework: Formal Integration of Information Geometry, de Rham Cohomology, and Field Theory

Scott Sun and Solomon Chen · August 2026

[ResearchGate](https://www.researchgate.net/publication/411189028_Particle_Quintuple_Descriptor_Framework_Formal_Integration_of_Information_Geometry_de_Rham_Cohomology_and_Field_Theory)

### 5. Geometric Constraint Evolution and Large-Scale Cosmological Correlations: A Mathematical Research Programme

Scott Sun and Solomon Chen · August 2026

[ResearchGate](https://www.researchgate.net/publication/411183208_Geometric_Constraint_Evolution_and_Large-Scale_Cosmological_CorrelationsA_Mathematical_Research_Programme)

### 6. Information Accessibility Transition: A Geometry-First Framework

Scott Sun and Solomon Chen · July 2026

[ResearchGate](https://www.researchgate.net/publication/411174715_Information_Accessibility_Transition_A_Geometry-First_Framework)

### 7. The Hidden Thread of Structural Information Evolution: A Comparative Study of Condensed Matter, Quantum Plasma and Black Hole Systems

Scott Sun · June 2026

[ResearchGate](https://www.researchgate.net/publication/411094172_The_Hidden_Thread_of_Structural_Information_Evolution_A_Comparative_Study_of_Condensed_Matter_Quantum_Plasma_and_Black_Hole_Systems)

### 8. Fractal Folding Theory: From the Kakeya Conjecture to Quantum Gravity Observations

Scott Sun · May 2026

[ResearchGate](https://www.researchgate.net/publication/411084695_Fractal_Folding_Theory_From_the_Kakeya_Conjecture_to_Quantum_Gravity_Observations_A_Synthetic_Study_Based_on_Random_Boolean_Network_Simulation_and_Cross-Theoretical_Comparison_Revised_Version_-Respons)

---

# 🧩 Research Modules

| Module | Research Focus |
|---|---|
| **HTSIE Framework** | Structural information and information evolution |
| **HTSIE-SAE** | Sparse autoencoders and learned representations |
| **Knowledge Entropy** | Entropy-like measures for structured information |
| **Spectral Analysis** | Spectral dimension and spectral structure |
| **Effective Dimensionality** | Dimension flow and representation structure |
| **Cross-System Analysis** | Comparative structural analysis |
| **Computational Experiments** | Numerical and PyTorch implementations |
| **Lean Formalization** | Machine-checkable formalization of selected mathematical propositions |

Individual modules may develop independently and may later be consolidated into research reports, preprints, computational notebooks, or archival releases.

---

# 📦 Data Availability

Large datasets are hosted separately because of repository storage limitations.

Depending on the experiment, datasets may include:

- Large-language-model SAE activation matrices
- Activation covariance data
- Microscopic-state transition data
- Spectral datasets
- Effective-dimensionality-flow benchmark data
- Large-scale numerical experiment outputs

## OpenXLab Dataset

**HTSIE Dataset**

https://openxlab.org.cn/datasets/suns1232026/HTSIE

The external dataset repository is intended to support independent inspection, replication, and further analysis.

---

# 💻 Source Code

The GitHub repository contains:

- Research modules
- Computational experiments
- Source code
- Documentation
- Lean formalization
- Continuous-integration workflows
- Reproducibility materials
- Supporting datasets and links

**Repository:**

https://github.com/suns1232023/HTSIE-Research-Program

The code is provided primarily for research, experimentation, verification, and reproducibility.

---

# 🌐 Research Website

The public research programme is presented through GitHub Pages:

https://suns1232023.github.io/HTSIE-Research-Program/

The website provides a human-readable entry point to the research programme and its individual modules.

---

# 👤 Research Identity

## Scott Sun

**Independent Researcher**

Persistent research identifiers and scholarly profiles:

- **ORCID:** https://orcid.org/0009-0002-1095-6228
- **Google Scholar:** https://scholar.google.com/citations?user=bmVEc3wAAAAJ
- **ResearchGate:** https://www.researchgate.net/profile/Scott-Sun-3
- **Research Website:** https://scottsun.com/
- **GitHub:** https://github.com/suns1232023

These profiles provide complementary records of publications, research outputs, code, datasets, and archival materials.

---

# 📖 Research Programme vs. Individual Papers

HTSIE is organized as a **research programme**, rather than a single paper or single theoretical claim.

```text
HTSIE Research Programme
        │
        ├── Research Questions
        │
        ├── Mathematical Frameworks
        │
        ├── Lean Formalization
        │
        ├── Individual Papers
        │
        ├── Computational Experiments
        │
        ├── Datasets
        │
        └── Archival Research Outputs
```

Individual publications should be cited according to their own bibliographic information and persistent identifiers where available.

---

# 📝 Citation

For the overall research programme, the repository may be cited as:

> Sun, Scott. *HTSIE Research Programme: Structural Information Evolution Across Physical and Computational Scales*. GitHub repository, 2026.

For a specific research result, please cite the corresponding publication, preprint, dataset, or archival record rather than citing the programme as a substitute.

Persistent identifiers such as DOI records should be preferred when an individual work has an archival DOI.

---

# 🔎 Research Scope & Epistemic Status

HTSIE is an **ongoing independent research programme**.

The repository may contain:

- Working hypotheses
- Preliminary mathematical formulations
- Computational experiments
- Exploratory numerical results
- Research notes
- Revised manuscripts
- Reproducibility materials
- Machine-checkable formalizations of selected mathematical propositions

The presence of a result in this repository does **not** by itself imply independent confirmation or acceptance by the wider scientific community.

A Lean-verified proposition establishes the correctness of the formal statement under its encoded assumptions. It does **not**, by itself, establish that the underlying model is physically complete or empirically correct.

The programme is designed to make assumptions, methods, computational evidence, formal proofs, and limitations increasingly explicit as the research develops.

---

# 📁 Repository Structure

```text
HTSIE-Research-Program/
│
├── formalization/
│   ├── HTSIE/
│   │   ├── Foundations/
│   │   │   ├── StateSpace/
│   │   │   ├── Constraints/
│   │   │   └── AccessibleStates/
│   │   │
│   │   ├── Information/
│   │   │   ├── SII/
│   │   │   └── DFFI/
│   │   │
│   │   ├── Dimension/
│   │   │   └── EDI/
│   │   │
│   │   ├── Inequalities/
│   │   │   └── HTSIEInequality/
│   │   │
│   │   └── SpectralFlow/
│   │       └── SpectralDimension/
│   │
│   ├── Applications/
│   │   ├── Chandrasekhar/        # [FORMAL_VERIFIED]
│   │   ├── CompactStars/
│   │   ├── BlackHoles/
│   │   └── SAE/
│   │
│   ├── formalization_registry.yaml
│   ├── FORMALIZATION_MAP.md
│   ├── FORMALIZATION_STATUS.md
│   ├── AXIOM_AUDIT.md
│   ├── lakefile.toml
│   ├── lean-toolchain
│   └── README.md
│
├── index.html
│
├── htsie_1(理论基础).md
├── htsie_2(数学骨架).md
├── htsie_3(大模型可解释性).md
├── htsie_4(实验与验证).md
├── htsie_5(跨学科应用).md
│
├── data/
│   ├── metrics.json
│   ├── daily_log.md
│   └── README.md
│
├── experiments/
│   ├── __init__.py
│   ├── runner.py
│   ├── sae_geometry.py
│   └── cross_system.py
│
├── scripts/
│   ├── daily_runner.py
│   ├── requirements.txt
│   └── modules/
│       ├── fetch_data.py
│       ├── run_computations.py
│       └── generate_reports.py
│
├── .github/
│   └── workflows/
│       ├── daily_experiment.yml
│       └── lean.yml
│
└── README.md
```

> **Repository architecture principle:**  
> The `formalization/` directory contains the machine-checkable mathematical layer.  
> Computational experiments, empirical observations, research notes, and physical interpretations remain separate from the formal proof layer.

---

# 🔑 Keywords

**Structural Information Evolution; HTSIE; Information Geometry; Entropy Evolution; Structural Information; Spectral Dimension; Spectral Dimension Flow; Effective Dimensionality; Emergent Causality; Complexity; Mathematical Physics; Computational Physics; Quantum Gravity; Condensed Matter; Quantum Plasma; Black Holes; Sparse Autoencoders; SAE; Representation Geometry; Large Language Models; Machine Learning Interpretability; Information Theory.**

---

# 📌 Status

| Field | Current Status |
|---|---|
| **Research Programme** | Active |
| **Researcher** | Scott Sun |
| **Affiliation** | Independent Research |
| **Year** | 2026 |
| **Repository** | GitHub |
| **Data** | OpenXLab |
| **Scholarly Profiles** | ORCID · Google Scholar · ResearchGate |
| **Lean Formal Verification** | Active — Chandrasekhar `[FORMAL_VERIFIED]` |

---

> **HTSIE is maintained as an open research programme.**
>
> Mathematical formulations, computational methods, datasets, formal proofs, and research outputs are progressively documented so that individual claims can be examined, reproduced, challenged, or extended independently.
