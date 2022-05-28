-- vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
-- vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:
-- Do not edit this file directly! It is managed by chezmoi.

local present, telescope = pcall(require, 'telescope')
if not present then
	return
end

local actions = require("telescope.actions")

telescope.setup({
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
})

telescope.load_extension('fzf')

vim.api.nvim_set_keymap(
	"n",
	"<Leader>t",
	[[<cmd>lua require('telescope.builtin').find_files()<CR>]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<Leader>b",
	[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
	{ noremap = true, silent = true }
)
