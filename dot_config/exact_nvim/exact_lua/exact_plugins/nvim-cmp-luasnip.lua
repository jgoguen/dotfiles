local M = {
	'saadparwaiz1/cmp_luasnip',
	after = 'nvim-cmp',
}

function M.config()
	local utils = require('jgoguen.utils')
	utils.add_cmp_source(utils.get_cmp_source('luasnip'))
end

return M
