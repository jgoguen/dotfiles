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

When using the `superpowers/writing-plans` skill, first load my personal skill:

`superpowers-preferences`

That skill contains my preferred central location for plan files and overrides
the default `docs/superpowers/plans/...` path.

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
