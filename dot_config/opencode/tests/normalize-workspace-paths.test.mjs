import assert from "node:assert/strict"
import test from "node:test"

import * as normalizeWorkspacePathsModule from "../plugins/normalize-workspace-paths.js"

const { default: normalizeWorkspacePaths } = normalizeWorkspacePathsModule

const workspace = "/Users/joel.goguen/Code/gosre"

test("exports only one legacy plugin entry", () => {
  assert.deepEqual(Object.keys(normalizeWorkspacePathsModule), ["default"])
})

test("normalizes an absolute path inside the active directory", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })
  const output = {
    args: { filePath: "/Users/joel.goguen/Code/gosre/internal/uvr/" },
  }

  await hooks["tool.execute.before"](
    { tool: "read", sessionID: "session", callID: "call" },
    output,
  )

  assert.equal(output.args.filePath, "internal/uvr")
})

test("uses the current directory for paths with a parent segment", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })
  const output = {
    args: {
      filePath: "/Users/joel.goguen/Code/gosre/internal/uvr/../cuuman",
    },
  }

  await hooks["tool.execute.before"](
    { tool: "read", sessionID: "session", callID: "call" },
    output,
  )

  assert.equal(output.args.filePath, "internal/cuuman")
})

test("normalizes the active directory itself to the relative current directory", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })
  const output = { args: { filePath: workspace } }

  await hooks["tool.execute.before"](
    { tool: "read", sessionID: "session", callID: "call" },
    output,
  )

  assert.equal(output.args.filePath, ".")
})

test("leaves absolute paths outside the active directory unchanged", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })
  const path = "/Users/joel.goguen/Documents/secret"
  const output = { args: { filePath: path } }

  await hooks["tool.execute.before"](
    { tool: "read", sessionID: "session", callID: "call" },
    output,
  )

  assert.equal(output.args.filePath, path)
})

test("leaves relative paths unchanged", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })
  const output = { args: { filePath: "internal/uvr" } }

  await hooks["tool.execute.before"](
    { tool: "read", sessionID: "session", callID: "call" },
    output,
  )

  assert.equal(output.args.filePath, "internal/uvr")
})

test("does not rewrite values that are not filesystem paths", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })
  const output = {
    args: {
      command: `${workspace}/internal/user.go`,
      content: `${workspace}/internal/user.go`,
      pattern: `${workspace}/internal/user.go`,
    },
  }

  for (const tool of ["bash", "edit", "glob", "grep", "read", "write"]) {
    await hooks["tool.execute.before"](
      { tool, sessionID: "session", callID: "call" },
      output,
    )
  }

  assert.deepEqual(output.args, {
    command: `${workspace}/internal/user.go`,
    content: `${workspace}/internal/user.go`,
    pattern: `${workspace}/internal/user.go`,
  })
})

test("normalizes only filesystem path arguments for supported tools", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })

  for (const tool of ["edit", "read", "write"]) {
    const output = { args: { filePath: `${workspace}/internal/user.go` } }
    await hooks["tool.execute.before"](
      { tool, sessionID: "session", callID: "call" },
      output,
    )
    assert.equal(output.args.filePath, "internal/user.go")
  }

  const list = { args: { path: `${workspace}/internal` } }
  await hooks["tool.execute.before"](
    { tool: "list", sessionID: "session", callID: "call" },
    list,
  )
  assert.equal(list.args.path, "internal")

  const glob = {
    args: {
      path: `${workspace}/internal`,
      pattern: "**/*.go",
    },
  }
  await hooks["tool.execute.before"](
    { tool: "glob", sessionID: "session", callID: "call" },
    glob,
  )
  assert.equal(glob.args.path, "internal")
  assert.equal(glob.args.pattern, "**/*.go")

  const grep = {
    args: {
      path: `${workspace}/internal`,
      pattern: "user",
    },
  }
  await hooks["tool.execute.before"](
    { tool: "grep", sessionID: "session", callID: "call" },
    grep,
  )
  assert.equal(grep.args.path, "internal")
  assert.equal(grep.args.pattern, "user")

  const bash = { args: { command: `cat ${workspace}/internal/user.go` } }
  await hooks["tool.execute.before"](
    { tool: "bash", sessionID: "session", callID: "call" },
    bash,
  )
  assert.equal(bash.args.command, `cat ${workspace}/internal/user.go`)
})

test("leaves an explicit external path unchanged for OpenCode permissions", async () => {
  const hooks = await normalizeWorkspacePaths({ directory: workspace })

  for (const tool of ["edit", "read", "write"]) {
    const path = "/Users/joel.goguen/Documents/secret"
    const output = { args: { filePath: path } }

    await hooks["tool.execute.before"](
      { tool, sessionID: "session", callID: "call" },
      output,
    )

    assert.equal(output.args.filePath, path)
  }

  for (const tool of ["glob", "grep", "list"]) {
    const path = "/Users/joel.goguen/Documents/secret"
    const output = { args: { path } }

    await hooks["tool.execute.before"](
      { tool, sessionID: "session", callID: "call" },
      output,
    )

    assert.equal(output.args.path, path)
  }
})

test("logs normalization decisions when debug logging is enabled", async () => {
  const logs = []
  const previousDebugValue = process.env.OPENCODE_NORMALIZE_WORKSPACE_PATHS_DEBUG
  process.env.OPENCODE_NORMALIZE_WORKSPACE_PATHS_DEBUG = "1"

  try {
    const hooks = await normalizeWorkspacePaths({
      directory: workspace,
      client: {
        app: {
          log: async (entry) => logs.push(entry),
        },
      },
    })

    const output = {
      args: { filePath: `${workspace}/internal/user.go` },
    }

    await hooks["tool.execute.before"](
      { tool: "read", sessionID: "session", callID: "call" },
      output,
    )

    assert.equal(output.args.filePath, "internal/user.go")
    assert.deepEqual(logs, [
      {
        body: {
          service: "normalize-workspace-paths",
          level: "debug",
          message: "normalized tool path",
          extra: {
            tool: "read",
            argument: "filePath",
            original: `${workspace}/internal/user.go`,
            result: "internal/user.go",
            changed: true,
          },
        },
      },
    ])
  } finally {
    if (previousDebugValue === undefined) {
      delete process.env.OPENCODE_NORMALIZE_WORKSPACE_PATHS_DEBUG
    } else {
      process.env.OPENCODE_NORMALIZE_WORKSPACE_PATHS_DEBUG = previousDebugValue
    }
  }
})
