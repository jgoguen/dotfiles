-- Do not edit this file directly! It is managed by chezmoi.

local TSUtils = require('utils.treesitter')

vim.opt_local.cindent = false
vim.opt_local.expandtab = true
vim.opt_local.iskeyword:append(':')
vim.opt_local.spell = true

TSUtils.ensure_installed({ 'markdown', 'markdown_inline' })
