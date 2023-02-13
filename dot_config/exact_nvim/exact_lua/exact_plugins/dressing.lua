local M = {
	'stevearc/dressing.nvim',
}

function M.config()
	require('dressing').setup({
		input = {
			default_prompt = '➤ ',
			win_options = {winhighlight = 'Normal:Normal,NormalNC:Normal'},
		},
		select = {
			backend = {'telescope', 'builtin'},
			builtin = {win_options = {winhighlight = 'Normal:Normal,NormalNC:Normal'}},
		},
	})
end

return M