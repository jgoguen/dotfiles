local M = {
	'pearofducks/ansible-vim',
	ft = {'ansible', 'yaml.ansible'},
}

function M.init()
	vim.g.ansible_unindent_after_newline = 1
	vim.g.ansible_extra_keywords_highlight = 1
end

return M
