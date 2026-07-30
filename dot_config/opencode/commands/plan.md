---
description: Create a detailed implementation plan from a spec or requirements
---

Create an actionable, step-by-step implementation plan and optionally execute it.

You must load the `superpowers-preferences` skill first. If the skill is not
available you must stop and ask for the directory where specs are stored and the
directory where plans are stored, as well as the format for spec and plan
filenames.

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

1. Load the `superpowers-preferences` skill.
2. Load the `writing-plans` skill.
3. Locate the spec or requirements: use the path from the
   `superpowers-preferences` skill, or the path in `$ARGUMENTS` if provided, or
   derive from the current conversation. If requirements are still ambiguous,
   involve `requirements-clarifier` before proceeding. If you have not done design
   exploration yet, consider `/brainstorm` first.
4. Scope check: if the spec covers multiple independent subsystems, propose
   splitting into separate plans before writing.
5. Map file structure: list every file to be created or modified and its single
   responsibility before defining tasks.
6. Write the plan as ordered, bite-sized tasks. Each task must include: exact
   file paths, actual test code, actual implementation code, the precise command
   to run the test, and a commit step.
7. Self-review: verify spec coverage, scan for placeholders, check type
   consistency across tasks. Fix inline.
8. Save the plan to a dated file. Default: `docs/plans/YYYY-MM-DD-<feature-name>
.md` — use the project's preferred location if one exists.
9. Offer execution choice:
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
