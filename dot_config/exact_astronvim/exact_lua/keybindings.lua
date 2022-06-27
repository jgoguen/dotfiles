local bindings = {
	[""] = {
		q = {'<Nop>', {noremap = false}},

		-- Reflow paragraph
		Q = {'gwap', {silent = true}},
	},
	c = {
		["w!!"] = {'w !sudo tee % >/dev/null', {silent = true}},
	},
	i = {
		["<S-Tab>"] = '<ESC><<a',
	},
	n = {
		["<F8>"] = {'<CMD>SymbolsOutline<CR>', {silent = true}},

		[";"] = ":",

		-- Allow ^ to act like Home in an IDE
		["^"] = {[[col('.') == match(getline('.'), '\\S')+1 ? '0' : '^']], {silent = true, expr = true}},

		-- Resize splits
		["<C-Left>"] = {'<C-w><', {silent = true}},
		["<C-Right>"] = {'<C-w>>', {silent = true}},

		["<C-t>"] = [[<CMD>lua require('FTerm').toggle()<CR>]],

		-- Move between tabs
		["<C-S-Right>"] = {'<CMD>tabnext<CR>', {silent = true}},
		["<C-S-Left>"] = {'<CMD>tabprev<CR>', {silent = true}},

		-- Move between buffers
		["<A-PageDown>"] = {'<CMD>bnext<CR>', {silent = true}},
		["<A-PageUp>"] = {'<CMD>bprev<CR>', {silent = true}},
		-- macOS needs the same mappings with Command
		["<D-PageDown>"] = {'<CMD>bnext<CR>', {silent = true}},
		["<D-PageUp>"] = {'<CMD>bprev<CR>', {silent = true}},

		-- Telescope buffers
		["<Leader>b"] = {[[<CMD>lua require('telescope.builtin').buffers()<CR>]], {silent = true}},

		-- Toggle cursorcolumn (useful for aligning text)
		["<Leader>cl"] = '<CMD><C-U>call utils#ToggleCursorColumn()<CR>',

		["<Leader>f"] = {'<CMD>Neotree reveal_force_cwd<CR>', {silent = true}},
		["<Leader>fc"] = {'<CMD>Neotree reveal_force_cwd toggle<CR>', {silent = true}},

		-- Move between splits
		["<Leader>h"] = {'<C-w>h', {silent = true}},
		["<Leader>j"] = {'<C-w>j', {silent = true}},
		["<Leader>k"] = {'<C-w>k', {silent = true}},
		["<Leader>l"] = {'<C-w>l', {silent = true}},
		-- Location window shortcuts
		["<Leader>ln"] = {'<CMD>lnext<CR>', {silent = true}},
		["<Leader>lp"] = {'<CMD>lprevious<CR>', {silent = true}},
		["<Leader>lc"] = {'<CMD>lclose<CR>', {silent = true}},

		-- Find merge conflict markers
		["<Leadr>mc"] = '/\\v^[<\\|=>]{7}( .*\\|$)<CR>',

		-- Quickfix window shortcuts
		["<Leader>qn"] = {'<CMD>cnext<CR>', {silent = true}},
		["<Leader>qp"] = {'<CMD>cprevious<CR>', {silent = true}},
		["<Leader>qc"] = {'<CMD>cclose<CR>', {silent = true}},

		-- Telescope find files
		["<Leader>t"] = {[[<CMD>lua require('telescope.builtin').find_files()<CR>]], {silent = true}},

		-- Normalize split size
		["<Leader>="] = {'<C-w>=', {silent = true}},

		-- Clear search highlights
		["//"] = {'<CMD>nohlsearch<CR>', {silent = true}},

		-- Allow gf to open files that don't exist
		gf = '<CMD>edit <cfile><CR>',

		-- Normal movement between wrapped lines
		k = 'gk',
		["<up>"] = 'gk',
		j = 'gj',
		["<down>"] = 'gj',

		-- Going to the next/previous match will centre the line it's on
		n = 'nzzzv',
		N = 'Nzzzv',
		-- Mark a word as rare
		["z?"] = {'<CMD>execute ":spellrare " .'}
	},
	t = {
		["<C-t>"] = '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
	},
	v = {
		-- Reflow selection
		Q = {'gq', {silent = true}},
	},
}

local map = function(mode, key, map, opts)
	local options = {noremap = true}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_set_keymap(mode, key, map, options)
end

local M = {}

M.setup = function()
	for mode, mapppings in pairs(bindings) do
		for key, value in pairs(mapppings) do
			if type(value) == "table" then
				map(mode, key, value[1], value[2])
			else
				map(mode, key, value)
			end
		end
	end
end

return M
