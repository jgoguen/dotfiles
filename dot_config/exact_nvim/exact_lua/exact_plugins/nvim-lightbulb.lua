local M = {
	'kosayoda/nvim-lightbulb',
	event = 'VimEnter',
	requires = {
		'antoinemadec/FixCursorHold.nvim',
	},
}

function M.config()
	require('nvim-lightbulb').setup({
		autocmd = {
			enabled = true,
		},
	})
end

return M
