---
description: Summarize achievements from the past N days (e.g., /recent-wins 7)
subtask: true
---

The user wants a summary of recent achievements. The argument is a
number of days to look back: $ARGUMENTS

If no argument is provided, default to 7 days.

Read all markdown files under ~/Documents/wins/!`date +%Y`/. If the
lookback period crosses a year boundary, also check the prior year's
directory.

Filter to entries dated within the specified lookback window (relative
to today, !`date +%Y-%m-%d`). Then produce:

1. **A chronological list** of achievements from that period. For each,
   include the date, title, and a one-sentence summary of the outcome.
2. **A brief narrative paragraph** (3-5 sentences) summarizing the
   overall theme of work during this period — suitable for a standup,
   weekly update, or status report.

If no entries fall within the window, say so and suggest the user check
a wider range.
