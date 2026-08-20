---
name: thermo-nuclear-code-quality-review
description: Use when `/review thermo` requests an unusually strict maintainability audit focused on structural simplification, file growth, branching complexity, abstraction quality, and codebase health.
---

# Thermo-Nuclear Code Quality Review

This is an opt-in, unusually strict maintainability lens for `/review thermo`.
It supplements the standard correctness and security review. It does not replace
them, and it does not turn subjective style preferences into findings.

## Attribution

This skill is a local adaptation of Cursor Team Kit's
`thermo-nuclear-code-quality-review` skill. The original source is:

<https://github.com/cursor/plugins/raw/refs/heads/main/cursor-team-kit/skills/thermo-nuclear-code-quality-review/SKILL.md>

This adaptation intentionally changes the invocation model, evidence bar, and
file-size threshold policy for local OpenCode use.

## Review Baseline

Perform a deep code-quality audit of the requested scope. Rethink how the change
could be structured or implemented to improve maintainability without changing
behavior. Look for a "code judo" move: a restructuring that removes concepts,
branches, helpers, or layers instead of merely moving them around.

Be ambitious about structural simplification, but remain evidence-driven. A
cleaner design is a finding only when the current design creates a concrete
maintenance, correctness, reliability, performance, or change-cost risk.

## Review Order

Prioritize findings in this order:

1. Structural regressions introduced by the change
2. Missed opportunities for a substantial behavior-preserving simplification
3. Spaghetti growth, duplicated conditions, and branching complexity
4. Boundary, abstraction, and type-contract problems
5. File-size and decomposition concerns
6. Modularity and maintainability problems
7. Legibility concerns with material impact

Assess every relevant area, but report only high-conviction findings. Merge
related observations when one finding explains the broader design problem.

## Structural Checks

For each meaningful change, ask:

- Is there a code-judo move that makes the implementation materially simpler?
- Did the change add concepts, branches, state, coupling, or helper layers that
  an alternative design could remove?
- Did a cohesive module become harder to scan or reason about?
- Did feature-specific logic leak into a shared or canonical path?
- Are repeated conditionals signaling a missing model, policy, dispatcher, or
  state abstraction?
- Is an abstraction earning its indirection, or is it a thin wrapper around a
  direct operation?
- Did the change duplicate an existing canonical helper?
- Are casts, `any`, `unknown`, optional values, or ad-hoc object shapes hiding a
  real invariant at a boundary?
- Is independent work serialized without a clear reason?
- Can related updates leave state partially applied when a more atomic structure
  is clear?

## File Size

Use the repository's documented convention or the user's explicit threshold when
one exists. Otherwise, use 1,000 lines as a strong decomposition trigger:

- If a change takes a file from below 1,000 lines to above 1,000 lines, inspect
  decomposition before approving it.
- Treat the crossing as a presumptive maintainability concern, not an automatic
  rejection. Explain the concrete cost and the smallest useful decomposition.
- Do not treat an existing large file as a new regression unless the change
  worsens its structure or the user requested a broader codebase audit.
- Exclude generated, vendored, and intentionally monolithic files when the
  repository identifies them as such. Verify the classification instead of
  assuming it.

## Flag Aggressively

Escalate findings for:

- Complex implementations where a plausible reframing would delete whole
  categories of complexity
- Ad-hoc conditionals or special cases bolted into unrelated flows
- One-off flags, nullable modes, or scattered feature checks
- Generic or magical mechanisms hiding simple data-shape assumptions
- Thin identity wrappers and pass-through abstractions
- Cast-heavy contracts or silent fallbacks that obscure the real invariant
- Copy-pasted logic where an existing helper or a focused abstraction is the
  canonical home
- Narrow edge cases inserted into an already busy function
- Temporary branching likely to become permanent debt
- Sequential orchestration or non-atomic updates that make the change more
  brittle without a clear need
- Refactors that move complexity without reducing the concepts a reader must
  hold in mind

Also apply the standard reviewer's adversarial checks for fake tests, hardcoded
implementations, scope creep, stubs, TODOs, swallowed errors, and happy-path-only
handling. Do not duplicate a standard finding merely because this lens noticed it.

## Preferred Remedies

Prefer remedies that reduce the model's complexity:

- Delete an unnecessary layer instead of polishing it
- Reframe the state model so conditionals disappear
- Move ownership to the module or package that already owns the concept
- Replace condition chains with an explicit typed model or dispatcher
- Separate orchestration from business logic
- Collapse duplicate branches into one direct flow
- Extract a focused pure helper when it removes local complexity
- Split a large file into coherent modules
- Reuse the canonical helper instead of introducing a near-duplicate
- Make type boundaries explicit so callers have fewer edge cases to handle
- Parallelize independent work when that also makes the flow clearer
- Make related updates atomic when partial state would be harder to reason about

Do not recommend a broad rewrite when a smaller structural change addresses the
identified risk. Do not require a particular fix strategy when the finding can
be explained without one.

## Approval Bar

Do not approve a thermo review merely because behavior appears correct. Before
approving, confirm that the requested maintainability dimensions were checked and
that the change has no clear structural regression, unjustified file growth,
spaghetti growth, needless indirection, unclear type boundary, misplaced logic,
or obvious behavior-preserving simplification that would materially improve the
design.

These are presumptive blockers only when the evidence shows material impact and
the requested scope permits the work:

- A file crosses the applicable decomposition threshold without justification
- The change scatters special-case logic across a shared flow
- The change adds a wrapper, cast, flag, or fallback that makes the contract
  less direct
- The change duplicates a canonical helper or places logic in the wrong layer
- The implementation preserves substantial incidental complexity despite a clear
  and proportionate simplification

If the repository, task, or user explicitly accepts the trade-off, record that
context and evaluate whether the remaining risk is still material.

## Output

Return findings in the standard review's single prioritized report. For each
thermo finding, include:

- File and line references whenever possible
- The structural problem
- The concrete risk or maintenance cost
- Why the issue is introduced or worsened by the requested scope
- A proportionate remedy or decomposition direction
- Any assumption or repository context that affects confidence

Keep the final report focused. If no thermo findings exist, say that the strict
maintainability checks were performed and list residual risks or unverified areas.
