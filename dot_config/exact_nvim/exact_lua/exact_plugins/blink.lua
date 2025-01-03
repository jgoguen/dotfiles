-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	{
		'saghen/blink.cmp',
		-- dependencies = {
		-- 	{ 'L3MON4D3/LuaSnip' },
		-- },
		opts = function(_, opts)
			local HasLuasnip, Luasnip = pcall(require, 'luasnip')

			if HasLuasnip then
				opts['snippets'] = opts['snippets'] or {}
				vim.tbl_deep_extend('force', opts['snippets'], {
					expand = function(snippet)
						Luasnip.lsp_expand(snippet)
					end,
					active = function(filter)
						if filter and filter.direction then
							return Luasnip.jumpable(filter.direction)
						end
						return Luasnip.in_snippet()
					end,
					jump = function(direction)
						Luasnip.jump(direction)
					end,
				})
			end
		end,
	},
}

return M
