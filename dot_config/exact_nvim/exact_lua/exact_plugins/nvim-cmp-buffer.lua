local M = {
	'hrsh7th/cmp-buffer',
	after = 'nvim-cmp',
}

function M.config()
	local utils = require('jgoguen.utils')
	utils.add_cmp_source(utils.get_cmp_source('buffer'))
end

return M
