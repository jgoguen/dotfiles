-- Do not edit this file directly! It is managed by chezmoi.

vim.opt_local.includeexpr = 'import#PythonImport(v:fname)'
vim.opt_local.spell = false

if vim.fn.filereadable(vim.fn.getcwd() .. '/venv/bin/python3') == 1 then
	vim.g.python3_host_prog = vim.fn.getcwd() .. '/venv/bin/python3'
end
