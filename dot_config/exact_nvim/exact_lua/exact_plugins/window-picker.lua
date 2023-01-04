local M = {
	's1n7ax/nvim-window-picker',
	tag = 'v1.*',
	module = 'window-picker',
}

function M.config()
	local window_picker = require('window-picker')
	local utils = require('jgoguen.utils')

	window_picker.setup({
		autoselect_one = true,
		include_current = true,
		filter_rules = {
			bo = {
				-- if the file type is one of following, the window will be ignored
				filetype = utils.excluded_filetypes,
				-- if the buffer type is one of following, the window will be ignored
				buftype = utils.excluded_buftypes,
			},
		},
	})
end

return M
