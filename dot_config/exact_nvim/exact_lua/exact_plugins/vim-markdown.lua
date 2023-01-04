local M = {
	'plasticboy/vim-markdown',
	requires = {
		'godlygeek/tabular',
		'vim-pandoc/vim-pandoc-syntax',
	},
	ft = {'markdown', 'pandoc.markdown'},
}

function M.setup()
	vim.g.vim_markdown_math = 1
	vim.g.vim_markdown_frontmatter = 1
	vim.g.vim_markdown_strikethrough = 1
	vim.g.vim_markdown_autowrite = 1
end

return M
