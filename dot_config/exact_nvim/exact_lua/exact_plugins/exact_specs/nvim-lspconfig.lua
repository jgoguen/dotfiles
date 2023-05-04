-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'hrsh7th/cmp-nvim-lsp',
	},
}

function M.config()
	local has_registry, registry = pcall(require, 'mason-registry')
	if not has_registry then
		return
	end
	local server_mappings = require('utils.lsp.mapping').package_to_lspconfig

	for _, package_name in ipairs(registry.get_installed_package_names()) do
		require('utils.lsp').setup(server_mappings[package_name])
	end
end

return M
