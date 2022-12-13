local workspace_library = vim.api.nvim_get_runtime_file("", true)
workspace_library[vim.fn.expand('$VIMRUNTIME/lua')] = true
workspace_library[vim.fn.stdpath('config') .. '/lua'] = true

return {
	Lua = {
		IntelliSense = {
			traceLocalSet = true,
			traceReturn = true,
		},
		runtime = {
			version = "LuaJIT",
			-- path = runtime_path,
		},
		diagnostics = {
			globals = { "require", "vim" },
		},
		workspace = {
			-- Make the LSP aware of nvim runtime files
			library = workspace_library,
		},
		telemetry = {
			enable = false,
		},
	},
}
