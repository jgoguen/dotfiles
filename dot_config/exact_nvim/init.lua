-- Set <Leader>
vim.g.mapleader = '`'
vim.g.maplocalleader = ']'

-- Store XDG_{CONFIG,DATA}_HOME for later reference
_G.XDG_CONFIG_HOME = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. '/.config'
_G.XDG_DATA_HOME = vim.env.XDG_DATA_HOME or vim.env.HOME .. '/.local/share'
vim.g.xdg_config_home = XDG_CONFIG_HOME
vim.g.xdg_data_home = XDG_DATA_HOME

local settings_paths = {
  "settings/*.vim",
  "settings/plugins/*.vim",
  "settings/post/*.vim",
}

if vim.fn.isdirectory(XDG_CONFIG_HOME .. '/vim-local') == 1 then
	vim.opt.rtp:append(XDG_CONFIG_HOME .. '/vim-local')
end

require('config.options')
require('plugins').setup()
require('config.keybindings').setup()

local has_inspect, inspect = pcall(require, 'inspect')
if has_inspect then
	_G.inspect = inspect
end

for _, glob in ipairs(settings_paths) do
	local settings = vim.fn.globpath(vim.o.runtimepath, glob, 0, 1)
	for _, f in ipairs(settings) do
		vim.cmd('source ' .. f)
	end
end

if vim.fn.filereadable(XDG_CONFIG_HOME .. '/vim-local.vim') ~= 0 then
	vim.cmd('source ' .. XDG_CONFIG_HOME .. '/vim-local.vim')
end

if vim.fn.filereadable(XDG_CONFIG_HOME .. '/vim-local.lua') ~= 0 then
	vim.cmd('source ' .. XDG_CONFIG_HOME .. '/vim-local.lua')
end
