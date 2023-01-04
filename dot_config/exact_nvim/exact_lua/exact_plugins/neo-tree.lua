local M = {
	'nvim-neo-tree/neo-tree.nvim',
	tag = 'v2.*',
	requires = {
		'MunifTanjim/nui.nvim',
	},
}

function M.setup()
	vim.g.neo_tree_remove_legacy_commands = true
end

function M.config()
	local has_neotree, neotree = pcall(require, 'neo-tree')
	if not has_neotree then return end

	neotree.setup({
		close_if_last_window = true,
		window = {
			width = 40,
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
			use_libuv_file_watcher = true,
		},
		git_status = {
			window = {
				position = 'float',
			},
		},
	})
end

return M
