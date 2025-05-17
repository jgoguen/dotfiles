local M = {
	{
		"zbirenbaum/copilot.lua",
		opts = {
			root_dir = function()
				return LazyVim.root() or LazyVim.root.cwd()
			end,
			filetypes = {
				yaml = true,
			},
		},
	},
}

return M
