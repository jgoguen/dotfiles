local M = {
	'lewis6991/gitsigns.nvim',
}

function M.enabled()
	return vim.fn.executable('git') == 1
end

function M.config()
	require('gitsigns').setup({
		signs = {
			topdelete = {
				text = '契',
			},
		},
	})
end

return M
