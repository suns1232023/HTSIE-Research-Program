# HTSIE Research Programme — AI Navigation

This file is the machine-oriented entry point for AI agents.

## Read first

```text
AGENTS.md
RESEARCH_MAP.yaml
```

Then select the appropriate research layer.

## Research layers

| Task | Primary location |
|---|---|
| Overall research question | `README.md` |
| Machine-readable research map | `RESEARCH_MAP.yaml` |
| Mathematical foundations | `htsie_2(数学骨架).md` |
| Lean formalization | `formalization/` |
| Formalization status | `formalization/FORMALIZATION_STATUS.md` |
| Assumption audit | `formalization/AXIOM_AUDIT.md` |
| Computational experiments | `experiments/` |
| Python pipelines | `scripts/` |
| Physical applications | `Applications/` |
| Research modules | `htsie_1...htsie_5...` |

## Evidence hierarchy

```text
FORMAL_VERIFIED
FORMAL_COUNTEREXAMPLE
FORMALIZED
NUMERICAL
EMPIRICAL
PHYSICAL_OPEN
CONJECTURE
```

Never silently upgrade one evidence class into another.

## Research workflow

```text
Question
→ Hypothesis
→ Mathematical formulation
→ Formal specification
→ Verification / falsification
→ Computation
→ Numerical audit
→ Reproducibility
→ Physical interpretation
```

## AI operating rule

If the repository does not provide enough evidence to establish a claim, report:

```text
INSUFFICIENT EVIDENCE
```

Do not fill the gap by inference.
