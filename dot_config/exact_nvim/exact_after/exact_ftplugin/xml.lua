-- Do not edit this file directly! It is managed by chezmoi.

local TSUtils = require('utils.treesitter')

vim.keymap.set('i', '=', TSUtils.html_attribute_equals, { buffer = true, expr = true })
vim.keymap.set('i', '/', TSUtils.html_self_closing, { buffer = true, expr = true })

vim.cmd([[compiler xmllint]])
