-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'folke/which-key.nvim',
	opts = function(_, opts)
		opts['plugins'] = opts['plugins'] or {}
		opts['win'] = opts['win'] or {}

		opts['plugins']['marks'] = false
		opts['win']['border'] = 'double'
	end,
}

return M
