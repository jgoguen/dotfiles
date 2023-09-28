-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-lualine/lualine.nvim',
	opts = function(_, opts)
		opts.options.disabled_filetypes = require('utils').excluded_filetypes

		table.insert(opts.sections.lualine_x, { 'filetype' })

		opts.sections.lualine_y = {
			{ 'progress', separator = ' ', padding = { left = 1, right = 0 } },
			{ '%l/%L' },
			{ '%v' },
			{ '%B' },
		}

		table.insert(opts.sections.lualine_z, 1, function()
			local f = io.popen('/bin/hostname -s')
			if f == nil then
				return ''
			end
			local hostname = f:read('*a') or ''
			f:close()
			hostname = string.gsub(hostname, '\n$', '')
			return hostname
		end)
	end,
}

return M
