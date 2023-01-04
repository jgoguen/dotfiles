local M = {
	'jose-elias-alvarez/null-ls.nvim',
}

function M.config()
	local has_null_ls, null_ls = pcall(require, 'null-ls')
	if not has_null_ls then return end

	local utils = require('jgoguen.utils')
	local null_ls_utils = require('null-ls.utils')

	null_ls.setup({
		root_dir = null_ls_utils.root_pattern(utils.project_root_files),
		sources = {
			-- Code actions

			-- Diagnostics
			null_ls.builtins.diagnostics.vint,
			null_ls.builtins.diagnostics.zsh,

			-- Formatters
		},
	})
end

return M
