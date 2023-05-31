-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	'lewis6991/gitsigns.nvim',
	opts = {
		signs = {
			topdelete = {
				text = '契',
			},
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function buf_set_keymap(mode, key, cmd, options)
				local opts = options and options or {}
				opts['buffer'] = bufnr
				require('utils').set_keymap(mode, key, cmd, opts)
			end

			buf_set_keymap(
				'n',
				']c',
				function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end,
				{ expr = true }
			)
			buf_set_keymap(
				'n',
				'[c',
				function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end,
				{ expr = true }
			)

			buf_set_keymap('n', '<LocalLeader>hs', gs.stage_hunk)
			buf_set_keymap('n', '<LocalLeader>hb', function() gs.blame_line({ full = true }) end)
			buf_set_keymap('n', '<LocalLeader>hS', gs.stage_buffer)
			buf_set_keymap('n', '<LocalLeader>hu', gs.undo_stage_hunk)
			buf_set_keymap('n', '<LocalLeader>hR', gs.reset_buffer)
			buf_set_keymap('n', '<LocalLeader>hp', gs.preview_hunk)
			buf_set_keymap('n', '<LocalLeader>tb', gs.toggle_current_line_blame)
			buf_set_keymap('n', '<LocalLeader>hd', gs.diffthis)
			buf_set_keymap('n', '<LocalLeader>hD', function() gs.diffthis('~') end)
			buf_set_keymap('n', '<LocalLeader>td', gs.toggle_deleted)
			-- Text object
			buf_set_keymap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
		end,
	},
}

function M.cond()
	local dir = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h') .. ';')
	return dir ~= '' and vim.fn.executable('git') == 1
end

return M
