-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'akinsho/bufferline.nvim',
	opts = function(_, opts)
		local has_catppuccin, catppuccin = pcall(require, 'catppuccin.groups.integrations.bufferline')

		if has_catppuccin then
			opts.highlights = catppuccin.get()
		end
	end,
}

return M
