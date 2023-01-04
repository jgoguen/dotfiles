local M = {
	'hrsh7th/cmp-path',
	after = 'nvim-cmp',
}

function M.config()
	local utils = require('jgoguen.utils')
	utils.add_cmp_source(utils.get_cmp_source('path'))
end

return M
