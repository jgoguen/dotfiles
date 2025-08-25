local M = {
	{
		'zbirenbaum/copilot.lua',
		opts = {
			root_dir = function()
				return LazyVim.root() or LazyVim.root.cwd()
			end,
			filetypes = {
				norg = false,
				yaml = true,
			},
		},
	},
}

return M
