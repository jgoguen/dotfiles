local M = {
	'nvim-lualine/lualine.nvim',
}

function M.config()
	local has_tokyonight, tokyonight = pcall(require, 'lualine.themes.tokyonight')
	local utils = require('jgoguen.utils')
	local lualine_x = {}
	local has_statusline_hints, statusline_hints = pcall(require, 'statusline-action-hints')

	if has_statusline_hints then
		lualine_x = {statusline_hints.statusline}
	end

	require('lualine').setup({
		options = {
			theme = has_tokyonight and tokyonight or 'auto',
			disabled_filetypes = utils.excluded_filetypes,
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
			lualine_x = lualine_x,
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
	})
end

return M
