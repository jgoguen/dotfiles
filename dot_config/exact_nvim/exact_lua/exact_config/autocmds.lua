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
			'quickfix',
			'nofile',
			'trouble',
		}
		local win_count = vim.fn.winnr('$')
		if win_count > 1 then
			return
		end

		for _, buftype in ipairs(autoclose_types) do
			if buftype == vim.bo[ev.buf].buftype then
				vim.cmd('q')
				return
			end
		end
	end,
})

-- Close certain filetypes with just 'q'
vim.api.nvim_create_autocmd('FileType', {
	group = Utils.augroup('close_with_q'),
	pattern = {
		'checkhealth',
		'help',
		'lspinfo',
		'man',
		'notify',
		'null-ls-info',
		'PlenaryTestPopup',
		'qf',
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

-- Treat all files in chezmoi source directory as chezmoi files
local HasChezmoiCommands, _ = pcall(require, 'chezmoi.commands')
if HasChezmoiCommands then
	vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
		pattern = { os.getenv('HOME') .. '/.local/share/chezmoi/*' },
		callback = function()
			vim.schedule(require('chezmoi.commands.__edit').watch)
		end,
	})
end
