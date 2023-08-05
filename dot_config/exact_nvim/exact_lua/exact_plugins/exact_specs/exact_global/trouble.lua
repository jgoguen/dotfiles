-- Do not edit this file directly! It is managed by chezmoi.

local Utils = require('utils')

local M = {
	'folke/trouble.nvim',
	dependencies = {
		'folke/lsp-colors.nvim',
	},
	lazy = true,
	cmd = {
		'Trouble',
		'TroubleToggle',
		'TroubleRefresh',
	},
	opts = {
		icons = true,
		fold_closed = Utils.get_icon('FoldClosed'),
		fold_open = Utils.get_icon('FoldOpen'),
		open_split = { '<C-x>', 's' },
		open_vsplit = { '<C-v>', 'i', 'v' },
		open_tab = { '<C-t>', 't' },
		auto_open = true,
		auto_close = true,
		auto_preview = true,
		use_diagnostic_signs = true,
		signs = {
			error = Utils.get_icon('DiagnosticError'),
			warning = Utils.get_icon('DiagnosticWarn'),
			hint = Utils.get_icon('DiagnosticHint'),
			information = Utils.get_icon('DiagnosticInfo'),
		},
		severity = vim.diagnostic.severity.WARN,
	},
}

return M
