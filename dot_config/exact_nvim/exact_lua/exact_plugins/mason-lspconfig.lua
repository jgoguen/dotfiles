local M = {
	'williamboman/mason-lspconfig.nvim',
	after = 'nvim-lspconfig',
}

function M.config()
	local options = {
		automatic_installation = true,
	}
	local has_config, config = pcall(require, 'config.mason-lspconfig')
	if has_config then
		options = vim.tbl_deep_extend('force', options, config)
	end

	require('mason-lspconfig').setup(options)
end

return M
