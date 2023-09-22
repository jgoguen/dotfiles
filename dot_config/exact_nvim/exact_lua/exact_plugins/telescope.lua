-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-telescope/telescope.nvim',
	opts = {
		defaults = {
			path_display = {
				'truncate',
			},
			sorting_strategy = 'ascending',
			layout_config = {
				horizontal = {
					prompt_position = 'top',
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
		},
	},
}

return M