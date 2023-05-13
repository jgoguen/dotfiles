-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	opts = {
		options = {
			theme = 'auto',
			disabled_filetypes = require('utils').excluded_filetypes,
			globalstatus = true,
		},
		extensions = {
			'neo-tree',
			'quickfix',
			'symbols-outline',
		},
		sections = {
			lualine_c = {
				{
					'filename',
					path = 1,
					newfile_status = true,
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {
				{'progress'},
				{'%l/%L'},
				{'%v'},
				{'%B'},
			},
		},
		tabline = {
			lualine_a = {
				{
					'buffers',
					show_filename_only = false,
				},
			},
			lualine_z = {
				{
					'tabs',
					mode = 2,
				},
			},
		},
	},
}

function M.config(plugin)
	local colorscheme = require('config.colorscheme')
	local has_cs, cs = pcall(require, 'lualine.themes.' .. colorscheme.active_colorscheme)
	local has_statusline_hints, statusline_hints = pcall(require, 'statusline-action-hints')

	if has_cs then
		plugin.opts.options.theme = cs
	end

	if has_statusline_hints then
		plugin.opts.sections.lualine_x = {statusline_hints.statusline}
	end

	require('lualine').setup(plugin.opts)
end

return M
