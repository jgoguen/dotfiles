-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'folke/which-key.nvim',
	opts = function(_, opts)
		opts['plugins'] = opts['plugins'] or {}
		opts['window'] = opts['window'] or {}

		opts['plugins']['marks'] = false
		opts['window']['border'] = 'double'
	end,
}

return M
