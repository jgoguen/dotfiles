-- Do not edit this file directly! It is managed by chezmoi.

local Utils = require('utils')

local M = {
	'neovim/nvim-lspconfig',
	opts = function(_, opts)
		local new_opts = {
			servers = {
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = {
								autoImportCompletions = true,
								autoSearchPaths = true,
								-- Ignore in favour of ruff
								ignore = { '*' },
							},
							disableOrganizeImports = true,
						},
						python = {
							pythonPath = vim.g.python3_host_prog,
						},
					},
				},
				ruff = {},
			},
		}

		return vim.tbl_deep_extend('force', opts, new_opts)
	end,
}

return M
