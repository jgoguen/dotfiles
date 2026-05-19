---
description: Diagnose and fix a bug or failure using root-cause-first investigation
---

Debug the current issue systematically.

Load the `systematic-debugging` skill and use `debugger` as the primary agent.
The skill imposes a hard gate: no fix may be proposed until the root cause is
confirmed. Do not shortcut this under time pressure.

If the scope warrants it, involve additional specialists:

- `performance-engineer` when the issue may be caused by latency, throughput,
  contention, or resource exhaustion
- `security-auditor` when the issue may involve trust boundaries, unsafe
  assumptions, or behavior triggered by malicious input
- `code-reviewer` after a fix is implemented, to verify the fix addresses the
  confirmed root cause without introducing regressions

Debug process:

1. Load the `systematic-debugging` skill.
2. Identify the failure boundary: what is the observed symptom, and where does
   behavior first become wrong?
3. Complete root cause investigation before proposing any fix.
4. Analyze patterns against working examples. Identify what differs.
5. Form one specific hypothesis, test it with the smallest possible change.
6. After confirming root cause: write a failing test that captures the behavior,
   then implement the fix.
7. Verify the fix resolves the issue without breaking other tests.
8. If three or more fix attempts fail, stop and question the architecture before
   attempting another patch.

Primary goals:

- Confirmed root cause, not symptom suppression
- Minimal, targeted fix grounded in the diagnosis
- Test coverage for the failure scenario
- Clear explanation of cause and why the fix resolves it

Output requirements:

- Observed symptom, confirmed or likely root cause, and supporting evidence
- File and line references when the cause is in code
- Description of the fix and why it resolves the root cause
- Any residual uncertainty or related risks discovered during investigation
