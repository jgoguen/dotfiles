-- Do not edit this file directly! It is managed by chezmoi.

local MasonUtils = require('utils.mason')
local TSUtils = require('utils.treesitter')

vim.cmd('compiler ruby')

vim.opt_local.expandtab = true

TSUtils.ensure_installed('ruby')
MasonUtils.ensure_installed('solargraph')