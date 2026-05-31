# Core Principles

- Prioritize accuracy and correct reasoning over speed or completeness.
- Before answering, check whether the premise, terminology, and assumptions are
  valid.
- If the premise, terminology, or assumptions are invalid or ambiguous, point
  that out and request confirmation before proceeding.
- Distinguish confirmed facts from assumptions or speculation, and mark unknowns
  explicitly.
- Do not invent APIs, commands, product specifications, or citations.

## Superpowers skill preferences

When using the `superpowers/writing-plans` or `superpowers/brainstorming` skills,
first load my personal skill:

`superpowers-preferences`

That skill contains my preferred central location for plan and spec files and
overrides the default `docs/superpowers/plans/...` or
`docs/superpowers/specs/...` paths.

## Python virtual environment resolution

When a Python repo is detected, resolve the venv in this order:

1. Parse `pyproject.toml` for `[tool.pyright]` section — check `venvPath`
   (relative to project root, defaults to `.` if absent) then `venv` for the
   venv directory name, constructing `<venvPath>/<venv>/bin/python` for the
   interpreter path.
2. Fall back to `./venv/` or `./.venv/` (check existence of `<dir>/bin/python`).
3. If no venv is found, use system Python/pip directly.

Use the resolved venv's `python`, `pytest`, `ruff`, and `pip` for all Python
operations (installing deps, running scripts, running lints/tests). Re-resolve
per session.

## Tool usage

When using commands with wildcards or relative to the current working directory,
always use paths starting with `./` (e.g. `ls ./*`, `find ./ -name ...`, `sort
./outputs/*`). Never use bare `*` or absolute paths with these commands. As an
example, if your current working directory is `/home/jgoguen/Code/project` and
you want to list all files in that directory, you should use `ls ./*` instead of
`ls *` or `ls /home/jgoguen/Code/project/*`. This ensures that the command
operates on the intended files and avoids unintended consequences. Similarly, if
you want to list all files in a subdirectory called `data`, you should use `ls
./data/*` instead of `ls data/*` or `ls /home/jgoguen/Code/project/data/*`. An
absolute path may only be used when operating on paths not under the current
working directory (e.g. `ls /tmp/data.1234/*` is acceptable). Always
double-check your commands to ensure they are correctly formatted and will
operate on the intended files.
