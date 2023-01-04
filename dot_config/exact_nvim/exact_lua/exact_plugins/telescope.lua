local M = {
	'nvim-telescope/telescope.nvim',
	module = 'telescope',
}

function M.config()
	local telescope = require('telescope')
	local actions = require('telescope.actions')
	local utils = require('jgoguen.utils')

	telescope.setup({
		defaults = {
			prompt_prefix = string.format('%s ', utils.get_icon('Search')),
			selection_caret = string.format('%s ', utils.get_icon('Selected')),
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

			mappings = {
				i = {
					['<esc>'] = actions.close,
					['<C-i>'] = actions.select_horizontal,
					['<C-j>'] = actions.move_selection_next,
					['<C-k>'] = actions.move_selection_previous,
					['<C-n>'] = actions.cycle_history_next,
					['<C-p>'] = actions.cycle_history_prev,
					['<C-s>'] = actions.select_vertical,
				},
				n = {
					['i'] = actions.select_horizontal,
					['q'] = actions.close,
					['s'] = actions.select_vertical,
					['t'] = actions.select_tab,
				},
			},
			vimgrep_arguments = {
				'rg', '--color=never', '--no-heading', '--with-filename',
				'--line-number', '--column', '--smart-case', '--trim',
			},
			pickers = {
				find_files = {
					find_command = {'fd', '--type', 'f', '--strip-cwd-prefix'},
					hidden = true,
				},
			},
			extensions = {
				project = {
					hidden_files = true,
				},
			},
		},
	})

	local has_notify, _ = require('notify')
	if has_notify then
		telescope.load_extension('notify')
	end
end

return M
