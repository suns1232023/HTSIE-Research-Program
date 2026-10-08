# HTSIE Research Programme — AI Agent Protocol

## 1. Mission

This repository is an active independent research programme on Structural Information Evolution (HTSIE).

AI agents working in this repository must treat the repository as a research programme, not as a conventional software project.

The primary objectives are:

1. preserve mathematical correctness;
2. distinguish proof from conjecture;
3. distinguish numerical observation from formal verification;
4. identify missing assumptions;
5. search for counterexamples;
6. improve reproducibility;
7. avoid overstating scientific conclusions.

---

## 2. Epistemic Rules

Never silently upgrade the epistemic status of a result.

Use the following hierarchy:

```text
[FORMAL_VERIFIED]
[FORMAL_COUNTEREXAMPLE]
[FORMALIZED]
[NUMERICAL]
[EMPIRICAL]
[EXTERNAL]
[PHYSICAL_OPEN]
[CONJECTURE]
```

Do not convert:

```text
NUMERICAL → THEOREM
CONJECTURE → FACT
FORMALIZED → FORMAL_VERIFIED
PHYSICAL_OPEN → ESTABLISHED
```

A Lean compilation success is evidence that the encoded proposition is accepted by Lean under its encoded assumptions.

It is not, by itself, evidence that the physical interpretation is correct.

---

## 3. Research Philosophy

The project is falsification-oriented.

Agents should actively search for:

- counterexamples;
- hidden assumptions;
- insufficient hypotheses;
- edge cases;
- domain restrictions;
- dimensional inconsistencies;
- incorrect monotonicity assumptions;
- numerical artefacts;
- reproducibility failures.

A counterexample is a valid research result.

Do not modify a counterexample merely to make a conjecture succeed.

---

## 4. Before Modifying Code

Before making substantive changes:

1. inspect the repository structure;
2. read the relevant `README.md`;
3. read `RESEARCH_MAP.yaml`;
4. read the relevant status file;
5. identify the exact target proposition or module;
6. inspect existing tests and CI;
7. search for existing implementations before creating a duplicate.

Do not assume that a missing theorem in one directory means that it does not exist elsewhere in the repository.

---

## 5. Formalization Rules

For Lean work:

- preserve the pinned Lean toolchain;
- preserve the pinned Mathlib version unless explicitly instructed otherwise;
- do not introduce `sorry` into a claimed verified result;
- do not weaken theorem statements merely to make them compile;
- expose assumptions explicitly;
- distinguish definitions from theorems;
- retain formal counterexamples;
- run the complete relevant build after modification.

Required distinction:

```text
FORMALIZED
≠
FORMAL_VERIFIED
```

---

## 6. Research Status Rules

When changing the status of a proposition, update:

```text
RESEARCH_MAP.yaml
FORMALIZATION_STATUS.md
AXIOM_AUDIT.md
```

where applicable.

Every status change should identify:

- proposition;
- source file;
- proof or evidence;
- assumptions;
- validation method;
- date;
- remaining limitations.

---

## 7. Evidence Rules

Every substantive research claim should be traceable to one or more of:

- a Lean theorem;
- a source-code implementation;
- a reproducible computation;
- a dataset;
- an external publication;
- an explicitly labelled research hypothesis.

Never fabricate:

- theorem names;
- file paths;
- benchmark results;
- numerical results;
- external references;
- successful test results;
- CI results.

If a result cannot be verified, say:

```text
UNVERIFIED
```

rather than inferring success.

---

## 8. Modification Rules

Prefer the smallest change that solves the problem.

Do not:

- rewrite unrelated files;
- rename public research concepts without reason;
- remove negative results;
- delete failed experiments merely because they failed;
- replace evidence with prose;
- introduce dependencies without justification;
- silently change mathematical definitions.

---

## 9. Required Validation

For code changes:

```text
Syntax
↓
Unit / local tests
↓
Full relevant test
↓
CI
↓
Research-status consistency
```

For mathematical changes:

```text
Definition
↓
Assumptions
↓
Formal statement
↓
Proof / counterexample
↓
Independent check
↓
Status update
```

---

## 10. Reporting Format

At the end of substantive work, report:

### Changed
What was changed.

### Verified
What was actually tested or formally proved.

### Not Verified
What remains unverified.

### Scientific Interpretation
What the result does and does not establish.

### Remaining Risk
Potential unresolved mathematical, computational, or physical issues.

---

## 11. Conflict Resolution

When repository documentation conflicts with source code:

```text
Executable source / Lean proof
        >
CI result
        >
formalization status
        >
research documentation
        >
README prose
```

However, do not silently rewrite documentation.

Report the inconsistency and recommend the appropriate correction.

---

## 12. Core Principle

> Formalize the claim before defending the claim.

> Try to break the theorem before trying to generalize it.

> Never confuse a machine-checked statement with an established physical law.
