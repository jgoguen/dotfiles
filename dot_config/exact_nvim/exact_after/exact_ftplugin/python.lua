-- Do not edit this file directly! It is managed by chezmoi.

local TSUtils = require('utils.treesitter')

vim.opt_local.includeexpr = 'import#PythonImport(v:fname)'
vim.opt_local.spell = false

TSUtils.ensure_installed('python')

local has_post, Post = pcall(require, 'ftplugin-post.' .. vim.opt.filetype:get())
if has_post then
	Post.setup()
end