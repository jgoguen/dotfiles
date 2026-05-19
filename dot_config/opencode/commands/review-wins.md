---
description: Generate a performance review summary from recorded achievements
subtask: true
---

Read all markdown files under ~/Documents/wins/!`date +%Y`/. If there
are files in prior year directories, note that but focus on the current
year unless the user asks otherwise.

For each file, extract:
- The date
- The title
- The project or team goal it supported (infer from context if not explicit)
- The key metric or outcome

Then produce a summary formatted for a performance review:

1. **Group achievements by project or theme.** If an achievement doesn't
   clearly belong to a project, group it under "General / Cross-cutting."
2. **Within each group, list entries in chronological order.**
3. **For each entry**, write a one- or two-sentence summary emphasizing
   impact and outcomes, not just activity.
4. **At the end**, include a "Highlights" section with the 3-5 most
   impactful achievements across all groups.

Use concise, professional language suitable for pasting into a
performance review form. Avoid filler and superlatives — let the
metrics speak.
