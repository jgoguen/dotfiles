---
description: Review the current code changes
---

Review the current code changes.

Use `code-reviewer` as the primary reviewer and always include
`security-auditor` in the review. If the scope of the change warrants it,
delegate to additional specialists and combine the results into one review:

- `technical-writer` for documentation-heavy changes or when documentation
  accuracy, clarity, or completeness is part of the review scope
- `accessibility-tester` when front-end or web UI changes materially affect
  semantics, keyboard interaction, focus behavior, screen reader support,
  visual contrast, or user task completion
- `compliance-auditor` when the changes touch regulated data, retention,
  consent, auditability, privacy, or other compliance-relevant behavior
- Other domain specialists when the review clearly benefits from their expertise

Review process:

1. Understand the scope of the changes and the repository conventions that
   should govern them.
2. Review with `code-reviewer` for correctness, regressions, maintainability,
   tests, and general engineering quality.
3. Review with `security-auditor` for vulnerabilities, unsafe assumptions,
   trust-boundary mistakes, dependency risk, and exposed attack surface.
4. Invoke additional specialists only when the change scope clearly calls for
   them.
5. Merge the results into one final review without duplicating overlapping
   findings.

Merging guidance:

- Merge overlapping findings into one stronger finding instead of listing the
  same issue multiple times from different specialists
- Prefer the most specific and highest-confidence explanation of the issue and
  risk
- Preserve security framing when a finding is both a correctness issue and a
  security issue
- When specialists disagree, surface the disagreement briefly and explain what
  additional context or validation would resolve it
- Keep the final review coherent and prioritized as one review, not a sequence
  of disconnected specialist reports

Primary review areas:

- Correctness and behavioral regressions
- Security vulnerabilities and unsafe assumptions
- Data loss, privacy, compliance, or reliability risks
- Performance regressions or unnecessary complexity
- Error handling, logging, and observability gaps
- Test coverage gaps, especially for edge cases and failure paths
- Documentation mismatches for public APIs, configuration, or user-visible
  behavior
- Maintainability, readability, and unnecessary abstraction

Review principles:

- Keep the review grounded in the actual changes
- Do not apply generic checklists mechanically
- Do not invent requirements that are not supported by the repository, task, or
  change scope
- Prefer high-signal findings over broad style commentary
- Avoid repeating the same issue across multiple findings when one clear finding
  is enough
- Distinguish clearly between confirmed findings, likely risks, and residual
  uncertainty

Output requirements:

- Present findings first, ordered by severity
- Include file and line references whenever possible
- Keep each finding focused on the issue, the risk, and why it matters
- Note which specialist perspective materially informed a finding only when it
  adds clarity
- If no findings are discovered, say so explicitly and mention any residual
  risks or testing gaps
- Keep any summary brief and place it after the findings
