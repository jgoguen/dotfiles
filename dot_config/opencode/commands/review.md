---
description: Review current code changes; use `thermo` for a strict maintainability audit
---

Invoke the `review` skill for the current repository.

The complete command input is `$ARGUMENTS`.

Parse only the first whitespace-delimited token as a mode selector:

- If the input starts with the exact token `thermo` followed by whitespace or
  end-of-input, also load
  `thermo-nuclear-code-quality-review`. Treat the remaining input after that
  token as user-provided review context.
- Otherwise, run the standard review and treat the complete input as
  user-provided review context.
- If there is no input, use the standard review scope and repository defaults.

Pass the resulting context to the `review` skill. Do not discard context about
VCS conventions, requested scope, specific risk areas, or review questions.

Examples:

- `/review This repo uses "jj" for VCS`
- `/review Focus on the overall library rather than a specific change`
- `/review thermo This repo uses "jj" for VCS`
- `/review thermo Focus on the overall library rather than a specific change`
