---
description: Clarify requirements and turn them into a working project document
---

Clarify and structure the current requirements.

Use `requirements-clarifier` as the primary specialist. The goal is to turn
incomplete, evolving ideas into a usable Markdown document that can guide later
implementation.

If the scope warrants it, involve additional specialists:

- `technical-writer` to polish or restructure the resulting documentation
- `mermaid-diagram-specialist` when diagrams would materially improve
  understanding of architecture, workflows, boundaries, or milestones
- `backend-developer`, `frontend-developer`, `database-engineer`, or
  `infrastructure-engineer` when technical design materially affects scope or
  milestone shape
- `security-auditor`, `compliance-auditor`, `accessibility-tester`, or
  `performance-engineer` when non-functional requirements materially affect the
  plan

Requirements process:

1. Identify confirmed goals, known constraints, assumptions, and major unknowns.
2. Ask concise clarification questions where ambiguity materially affects scope,
   architecture, or milestone boundaries.
3. Distinguish confirmed requirements, assumptions, open questions, deferred
   decisions, risks, and non-goals explicitly.
4. Break the work into self-contained milestones when possible.
5. Produce or update a Markdown requirements document, scope document, proposal
   document, or milestone plan, depending on what best fits the task.
6. Revise the structure as new ideas emerge instead of forcing an early draft to
   stay fixed.

Primary goals:

- Clear requirements and scope boundaries
- Explicit assumptions and open questions
- Actionable milestones
- Useful architecture or workflow diagrams when they help
- Documents that are easy to revise as the plan evolves

Output requirements:

- Summarize the current understanding of the project or feature
- Distinguish confirmed requirements from assumptions and open questions
- Call out notable non-goals or deferred work when known
- Identify where further clarification is needed before safe implementation
- State which specialists materially informed the resulting document only when it
  adds clarity
