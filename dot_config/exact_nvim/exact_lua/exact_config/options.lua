-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local Utils = require('utils')

local settings = {
	opt = {
		-- Write modified buffers when the buffer becomes hidden
		autowriteall = true,

		-- Don't stop backspace at insert, C-w and C-u do not stop
		-- at start of insert
		backspace = vim.opt.backspace + { 'nostop' },

		-- Yank/Delete to the "*" register, do not use the system clipboard
		clipboard = vim.env.SSH_TTY and '' or 'unnamed',

		-- Use 2 lines for the command area at the bottom of the screen
		cmdheight = 2,

		-- Highlight the column after 'textwidth'
		colorcolumn = '+1',

		-- Include current and included files for completion
		complete = vim.opt.complete + { 'd' },

		-- Keep concealing in normal and command editing mode
		concealcursor = 'nc',

		-- Open diffs in vertical splits
		diffopt = vim.opt.diffopt + { 'vertical' },

		-- Default to tabs instead of spaces
		expandtab = false,

		-- Set characters for filling
		fillchars = {
			vert = '┃',
			fold = ' ',
			diff = '-',
			eob = ' ',
			msgsep = '‾',
		},

		-- A fold must have at least this many lines
		foldminlines = 3,

		-- Set formatting options
		-- t: Auto-wrap text using textwidth
		-- c: Auto-wrap comments using textwidth, and insert the comment leader
		-- q: Allow formatting comments with `gq`
		-- n: Recognize numbered lists when formatting
		-- m: Break at multibyte characters above 255
		-- M: Don't insert a space before/after multibyte characters
		-- 1: Break a line before a one-letter word instead of after
		-- j: Remove a comment leader when joining lines if it makes sense
		-- l: Do not format lines longer before inserting
		formatoptions = 'tcqnmM1jl',

		grepformat = '%f:%l:%c:%m',
		grepprg = 'rg --vimgrep --no-heading --smart-case --hidden --no-ignore',

		-- Show a global status line
		laststatus = 3,

		-- listchars options
		-- tab:xy - Print x, then y as many times as possible in the tab space
		-- trail - Character to show for trailing spaces
		-- extends - Character to show when 'wrap' is off and line extends off-screen
		-- precedes - Character to show when line extends left off screen
		-- nbsp - Character to show for a non-breakable space
		-- conceal - Character to show for concealed text when conceallevel is 1
		listchars = {
			tab = '  ',
			trail = '•',
			extends = '»',
			precedes = '«',
			nbsp = '✖',
			conceal = '≠',
		},

		-- Add matching pairs (% jumps between pairs)
		matchpairs = vim.opt.matchpairs + {
			'<:>',
			'「:」',
			'『:』',
			'【:】',
			'“:”',
			'‘:’',
			'《:》',
			"':'",
			'":"',
		},

		-- Disable mouse support
		mouse = '',

		sessionoptions = vim.opt.sessionoptions + { 'localoptions', 'options' },

		-- Do not write a shada/viminfo file
		shadafile = 'NONE',

		-- Shorten messages
		-- m - Use [+] instead of [modified]
		-- r - Use [RO] instead of [readonly]
		shortmess = vim.opt.shortmess + {
			m = true,
			r = true,
		},

		-- When a bracket is inserted, briefly show the matching bracket if it's
		-- visible
		showmatch = true,

		-- Show the sign column, allow up to 3 characters
		signcolumn = 'auto:3',

		-- Set a spell file
		spellfile = vim.fn.stdpath('data') .. '/spell.utf8.add',

		-- Properly spell check camelCase words
		spelloptions = vim.opt.spelloptions + { 'camel' },

		-- Keep the same top line when opening or closing splits
		splitkeep = 'topline',

		-- Do not use swap files
		swapfile = false,

		-- Follow ignorecase and smartcase when searching tags files
		tagcase = 'followscs',

		-- Maximum width of text 80 columns default
		textwidth = 80,

		-- Milliseconds until CursorHold is triggered
		updatetime = 100,

		whichwrap = vim.opt.whichwrap + {
			['<'] = true,
			['>'] = true,
			['['] = true,
			[']'] = true,
		},

		-- Do not write backup files
		writebackup = false,
	},
	g = {
		-- Do not use an AI source for autocompletion if it's supported
		ai_cmp = false,

		mapleader = '`',
		maplocalleader = '\\',

		latex_to_unicode_auto = 1,
		markdown_recommended_style = 0,

		loaded_node_provider = 0,
		loaded_perl_provider = 0,

		lazyvim_picker = 'snacks',
		lazyvim_python_lsp = 'basedpyright',
		lazyvim_python_ruff = 'ruff',

		-- Python3 or bust
		python_highlight_all = true,
		python_highlight_file_headers_as_comments = true,
		python3_host_prog = Utils.python_executable(),
		python_version = 'python3',

		-- Spec used by LazyVim to detect the root directory. Entries are one of:
		-- - The name of a detector function
		--   - See https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/root.lua
		-- - A pattern or list of patterns of file or directory names only found in the root directory
		-- - A function with signature `function(bufnum): string|string[]`
		root_spec = {
			'lsp',
			{
				'.git',
				'.hg',
				'lua',
				'go.mod',
				'go.sum',
				'BAZEL.module',
				'pyproject.toml',
				'hugo.toml',
				'Cargo.toml',
				'requirements.txt',
			},
			function(buf)
				local ok, path = pcall(LazyVim.root.bufpath, buf)
				if ok and path ~= nil and path ~= "" then
					return vim.fs.dirname(path)
				end
				return LazyVim.root.cwd()
			end,
		},
	},
}

if vim.fn.has('win32') == 1 then
	settings['opt']['shell'] = Utils.has_tool('pwsh.exe') and 'pwsh.exe' or 'powershell.exe'
end

for scope, opts in pairs(settings) do
	for setting, value in pairs(opts) do
		vim[scope][setting] = value
	end
end

if vim.fn.filereadable(XDG_CONFIG_HOME .. '/vim-local.vim') ~= 0 then
	vim.cmd('source ' .. XDG_CONFIG_HOME .. '/vim-local.vim')
end

if vim.fn.filereadable(XDG_CONFIG_HOME .. '/vim-local.lua') ~= 0 then
	vim.cmd('source ' .. XDG_CONFIG_HOME .. '/vim-local.lua')
end
