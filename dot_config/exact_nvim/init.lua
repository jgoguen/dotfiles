-- Store XDG_{CONFIG,DATA}_HOME for later reference
_G.XDG_CONFIG_HOME = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. '/.config'
_G.XDG_DATA_HOME = vim.env.XDG_DATA_HOME or vim.env.HOME .. '/.local/share'
vim.g.xdg_config_home = XDG_CONFIG_HOME
vim.g.xdg_data_home = XDG_DATA_HOME

-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

local settings = vim.fn.globpath(vim.o.runtimepath, 'settings/*.vim', false, true)
if settings ~= nil then
	for _, f in ipairs(settings) do
		vim.cmd('source ' .. f)
	end
end

vim.cmd('helptags ALL')
