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
			workspace = {
				library = {
					vim.fn.expand('$VIMRUNTIME/lua'),
				},
			},
		},
	},
}
