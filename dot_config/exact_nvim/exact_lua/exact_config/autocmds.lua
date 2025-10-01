-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local Utils = require('utils')

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = Utils.augroup('text_yank_post'),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Handle terminal resizing
vim.api.nvim_create_autocmd('VimResized', {
	group = Utils.augroup('resizing'),
	callback = function()
		vim.defer_fn(function()
			vim.cmd('tabdo wincmd =')
		end, 100)
	end,
})

-- Close when buffer is in the last open window
vim.api.nvim_create_autocmd('QuitPre', {
	group = Utils.augroup('last_window_close'),
	callback = function(ev)
		Utils.log('Starting last_window_close check')

		local autoclose_buftypes = {
			help = true,
			nofile = true,
			prompt = true,
			quickfix = true,
			trouble = true,
		}
		local close_filetypes = {
			noice = true,
			snacks_layout_box = true,
			snacks_picker_input = true,
			snacks_picker_layout = true,
			snacks_picker_list = true,
		}

		local close_windows = {} ---@type integer[]
		local windows = vim.api.nvim_tabpage_list_wins(0)
		local current_win = vim.api.nvim_get_current_win()
		Utils.log('Checking windows: ' .. vim.inspect(windows))

		-- Try to find a reason to quit. Any buffer whose buftype is not in autoclose_buftypes or whose filetype is in
		-- skip_filetypes is an excuse to bail out early.
		for _, winid in ipairs(windows) do
			Utils.log('Checking window: ' .. winid)
			local bufid = vim.api.nvim_win_get_buf(winid)
			if bufid == ev.buf and winid == current_win then
				-- Don't consider the buffer that is being closed
				Utils.log('Skipping buffer ' .. bufid .. ' in window ' .. winid .. ' because it is being closed')
				goto continue
			end

			Utils.log('Checking buffer: ' .. bufid)
			Utils.log('Buffer ' .. bufid .. ' is loaded: ' .. tostring(vim.api.nvim_buf_is_loaded(bufid)))
			Utils.log(
				'Buffer ' .. bufid .. ' is listed: ' .. tostring(vim.api.nvim_get_option_value('buflisted', { buf = bufid }))
			)
			-- Only consider loaded buffers
			if vim.api.nvim_buf_is_loaded(bufid) then
				-- If the filetype is in the skip_filetypes list, we definitely won't be closing anything so just return early.
				-- Filetype is checked before buflisted because some buffers may be loaded but not listed. For example, The
				-- snacks.nvim dashboard.
				local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufid })
				Utils.log('Buffer ' .. bufid .. ' has filetype: ' .. filetype)
				if not close_filetypes[filetype] then
					Utils.log('Skipping buffer ' .. bufid .. ' due to filetype: ' .. filetype)
					return
				end

				if vim.api.nvim_get_option_value('buflisted', { buf = bufid }) then
					-- If the buftype is not in the autoclose_buftypes list, we won't be closing anything so just return early
					local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufid })
					Utils.log('Buffer ' .. bufid .. ' has buftype: ' .. buftype)
					if buftype ~= '' and not autoclose_buftypes[buftype] then
						Utils.log('Skipping buffer ' .. bufid .. ' due to buftype: ' .. buftype)
						return
					end
				end
			end

			-- If we get here, the window can be closed and we haven't detected any windows to prevent closing in any windows
			-- so far.
			table.insert(close_windows, winid)

			-- Keep this as the very last statement in the loop, because for some reason Lua doesn't want to add a proper
			-- continue statement.
			::continue::
		end

		-- If we reach this point, none of the buffers have a filetype that should be ignored and all of the buffers have
		-- a buftype that indicates we have no more user-active windows open. Close all remaining windows.
		Utils.log('Closing windows: ' .. vim.inspect(close_windows))
		for _, winid in ipairs(close_windows) do
			Utils.log('Closing window: ' .. winid)
			vim.api.nvim_win_close(winid, true)
		end

		Utils.log_immediate('Last windows closed successfully')
	end,
})

-- Close certain filetypes with just 'q'
vim.api.nvim_create_autocmd('FileType', {
	group = Utils.augroup('close_with_q'),
	pattern = {
		'checkhealth',
		'diagmsg',
		'fzf',
		'help',
		'lspinfo',
		'man',
		'neo-tree',
		'nofile',
		'notify',
		'null-ls-info',
		'PlenaryTestPopup',
		'qf',
		'query',
		'snacks_picker_list',
		'startuptime',
		'Trouble',
		'tsplayground',
	},
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		Utils.set_keymap('n', 'q', ':close<CR>', { buffer = ev.buf })
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
		Utils.flush_log_queue()
	end,
})

-- org-mode "meta return"
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'org',
	callback = function()
		vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
			silent = true,
			buffer = true,
		})
	end,
})
