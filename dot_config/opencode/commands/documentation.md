---
description: Update documentation
---

Review and update the broader repository documentation.

Focus on documentation such as:

- `README` files
- `docs/` content
- command, library, package, service, or tool guides
- setup, usage, configuration, deployment, migration, and troubleshooting docs

This command is for user-facing, operator-facing, and repo-level documentation,
not for routine inline code comments or API reference generation unless those
are part of the requested documentation scope.

Use `technical-writer` as the primary specialist. If the scope of the
documentation warrants it, involve additional specialists:

- `mermaid-diagram-specialist` when diagrams, architecture visuals, workflows,
  sequence flows, state diagrams, or ERDs are part of the documentation surface
- `security-auditor` when setup, defaults, secrets handling, permissions, trust
  boundaries, or security-sensitive workflows are documented
- `compliance-auditor` when privacy, retention, consent, auditability, or other
  compliance-relevant behavior must be documented accurately
- Other domain specialists when the documentation depends on deep product,
  infrastructure, or language-specific expertise

Documentation process:

1. Identify the relevant documentation surface for the change. This may be
   repo-wide, or local to a command, library, service, or package directory.
2. Review the existing documentation structure and determine which files should
   be updated.
3. Verify documentation against the current code, configuration, commands, and
   behavior instead of restating assumptions.
4. Make the smallest correct documentation changes needed to restore accuracy,
   clarity, and usability.
5. Update related examples, prerequisites, warnings, migration notes,
   troubleshooting steps, or cross-references when the change requires them.
6. Run relevant docs checks, link checks, or documentation builds when the
   repository provides them.

Primary documentation goals:

- Accuracy with current code and configuration
- Clear audience fit and task orientation
- Correct setup, usage, and operational guidance
- Working examples and commands
- Updated migration, rollout, or troubleshooting notes when needed
- Consistent terminology and navigation
- Accurate, maintainable diagrams when diagrams are part of the docs

Documentation principles:

- Keep the work grounded in the actual repository and changed behavior
- Prefer focused updates over broad rewrites unless the existing structure is
  materially misleading or broken
- Do not invent behavior, guarantees, defaults, or workflows that are not
  supported by the repository
- Treat stale examples, missing warnings, and mismatched setup steps as real
  documentation defects

Output requirements:

- Summarize which documentation files were updated and why
- Mention any important stale or missing docs you found outside the immediate
  edit scope
- State which documentation checks or validation steps were actually run
- Call out any assumptions or behavior you could not verify directly
