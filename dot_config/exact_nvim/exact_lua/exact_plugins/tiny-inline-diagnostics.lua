-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'rachartier/tiny-inline-diagnostic.nvim',
	event = { 'LspAttach' },
	priority = 1000,
	opts = {
		options = {
			break_line = {
				enabled = true,
			},
			multilines = true,
			show_source = true,
		},
	},
	config = function(_, opts)
		require('tiny-inline-diagnostic').setup(opts)
		vim.diagnostic.config({ virtual_text = false })
	end,
}

return M
