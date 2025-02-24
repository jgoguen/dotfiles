-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	{
		'williamboman/mason.nvim',
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { 'dot-language-server' })
		end,
	},
	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				dotls = {},
			},
		},
	},
	{
		'izocha/graphviz.nvim',
		enabled = function()
			return require('utils').has_tool('dot')
		end,
		ft = { 'dot' },
		opts = {},
	},
}

return M
