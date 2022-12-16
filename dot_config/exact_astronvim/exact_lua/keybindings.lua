local bindings = {
  [""] = {
    q = { '<Nop>', { noremap = false } },

    -- Reflow paragraph
    Q = 'gwap',
  },
  c = {
    ["w!!"] = 'w !sudo tee % >/dev/null',
  },
  i = {
    ["<S-Tab>"] = { '<ESC><<a', { silent = false } },
  },
  n = {
    ["<F8>"] = '<CMD>SymbolsOutline<CR>',

    [";"] = { ":", { silent = false } },

    -- Allow ^ to act like Home in an IDE
    ["^"] = { [[col('.') == match(getline('.'), '\\S')+1 ? '0' : '^']], { expr = true } },

    -- Resize splits
    ["<C-Left>"] = '<C-w><',
    ["<C-Right>"] = '<C-w>>',

    ["<C-c>"] = [[<CMD>lua require('FTerm').toggle()<CR>]],

    -- Move between tabs
    ["<C-S-Right>"] = '<CMD>tabnext<CR>',
    ["<C-S-Left>"] = '<CMD>tabprev<CR>',

    -- Move between buffers
    ["<A-PageDown>"] = '<CMD>bnext<CR>',
    ["<A-PageUp>"] = '<CMD>bprev<CR>',
    -- macOS needs the same mappings with Command
    ["<D-PageDown>"] = '<CMD>bnext<CR>',
    ["<D-PageUp>"] = '<CMD>bprev<CR>',

    -- Telescope buffers
    ["<Leader>b"] = [[<CMD>lua require('telescope.builtin').buffers()<CR>]],

    -- Toggle cursorcolumn (useful for aligning text)
    ["<Leader>cl"] = '<CMD><C-U>call utils#ToggleCursorColumn()<CR>',

    ["<Leader>f"] = '<CMD>Neotree reveal_force_cwd<CR>',
    ["<Leader>fc"] = '<CMD>Neotree reveal_force_cwd toggle<CR>',

    -- Move between splits
    ["<Leader>h"] = '<C-w>h',
    ["<Leader>j"] = '<C-w>j',
    ["<Leader>k"] = '<C-w>k',
    ["<Leader>l"] = '<C-w>l',
    -- Location window shortcuts
    ["<Leader>ln"] = '<CMD>lnext<CR>',
    ["<Leader>lp"] = '<CMD>lprevious<CR>',
    ["<Leader>lc"] = '<CMD>lclose<CR>',

    -- Find merge conflict markers
    ["<Leadr>mc"] = '/\\v^[<\\|=>]{7}( .*\\|$)<CR>',

    -- Quickfix window shortcuts
    ["<Leader>qn"] = '<CMD>cnext<CR>',
    ["<Leader>qp"] = '<CMD>cprevious<CR>',
    ["<Leader>qc"] = '<CMD>cclose<CR>',

    -- Telescope find files
    ["<Leader>t"] = [[<CMD>lua require('telescope.builtin').find_files()<CR>]],

    -- Select window to jump to
    ["<Leader>w"] = function()
      local has_picker, picker = pcall(require, 'window-picker')
      if has_picker then
        local wid = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(wid)
      end
    end,

    -- Normalize split size
    ["<Leader>="] = '<C-w>=',

    -- Clear search highlights
    ["//"] = '<CMD>nohlsearch<CR>',

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
    ["z?"] = '<CMD>execute ":spellrare " .',
  },
  t = {
    ["<C-t>"] = '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
  },
  v = {
    -- Reflow selection
    Q = 'gq',
  },
}

local map = function(mode, key, map, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.keymap.set(mode, key, map, options)
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
