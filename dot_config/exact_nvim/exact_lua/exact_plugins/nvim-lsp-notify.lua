local M = {
	'mrded/nvim-lsp-notify',
	after = 'nvim-notify',
}

function M.config()
	require('lsp-notify').setup({})
end

return M
