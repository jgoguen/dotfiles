-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'neovim/nvim-lspconfig',
	init = function()
		local keys = require('lazyvim.plugins.lsp.keymaps').get()

		keys[#keys + 1] = {
			'sgd',
			function()
				require('telescope.builtin').lsp_definitions({ reuse_win = true, jump_type = 'vsplit' })
			end,
			desc = 'Goto Definition (vsplit)',
			has = 'definition',
		}
		keys[#keys + 1] = {
			'-gd',
			function()
				require('telescope.builtin').lsp_definitions({ reuse_win = true, jump_type = 'split' })
			end,
			desc = 'Goto Definition (split)',
			has = 'definition',
		}
	end,
	opts = function(_, opts)
		opts.diagnostics.virtual_text = false
		return opts
	end,
}

return M
