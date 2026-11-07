---
description: Explore design space collaboratively before implementing anything
---

Turn an idea into a validated spec before writing any code.

You must load the `plan-preferences` skill first. If the skill is not available you must stop and ask for the directory
where specs are stored, the directory where plans are stored, and the filename format for specs and plans.

Load the `spec-driven-development` skill. No implementation work begins until a written spec exists and you have
approved it. This applies to every task regardless of perceived simplicity.

If the scope warrants it, involve additional specialists during design:

- `requirements-clarifier` when the idea involves multiple systems or the scope boundaries are ambiguous enough to need
explicit definition first
- `mermaid-diagram-specialist` when component structure, data flow, or architecture would be clearer with a diagram in
the spec
- `backend-developer`, `frontend-developer`, `database-engineer`, or `infrastructure-engineer` when technical
constraints materially narrow the design options

Spec process:

1. Load the `plan-preferences` skill.
2. Load the `spec-driven-development` skill.
3. Explore project context: relevant files, docs, and recent commits.
4. Ask clarifying questions one at a time. Ask at most the five highest-impact questions, covering purpose, constraints,
   and success criteria. Use multiple-choice when possible.
5. Propose 2-3 design approaches with trade-offs and a recommendation.
6. Present the design section by section, getting approval before moving on.
7. Write the validated spec to the path from `plan-preferences`. Do not create a repo-local `specs/` directory.
8. Self-review the spec: check for placeholders, contradictions, and ambiguity. Fix inline.
9. Ask for spec review before proceeding.
10. On approval, transition to `/plan` to create the implementation plan.

Primary goals:

- Design with explicit trade-offs considered before committing to an approach
- YAGNI: no scope beyond what is actually needed now
- Approved written spec before any code is written
- Clean transition into an actionable implementation plan

Output requirements:

- Written spec file saved to the path from `plan-preferences`, path reported
- Summary of design decisions made and why
- Explicit list of deferred decisions and out-of-scope items
