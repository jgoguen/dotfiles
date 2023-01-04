local M = {
	'NvChad/nvim-colorizer.lua',
}

function M.config()
	require('colorizer').setup()
end

return M
