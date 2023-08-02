-- Do not edit this file directly! It is managed by chezmoi.

local MasonUtils = require('utils.mason')
local TSUtils = require('utils.treesitter')

vim.cmd('compiler tex')

TSUtils.ensure_installed({ 'bibtex', 'latex' })
MasonUtils.ensure_installed('texlab')