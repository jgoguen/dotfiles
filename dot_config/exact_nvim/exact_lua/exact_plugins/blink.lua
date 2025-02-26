-- Do not edit this file directly! It is managed by chezmoi.

local Utils = require('utils')

local M = {
	{
		'saghen/blink.cmp',
		opts = function(_, opts)
			local new_opts = {
				completion = {
					ghost_text = {
						enabled = true,
					},
					menu = {
						draw = {
							columns = {
								{ 'item_idx' },
								{ 'kind_icon', 'kind' },
								{ 'label', 'label_description' },
							},
						},
					},
				},
				keymap = {
					['<A-1>'] = {
						function(cmp)
							cmp.accept({ index = 1 })
						end,
					},
					['<A-2>'] = {
						function(cmp)
							cmp.accept({ index = 2 })
						end,
					},
					['<A-3>'] = {
						function(cmp)
							cmp.accept({ index = 3 })
						end,
					},
					['<A-4>'] = {
						function(cmp)
							cmp.accept({ index = 4 })
						end,
					},
					['<A-5>'] = {
						function(cmp)
							cmp.accept({ index = 5 })
						end,
					},
					['<A-6>'] = {
						function(cmp)
							cmp.accept({ index = 6 })
						end,
					},
					['<A-7>'] = {
						function(cmp)
							cmp.accept({ index = 7 })
						end,
					},
					['<A-8>'] = {
						function(cmp)
							cmp.accept({ index = 8 })
						end,
					},
					['<A-9>'] = {
						function(cmp)
							cmp.accept({ index = 9 })
						end,
					},
					['<A-0>'] = {
						function(cmp)
							cmp.accept({ index = 10 })
						end,
					},
				},
				signature = {
					enabled = true,
				},
			}

			opts = vim.tbl_deep_extend('force', opts, new_opts)
			opts.enabled = function()
				return not (
					vim.tbl_contains(Utils.excluded_buftypes, vim.bo.buftype)
					or vim.tbl_contains(Utils.excluded_filetypes, vim.bo.filetype)
				)
			end
		end,
	},
}

return M
