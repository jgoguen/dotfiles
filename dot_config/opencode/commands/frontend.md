---
description: Plan or implement frontend behavior and web UI changes
---

Work on the frontend aspects of the current task.

Use `frontend-developer` as the primary specialist for semantic HTML,
template-driven rendering, progressive enhancement, vanilla JavaScript, SCSS,
and framework-based UI work when the repository already uses it.

If the scope warrants it, involve additional specialists:

- `requirements-clarifier` when UI behavior, scope boundaries, or interaction
  requirements are still ambiguous
- `accessibility-tester` when semantics, keyboard access, focus behavior,
  screen-reader support, contrast, motion, or cognitive accessibility
  materially affect the UI
- `security-auditor` whenever JavaScript behavior, DOM manipulation, client
  storage, third-party scripts, or browser-exposed trust boundaries materially
  affect the solution
- `technical-writer` when interaction, setup, or known limitations need to be
  documented clearly
- `mermaid-diagram-specialist` when flows, navigation, or component
  relationships would benefit from diagrams
- `backend-developer` when rendering or API boundaries materially affect
  frontend behavior

Frontend process:

1. Understand the user tasks, rendered structure, and interaction flows being
   added or changed.
2. Clarify ambiguous interaction behavior, browser support, or progressive
   enhancement expectations before locking in the solution.
3. Decide what should live in markup, styling, JavaScript, templates, or backend
   rendering.
4. Prefer the smallest correct frontend change that fits repository conventions.
5. Bring in accessibility and security specialists whenever user access or
   client-side risk materially affect the implementation.

Primary goals:

- Clear and resilient user-facing behavior
- Semantic structure and maintainable styling
- Safe, proportionate JavaScript usage
- Accessible and secure interaction patterns
- Actionable guidance for implementation in the appropriate frontend layer

Output requirements:

- Summarize the intended frontend behavior and implementation layer
- Call out assumptions, interaction ambiguities, and browser or device impact
- Identify when accessibility or security review is needed before implementation
- State which specialists materially informed the result only when it adds
  clarity
