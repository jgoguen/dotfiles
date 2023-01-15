local M = {
	'hrsh7th/nvim-cmp',
	after = {'LuaSnip', 'lspkind.nvim'},
}

function M.config()
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	local lspkind = require('lspkind')
	local utils = require('jgoguen.utils')
	local border_opts = {
		border = 'single',
		winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
	}

	cmp.setup({
		enabled = function()
			local ctx = require('cmp.config.context')

			-- Always enabled in command mode
			if vim.api.nvim_get_mode().mode == 'c' then
				return true
			end

			-- Disable in comment contexts
			return not ctx.in_treesitter_capture("comment") and not ctx.in_syntax_group("Comment")
		end,
		preselect = cmp.PreselectMode.None,
		formatting = {
			fields = {'kind', 'abbr', 'menu'},
			format = lspkind.cmp_format(utils.lspkind_opts()),
		},
		snippet = {
			expand = function(args) luasnip.lsp_expand(args.body) end,
		},
		duplicates = {
			nvim_lsp = 1,
			luasnip = 1,
			cmp_tabnine = 1,
			buffer = 1,
			path = 1,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = cmp.config.window.bordered(border_opts),
			documentation = cmp.config.window.bordered(border_opts),
		},
		mapping = {
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
			['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), {'i', 'c'}),
			['<C-e>'] = cmp.mapping {
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			},
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
			['<C-j>'] = cmp.mapping.select_next_item {behavior = cmp.SelectBehavior.Insert},
			['<C-k>'] = cmp.mapping.select_prev_item {behavior = cmp.SelectBehavior.Insert},
			['<C-n>'] = cmp.mapping.select_next_item {behavior = cmp.SelectBehavior.Insert},
			['<C-p>'] = cmp.mapping.select_prev_item {behavior = cmp.SelectBehavior.Insert},
			['<C-y>'] = cmp.config.disable,
			['<Esc>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<Up>'] = cmp.mapping.select_prev_item {behavior = cmp.SelectBehavior.Select},
			['<Down>'] = cmp.mapping.select_next_item {behavior = cmp.SelectBehavior.Select},
			['<CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, {
				'i',
				's',
			}),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				'i',
				's',
			}),
		},
	})

	cmp.setup.cmdline(
		{'/', '?'},
		{
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources(
				{
					{name = 'nvim_lsp_document_symbol'},
				},
				{
					{name = 'buffer'},
				}
			),
		}
	)
	cmp.setup.cmdline(
		':',
		{
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources(
				{
					{name = 'path'},
				},
				{
					{name = 'cmdline'},
				}
			),
		}
	)
end

return M
