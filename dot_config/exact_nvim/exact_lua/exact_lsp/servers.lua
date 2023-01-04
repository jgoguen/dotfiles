local lsputils = require('jgoguen.lsputils')
local default_config = {
	on_attach = lsputils.on_attach,
	capabilities = lsputils.capabilities,
}
local M = {
	'ansiblels',
	'clangd',
	'jsonls',
	'prosemd_lsp',
	'pyright',
	'solargraph',
	'sumneko_lua',
	'yamlls',
}

local server_setup = function(server_name)
	local has_config, config = pcall(require, 'lsp.servers.' .. server_name)
	config = has_config and config or {}
	vim.tbl_deep_extend('force', config, default_config)

	local server = require('lspconfig')[server_name]
	server.setup(config)
end

function M.setup(server)
	server = server or nil
	if server and server ~= '' then
		server_setup(server)
	else
		for _, server_name in ipairs(M) do
			server_setup(server_name)
		end
	end
end

return M
