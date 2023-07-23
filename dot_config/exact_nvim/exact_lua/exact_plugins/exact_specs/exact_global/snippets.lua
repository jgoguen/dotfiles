-- Do not edit this file directly! It is managed by chezmoi.

local Utils = require('utils')

local border_opts = {
	border = 'single',
	winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
}

local M = {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'evesdropper/luasnip-latex-snippets.nvim',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-emoji',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'hrsh7th/cmp-path',
		{
			'L3MON4D3/LuaSnip',
			build = 'make install_jsregexp',
		},
		'onsails/lspkind.nvim',
		'rafamadriz/friendly-snippets',
		'saadparwaiz1/cmp_luasnip',
		'windwp/nvim-autopairs',
	},
	enabled = Utils.has_tool('make'),
	opts = {
		autopairs = {
			check_ts = true,
			ts_config = {
				java = false,
			},
			fast_wrap = {
				map = '<M-e>',
				chars = { '{', '[', '(', '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
				offset = 0,
				end_key = '$',
				keys = 'qwertyuiopzxcvbnmasdfghjkl',
				check_comma = true,
				highlight = 'PmenuSel',
				highlight_grey = 'LineNr',
			},
		},
	},
}

function M.config(_, opts)
	local Cmp = require('cmp')

	-- Base nvim-cmp
	Cmp.setup({
		enabled = function()
			-- Always disabled in command mode
			if vim.api.nvim_get_mode().mode == 'c' then
				return false
			end

			-- Disable in comment contexts
			local Ctx = require('cmp.config.context')
			return not Ctx.in_treesitter_capture("comment") and not Ctx.in_syntax_group("Comment")
		end,
		preselect = Cmp.PreselectMode.None,
		formatting = {
			fields = { 'kind', 'abbr', 'menu' },
			format = require('lspkind').cmp_format(require('utils').lspkind_opts()),
		},
		snippet = {
			expand = function(args) require('luasnip').lsp_expand(args.body) end,
		},
		sorting = {
			comparators = {
				Cmp.config.compare.sort_text,
				Cmp.config.compare.offset,
				Cmp.config.compare.exact,
				Cmp.config.compare.score,
				Cmp.config.compare.recently_used,
				Cmp.config.compare.locality,
				Cmp.config.compare.kind,
				Cmp.config.compare.length,
				Cmp.config.compare.order,
			},
		},
		duplicates = {
			nvim_lsp = 1,
			luasnip = 1,
			cmp_tabnine = 1,
			buffer = 1,
			path = 1,
		},
		confirm_opts = {
			behavior = Cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = Cmp.config.window.bordered(border_opts),
			documentation = Cmp.config.window.bordered(border_opts),
		},
		mapping = {
			['<C-Space>'] = Cmp.mapping(Cmp.mapping.complete(), { 'i', 'c' }),
			['<C-b>'] = Cmp.mapping(Cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-d>'] = Cmp.mapping(Cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
			['<C-e>'] = Cmp.mapping {
				i = Cmp.mapping.abort(),
				c = Cmp.mapping.close(),
			},
			['<C-f>'] = Cmp.mapping(Cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-j>'] = Cmp.mapping.select_next_item { behavior = Cmp.SelectBehavior.Insert },
			['<C-k>'] = Cmp.mapping.select_prev_item { behavior = Cmp.SelectBehavior.Insert },
			['<C-n>'] = Cmp.mapping.select_next_item { behavior = Cmp.SelectBehavior.Insert },
			['<C-p>'] = Cmp.mapping.select_prev_item { behavior = Cmp.SelectBehavior.Insert },
			['<C-y>'] = Cmp.config.disable,
			['<Esc>'] = Cmp.mapping({
				i = Cmp.mapping.abort(),
				c = Cmp.mapping.close(),
			}),
			['<Up>'] = Cmp.mapping.select_prev_item { behavior = Cmp.SelectBehavior.Select },
			['<Down>'] = Cmp.mapping.select_next_item { behavior = Cmp.SelectBehavior.Select },
			['<CR>'] = Cmp.mapping.confirm({
				behavior = Cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			['<Tab>'] = require('cmp').mapping(function(fallback)
				local Luasnip = require('luasnip')
				if Cmp.visible() then
					Cmp.select_next_item()
				elseif Luasnip.expandable() then
					Luasnip.expand()
				elseif Luasnip.expand_or_jumpable() then
					Luasnip.expand_or_jump()
				else
					fallback()
				end
			end, {
				'i',
				's',
			}),
			['<S-Tab>'] = require('cmp').mapping(function(fallback)
				local Luasnip = require('luasnip')
				if Cmp.visible() then
					Cmp.select_prev_item()
				elseif Luasnip.jumpable(-1) then
					Luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				'i',
				's',
			}),
		},
	})

	-- Begin autopairs
	local Autopairs = require('nvim-autopairs')
	local AutopairCmp = require('nvim-autopairs.completion.cmp')
	local AutopairRule = require('nvim-autopairs.rule')
	local AutopairCond = require('nvim-autopairs.conds')
	local AutopairHandlers = require('nvim-autopairs.completion.handlers')
	local TSUtils = require('utils.treesitter')
	Autopairs.setup(opts.autopairs)

	for _, p in ipairs({ ',', ';' }) do
		Autopairs.add_rules({
			-- Move past comma and semi-colon
			AutopairRule('', p)
					:with_move(function(rule_opts) return rule_opts.char == p end)
					:with_pair(function() return false end)
					:with_del(function() return false end)
					:with_cr(function() return false end)
					:use_key(p)
		})
	end

	Autopairs.add_rules({
		-- Add space before equals
		AutopairRule('=', '')
				:with_pair(AutopairCond.not_inside_quote())
				:with_pair(AutopairCond.not_filetypes({
					'conf',
					'html',
					'sh',
					'snippets',
					'TelescopePrompt',
					'template',
					'tmux',
					'vim',
					'xhtml',
					'xml',
					'zsh',
				}))
				:with_pair(TSUtils.node_or_parent_is_not({
					'argument_list',
					'keyword_argument',
				}))
				:with_pair(function(rule_opts)
					local last_char = rule_opts.line:sub(rule_opts.col - 1, rule_opts.col - 1)
					if last_char:match('[%w%=%s]') then
						return true
					end
					return false
				end)
				:replace_endpair(function(rule_opts)
					local prev_chars = rule_opts.line:sub(rule_opts.col - 2, rule_opts.col - 1)
					local next_char = rule_opts.line:sub(rule_opts.col, rule_opts.col)
					next_char = next_char == ' ' and '' or ' '

					if prev_chars:match('%w$') then
						return '<BS> =' .. next_char
					end
					if prev_chars:match('%=$') then
						return next_char
					end
					if prev_chars:match('=') then
						return '<BS><BS>=' .. next_char
					end

					return ''
				end)
				:set_end_pair_length(0)
				:with_move(AutopairCond.none())
				:with_del(AutopairCond.none()),
		AutopairRule('<', '>')
				:with_pair(AutopairCond.before_regex('%a+'))
		---@diagnostic disable-next-line: redefined-local
				:with_move(function(opts)
					return opts.char == '>'
				end),
	})

	Cmp.event:on(
		'confirm_done',
		AutopairCmp.on_confirm_done({
			filetypes = {
				['*'] = {
					['('] = {
						kind = {
							Cmp.lsp.CompletionItemKind.Function,
							Cmp.lsp.CompletionItemKind.Method,
						},
						handler = AutopairHandlers["*"]
					},
				},
				latex = false,
				tex = false,
			},
		})
	)
	-- End autopairs

	-- Luasnip sources
	local Luasnip = require('luasnip')
	for _, lang in ipairs({ 'chef', 'editorconfig', 'go', 'python', 'sh', 'all' }) do
		Luasnip.add_snippets(lang, require('config.snippets.' .. lang), { key = lang })
	end

	for _, load_type in ipairs { 'vscode', 'snipmate', 'lua' } do
		local Loader = require('luasnip.loaders.from_' .. load_type)
		if load_type == 'snipmate' then
			Loader.load()
		else
			Loader.lazy_load()
		end
	end

	-- Add sources to cmp
	local sources = {
		'buffer',
		'emoji',
		'luasnip',
		'nvim_lsp',
		'nvim_lsp_signature_help',
		'path',
	}
	for _, source in ipairs(sources) do
		Utils.add_cmp_source(Utils.get_cmp_source(source))
	end
end

return M
