local options = {
	opt = {
		-- Do not write backup or swap files [[[
		backup = false,
		swapfile = false,
		writebackup = false,
		-- ]]]

		-- Set intelligent case insensitivity when searching [[[
		ignorecase = true,
		smartcase = true,
		tagcase = 'followscs',
		-- ]]]

		-- Configure indentation handling [[[
		-- Use current line's indentation when starting a new line
		autoindent = true,

		-- Make autoindent more intelligent
		smartindent = true,

		-- Let backspace and tab intelligently treat expanded tabs like tabs
		smarttab = true,

		-- Make >, <, >>, and << round to a multiple of shiftwidth
		shiftround = true,

		shiftwidth = 2,
		softtabstop = 2,
		tabstop = 2,
		-- ]]]

		-- Automatically read and write files appropriately [[[
		-- If a file is changed outside vim and not changed in vim, automatically read
		-- and display the new file contents
		autoread = true,

		-- Write modified buffers when the buffer becomes hidden
		autowriteall = true,
		-- ]]]

		-- Configure folding [[[
		-- Needed for nvim-ufo to properly manage folding
		foldcolumn = '1',
		foldlevel = 99,
		foldlevelstart = 99,
		foldenable = true,
		foldmethod = 'manual',
		-- ]]]

		-- Configure search match highlighting [[[
		-- Highlight all search matches
		hlsearch = true,

		-- Highlight search matches while typing
		incsearch = true,
		-- ]]]

		-- Configure list characters display (list and listchars) [[[
		list = true,

		-- Configure splits [[[
		-- Open splits below the current one by default
		splitbelow = true,

		-- Open splits to the right of the current one by default
		splitright = true,
		-- ]]]

		-- Configure colors [[[
		-- Use 24-bit RGB color in the terminal and use GUI color attributes instead of
		-- cterm attributes
		termguicolors = true,
		-- ]]]

		-- Configure the status area [[[
		-- Use 2 lines for the command area at the bottom of the screen
		cmdheight = 2,

		-- Always show the status line
		laststatus = 2,

		-- Don't show the mode, the airline extension will handle that
		showmode = false,
		-- ]]]

		-- Set display appropriate for dark backgrounds
		background = 'dark',

		-- Highlight the column following 'textwidth'
		colorcolumn = '+1',

		-- Concealed text is hidden unless there's a custom replacement character
		conceallevel = 2,

		-- Confirm instead of failing operations
		confirm = true,

		-- Highlight the line with the cursor
		cursorline = true,

		-- Hide unloaded buffers instead of trying to close them
		hidden = true,

		-- Do not insert two spaces after punctuation when joining lines
		joinspaces = false,

		-- Don't redraw while executing macros, commands, etc.
		lazyredraw = true,

		-- Intelligently break long lines
		linebreak = true,

		-- Maximum number of items in a pop-up menu
		pumheight = 10,

		-- Number of lines above and below the cursor to keep visible
		scrolloff = 3,

		-- Show this character at the start of lines that have been wrapped
		showbreak = '↪',

		-- When a bracket is inserted, briefly show the matching bracket if it's
		-- visible
		showmatch = true,

		-- Keep the cursor in the current column if possible
		startofline = false,

		-- Maximum width of text
		textwidth = 80,

		-- Wait less time for multi-character mappings
		timeoutlen = 500,

		-- Milliseconds until CursorHold is triggered
		updatetime = 100,

		-- Do not write a viminfo file
		viminfofile = 'NONE',

		-- Allow a cursor to be placed where there's no character in Visual mode
		virtualedit = 'block',

		mouse = '',
		number = true,
		relativenumber = true,
	},
	g = {
		mapleader = '`',

		-- Turn off things we don't want loaded by default [[[
		-- Do not load default menus
		did_install_default_menus = 1,

		indent_guides_enable_on_vim_startup = 1,

		-- Do not load netrw
		loaded_netrw = 1,
		loaded_netrwPlugin = 1,

		-- Do not load tohtml.vim
		loaded_2html_plugin = 1,

		-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim
		loaded_zipPlugin = 1,
		loaded_gzip = 1,
		loaded_tarPlugin = 1,

		-- Do not load tutor mode
		loaded_tutor_mode_plugin = 1,

		-- Disable the Python2 provider
		loaded_python_provider = 1,

		-- Skip the Python2 host provider check
		python_host_skip_check = 1,

		python_version = 'python3',

		-- Remove all legacy commands from NeoTree
		neo_tree_remove_legacy_commands = 1,
		-- ]]]

		html_indent_script1 = 'inc',
		html_indent_style1 = 'inc',

		-- Enable vim-javascript highlighting for JSDocs
		javascript_plugin_jsdoc = 1,
		-- Enable vim-javascript highlighting for Flow
		javascript_plugin_flow = 1,

		latex_to_unicode_auto = 1,

		python_highlight_all = 1,
		python_highlight_file_headers_as_comments = 1,

		symbols_outline = {
			auto_preview = false,
		},

		tex_flavor = 'xelatex',
		Tex_CompileRule_pdf = 'xelatex --interaction=nonstopmode $*',

		tokyonight_style = 'night',
		tokyonight_sidebars = {
			'qf', 'vista_kind', 'terminal', 'packer', 'NvimTree', 'Fern', 'Tagbar', 'Outline',
		},

		vim_indent_cont = vim.o.shiftwidth,

		vim_markdown_autowrite = 1,
		vim_markdown_follow_anchor = 1,
		vim_markdown_no_extensions_in_markdown = 1,
		vim_markdown_math = 1,
		tex_conceal = '',
		vim_markdown_conceal = 0,
		vim_markdown_frontmatter = 1,
		vim_markdown_toml_frontmatter = 1,
		vim_markdown_json_frontmatter = 1,
		vim_markdown_strikethrough = 1,
		vim_markdown_new_list_item_indent = 2,
		vim_markdown_edit_url_in = 'tab',

		xdg_config_home = os.getenv('XDG_CONFIG_HOME') ~= nil and os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config'
	},
}

return options
