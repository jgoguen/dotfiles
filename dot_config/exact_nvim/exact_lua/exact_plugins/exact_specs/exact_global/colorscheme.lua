-- Do not edit this file directly! It is managed by chezmoi.

local Colorscheme = require('config.colorscheme')

local M = {
	Colorscheme.themes[Colorscheme.active_colorscheme].repo,
	name = Colorscheme.themes[Colorscheme.active_colorscheme].name,
	lazy = false,
	priority = 1000,
	opts = Colorscheme.themes[Colorscheme.active_colorscheme].opts,
}

function M.config(_, opts)
	local Colorscheme = require('config.colorscheme')
	require(Colorscheme.active_colorscheme).setup(opts)

	vim.cmd('colorscheme ' .. Colorscheme.active_colorscheme)
end

return M
