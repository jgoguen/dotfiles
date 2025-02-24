local M = {
	{
		'airbus-cert/tree-sitter-powershell',
		ft = { 'powershell' },
		enabled = function()
			return vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 or vim.fn.has('win16') == 1
		end,
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
		ft = { 'powershell' },
		opts = {
			bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services',
		},
	},
}

return M
