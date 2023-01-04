local M = {
	'vim-airline/vim-airline',
	requires = {
		'tpope/vim-fugitive',
		'vim-airline/vim-airline-themes',
	},
}

function M.setup()
	vim.g.airline_theme = 'tokyonight'
end

return M
