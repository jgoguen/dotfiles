-- Do not edit this file directly! It is managed by chezmoi.

local M = {}

function M.bootstrap()
	--local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
	local lazy_path = vim.fn.expand('~/Code/lazy.nvim')
	if not vim.loop.fs_stat(lazy_path) then
		vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'--depth=1',
		'https://github.com/folke/lazy.nvim.git',
		lazy_path,
	})
	end

	vim.opt.rtp:prepend(lazy_path)
end

function M.setup()
	local colorscheme = require('config.colorscheme')
	M.bootstrap()
	require('lazy').setup(
		'plugins.specs',
		{
			checker = {
				enabled = true,
			},
			dev = {
				path = '~/Code',
				fallback = true,
			},
			install = {
				colorscheme = {colorscheme.active_colorscheme},
			},
			lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',
			performance = {
				rtp = {
					paths = {
						XDG_CONFIG_HOME .. '/vim-local',
						vim.fn.stdpath('data') .. '/tree-sitter-parsers',
					},
				},
			},
		}
	)
end

return M
