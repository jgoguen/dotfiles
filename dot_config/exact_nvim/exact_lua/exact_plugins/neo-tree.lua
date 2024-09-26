-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'nvim-neo-tree/neo-tree.nvim',
	keys = {
		{
			'<leader>fe',
			function()
				require('neo-tree.command').execute({ action = 'focus', toggle = false, dir = require('lazyvim.util').root() })
			end,
			desc = 'Go to file in NeoTree (Root Dir)',
		},
		{
			'<leader>fw',
			function()
				require('neo-tree.command').execute({ action = 'close' })
			end,
			desc = 'Close NeoTree',
		},
	},
	dependencies = {
		's1n7ax/nvim-window-picker',
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				never_show = {
					'.DS_Store',
					'thumbs.db',
					'node_modules',
					'__pycache__',
				},
			},
		},
		close_if_last_window = true,
		sort_case_insensitive = true,
		window = {
			width = 30,
			mappings = {
				['<CR>'] = 'open_with_window_picker',
				['a'] = {
					'add',
					config = {
						show_path = 'relative',
					},
				},
				['A'] = {
					'add_directory',
					config = {
						show_path = 'relative',
					},
				},
				['c'] = {
					'copy',
					config = {
						show_path = 'relative',
					},
				},
				['m'] = {
					'move',
					config = {
						show_path = 'relative',
					},
				},
				['i'] = 'split_with_window_picker',
				['s'] = 'vsplit_with_window_picker',
			},
		},
		git_status = {
			window = {
				position = 'float',
			},
		},
		renderers = {
			directory = {
				{ 'indent' },
				{ 'icon' },
				{ 'current_filter' },
				{ 'name' },
				{ 'clipboard' },
				{
					'diagnostics',
					errors_only = true,
					hide_when_expanded = true,
				},
				{ 'git_status' },
			},
			file = {
				{ 'indent' },
				{ 'icon' },
				{
					'name',
					use_git_status_colors = true,
					zindex = 10,
				},
				{ 'clipboard' },
				{ 'bufnr' },
				{ 'modified' },
				{ 'diagnostics' },
				{ 'git_status' },
			},
		},
		event_handlers = {
			{
				event = 'neo_tree_buffer_enter',
				handler = function(_)
					vim.opt_local.relativenumber = true
				end,
			},
		},
	},
}

return M
