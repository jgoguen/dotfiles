-- vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
-- vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:
-- Do not edit this file directly! It is managed by chezmoi.

local present, null_ls = pcall(require, 'null-ls')
if not present then
	return
end

local utils = require("null-ls.utils")

return {
	root_dir = utils.root_pattern("Makefile", ".git", ".hg"),
	sources = {
		-- Code actions [[[
		-- ]]]

		-- Diagnostics [[[
		null_ls.builtins.diagnostics.vint,
		null_ls.builtins.diagnostics.zsh,
		-- ]]]

		-- Formatters [[[
		-- ]]]
	},
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
}
