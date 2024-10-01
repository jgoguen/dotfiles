local M = {
	'echasnovski/mini.files',
	opts = function(_, opts)
		opts.mappings = opts.mappings or {}

		opts.mappings.go_in_horizontal_plus = '<C-v>'
		opts.mappings.go_in_horizontal = '<C-w>V'
		opts.mappings.go_in_vertical_plus = '<C-s>'
		opts.mappings.go_in_vertical = '<C-w>S'
	end,
}

return M
