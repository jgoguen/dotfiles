local M = {}

function M.setup_markup_pairs()
	local TSUtils = require('utils.treesitter')

	vim.keymap.set('i', '=', TSUtils.html_attribute_equals, { buffer = true, expr = true })
	vim.keymap.set('i', '/', TSUtils.html_self_closing, { buffer = true, expr = true })
end

function M.setup_css_important_toggle()
	local Utils = require('utils')

	Utils.set_keymap('n', '<LocalLeader>i', function()
		local line = vim.fn.getline('.')
		if line:find('!important') then
			line = line:gsub(' !important', '')
		else
			line = line:gsub(';', ' !important;')
		end

		vim.fn.setline(vim.fn.line('.'), line)
	end, { buffer = true })
end

return M
