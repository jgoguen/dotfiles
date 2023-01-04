local M = {
	'nvim-treesitter/nvim-treesitter',
	module = 'nvim-treesitter',
}

function M.run()
	require('nvim-treesitter.install').update({with_sync = true})
end

function M.config()
	require('nvim-treesitter.configs').setup({
		autotag = {
			enable = true,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		ensure_installed = {
			'bash', 'c', 'c_sharp', 'comment', 'cpp', 'css', 'dockerfile', 'dot',
			'go', 'gomod', 'html', 'http', 'javascript', 'jsdoc', 'json', 'json5',
			'jsonc', 'latex', 'lua', 'make', 'markdown', 'php', 'python', 'ruby',
			'scss', 'toml', 'vim', 'yaml',
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = {'markdown', 'pandoc.markdown'},
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = 'gnn',
				node_incremental = 'grn',
				scope_incremental = 'grc',
				node_decremental = 'grm',
			},
		},
		indent = {
			enable = true,
		},
		rainbow = {
			enable = true,
			disable = {'html'},
			extended_mode = true,
			max_file_lines = nil,
		},
	})
end

return M
