local M = {
	'pangloss/vim-javascript',
	ft = {'javascript'},
}

function M.setup()
	vim.g.javascript_plugin_jsdoc = 1
	vim.g.javascript_plugin_flow = 1
end

return M
