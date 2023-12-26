-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'RRethy/nvim-treesitter-endwise',
		'windwp/nvim-ts-autotag',
	},
	opts = function(_, opts)
		opts.highlight.additional_vim_regex_highlighting = { 'markdown', 'pandoc.markdown' }
		opts.autotag = { enable = true }
		opts.endwise = { enable = true }
		for _, p in ipairs({ 'comment' }) do
			table.insert(opts.ensure_installed, p)
		end
	end,
}

return M
