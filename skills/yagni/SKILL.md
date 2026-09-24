---
name: yagni
description: Enforce You Aren't Gonna Need It (YAGNI). Eliminate speculative abstractions, dead code, premature generalization, and scaffolding for hypothetical futures.
---

# YAGNI (You Aren't Gonna Need It)

Enforce strict minimalism and eliminate speculative engineering across all software design, implementation, and refactoring.

## Core Tenet

Do not write code for requirements that do not currently exist. Solve today's concrete problem with the minimum viable complexity.

## The YAGNI Rules

1. **No Single-Implementation Abstractions**
   - No interfaces or abstract classes with only one concrete implementation.
   - No generic factory methods or builder patterns for objects constructed in one place.
   - No plugin or hook systems created before a second consumer exists.

2. **No Speculative Configuration**
   - Hardcode constants until there is a proven operational requirement to change them without code deployment.
   - Do not add configuration knobs or environment variable overrides "just in case".

3. **No Dead Flexibility**
   - Do not pass parameters that are always invoked with the same constant value.
   - Do not implement unused options, branches, or return types.
   - Delete dead functions and variables immediately—git history retains the past.

4. **Shortest Working Architecture**
   - Native platform & standard library first.
   - Avoid pulling in external packages for problems solvable in 5–10 lines of standard library code.
   - Prefer flat, boring functions over layered dependency trees.

## Evaluation Checklist

Before approving or finalizing any code change, answer:
- [ ] Is any class, interface, or helper created for a hypothetical future requirement?
- [ ] Can this change be done in fewer lines without hurting correctness or edge-case handling?
- [ ] Are all added parameters and configuration keys consumed by existing code?
- [ ] If this speculative abstraction is deleted right now, does any current test fail? If no: **delete it**.
