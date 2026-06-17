---
name: ast-grep
description: Structural code search and refactoring via ast-grep. Reach for this when Edit fails with 'old_string not unique', when refactoring across formatting variations, or when matching code shape rather than text.
---

# ast-grep

Search and rewrite code by AST shape instead of literal text. Resilient to
whitespace, line breaks, and formatting differences that defeat string matching.

## Invocation

- Search: `ast-grep -l LANG -p 'PATTERN'`
- Preview a rewrite: `ast-grep -l LANG -p 'OLD' -r 'NEW'`
- Apply the rewrite: `ast-grep -l LANG -p 'OLD' -r 'NEW' --update-all`

`-l` (language) is **required** -- auto-detection is unreliable. The
interactive flag `-i` does not work from this harness.

## Metavariables

- `$VAR` -- a single AST node (an expression or identifier)
- `$$$ARGS` -- zero or more list items (function args, statement bodies)
- `$$STMT` -- multiple statements

## Canonical patterns

Rename a function across all call sites:

```
ast-grep -l typescript -p 'oldFn($$$ARGS)' -r 'newFn($$$ARGS)'
```

Rename a method on any receiver:

```
ast-grep -l javascript -p '$OBJ.oldMethod($$$ARGS)' -r '$OBJ.newMethod($$$ARGS)'
```

Rewrite imports:

```
ast-grep -l typescript -p 'import $WHAT from "old-pkg"' -r 'import $WHAT from "new-pkg"'
```

## Workflow

Run without `-r` to see matches, with `-r` to preview the diff, then add
`--update-all` to apply. For surgical per-site control, use ast-grep to find the
locations and the Edit tool to apply each change.
