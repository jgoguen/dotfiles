local M = {
	{
		'airbus-cert/tree-sitter-powershell',
	},
	{
		'neovim/nvim-lspconfig',
		opts = function(_, opts)
			opts['servers']['powershell_es'] = {
				bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services',
				settings = {
					powershell = {
						codeFormatting = {
							Preset = 'Stroustrup',
						},
					},
				},
			}
		end,
	},
	{
		'TheLeoP/powershell.nvim',
		opts = {
			bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services',
		},
	},
}

return M
