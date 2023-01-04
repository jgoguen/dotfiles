local M = {
	'jayp0521/mason-null-ls.nvim',
	after = 'null-ls.nvim'
}

function M.config()
	local mason_null_ls = require('mason-null-ls')

	mason_null_ls.setup({
		automatic_installation = true,
		automatic_setup = true,
		ensure_installed = {
			'jq',
			'vale',
			'vint',
		},
	})

	mason_null_ls.setup_handlers()
end

return M
