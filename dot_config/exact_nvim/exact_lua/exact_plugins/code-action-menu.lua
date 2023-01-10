local M = {
	'weilbith/nvim-code-action-menu',
	cmd = 'CodeActionMenu',
}

function M.setup()
	vim.g.code_action_menu_window_border = 'double'
end

return M
