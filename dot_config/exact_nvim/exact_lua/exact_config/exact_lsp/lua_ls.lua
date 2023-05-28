-- Do not edit this file directly! It is managed by chezmoi.

return {
	settings = {
		Lua = {
			IntelliSense = {
				traceLocalSet = true,
				traceReturn = true,
			},
			telemetry = {
				enable = false,
			},
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {
					'vim', 'require', 'pcall', '_G', 'os', 'ipairs',
				},
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = 'tab',
					indent_size = 2,
				},
			},
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}