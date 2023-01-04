local M = {
	'hrsh7th/cmp-emoji',
	after = 'nvim-cmp',
}

function M.config()
	local utils = require('jgoguen.utils')
	utils.add_cmp_source(utils.get_cmp_source('emoji'))
end

return M
