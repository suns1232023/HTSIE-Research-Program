# HTSIE Repository Instructions

This repository is an independent research programme, not a conventional application repository.

Before modifying code or documentation:

1. Read `AGENTS.md`.
2. Read `RESEARCH_MAP.yaml`.
3. Identify the relevant research module.
4. Inspect the existing implementation before creating new code.
5. Preserve epistemic status labels.

## Scientific rules

Never present:

- numerical observations as proofs;
- conjectures as established facts;
- formalized definitions as verified theorems;
- physical interpretations as mathematically established conclusions.

When uncertain, explicitly mark the result as:

`UNVERIFIED`

## Lean rules

For Lean changes:

- use the pinned toolchain;
- avoid `sorry`;
- do not weaken theorem statements solely to obtain compilation;
- expose assumptions;
- preserve counterexamples;
- run the relevant Lean build.

## Python rules

For computational work:

- preserve reproducibility;
- record parameters;
- avoid hidden random seeds;
- avoid silently changing datasets;
- report runtime and validation results when relevant.

## Documentation rules

Do not rewrite research history to make the project appear more mature.

Negative results, failed conjectures, and formal counterexamples are valuable research records.

## Final report

Every substantive change should report:

- Changed
- Verified
- Not Verified
- Scientific Interpretation
- Remaining Risk
