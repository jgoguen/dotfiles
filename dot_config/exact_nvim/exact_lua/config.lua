-- Do not edit this file directly! It is managed by chezmoi.

local py3_venv = vim.fn.stdpath('data') .. '/venv/bin/python3'
local py3_path = vim.fn.resolve(vim.fn.exepath('python3'))

local M = {
	settings = {
		opt = {
			-- Write modified buffers when the buffer becomes hidden
			autowriteall = true,
			background = 'light',
			-- Don't stop backspace at insert, C-w and C-u do not stop
			-- at start of insert
			backspace = vim.opt.backspace + { 'nostop' },
			-- Use 2 lines for the command area at the bottom of the screen
			cmdheight = 2,
			-- Highlight the column after 'textwidth'
			colorcolumn = '+1',
			-- Include current and included files for completion
			complete = vim.opt.complete + { 'd' },
			-- Influence insert-mode completion
			completeopt = {
				'menuone',
				'noselect',
				'noinsert',
				'longest',
				'menu',
				'preview',
			},
			-- Concealed text is hidden unless there's a custom replacement character
			conceallevel = 2,
			-- Confirm instead of failing operations
			confirm = true,
			-- Highlight the line with the cursor
			cursorline = true,
			-- Open diffs in vertical splits
			diffopt = vim.opt.diffopt + { 'vertical' },
			-- Set characters for filling
			fillchars = {
				vert = '┃',
				fold = ' ',
				diff = '-',
				eob = ' ',
				msgsep = '‾',
			},
			foldexpr = 'nvim_treesitter#foldexpr()',
			-- Folds of a higher level will be closed when opening a file
			foldlevel = 2,
			-- Set custom fold markers
			foldmarker = '[[[,]]]',
			foldmethod = 'expr',
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
			formatoptions = 'tcqnmM1j',
			-- By defaut, ignore case when searching
			ignorecase = true,
			-- Show a global status line
			laststatus = 3,
			-- Configure list characters display (with listchars)
			list = true,
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
			-- Show line numbers
			number = true,
			-- Maximum number of items in a pop-up menu
			pumheight = 10,
			-- Show relative line numbers
			relativenumber = true,
			-- Number of lines above and below the cursor to keep visible
			scrolloff = 3,
			-- Do not write a shada/viminfo file
			shadafile = 'NONE',
			-- Make >, <, >>, and << round to a multiple of shiftwidth
			shiftround = true,
			-- Number of spaces to use for autoindent
			shiftwidth = 2,
			-- Shorten messages
			-- m - Use [+] instead of [modified]
			-- r - Use [RO] instead of [readonly]
			-- I - Don't give the :intro message when starting vim
			shortmess = vim.opt.shortmess + {
				m = true,
				r = true,
				I = true,
			},
			-- When a bracket is inserted, briefly show the matching bracket if it's
			-- visible
			showmatch = true,
			-- Control showing the mode in the status line
			showmode = false,
			-- Show the sign column, allow up to 3 characters
			signcolumn = 'auto:3',
			-- Consider case when the search term has capitals
			smartcase = true,
			-- Make autoindent more intelligent
			smartindent = true,
			-- Number of spaces a tab counts as when expanding tabs
			softtabstop = 2,
			-- Set a spell file
			spellfile = vim.fn.stdpath('data') .. '/spell.utf8.add',
			-- Use regional variations of English
			spelllang = { 'en_us', 'en_ca' },
			-- Open new splits below the current one
			splitbelow = true,
			-- Open splits to the right of the current one
			splitright = true,
			-- Do not use swap files
			swapfile = false,
			-- Number of spaces to display a tab character as
			tabstop = 2,
			-- Follow ignorecase and smartcase when searching tags files
			tagcase = 'followscs',
			-- Use 24-bit RGB color in the terminal and use GUI color
			-- attributes instead of cterm attributes
			termguicolors = true,
			-- Maximum width of text
			textwidth = 80,
			-- Wait less time for multi-character mappings
			timeoutlen = 500,
			-- Set window manager title
			title = true,
			titlelen = 0,
			titlestring = '%{expand(\"%:t\")}',
			-- Milliseconds until CursorHold is triggered
			updatetime = 100,
			undofile = true,
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
			-- Disable a bunch of things we don't want
			did_install_default_menus = 1,
			loaded_2html_plugin = true,
			loaded_getscript = true,
			loaded_getscriptPlugin = true,
			loaded_gzip = true,
			loaded_logipat = true,
			loaded_man = true,
			loaded_matchit = true,
			loaded_netrw = true,
			loaded_netrwFileHandlers = true,
			loaded_netrwPlugin = true,
			loaded_netrwSettngs = true,
			loaded_node_provider = 0,
			loaded_perl_provider = 0,
			loaded_python_provider = true,
			loaded_remote_plugins = true,
			loaded_ruby_provider = 0,
			loaded_tar = true,
			loaded_tarPlugin = true,
			loaded_tutor_mode_plugin = true,
			loaded_zip = true,
			loaded_zipPlugin = true,
			loaded_vimball = true,
			loaded_vimballPlugin = true,
			python_host_skip_check = true,
			zipPlugin = false,

			latex_to_unicode_auto = 1,

			-- Python3 or bust
			python_highlight_all = true,
			python_highlight_file_headers_as_comments = true,
			python3_host_prog = vim.fn.filereadable(py3_venv) == 1 and py3_venv or py3_path,
			python_version = 'python3',
			['rainbow-delimiters'] = {
				enable = true,
				disable = { 'html' },
				extended_mode = true,
				max_file_lines = nil,
			},
		},
	},
}

if vim.fn.executable("rg") == 1 then
	M.settings.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
	M.settings.opt.grepformat = "%f:%l:%c:%m"
elseif vim.fn.executable("ag") == 1 then
	M.settings.opt.grepprg = "ag --nogroup --nocolor"
end

function M.setup()
	for scope, opts in pairs(M.settings) do
		for setting, value in pairs(opts) do
			vim[scope][setting] = value
		end
	end

	require('config.autocmd').setup()
end

return M
