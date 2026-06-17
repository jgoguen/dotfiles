---
name: code-structure
description: Get an outline (functions/classes/exports) of a file or package without reading it whole. Use when the question is 'list/show/what's in' rather than 'where is' (search) or 'how does it work' (read).
---

# code-structure

When the question is "list the X in Y", do not Read the whole file. Get an
outline first, then Read selectively.

## Trigger discrimination

- "list / show / all the methods / classes / exports in..." -> outline (this skill)
- "where is X defined" / "find calls to X" -> search (rg or ast-grep)
- "how does X work" / "what does X do" -> Read

## Tiered approach

**1. Compiler/parser-aware tool** (preferred when one fits the language --
respects exports, works across files, gives real semantic info):

- Go: `go doc -all ./path/to/pkg`
- Python: `python -m pydoc some.module.path` (needs an importable module, its deps, and PYTHONPATH)
- TS/JS third-party: `cat node_modules/<pkg>/dist/index.d.ts` (the `.d.ts` is a pre-made API outline)
- Java: `javap -p <Class>` (needs a compiled `.class`)

**2. ast-grep signature pattern** (works on any file, no build step; swap the
keyword for `function`/`class`/`struct`/`interface`/`type`):

- JS/TS: `ast-grep -l typescript -p 'export function $NAME($$$)' file.ts`
- Python: `ast-grep -l python -p 'def $NAME($$$):' file.py`
- Go exported: `ast-grep -l go -p 'func $NAME($$$)' file.go | rg -e '^func [A-Z]'`
- Rust public: `ast-grep -l rust -p 'pub fn $NAME($$$)' file.rs`

**3. ctags fallback** (universal, canonical for C/C++):

```
ctags -f - file | grep -v '^!' | cut -f1,4
```

(prints symbol + kind)

Use the outline to decide what to Read, then Read just that section.
