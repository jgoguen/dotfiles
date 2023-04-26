-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'hrsh7th/cmp-nvim-lsp',
	dependencies = {
		'hrsh7th/nvim-cmp',
	},
}

function M.config()
	local utils = require('utils')
	utils.add_cmp_source(utils.get_cmp_source('nvim_lsp'))
end

return M
