---
description: Start or continue a persistent meeting notes recording session
---

Start or continue a persistent meeting notes session.

Use `meeting-notes-recorder` as the primary specialist and keep the same session
active until the user explicitly ends the meeting.

Session behavior:

1. On start, require a meeting title. If one is missing, ask for it briefly.
2. Once started, treat subsequent user messages as meeting-note content by
   default, not as separate unrelated requests.
3. Continue capturing notes across turns until the user clearly indicates the
   meeting is over.
4. If the user asks to revise, remove, or reorganize a previously captured note,
   apply that correction within the active meeting session.
5. When the user ends the meeting, have the agent:
   - clean up the notes for coherent presentation
   - summarize the meeting
   - identify action items
   - write the Markdown document to
     `~/Documents/Meeting Notes/%Y-%m/%Y-%m-%d-{title}.md`

Meeting end triggers:

- explicit instructions such as `end meeting`, `finish meeting`, `stop taking
  notes`, `wrap up the meeting`, or equivalent clear phrasing

During the meeting:

- Keep responses brief unless the user asks for more structure or feedback
- Do not over-summarize during live capture
- Preserve important corrections, decisions, open questions, and action-item
  candidates

On meeting end, output requirements:

- Confirm that the meeting has been ended
- Report the file path written
- Briefly mention any assumptions or unclear action-item ownership if relevant
