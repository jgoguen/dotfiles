local M = {
	'williamboman/mason-lspconfig.nvim',
	after = 'nvim-lspconfig',
}

function M.config()
	require('mason-lspconfig').setup({
		automatic_installation = true,
		ensure_installed = {
			'ansiblels',
			'bashls',
			'csharp_ls',
			'cssls',
			'html',
			'jsonls',
			'prosemd_lsp',
			'solargraph',
			'sumneko_lua',
			'texlab',
			'tsserver',
			'vimls',
			'yamlls',
		},
	})
end

return M
