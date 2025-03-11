-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	{
		'neovim/nvim-lspconfig',
		opts = function(_, opts)
			local settings = {
				settings = {
					openscad = {
						-- An empty string is required here if there are no paths to provide because openscad-lsp doesn't check for
						-- this value being missing but empty is fine.
						search_paths = '',
						fmt_style = 'file',
					},
				},
			}

			opts['servers']['openscad_lsp'] = vim.tbl_deep_extend('force', opts['servers']['openscad_lsp'] or {}, settings)
		end,
	},
}

return M
