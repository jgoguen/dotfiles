-- Do not edit this file directly! It is managed by chezmoi.

local Utils = require('utils')

local M = {
	'williamboman/mason.nvim',
	build = ':MasonUpdate',
	opts = {
		ui = {
			icons = {
				package_installed = Utils.get_icon('Check'),
				package_uninstalled = Utils.get_icon('X'),
				packge_pending = Utils.get_icon('Reload'),
			},
		},
		border = 'rounded',
	},
}

return M
