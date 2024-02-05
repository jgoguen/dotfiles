local M = {
	'stevearc/aerial.nvim',
	keys = {
		{
			'<F8>',
			function()
				require('telescope').extensions.aerial.aerial()
			end,
			silent = true,
		},
		{ '<S-F8>', ':AerialToggle!<CR>', silent = true },
	},
	opts = {
		layout = {
			-- Maximum is the lesser of 100 columns or 20% of total width
			max_width = { 100, 0.2 },
			min_width = 20,
			-- prefer_{right,left}, right, left, float
			-- prefer_* options will open the other way if a buffer is on that side
			default_direction = 'right',
			-- edge or window
			-- edge: open on the far edge
			-- window: open a new window in the given direction
			placement = 'edge',
			preserve_equality = true,
		},
		attach_mode = 'global',
		close_automatic_events = { 'unsupported' },
		show_guides = true,
	},
}

return M
