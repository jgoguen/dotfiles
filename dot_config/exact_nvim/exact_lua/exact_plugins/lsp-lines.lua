local M = {
	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
	after = 'nvim-lspconfig',
}

function M.config()
	require('lsp_lines').setup()
end

return M
