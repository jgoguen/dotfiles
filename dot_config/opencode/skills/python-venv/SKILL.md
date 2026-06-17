---
name: python-venv
description: Use when working in a Python repo and about to run python, pip, pytest, ruff, mypy, or any Python tool. Resolves the project virtualenv and requires full ./venv/bin/<tool> paths in all commands, plan files, and subagent prompts. Never run bare pytest or python.
---

# Python virtual environment resolution

When a Python repo is detected, resolve the venv in this order:

1. Parse `pyproject.toml` for `[tool.pyright]` section, then check `venvPath`
   (relative to project root, defaults to `.` if absent) then `venv` for the
   venv directory name, constructing `<venvPath>/<venv>/bin/python` for the
   interpreter path.
2. Fall back to `./venv/` or `./.venv/` (check existence of `<dir>/bin/python`).
3. If no venv is found, use system Python/pip directly.

## Enforcement (applies to all agents, including subagents)

- All Python test/run/lint commands in plan files, task descriptions, and
  subagent prompts MUST use full paths to the resolved venv binaries (e.g.
  `./venv/bin/pytest`, `./venv/bin/python`). Never use bare `pytest` or `python`.
- When writing plan files (`superpowers:writing-plans`), every command step
  MUST use the venv-resolved path prefix, not the bare tool name.
- When dispatching subagents, include the resolved venv path in the scene-setting
  context so the subagent uses it for all commands.
- The resolved venv path is available at the session level via the venv
  resolution logic; if uncertain, default to `./venv/`.
