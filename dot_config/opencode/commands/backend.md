---
description: Plan or implement backend behavior and service design
---

Work on the backend aspects of the current task.

Use `backend-developer` as the primary specialist for backend behavior, service
design, API boundaries, auth, data flow, jobs, and operational backend
concerns.

If the scope warrants it, involve additional specialists:

- `requirements-clarifier` when backend behavior, scope boundaries, or
  milestone shape are still ambiguous
- `database-engineer` when schema design, migrations, query behavior, indexing,
  or DAO boundaries materially affect the solution
- A language-specific agent such as `python-pro`, `golang-pro`, `rust-pro`, or
  `cpp-pro` when idiomatic implementation details in a specific language matter
- `security-auditor`, `compliance-auditor`, or `performance-engineer` when
  backend design materially affects security, regulated data handling, or
  scaling and latency
- `technical-writer` when API, migration, or operational documentation needs to
  be updated clearly

Backend process:

1. Understand the user-visible or service-visible backend behavior being added or
   changed.
2. Clarify ambiguous behavior, ownership, persistence, failure handling, or
   rollout expectations before locking in the design.
3. Define the smallest correct backend behavior, contracts, and data flow that
   fit repository conventions.
4. Bring in `database-engineer` or a language-specific agent when persistence or
   implementation details become central.
5. Keep contracts, side effects, migration impact, and operational constraints
   explicit.

Primary goals:

- Correct backend behavior
- Clear service and API contracts
- Explicit persistence and failure-handling behavior
- Safe rollout and compatibility expectations
- Actionable guidance for language-specific implementation when needed

Output requirements:

- Summarize the backend behavior, boundaries, and contracts being changed
- Call out assumptions, unresolved questions, and important constraints
- Identify which layer or specialist should handle the next step when applicable
- State which specialists materially informed the result only when it adds
  clarity
