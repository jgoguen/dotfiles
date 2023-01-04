local M = {
	'vim-latex/vim-latex',
	ft = {'latex', 'tex'},
}

function M.setup()
	vim.g.tex_flavor = 'xelatex'
	vim.g.Tex_CompileRule_pdf = 'xelatex --interaction=nonstopmode $*'
end

return M
