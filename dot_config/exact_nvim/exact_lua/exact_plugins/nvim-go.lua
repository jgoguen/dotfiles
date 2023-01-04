local M = {
	'crispgm/nvim-go',
	ft = {'go'},
}

function M.config()
	require('go').setup({
		auto_lint = false,
		formatter = 'gofmt',
	})
end

return M
