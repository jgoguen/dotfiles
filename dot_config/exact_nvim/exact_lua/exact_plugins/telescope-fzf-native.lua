local M = {
	'nvim-telescope/telescope-fzf-native.nvim',
	after = 'telescope.nvim',
	disable = vim.fn.executable('make') == 0,
	run = 'make',
}

function M.config()
	require('telescope').load_extension('fzf')
end

return M
