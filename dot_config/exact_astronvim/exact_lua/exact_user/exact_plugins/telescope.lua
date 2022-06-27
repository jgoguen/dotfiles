local actions = require('telescope.actions')

return {
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-s>"] = actions.select_vertical,
				["<C-i>"] = actions.select_horizontal,
			},
			n = {
				["s"] = actions.select_vertical,
				["i"] = actions.select_horizontal,
				["t"] = actions.select_tab,
			},
		},
		vimgrep_arguments = {
			"rg", "--color=never", "--no-heading", "--with-filename",
			"--line-number", "--column", "--smart-case", "--trim",
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			hidden = true,
		},
	},
	extensions = {
		project = {
			hidden_files = true,
		},
	},
}
