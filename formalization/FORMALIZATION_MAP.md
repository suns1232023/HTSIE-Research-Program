# LEGACY_INVENTORY.md

## Repository Lean File Inventory

**Date**: 2026-10-07
**Repository**: suns1232023/HTSIE-Research-Program

## Current Status

As of this inventory, the repository contains **no pre-existing Lean files**.
The formalization layer is being created fresh in this commit series.

## Existing Non-Lean Mathematical Content

| File | Mathematical Content | Relevance to Formalization |
|---|---|---|
| htsie_2(数学骨架).md | SII, DFFI, EDI definitions; HTSIE inequality | Primary source for formal definitions |
| htsie_5(跨学科应用).md | Compact stars, Chandrasekhar limit discussion | Physical context |
| htsie_1(理论基础).md | Core HTSIE hypothesis chain | Background for constraint definitions |

## Formalization Scope Decision

- **Primary target**: Chandrasekhar mass limit (mathematical derivation)
- **Rationale**: Well-defined mathematical structure; no prior peer-reviewed Lean formalization identified
- **HTSIE connection**: Treated as an independent formal case study, NOT as proof of HTSIE

## Evidence Classification

| Label | Meaning |
|---|---|
| [FORMAL_DEF] | Lean definition exists |
| [FORMAL_VERIFIED] | Compiles, no sorry, axiom-audited |
| [FORMAL_OPEN] | Incomplete proof (sorry present, documented) |
| [CONJECTURE] | Research hypothesis |
| [PHYSICAL_OPEN] | Physical interpretation unestablished |
| [ESTABLISHED] | Known result from literature |
