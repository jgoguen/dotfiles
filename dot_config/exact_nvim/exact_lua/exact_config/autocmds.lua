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
		vim.cmd('tabdo wincmd =')
	end,
})

-- Close when buffer is in the last open window
vim.api.nvim_create_autocmd('WinEnter', {
	group = Utils.augroup('last_window_close'),
	callback = function(ev)
		local autoclose_types = {
			'nofile',
			'prompt',
			'quickfix',
			'trouble',
		}

		local wins = vim.api.nvim_list_wins()
		local wins_to_close = {} ---@type integer[]

		for _, winid in ipairs(wins) do
			local bufid = vim.api.nvim_win_get_buf(winid)
			local ok, buftype = pcall(vim.api.nvim_get_option_value, 'buftype', { buf = bufid })
			if ok and buftype then
				for _, candidate in ipairs(autoclose_types) do
					if buftype == candidate then
						table.insert(wins_to_close, winid)
						break
					end
				end
			end
		end

		-- If the length of the windows to close list is the same as the window list, we can just exit.
		if #wins == #wins_to_close then
			vim.cmd('qa')
		end
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
