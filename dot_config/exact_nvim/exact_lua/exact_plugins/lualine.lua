local M = {
	'nvim-lualine/lualine.nvim',
}

function M.config()
	local has_tokyonight, tokyonight = pcall(require, 'lualine.themes.tokyonight')
	local utils = require('jgoguen.utils')
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
	})
end

return M
