-- Do not edit this file directly! It is managed by chezmoi.

local MasonUtils = require('utils.mason')
local TSUtils = require('utils.treesitter')

vim.cmd('compiler jsonlint')

vim.opt_local.spell = false

vim.keymap.set(
	'n',
	'o',
	function()
		local line = vim.api.nvim_get_current_line()
		local needs_comma = line:find('[^,{[]$')

		if needs_comma then
			return 'A,<CR>'
		end
		return 'o'
	end,
	{ buffer = true, expr = true }
)

vim.cmd([[command! FormatJSON %!/usr/bin/env python3 -m json.tool]])

TSUtils.ensure_installed({ 'json', 'jsonc' })
MasonUtils.ensure_installed('jsonls')
