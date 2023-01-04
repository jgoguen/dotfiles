local M = {
	'neovim/nvim-lspconfig',
}

function M.config()
	local servers = require('lsp.servers')
	servers.setup()
end

return M
