local M = {
	'kosayoda/nvim-lightbulb',
	event = {'CursorHold', 'CursorHoldI'},
	after = 'nvim-code-action-menu',
}

function M.config()
	require('nvim-lightbulb').setup({
		autocmd = {
			enabled = true,
		},
	})
end

return M
