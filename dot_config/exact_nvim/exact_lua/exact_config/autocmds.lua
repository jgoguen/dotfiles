-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local Utils = require('utils')

-- Close certain filetypes with just 'q'. This should match what LazyVim already does, but for additional file types not
-- in LazyVim's list.
vim.api.nvim_create_autocmd('FileType', {
	group = Utils.augroup('close_with_q'),
	pattern = {
		'diagmsg',
		'fzf',
		'neo-tree',
		'nofile',
		'null-ls-info',
		'query',
		'snacks_picker_list',
		'Trouble',
	},
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.schedule(function()
			Utils.set_keymap('n', 'q', function()
				vim.cmd('close')
				pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
			end, {
				buffer = ev.buf,
				desc = 'Quit buffer',
			})
		end)
	end,
})

-- Strip trailing whitespace on save unless disabled
vim.api.nvim_create_autocmd('BufWritePre', {
	group = Utils.augroup('strip_trailing_whitespace'),
	callback = function(ev)
		if vim.b[ev.buf].skip_whitespace_strip then
			return
		end

		local viewdata = vim.fn.winsaveview()
		vim.api.nvim_exec2([[keepjumps keeppatterns silent! %s/\v\s+$//e]], { output = false })
		vim.fn.winrestview(viewdata)
	end,
})

-- Organize imports on save unless disabled
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = { '*.go', '*.py', '*.rs' },
	callback = function(ev)
		if vim.b[ev.buf].skip_organize_imports then
			return
		end

		require('utils.lsp').organize_imports()
	end,
})

-- Flush the log queue on VimLeavePre
vim.api.nvim_create_autocmd('VimLeavePre', {
	group = Utils.augroup('flush_log_queue'),
	callback = function()
		Utils.flush_debug_log()
	end,
})

-- org-mode "meta return"
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'neorg',
	callback = function()
		vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
			silent = true,
			buffer = true,
		})

		local HasOrgHyperlink, OrgHyperlink = pcall(require, 'orgmode.org.links.hyperlink')
		if HasOrgHyperlink then
			vim.keymap.set('n', '<CR>', function()
				local TSUtils = require('utils.treesitter')
				if TSUtils.node_or_any_parent_is('listitem') then
					Utils.log_immediate('In listitem, checking for link')
					Utils.log_immediate('Current node type: ' .. vim.treesitter.get_node():type())
					local link_desc = TSUtils.find_child_of_type('link_desc')

					-- Could be that we're lower in the tree so we need a parent
					if link_desc == nil then
						Utils.log_immediate('No link child found, checking parents')
						link_desc = TSUtils.find_parent_of_type('link_desc')
					end

					-- Could be that it's one of the sibling nodes that has the link_desc
					if link_desc == nil then
						Utils.log_immediate('No link parent found, checking siblings')
						local node = vim.treesitter.get_node():parent()
						if node ~= nil then
							Utils.log_immediate('Parent node type: ' .. node:type())
							link_desc = TSUtils.find_child_of_type('link_desc', node)
						end
					end

					if link_desc ~= nil then
						Utils.log_immediate('Found link_desc, trying to open link')
						local link = OrgHyperlink.from_node(link_desc, vim.api.nvim_get_current_buf())
						local Org = require('orgmode')
						Utils.log_immediate('Opening link: ' .. link.url:to_string())
						vim.schedule(function()
							if Org.links:follow(link.url:to_string()) then
								Utils.log_immediate('Link opened successfully')
							else
								Utils.log_immediate('Failed to open link')
								vim.notify('Could not open link: ' .. link.url:to_string(), vim.log.levels.WARN)
							end
						end)
						return ''
					end
				end

				Utils.log_immediate('Not in listitem or no link found, inserting newline')
				return '<CR>'
			end, { buffer = true, noremap = true, silent = true, expr = true })
		end
	end,
})
