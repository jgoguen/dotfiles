local M = {
	'williamboman/mason.nvim',
	module = 'mason',
}

function M.config()
	local utils = require('jgoguen.utils')
	require('mason').setup({
		ui = {
			icons = {
				package_installed = utils.get_icon('Check'),
				package_uninstalled = utils.get_icon('X'),
				packge_pending = utils.get_icon('Reload'),
			},
		},
		border = 'rounded',
	})
end

return M
