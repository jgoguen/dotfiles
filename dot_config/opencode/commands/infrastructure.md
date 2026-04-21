---
description: Plan or implement infrastructure and deployment changes
---

Work on the infrastructure aspects of the current task.

Use `infrastructure-engineer` as the primary specialist for declarative
infrastructure, cloud resource changes, deployment systems, environment
configuration, Terraform, generated Terraform JSON, YAML-driven IaC layers, and
other infrastructure abstractions.

If the scope warrants it, involve additional specialists:

- `requirements-clarifier` when ownership, rollout scope, environment
  responsibilities, or abstraction-layer intent are still ambiguous
- `security-auditor` when IAM, secrets, network boundaries, trust boundaries,
  or exposed infrastructure attack surface materially affect the change
- `compliance-auditor` when residency, retention, auditability, or
  regulated-data obligations materially affect the infrastructure behavior
- `performance-engineer` when topology, sizing, latency, throughput, or scaling
  materially affect the infrastructure design
- `debugger` when the issue may be caused by environment drift, deployment
  behavior, runtime state, or third-party platform issues
- `technical-writer` when environment, rollout, or operational documentation
  needs to be updated clearly

Infrastructure process:

1. Identify the true source of truth for the desired infrastructure change.
2. Clarify ambiguous ownership, abstraction-layer semantics, environment scope,
   or rollout expectations before locking in the change.
3. Make the smallest correct change in the appropriate authored layer rather
   than bypassing generation or abstraction flow.
4. Keep environment scope, dependency impact, rollout behavior, and drift risk
   explicit.
5. Run relevant formatting, linting, generation, plan, policy, or dry-run checks
   when the repository provides them.

Primary goals:

- Correct source-of-truth handling
- Safe, maintainable infrastructure changes
- Explicit environment and rollout behavior
- Minimal drift and abstraction-layer bypass risk
- Actionable guidance for implementation in the right infrastructure layer

Output requirements:

- Summarize the intended infrastructure change and the layer where it belongs
- Call out assumptions, environment scope, dependency impact, and rollout
  constraints explicitly
- Identify ambiguities that need clarification before safe implementation when
  applicable
- State which specialists materially informed the result only when it adds
  clarity
