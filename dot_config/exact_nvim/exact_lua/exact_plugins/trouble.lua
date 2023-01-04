local M = {
	'folke/trouble.nvim',
	requires = {
		'folke/lsp-colors.nvim',
	},
}

function M.config()
	local utils = require('jgoguen.utils')
	require('trouble').setup({
		fold_closed = utils.get_icon('FoldClosed'),
		fold_open = utils.get_icon('FoldOpen'),
		open_split = { '<C-x>', 's' },
		open_vsplit = { '<C-v>', 'i', 'v' },
		open_tab = { '<C-t>', 't' },
		auto_open = true,
		auto_close = true,
		auto_preview = false,
		use_diagnostic_signs = true,
	})
end

return M
