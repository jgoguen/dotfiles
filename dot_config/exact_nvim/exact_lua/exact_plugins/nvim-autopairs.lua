-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	{ 'echasnovski/mini.pairs', enabled = false },
	{
		'windwp/nvim-autopairs',
		event = { 'InsertEnter' },
		opts = {
			check_ts = true,
			-- enable_check_bracket_line = false,
			ts_config = {
				java = false,
			},
			fast_wrap = {
				map = '<A-e>',
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
		config = function(_, opts)
			local Autopairs = require('nvim-autopairs')
			local AutopairRule = require('nvim-autopairs.rule')
			local AutopairCond = require('nvim-autopairs.conds')
			local TSUtils = require('utils.treesitter')

			Autopairs.setup(opts)

			-- Add pre-defined rules
			Autopairs.add_rules(require('nvim-autopairs.rules.ts_basic').setup({
				enable_moveright = false,
				ignored_next_char = '%w',
				enable_check_bracket_line = false,
				enable_bracket_in_quote = false,
			}))
			Autopairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
			Autopairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

			for _, p in ipairs({ ',', ';' }) do
				Autopairs.add_rules({
					-- Move past comma and semi-colon
					AutopairRule('', p)
						:with_move(function(rule_opts)
							return rule_opts.char == p
						end)
						:with_pair(function()
							return false
						end)
						:with_del(function()
							return false
						end)
						:with_cr(function()
							return false
						end)
						:use_key(p),
				})
			end

			Autopairs.add_rules({
				-- Add space before equals
				AutopairRule('=', '')
					:with_pair(AutopairCond.not_inside_quote())
					:with_pair(AutopairCond.not_filetypes({
						'conf',
						'dockerfile',
						'html',
						'ldif',
						'sh',
						'snippets',
						'sshconfig',
						'TelescopePrompt',
						'template',
						'tmux',
						'vim',
						'xhtml',
						'xml',
						'yaml',
						'zsh',
					}))
					:with_pair(function(rule_opts)
						local expand_in_args_ft = { 'bzl' }
						if not vim.tbl_contains(expand_in_args_ft, vim.bo[rule_opts.bufnr].filetype) then
							if TSUtils.node_or_parent_is({ 'argument_list', 'keyword_argument' }) then
								return false
							end
						end
					end)
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

				-- Auto-pair <> for generics but not as greater-than/less-than
				AutopairRule('<', '>', { '-html', '-javascriptreact', '-typescriptreact' })
					-- %a+ means it will auto-pair on word characters followed by <, but not on something like 'a <'
					-- (::)? makes it work with Rust generics like 'my_func::<T>()'
					:with_pair(
						AutopairCond.before_regex('%a+(::)?$', 3)
					)
					:with_move(function(rule_opts)
						return rule_opts.char == '>'
					end),

				-- Try to handle triple-backticks
				AutopairRule('```', '```'):with_pair(AutopairCond.not_before_char('`', 3)),
				AutopairRule('```.*$', '```'):only_cr():use_regex(true),
			})
		end,
	},
}

return M
