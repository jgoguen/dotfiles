return {
	['akinsho/bufferline.nvim'] = { disable = true },
	['akinsho/toggleterm.nvim'] = { disable = true },
	['feline-nvim/feline.nvim'] = { disable = true },
	['goolord/alpha-nvim'] = { disable = true },
	['Shatur/neovim-session-manager'] = { disable = true },
	['stevearc/aerial.nvim'] = { disable = true },

	{
		'crispgm/nvim-go',
		config = function()
			require('go').setup({
				auto_lint = false,
				formatter = 'gofmt',
			})
		end,
	},
	{ 'folke/tokyonight.nvim' },
	{
		'folke/trouble.nvim',
		requires = {
			{ 'folke/lsp-colors.nvim' },
			{ 'kyazdani42/nvim-web-devicons' },
		},
		config = function()
			require('trouble').setup({
				fold_closed = '▸',
				fold_open = '▾',
				open_split = { '<C-x>', 's' },
				open_vsplit = { '<C-v>', 'i', 'v' },
				open_tab = { '<C-t>', 't' },
				auto_open = true,
				auto_close = true,
				auto_preview = false,
				use_diagnostic_signs = true,
			})
		end,
	},
	{ 'gpanders/editorconfig.nvim' },
	{ 'jgoguen/tmpl.vim' },
	{
		'kosayoda/nvim-lightbulb',
		requires = {
			{ 'antoinemadec/FixCursorHold.nvim' },
		},
		config = function()
			require('nvim-lightbulb').setup({
				autocmd = {
					enabled = true,
				},
			})
		end,
	},
	{ 'nathanaelkane/vim-indent-guides' },
	{
		'numToStr/FTerm.nvim',
		config = function()
			require('FTerm').setup({
				auto_close = false,
				border = "double",
			})
		end,
	},
	{ 'nvim-telescope/telescope-symbols.nvim' },
	{ 'pangloss/vim-javascript' },
	{ 'pearofducks/ansible-vim' },
	{
		'plasticboy/vim-markdown',
		requires = {
			{ 'vim-pandoc/vim-pandoc-syntax' },
		},
	},
	{ 'preservim/nerdcommenter' },
	{ 'preservim/vimux' },
	{ 'ryanoasis/vim-devicons' },
	{
		's1n7ax/nvim-window-picker',
		tag = 'v1.*',
	},
	{ 'simrat39/symbols-outline.nvim' },
	{ 'tmux-plugins/vim-tmux' },
	{
		'vim-airline/vim-airline',
		requires = {
			{ 'tpope/vim-fugitive' },
			{ 'vim-airline/vim-airline-themes' },
		},
	},
	{ 'vim-python/python-syntax' },
	{
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	},
}
