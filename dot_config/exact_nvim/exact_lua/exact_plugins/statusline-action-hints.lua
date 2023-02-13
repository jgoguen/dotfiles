local M = {
	'roobert/statusline-action-hints.nvim',
	after = 'lualine.nvim',
}

function M.config()
	require('statusline-action-hints').setup({
		definition_identifier = 'gd',
		template = '%s ref:%s',
	})
end

return M
