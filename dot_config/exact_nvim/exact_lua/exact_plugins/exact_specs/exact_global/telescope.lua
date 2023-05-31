-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-telescope/telescope-symbols.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function() return vim.fn.executable('make') ~= 0 end,
		},
	},
	lazy = true,
	cmd = {
		'Telescope',
	},
}

function M.config()
	local Telescope = require('telescope')
	local TelescopeActions = require('telescope.actions')
	local Utils = require('utils')

	Telescope.setup({
		defaults = {
			prompt_prefix = string.format('%s ', Utils.get_icon('Search')),
			selection_caret = string.format('%s ', Utils.get_icon('Selected')),
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
					['<esc>'] = TelescopeActions.close,
					['<C-i>'] = TelescopeActions.select_horizontal,
					['<C-j>'] = TelescopeActions.move_selection_next,
					['<C-k>'] = TelescopeActions.move_selection_previous,
					['<C-n>'] = TelescopeActions.cycle_history_next,
					['<C-p>'] = TelescopeActions.cycle_history_prev,
					['<C-s>'] = TelescopeActions.select_vertical,
				},
				n = {
					['i'] = TelescopeActions.select_horizontal,
					['q'] = TelescopeActions.close,
					['s'] = TelescopeActions.select_vertical,
					['t'] = TelescopeActions.select_tab,
				},
			},
			vimgrep_arguments = {
				'rg', '--color=never', '--no-heading', '--with-filename',
				'--line-number', '--column', '--smart-case', '--trim',
			},
			pickers = {
				find_files = {
					find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
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

	local has_notify, _ = pcall(require, 'notify')
	if has_notify then
		Telescope.load_extension('notify')
	end

	local has_fzf, _ = pcall(require, 'telescope._extensions.fzf')
	if has_fzf then
		Telescope.load_extension('fzf')
	end
end

return M
