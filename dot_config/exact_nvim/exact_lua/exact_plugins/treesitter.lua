local M = {
	'nvim-treesitter/nvim-treesitter',
}

function M.run()
	require('nvim-treesitter.install').update({with_sync = true})
end

function M.config()
	local options = {
		autotag = {
			enable = true,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
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
	}
	local has_config, config = pcall(require, 'config.treesitter')
	if has_config then
		options = vim.tbl_deep_extend('force', options, config)
	end

	require('nvim-treesitter.configs').setup(options)
end

return M
