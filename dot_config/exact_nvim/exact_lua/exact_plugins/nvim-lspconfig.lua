local M = {
	'neovim/nvim-lspconfig',
	module = 'lspconfig',
}

function M.config()
	local servers = require('lsp.servers')
	servers.setup()
end

return M
