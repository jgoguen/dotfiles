---
name: python-venv
description: Use when working in a Python repo and about to run python, pip, pytest, ruff, mypy, or any Python tool. Resolves the project virtualenv and requires full ./venv/bin/<tool> paths in all commands, plan files, and subagent prompts. Never run bare pytest or python.
---

# Python virtual environment resolution

When a Python repo is detected, resolve the venv in this order:

1. If the `uv` command is in the `$PATH`, use `uv` to install all dependencies and run all commands for `python`,
   `pytest`, `ruff`, `basedpyright`, and other Python tools. This is the preferred method for venv resolution, if `uv`
   is available you do not need to specifically check for a venv directory.
2. Parse `pyproject.toml` for `[tool.pyright]` section, then check `venvPath` (relative to project root, defaults to `.`
   if absent) then `venv` for the venv directory name, constructing `<venvPath>/<venv>/bin/python` for the interpreter
   path.
3. Fall back to `./.venv/` or `./venv/` (check existence of `<dir>/bin/python`).
4. If no `uv` command or venv is found, use system Python/pip directly.

## Enforcement (applies to all agents, including subagents)

- All Python test/run/lint commands in plan files, task descriptions, and subagent prompts MUST be run using `uv` when
it is available.
- If `uv` is not available, all Python test/run/lint commands MUST use full paths to the resolved venv binaries (e.g.
`./venv/bin/pytest`, `./venv/bin/python`). Never use bare `pytest` or `python` when a venv is available, install
dependencies and tools in the venv instead of using a system tool.
- When writing plan files (`spec-driven-development`), every command step MUST use `uv` to be run, or if `uv` is not
available every command MUST use the venv-resolved path. Never use the bare tool name if `uv` or a venv is available.
- When dispatching subagents, include the requirements for running commands and tools (using `uv` or using the resolved
venv path) in the scene-setting context so the subagent will also correctly run all commands.
- Using `uv` or the resolved venv path is available at the session level via the resolution logic given earlier; if
uncertain, default to `./.venv/`.
