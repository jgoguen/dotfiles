---
description: Create a detailed implementation plan from a spec or requirements
---

Create an actionable, step-by-step implementation plan and optionally execute it.

Load the `writing-plans` skill. The plan must contain real code, exact file
paths, and precise test commands at every step — no pseudocode or placeholders.

If the scope warrants it, involve additional specialists before writing:

- `requirements-clarifier` if the requirements or scope are still ambiguous —
  resolve them before writing the plan, not during
- `backend-developer`, `frontend-developer`, `database-engineer`, or a
  language-specific agent when architecture or implementation decisions must be
  locked in for the plan to be accurate
- `mermaid-diagram-specialist` when data flow or structure benefits from a
  diagram included in the plan

Planning process:

1. Load the `writing-plans` skill.
2. Locate the spec or requirements: use the path in `$ARGUMENTS` if provided,
   or derive from the current conversation. If requirements are still ambiguous,
   involve `requirements-clarifier` before proceeding. If you have not done
   design exploration yet, consider `/brainstorm` first.
3. Scope check: if the spec covers multiple independent subsystems, propose
   splitting into separate plans before writing.
4. Map file structure: list every file to be created or modified and its
   single responsibility before defining tasks.
5. Write the plan as ordered, bite-sized tasks. Each task must include: exact
   file paths, actual test code, actual implementation code, the precise command
   to run the test, and a commit step.
6. Self-review: verify spec coverage, scan for placeholders, check type
   consistency across tasks. Fix inline.
7. Save the plan to a dated file. Default:
   `docs/plans/YYYY-MM-DD-<feature-name>.md` — use the project's preferred
   location if one exists.
8. Offer execution choice:
   - **Subagent-driven** (recommended): fresh subagent per task with review
     between tasks — load `subagent-driven-development` skill
   - **Inline execution**: execute tasks in this session with checkpoints — load
     `executing-plans` skill

Primary goals:

- A plan completable by a skilled developer with zero codebase context
- No ambiguous steps: every code step shows actual code, not descriptions
- TDD structure: test before implementation at every task
- Frequent commits: one per task
- Clean hand-off into execution

Output requirements:

- Saved plan file with path and task count reported
- Brief scope summary
- Execution choice presented
