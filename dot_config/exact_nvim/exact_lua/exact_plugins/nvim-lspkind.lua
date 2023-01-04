local M = {
	'onsails/lspkind.nvim',
}

function M.config()
	local utils = require('jgoguen.utils')
	require('lspkind').init(utils.lspkind_opts())
end

return M
