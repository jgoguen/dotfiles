-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local has_LazyvimUtils, LazyvimUtils = pcall(require, 'lazyvim.util')
local Utils = require('utils')

local keybindings = {
	[''] = {
		q = { '<Nop>', { noremap = false } },

		-- Reflow paragraphs
		Q = { 'gwap', { desc = 'Reflow paragraph' } },
	},
	c = {
		['w!!'] = 'w !sudo tee % >/dev/null',
	},
	i = {
		['<C-BS>'] = '<Esc>cvb',
		['<S-Tab>'] = { '<ESC><<a', { silent = false } },

		['<C-n>'] = '<Plug>luasnip-next-choice',
		['<C-p>'] = '<Plug>luasnip-prev-choice',

		-- Insert link
		['<C-i>'] = {
			function()
				require('utils.forms').insert_link_with_text()
			end,
			{ desc = 'Insert link and text' },
		},

		-- Add undo breakpoints
		['('] = '(<C-g>u',
		[')'] = ')<C-g>u',

		['<Leader>fec'] = { ':Neotree reveal_force_cwd toggle<CR>', { desc = 'NeoTree Toggle' } },
		['<Leader>fEc'] = { ':Neotree reveal_force_cwd toggle<CR>', { desc = 'NeoTree Toggle' } },
	},
	n = {
		-- <F8> is defined in plugins to allow lazy-loading by keypress

		[';'] = function()
			require('telescope.builtin').resume()
		end,

		-- Allow ^ to act like Home in an IDE
		['^'] = { [[col('.') == match(getline('.'), '\S')+1 ? '0' : '^']], { expr = true } },

		['<C-/>'] = {
			function()
				if not has_LazyvimUtils then
					return
				end

				LazyvimUtils.terminal({ vim.o.shell, '-l' }, { cwd = LazyvimUtils.root(), border = 'rounded' })
			end,
			{ desc = 'Terminal (root dir)' },
		},

		-- Keep the cursor in the middle of the screen with <C-d> and <C-u>
		['<C-d>'] = '<C-d>zz',
		['<C-u>'] = '<C-u>zz',

		-- Insert link
		['<C-i>'] = {
			function()
				require('utils.forms').insert_link_with_text()
			end,
			{ desc = 'Insert link and text' },
		},

		-- Normal movement between wrapped lines
		['<up>'] = { [[v:count == 0 ? 'gk' : 'k']], { expr = true } },
		['<down>'] = { [[v:count == 0 ? 'gj' : 'j']], { expr = true } },

		-- Autoindent like VS Code when inserting on blank line
		a = {
			function()
				if #vim.fn.getline('.') == 0 then
					return [["_cc]]
				else
					return 'a'
				end
			end,
			{ expr = true, desc = 'Properly indent on empty line on insert-after' },
		},
		i = {
			function()
				if #vim.fn.getline('.') == 0 then
					return [["_cc]]
				else
					return 'i'
				end
			end,
			{ expr = true, desc = 'Properly indent on empty line on insert' },
		},

		-- Mark z, join [count] lines, jump back to mark z
		J = 'mzJ`z',

		-- Going to the next/previous match will centre the line it's on
		n = { [['Nn'[v:searchforward]|zzzv]], { expr = true } },
		N = { [['nN'[v:searchforward]|zzzv]], { expr = true } },

		-- Location/Quickfix window keymaps
		['[l'] = { ':lprevious<CR>zz', { desc = 'Previous location window entry' } },
		[']l'] = { ':lnext<CR>zz', { desc = 'Next location window entry' } },

		-- Normalize split size
		['<Leader>='] = '<C-w>=',

		-- Trouble.nivm keymaps
		['<Leader>xR'] = { ':TroubleToggle lsp_references<CR>', { desc = 'Trouble LSP References' } },
		gR = { ':TroubleToggle lsp_references<CR>', { desc = 'Trouble LSP References' } },

		['<Leader>rs'] = {
			':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR>:redraw!<CR>',
			{ desc = 'Refresh screen' },
		},

		-- Find merge conflict markers
		['<Leader>mc'] = { '/\\v^[<\\|=>]{7}( .*\\|$)<CR>', { desc = 'Merge conflict marker search' } },

		-- Mark a word as rare
		['z?'] = ':execute ":spellrare " .. expand("<cword>")<CR>',

		-- Toggle cursorcolumn (useful for aligning text)
		['<Leader>cl'] = { ':<C-U>call utils#ToggleCursorColumn()<CR>', { desc = 'Toggle cursor column' } },
	},
	v = {
		-- Better indentation
		['<'] = '<gv',
		['>'] = '>gv',

		-- Reflow selection
		Q = 'gq',

		-- Don't jump the cursor back where it was after yanking
		y = 'ygv<Esc>',
	},
	x = {
		-- Delete highlighted text and paste over without copying it to the paste
		-- register
		['<Leader>p'] = '"_dP',
	},
}

for mode, mapppings in pairs(keybindings) do
	for key, value in pairs(mapppings) do
		if type(value) == 'table' then
			Utils.set_keymap(mode, key, value[1], value[2])
		else
			Utils.set_keymap(mode, key, value)
		end
	end
end
