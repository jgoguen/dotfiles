-- Do not edit this file directly! It is managed by chezmoi.

local MasonUtils = require('utils.mason')
local TSUtils = require('utils.treesitter')

TSUtils.ensure_installed({ 'lua', 'luadoc', 'luap' })
MasonUtils.ensure_installed('lua_ls')
