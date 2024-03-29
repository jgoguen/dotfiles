-- Do not edit this file directly! It is managed by chezmoi.

local MasonUtils = require('utils.mason')
local TSUtils = require('utils.treesitter')

vim.opt_local.expandtab = true
vim.opt_local.spell = false
vim.opt_local.textwidth = 120

TSUtils.ensure_installed('yaml')
MasonUtils.ensure_installed('ansiblels')
