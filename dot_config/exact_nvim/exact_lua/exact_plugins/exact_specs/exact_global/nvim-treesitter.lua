-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'JoosepAlviste/nvim-ts-context-commentstring',
		'nvim-treesitter/playground',
		'RRethy/nvim-treesitter-endwise',
		'windwp/nvim-ts-autotag',
	},
	opts = {
		auto_install = true,
		autotag = {
			enable = true,
		},
		context_commentstring = {
			enable = true,
		},
		endwise = {
			enabled = true,
		},
		ensure_installed = { 'bash', 'comment', 'markdown_inline', 'query', 'regex' },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { 'markdown', 'pandoc.markdown' },
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
		parser_install_dir = vim.fn.stdpath('data') .. '/tree-sitter-parsers',
		playground = {
			enable = true,
		},
	},
}

function M.build()
	require('nvim-treesitter.install').update({ with_sync = true })
end

function M.config(_, opts)
	local options = opts
	local has_config, Config = pcall(require, 'config.treesitter')
	if has_config then
		options = vim.tbl_deep_extend('force', options, Config)
	end

	require('nvim-treesitter.configs').setup(options)
end

return M
