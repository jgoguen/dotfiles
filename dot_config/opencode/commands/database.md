---
description: Design or evolve database schema and data-access behavior
---

Work on the database aspects of the current task.

Use `database-engineer` as the primary specialist for SQL and document database
schema design, query behavior, indexes, migrations, and DAO or repository
boundaries.

If the scope warrants it, involve additional specialists:

- `requirements-clarifier` when entity boundaries, lifecycle rules, retention,
  or access patterns are still ambiguous
- `backend-developer` when schema and data-access design depend on service
  boundaries, API contracts, or workflow behavior
- A language-specific agent such as `python-pro`, `golang-pro`, `rust-pro`, or
  `cpp-pro` when idiomatic DAO, ORM, query-builder, or repository
  implementation details matter
- `performance-engineer` when indexing, query latency, throughput, or scaling
  materially affect the design
- `security-auditor` or `compliance-auditor` when access control, retention,
  auditability, residency, or sensitive-data handling materially affect the
  model
- `technical-writer` when migration, operational, or integration documentation
  needs to be updated clearly

Database process:

1. Understand the entities, invariants, access patterns, and lifecycle behavior
   that the application actually needs.
2. Clarify ambiguous entity boundaries, consistency needs, retention behavior,
   or query patterns before locking in the model.
3. Design the smallest correct schema, collection structure, indexes, and DAO
   boundaries that fit repository conventions.
4. Provide SQL DDL when relational schema creation or modification is part of
   the task.
5. Keep migration, rollout, operational, and compatibility impact explicit.

Primary goals:

- Correct and idiomatic persistence design
- Clear access patterns and DAO boundaries
- Safe schema evolution and migration behavior
- Explicit indexing and consistency decisions
- Actionable guidance for implementation in the appropriate language or data
  layer

Output requirements:

- Summarize the intended data model, access patterns, and persistence changes
- Call out assumptions, migration impact, and operational tradeoffs explicitly
- Include SQL DDL when SQL schema work is part of the task
- Identify ambiguities that need clarification before safe implementation when
  applicable
