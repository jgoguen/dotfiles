-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-neorg/neorg',
	build = ':Neorg sync-parsers',
	cmd = 'Neorg',
	ft = { 'norg' },
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	opts = {
		load = {
			['core.defaults'] = {},
			['core.concealer'] = {},
			['core.dirman'] = {
				config = {
					workspaces = {
						notes = '~/OneDrive/Notes',
					},
				},
			},
			['external.context'] = {},
		},
	},
}

return M
