local M = {
	'folke/tokyonight.nvim',
	opt = false,
}

function M.config()
	local has_tokyonight, tokyonight = pcall(require, 'tokyonight')
	if not has_tokyonight then return end

	tokyonight.setup({
		style = 'night',
		styles = {
			comments = {
				italic = false,
			},
			keywords = {
				italic = false,
			},
		},
		sidebars = {
			'help',
			'lazy',
			'qf',
			'terminal',
		},
	})
	vim.cmd('colorscheme tokyonight')
end

return M
