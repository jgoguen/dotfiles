---
description: Check PR status, address review comments, and fix CI failures
---

Run one pass of PR review management for the current branch.

Load the `receiving-code-review` skill before addressing any review comments.
It enforces that each suggestion is technically verified before implementing —
not every reviewer suggestion is correct and not every suggestion fits the
current scope.

If the scope warrants it, involve additional specialists:

- `code-reviewer` when a comment raises a correctness or design concern that
  needs careful independent assessment before deciding how to respond
- `security-auditor` when review feedback touches security boundaries, unsafe
  assumptions, or sensitive data handling
- `debugger` when a CI failure requires investigation before it can be fixed

PR review process:

1. Confirm you are on a feature branch, not main or master.
2. Find the PR with `gh pr view`. If no open PR exists, report and stop.
3. Check CI status with `gh pr checks`. Note any failing checks.
4. Load the `receiving-code-review` skill.
5. Fetch review comments: inline comments via
   `gh api repos/{REPO}/pulls/{PR_NUMBER}/comments` and general comments via
   `gh api repos/{REPO}/issues/{PR_NUMBER}/comments`. Group by thread.
6. For each new unaddressed comment, assess technically before deciding:
   - Explicit code replacement or concrete bug: **fix**
   - Nits (rename, typo, import order): **fix**, batch similar nits together
   - Design question or scope expansion: **reply** with rationale, no code change
   - Ambiguous: **reply** requesting clarification, no code change
   - Conflicting reviewers or architectural decision: **surface for your input**
7. For CI failures caused by branch changes: diagnose and fix. Skip failures
   that are unrelated to this branch (verify against main if unclear).
8. Present a summary of planned changes and replies before acting. Wait for
   approval unless "autonomous" is passed as an argument.
9. Stage only the files you intentionally changed. Commit with a message
   referencing the PR branch or ticket number.
10. Push. If Graphite is available (`gt` on PATH), use `gt stack submit`.
11. Prefix every PR reply with `*[AI-assisted response]*`. Do not resolve threads.
12. Report status: failures fixed, comments addressed, items needing your input.

Primary goals:

- Technically sound responses to review feedback, not performative agreement
- CI failures diagnosed and fixed, or clearly explained when out of scope
- All changes batched into one commit per pass
- Unresolvable decisions surfaced promptly

Output requirements:

- Disposition of each review comment: fixed, replied, or needs your decision
- CI check status and any failures fixed or skipped
- Commit summary if changes were pushed
- Clear list of items requiring your attention
