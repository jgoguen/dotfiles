-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	keybindings = {
		[''] = {
			q = { '<Nop>', { noremap = false } },

			-- Reflow paragraph
			Q = 'gwap',
		},
		c = {
			['w!!'] = 'w !sudo tee % >/dev/null',
		},
		i = {
			['<C-BS>'] = '<Esc>cvb',
			['<S-Tab>'] = { '<ESC><<a', { silent = false } },

			['<C-n>'] = '<Plug>luasnip-next-choice',
			['<C-p>'] = '<Plug>luasnip-prev-choice',

			-- Add undo breakpoints
			[','] = ',<C-g>u',
			['.'] = '.<C-g>u',
			[';'] = ';<C-g>u',
			['('] = '(<C-g>u',
			[')'] = ')<C-g>u',
		},
		n = {
			-- <F8> is defined in plugins/specs/global/aerial.lua to allow
			-- lazy-loading by keypress

			[';'] = function() require('telescope.builtin').resume() end,

			-- Allow ^ to act like Home in an IDE
			['^'] = { [[col('.') == match(getline('.'), '\S')+1 ? '0' : '^']], { expr = true } },

			-- Resize splits
			['<C-Up>'] = ':resize +2<CR>',
			['<C-Down>'] = ':resize -2<CR>',
			['<C-Left>'] = ':vertical resize -2<CR>',
			['<C-Right>'] = ':vertical resize +2<CR>',

			['<C-c>'] = function() require('FTerm').toggle() end,

			-- Keep the cursor in the middle of the screen with <C-d> and <C-u>
			['<C-d>'] = '<C-d>zz',
			['<C-u>'] = '<C-u>zz',

			-- Move between splits
			['<C-h>'] = '<C-w>h',
			['<C-j>'] = '<C-w>j',
			['<C-k>'] = '<C-w>k',
			['<C-l>'] = '<C-w>l',

			-- Move between tabs
			['<C-S-Right>'] = ':tabnext<CR>',
			['<C-S-Left>'] = ':tabprev<CR>',

			-- Move between buffers
			['<S-h>'] = ':bprevious<CR>',
			['[b'] = ':bprevious<CR>',
			['<S-l>'] = ':bnext<CR>',
			[']b'] = ':bnext<CR>',

			-- Telescope buffers
			['<Leader>b'] = function() require('telescope.builtin').buffers() end,

			['<Leader>cd'] = vim.diagnostic.open_float,

			-- Toggle cursorcolumn (useful for aligning text)
			['<Leader>cl'] = ':<C-U>call utils#ToggleCursorColumn()<CR>',

			-- Delete to the void register
			['<Leader>d'] = '"_d',

			['<Leader>ecb'] = ':EditCodeBlock',

			['<Leader>f'] = ':Neotree reveal_force_cwd<CR>',
			['<Leader>fc'] = ':Neotree reveal_force_cwd toggle<CR>',
			['<Leader>fml'] = ':CellularAutomaton game_of_life<CR>',

			['<LocalLeader>l'] = ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR>:redraw!<CR>',

			-- Location window shortcuts
			['<Leader>ln'] = ':lnext<CR>zz',
			['<Leader>lp'] = ':lprevious<CR>zz',
			['<Leader>lc'] = ':lclose<CR>',

			-- Find merge conflict markers
			['<Leader>mc'] = '/\\v^[<\\|=>]{7}( .*\\|$)<CR>',

			-- Quickfix window shortcuts
			['<Leader>qn'] = ':cnext<CR>zz',
			['<Leader>qp'] = ':cprevious<CR>zz',
			['<Leader>qc'] = ':cclose<CR>',

			-- Search/replace word under cursor
			['<Leader>s'] = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],

			-- Telescope find files
			['<Leader>t'] = function() require('telescope.builtin').find_files() end,

			-- Select window to jump to
			-- <Leader>w is defined in lua/plugins/specs/global/window-picker.lua
			-- to allow lazy-loading the plugin
			['<Leader>wcf'] = function() require('utils').close_floating_windows() end,

			['<Leader>xd'] = ':TroubleToggle document_diagnostics<CR>',
			['<Leader>xl'] = ':TroubleToggle loclist<CR>',
			['<Leader>xq'] = ':TroubleToggle quickfix<CR>',
			['<Leader>xw'] = ':TroubleToggle workspace_diagnostics<CR>',
			['<Leader>xx'] = ':TroubleToggle<CR>',

			-- Normalize split size
			['<Leader>='] = '<C-w>=',

			-- Clear search highlights
			['//'] = ':nohlsearch<CR>',

			-- Allow gf to open files that don't exist
			gf = ':edit <cfile><CR>',

			-- LSP references in Trouble
			gR = ':TroubleToggle lsp_references<CR>',

			-- Normal movement between wrapped lines
			k = { [[v:count == 0 ? 'gk' : 'k']], { expr = true } },
			['<up>'] = { [[v:count == 0 ? 'gk' : 'k']], { expr = true } },
			j = { [[v:count == 0 ? 'gj' : 'j']], { expr = true } },
			['<down>'] = { [[v:count == 0 ? 'gj' : 'j']], { expr = true } },

			-- Mark z, join [count] lines, jump back to mark z
			J = 'mzJ`z',

			-- Going to the next/previous match will centre the line it's on
			n = { [['Nn'[v:searchforward]|zzzv]], { expr = true } },
			N = { [['nN'[v:searchforward]|zzzv]], { expr = true } },
			-- Mark a word as rare
			['z?'] = ':execute ":spellrare " .. expand("<cWORD>")<CR>',
		},
		t = {
			['<C-t>'] = '<C-\\><C-n>:lua require("FTerm").toggle()<CR>',
		},
		v = {
			-- Better indentation
			['<'] = '<gv',
			['>'] = '>gv',

			-- Delete to the void register
			['<Leader>d'] = '"_d',

			-- Allow moving selected lines up and down
			J = ":m '>+1<CR>gv==kgvo<Esc>=kgvo",
			K = ":m '<-2<CR>gv==jgvo<Esc>=jgvo",

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
	},
}

function M.setup()
	local utils = require('utils')
	for mode, mapppings in pairs(M.keybindings) do
		for key, value in pairs(mapppings) do
			if type(value) == 'table' then
				utils.set_keymap(mode, key, value[1], value[2])
			else
				utils.set_keymap(mode, key, value)
			end
		end
	end
end

function M.apply(mode, key, val, opts)
	require('utils').set_keymap(mode, key, val, opts or {})
end

return M
