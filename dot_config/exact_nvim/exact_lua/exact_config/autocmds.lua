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
vim.g.jgoguen_last_window_close_debounce = nil
vim.api.nvim_create_autocmd({ 'BufDelete', 'BufUnload', 'BufWipeout' }, {
	group = Utils.augroup('last_window_close'),
	callback = function()
		Utils.log('Starting last_window_close check')
		if vim.g.jgoguen_last_window_close_debounce then
			Utils.log('Skipping, debounce active')
			return
		end

		vim.g.jgoguen_last_window_close_debounce = true
		vim.defer_fn(function()
			vim.g.jgoguen_last_window_close_debounce = nil

			local autoclose_buftypes = {
				help = true,
				nofile = true,
				prompt = true,
				quickfix = true,
				trouble = true,
			}
			local skip_filetypes = {
				snacks_dashboard = true,
			}

			local windows = vim.api.nvim_tabpage_list_wins(0)
			Utils.log('Checking windows: ' .. vim.inspect(windows))

			for _, winid in ipairs(windows) do
				Utils.log('Checking window: ' .. winid)
				local bufid = vim.api.nvim_win_get_buf(winid)

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
					if skip_filetypes[filetype] then
						Utils.log('Skipping buffer ' .. bufid .. ' due to filetype: ' .. filetype)
						return
					end

					if vim.api.nvim_get_option_value('buflisted', { buf = bufid }) then
						-- If the buftype is not in the autoclose_buftypes list, we won't be closing anything so just return early
						local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufid })
						Utils.log('Buffer ' .. bufid .. ' has buftype: ' .. buftype)
						if not autoclose_buftypes[buftype] then
							Utils.log('Skipping buffer ' .. bufid .. ' due to buftype: ' .. buftype)
							return
						end
					end
				end
			end

			-- If we reach this point, none of the buffers have a filetype that should be ignored and all of the buffers have
			-- a buftype that indicates we have no more user-active windows open. Now decide if we're closing the tab or the
			-- application.
			if #vim.api.nvim_list_tabpages() == 1 then
				Utils.log('Closing application, only one tabpage left')
				vim.cmd('qa')
			else
				Utils.log('Closing tab, multiple tabpages left')
				vim.cmd('tabclose')
			end
		end, 100)
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
	callback = Utils.flush_log_queue,
})
